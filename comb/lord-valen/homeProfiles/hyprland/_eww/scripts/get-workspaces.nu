#!/usr/bin/env nu

source ./base.nu
let workspaces = ($names | zip 1.. | par-each {|space| {index: $space.1, name: $space.0, windows: 0, current: false}})

def main [] {
  let hyprWorkspaces = (hyprctl workspaces -j | from json | select id windows | rename index)
  let activeWorkspaces = (hyprctl monitors -j | from json | select activeWorkspace.id | rename index | upsert current true )

  let result = (
    $workspaces | par-each {|self|
      $self | merge (
        if ($hyprWorkspaces | any {|x| ($x.index == $self.index)})
          {($hyprWorkspaces | where {|x| ($x.index == $self.index)}).0}
        else {$self}
      )
    } | par-each {|self|
      $self | merge (
        if ($activeWorkspaces | any {|x| ($x.index == $self.index)})
          {($activeWorkspaces | where {|x| ($x.index == $self.index)}).0}
        else {$self}
      )
    } | sort-by index
  )

  $result | to json -r | print
}

main
socket ["workspace" "createworkspace" "destroyworkspace" "openwindow" "closewindow" "movewindow"] | each {|| main}
