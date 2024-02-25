let dark_theme = {
  separator: white
  leading_trailing_space_bg: { attr: n }
  header: green_bold
  empty: blue
  bool: white
  int: white
  filesize: white
  duration: white
  date: white
  range: white
  float: white
  string: white
  nothing: white
  binary: white
  cellpath: white
  row_index: green_bold
  record: white
  list: white
  block: white
  hints: dark_gray

  shape_garbage: { fg: "#FFFFFF" bg: "#FF0000" attr: b}
  shape_binary: purple_bold
  shape_bool: light_cyan
  shape_int: purple_bold
  shape_float: purple_bold
  shape_range: yellow_bold
  shape_internalcall: cyan_bold
  shape_external: cyan
  shape_externalarg: green_bold
  shape_literal: blue
  shape_operator: yellow
  shape_signature: green_bold
  shape_string: green
  shape_string_interpolation: cyan_bold
  shape_datetime: cyan_bold
  shape_list: cyan_bold
  shape_table: blue_bold
  shape_record: cyan_bold
  shape_block: blue_bold
  shape_filepath: cyan
  shape_directory: cyan
  shape_globpattern: cyan_bold
  shape_variable: purple
  shape_flag: blue_bold
  shape_custom: green
  shape_nothing: light_cyan
  shape_matching_brackets: { attr: u }
}

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

$env.config = {
  show_banner: false
  color_config: $dark_theme
  use_ansi_coloring: true
  use_grid_icons: true
  footer_mode: "25"
  float_precision: 2
  edit_mode: emacs
  shell_integration: true
  render_right_prompt_on_last_line: false

  hooks: {
    command_not_found: {|cmd|
      let attrs = (
        nix-locate --minimal --no-group --type x --type s --top-level --whole-name --at-root $"/bin/($cmd)"
        | lines | par-each { split row . | $in.0})
      ;
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
            $"The program '($cmd)' is currently not installed. It is provided by several packages. You can install it by typing one of the following:",
            ($attrs | par-each {|e| $"\n\tnix profile install nixpkgs#($e)"}),
            "\n\nOr run it once with:",
            ($attrs | par-each {|e| $"\n\tnix shell nixpkgs#($e) -c ($cmd)"})
          ]
          | flatten
          | str join
        }
      }
    }
  }

  ls: {
    use_ls_colors: true
    clickable_links: true
  }

  rm: {
    always_trash: false
  }

  table: {
    mode: rounded
    index_mode: always
    trim: {
      methodology: wrapping
      wrapping_try_keep_words: true
      truncating_suffix: "..."
    }
  }

  history: {
    file_format: "plaintext"
    sync_on_enter: true
    max_size: 10000
  }

  completions: {
    quick: true
    case_sensitive: false
    algorithm: "prefix"
    partial: true
    external: {
      enable: true
      max_results: 100
      completer: $multiple_completer
    }
  }

  filesize: {
    metric: false
    format: "auto"
  }

  menus: [
    {
      name: completion_menu
      only_buffer_difference: false
      marker: "| "
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
    }
    {
      name: history_menu
      only_buffer_difference: true
      marker: "? "
      type: {
        layout: list
        page_size: 10
      }
      style: {
        text: green
        selected_text: green_reverse
        description_text: yellow
      }
    }
    {
      name: help_menu
      only_buffer_difference: true
      marker: "? "
      type: {
        layout: description
        columns: 4
        col_width: 20
        col_padding: 2
        selection_rows: 4
        description_rows: 10
      }
      style: {
        text: green
        selected_text: green_reverse
        description_text: yellow
      }
    }
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
    {
      name: commands_with_description
      only_buffer_difference: true
      marker: "# "
      type: {
        layout: description
        columns: 4
        col_width: 20
        col_padding: 2
        selection_rows: 4
        description_rows: 10
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
  ]
  keybindings: [
    {
      name: completion_menu
      modifier: none
      keycode: tab
      mode: emacs
      event: {
        until: [
          { send: menu name: completion_menu }
          { send: menunext }
        ]
      }
    }
    {
      name: completion_previous
      modifier: shift
      keycode: backtab
      mode: [emacs, vi_normal, vi_insert]
      event: { send: menuprevious }
    }
    {
      name: history_menu
      modifier: control
      keycode: char_r
      mode: emacs
      event: { send: menu name: history_menu }
    }
    {
      name: next_page
      modifier: control
      keycode: char_x
      mode: emacs
      event: { send: menupagenext }
    }
    {
      name: undo_or_previous_page
      modifier: control
      keycode: char_z
      mode: emacs
      event: {
        until: [
          { send: menupageprevious }
          { edit: undo }
        ]
      }
    }
    {
      name: yank
      modifier: control
      keycode: char_y
      mode: emacs
      event: {
        until: [
          {edit: pastecutbufferafter}
        ]
      }
    }
    {
      name: unix-line-discard
      modifier: control
      keycode: char_u
      mode: [emacs, vi_normal, vi_insert]
      event: {
        until: [
          {edit: cutfromlinestart}
        ]
      }
    }
    {
      name: kill-line
      modifier: control
      keycode: char_k
      mode: [emacs, vi_normal, vi_insert]
      event: {
        until: [
          {edit: cuttolineend}
        ]
      }
    }
    {
      name: commands_menu
      modifier: control
      keycode: char_t
      mode: [emacs, vi_normal, vi_insert]
      event: { send: menu name: commands_menu }
    }
    {
      name: vars_menu
      modifier: alt
      keycode: char_o
      mode: [emacs, vi_normal, vi_insert]
      event: { send: menu name: vars_menu }
    }
    {
      name: commands_with_description
      modifier: control
      keycode: char_s
      mode: [emacs, vi_normal, vi_insert]
      event: { send: menu name: commands_with_description }
    }
  ]
}
