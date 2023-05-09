#!/usr/bin/env nu

source ./base.nu

def main [] {
  hyprctl monitors -j | from json | select activeWorkspace.id | rename id | to json -r | print
}

main
socket ["workspace" "createworkspace" "destroyworkspace"] | each {|| main}
