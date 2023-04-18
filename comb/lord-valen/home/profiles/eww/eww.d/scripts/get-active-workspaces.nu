#!/usr/bin/env nu

source ./base.nu

def main [] {
  hyprctl monitors -j | from json | select activeWorkspace.name | rename name | to json -r | print
}

main
socat -u $socket - | lines | each {|line| $line | split column ">>" | into record
  | each {|record| if $record.column1 == workspace {main}}}
