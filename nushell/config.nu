use "scripts/theme.nu";
use "scripts/starship_init.nu";
use "scripts/keybindings.nu";
use "scripts/mt.nu";

# The default config record. This is where much of your global configuration is setup.
$env.config = {
    show_banner: false
    rm: {
        always_trash: false # always act as if -t was given. Can be overridden with -p
    }
    error_style: "fancy" # "fancy" or "plain" for screen reader-friendly error messages
    datetime_format: {
        normal: '%A at %H%M -- %d of %B  '    # shows up in displays of variables or other datetime's outside of tables
        table: '%d/%m %H%M'          # generally shows up in tabular outputs such as ls. commenting this out will change it to the default human readable datetime format
    }
    history: {
        max_size: 1000_000 # Session has to be reloaded for this to take effect
        sync_on_enter: true # Enable to share history between multiple sessions, else you have to close the session to write history to file
        file_format: "sqlite" # "sqlite" or "plaintext"
        isolation: false # only available with sqlite file_format. true enables history isolation, false disables it. true will allow the history to be isolated to the current session using up/down arrows. false will allow the history to be shared across all sessions.
    }
    footer_mode: 25 # always, never, number_of_rows, auto
    float_precision: 2 # the precision for displaying floats in tables
    buffer_editor: "helix" # command that will be used to edit the current line buffer with ctrl+o, if unset fallback to $env.EDITOR and $env.VISUAL
    use_ansi_coloring: true
    bracketed_paste: true # enable bracketed paste, currently useless on windows
    edit_mode: emacs
    render_right_prompt_on_last_line: false # true or false to enable or disable right prompt to be rendered on last line of the prompt.
    use_kitty_protocol: true # enables keyboard enhancement protocol implemented by kitty console, only if your terminal support this
}

$env.config = ($env.config | merge {
        color_config: (theme)
        keybindings: (keybindings)
    }
)
