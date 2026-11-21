$env.config = {
    show_banner: false
    buffer_editor: "helix"
    edit_mode: helix
}
$env.config.keybindings ++= [
    {
        name: line_auto_complete_take
        modifier: alt
        keycode: char_l
        mode: helix_insert
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
        mode: helix_insert
        event: {
            until: [
                {send: historyhintwordcomplete}
            ]
        }
    }
    {
        name: helix_escape
        modifier: alt
        keycode: char_i # Change to char_c, backslash, etc.
        mode: [helix_insert, helix_select]
        event: { send: HelixChangeMode, mode: normal }
    }        
]
