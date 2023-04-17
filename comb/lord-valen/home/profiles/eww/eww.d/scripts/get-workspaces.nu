#!/usr/bin/env nu

source ./base.nu
let workspaces = ($names | each {|name| {name: $name, windows: 0}})

def main [] {
  let hyprWorkspaces = (hyprctl workspaces -j | from json | select name windows)

  let workspaces = (
    $workspaces | par-each {|self| (
      if ($hyprWorkspaces | all {|space| $space.name != $self.name}) {
        $self
      } else {
        $hyprWorkspaces | par-each {|super| if $self.name == $super.name { $self | merge $super}}
      }
    )}
  )

  let finalWorkspaces = ($workspaces | to json -r)
  print $finalWorkspaces
}

main
# TODO: Check for event's that would change the count
socat -u $socket - | lines | each {|| main}
