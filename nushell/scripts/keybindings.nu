export def main [] {
  return [
        {
            name: history_menu
            modifier: control
            keycode: char_r
            mode: emacs
            event: { send: menu name: history_menu }
        }
        {
            name: cancel_command
            modifier: control
            keycode: char_c
            mode: emacs
            event: { send: ctrlc }
        }
        {
            name: clear_screen
            modifier: control
            keycode: char_l
            mode: emacs
            event: { send: clearscreen }
        }
        {
            name: line_auto_complete_take
            modifier: alt
            keycode: char_l
            mode: emacs
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
            mode: emacs
            event: {
                until: [
                    {send: historyhintwordcomplete}
                ]
            }
        }
    ]  
}
