export def main [] {
  return [
        {
            name: completion_menu
            modifier: none
            keycode: tab
            mode: vi_insert
            event: {
                until: [
                    { send: menu name: completion_menu }
                    { send: menunext }
                    { edit: complete }
                ]
            }
        }
        {
            name: history_menu
            modifier: control
            keycode: char_r
            mode: [vi_insert vi_normal]
            event: { send: menu name: history_menu }
        }
        {
            name: help_menu
            modifier: none
            keycode: f1
            mode: [vi_insert vi_normal]
            event: { send: menu name: help_menu }
        }
        {
            name: completion_previous_menu
            modifier: shift
            keycode: backtab
            mode: [vi_normal vi_insert]
            event: { send: menuprevious }
        }
        {
            name: cancel_command
            modifier: control
            keycode: char_c
            mode: [vi_normal vi_insert]
            event: { send: ctrlc }
        }
        {
            name: clear_screen
            modifier: control
            keycode: char_l
            mode: [vi_normal vi_insert]
            event: { send: clearscreen }
        }
        {
            name: search_history
            modifier: alt
            keycode: char_s
            mode: [vi_normal vi_insert]
            event: { send: searchhistory }
        }
        {
            name: open_command_editor
            modifier: alt
            keycode: char_o
            mode: [vi_normal vi_insert]
            event: { send: openeditor }
        }
        {
            name: line_auto_complete_take
            modifier: alt
            keycode: char_l
            mode: [vi_normal vi_insert]
            event: {
                until: [
                    {send: historyhintcomplete}
                ]
            }
        }
        {
            name: word_auto_complete_take
            modifier: alt
            keycode: char_w
            mode: [vi_normal vi_insert]
            event: {
                until: [
                    {send: historyhintwordcomplete}
                ]
            }
        }
        {
            name: escape_vi_insert
            modifier: alt
            keycode: char_i
            mode: [vi_insert]
            event: { send: Esc }    # NOTE: does not appear to work
        }
    ]  
}
