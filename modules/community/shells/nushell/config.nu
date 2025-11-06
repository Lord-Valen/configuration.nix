let zoxide_completer = {|spans|
  $spans | skip 1 | zoxide query -l $in | lines | where {|e| $e != $env.PWD}
}

let carapace_completer = {|spans|
  carapace $spans.0 nushell ...$spans | from json
}

let multiple_completer = {|spans|
  match $spans.0 {
    __zoxide_z => $zoxide_completer
    __zoxide_zi => $zoxide_completer
    _ => $carapace_completer
  } | do $in $spans
}

$env.config.completions.external.completer = $multiple_completer

$env.config.hooks.command_not_found = {
  |cmd|
  let attrs = (
    nix-locate --minimal --no-group --type x --type s --top-level --whole-name --at-root $"/bin/($cmd)"
    | lines
    | par-each { split row . | $in.0 }
    );
    $attrs
    | length
    | match $in {
      0 => {
        $"($cmd): command not found"
      }
      1 => {
        $"The program '($cmd)' is currently not installed. You can install it by typing:\n\tnix profile install nixpkgs#($attrs.0)\n\nOr run it once with:\n\tnix shell nixpkgs#($attrs.0) -c ($cmd)"
      }
      _ => {
        [
          $"The program '($cmd)' is currently not installed. It is provided by several packages. You can install it by typing one of the following:\n",
          ($attrs | par-each {|e| $"\n\tnix profile install nixpkgs#($e)"}),
          "\n\nOr run it once with:\e\n",
          ($attrs | par-each {|e| $"\n\tnix shell nixpkgs#($e) -c ($cmd)"})
        ]
        | flatten
        | str join
      }
    }
}

$env.config.menus ++= [
  {
    name: commands_menu
    only_buffer_difference: false
    marker: "# "
    type: {
      layout: columnar
      columns: 4
      col_width: 20
      col_padding: 2
    }
    style: {
      text: green
      selected_text: green_reverse
      description_text: yellow
    }
    source: { |buffer, position|
      $nu.scope.commands
      | where command =~ $buffer
      | each { |it| {value: $it.command description: $it.usage} }
    }
  }
  {
    name: vars_menu
    only_buffer_difference: true
    marker: "# "
    type: {
      layout: list
      page_size: 10
    }
    style: {
      text: green
      selected_text: green_reverse
      description_text: yellow
    }
    source: { |buffer, position|
      $nu.scope.vars
      | where name =~ $buffer
      | sort-by name
      | each { |it| {value: $it.name description: $it.type} }
    }
  }
]

$env.config.keybindings ++= [
  {
    name: commands_menu
    modifier: control
    keycode: char_t
    mode: [emacs, vi_normal, vi_insert]
    event: { send: menu name: commands_menu }
  }
  {
    name: vars_menu
    modifier: control
    keycode: char_v
    mode: [emacs, vi_normal, vi_insert]
    event: { send: menu name: vars_menu }
  }
]
