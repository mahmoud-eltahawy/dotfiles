export def enc [file_name] {
    if ($file_name | str contains 'enc') {
        openssl enc -in $file_name -aes-256-cbc -d out> ($file_name | str replace '.enc' '')
    } else {
        openssl enc -in $file_name -aes-256-cbc out> ($file_name + '.enc')
    }
    rm $file_name
}

export def ex [file_path : path] {
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

export def set_volume [vol] {
    pactl set-sink-volume 0 $vol;
}

export def record_screen [target = "screen_record"] {
    wl-screenrec --low-power=off --no-damage -f $"($target).mp4"
}

export def record_voice [target = "voice_record"] {
    ffmpeg -f alsa -ac 2 -i hw:0 $"($target).mp3"
}

export def record [target = "record"] {
    wl-screenrec --low-power=off --no-damage --audio -f $"($target).mp4"
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
