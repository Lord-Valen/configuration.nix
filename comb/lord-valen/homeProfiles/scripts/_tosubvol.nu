#!/usr/bin/env nu

def main [subdir: path] {
    let target: path = $subdir | path expand 
    let temp: path = mktemp -d | path join $in ($target | path basename)

    btrfs subvolume create $temp
    $target 
    | path join "*" 
    | into glob 
    | par-each {|e| cp -r $e $temp}
    rm -r $target
    #FIXME: Why can't we just use `mv`?
    btrfs subvolume snapshot $temp $target
    btrfs subvolume delete $temp
    print $"($target) is now a subvolume."
}