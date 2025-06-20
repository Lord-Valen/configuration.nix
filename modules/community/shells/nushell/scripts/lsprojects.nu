#! /usr/bin/env nu
def main [path?: path] {
    let target = if $path == null {
        $env.XDG_PROJECTS_DIR? | default ($nu.home-dir | path join Projects)
    } else {
        $path
    }
    let projects = ls $target | where type == "dir" | par-each { |dir|
        cd $dir.name
        if (".git" | path exists) {
            let last_commit = (git log -1 --format="%cI" | into datetime)
            { project: ($dir.name | path basename), last_active: $last_commit }
        } else {
            { project: ($dir.name | path basename), last_active: null }
        }
    }
    let dated = $projects | where last_active != null | sort-by --reverse last_active
    let undated = $projects | where last_active == null
    {
        dated: $dated
        undated: $undated
    }
}
