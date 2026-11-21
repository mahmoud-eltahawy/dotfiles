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

export def extract [file_path : path] {
    let basename = $file_path | path basename;
    let map = [
        {exten : "tar.bz2",action : {|| tar xjf $file_path }},
        {exten : "tar.gz",action :  {|| tar xzf $file_path }},
        {exten : "tar",action :  {|| tar xf $file_path }},
        {exten : "tbz2",action :  {|| tar xjf $file_path }},
        {exten : "tgz",action :  {|| tar xzf $file_path }},
        {exten : "tar.xz",action :  {|| tar xf $file_path }},
        {exten : "tar.zst",action :  {|| tar xf $file_path }},
        {exten : "zip",action :  {|| unzip $file_path }},
        {exten : "7z",action :  {|| 7z x $file_path }},
        {exten : "rar",action :  {|| unrar x $file_path }},
        {exten : "bz2",action :  {|| bunzip2 $file_path }},
        {exten : "gz",action :  {|| gunzip $file_path }},
        {exten : "Z",action :  {|| uncompress $file_path }},
        {exten : "deb",action :  {|| ar x $file_path }},
    ]

    $map | each {|x| if ($basename | str ends-with ($x | get exten)) {
        let action = $x | get action;
        do $action;
    }}
}

export def camera [] {
    ffplay -window_title my_camera -vf hflip -fast -noborder -infbuf -loglevel panic -an -x 360 -y 360  /dev/video0
}

export def wifi_connect [ssid?,password?] {
    if $ssid == null and $password == null {
        nmcli device;
        nmcli device wifi;
    } else if $ssid != null and $password == null {
        nmcli device wifi connect $ssid
    } else if $ssid != null and $password != null {
        nmcli device wifi connect $ssid password $password
    }
}

export def wifi_connect_hidden [ssid?,password?] {
    if $ssid != null and $password != null {
        nmcli device wifi connect $ssid password $password hidden yes
    }
}
