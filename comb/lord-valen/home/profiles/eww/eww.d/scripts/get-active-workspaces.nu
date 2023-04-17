#!/usr/bin/env nu

source ./base.nu

def main [] {
  let activeWorkspaces = (hyprctl monitors -j | from json | select activeWorkspace.name | rename name)
  $activeWorkspaces | to json -r | print
}

main
socat -u $socket - | lines | each {|line| $line | split column ">>" | into record
  | each {|record| if $record.column1 == workspace {main}}}
