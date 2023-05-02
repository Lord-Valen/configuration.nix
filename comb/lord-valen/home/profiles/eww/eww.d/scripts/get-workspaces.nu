#!/usr/bin/env nu

source ./base.nu
let workspaces = ($names | zip 0..10 | each {|workspace| {name: $workspace.0, id: $workspace.1, windows: 0}})

def main [] {
  let hyprWorkspaces = (hyprctl workspaces -j | from json | select id windows)

  let workspaces = (
    $workspaces | par-each {|self| (
      if ($hyprWorkspaces | all {|space| $space.id != $self.id}) {
        $self
      } else {
        $hyprWorkspaces | par-each {|super| if $self.id == $super.id { $self | merge $super}}
      }
    )}
  )

  $workspaces | to json -r | print
}

main
# TODO: Check for event's that would change the count
socat -u $socket - | lines | each {|| main}
