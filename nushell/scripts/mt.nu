
export def enc [file_name] {
    if ($file_name | str contains 'enc') {
        openssl enc -in $file_name -aes-256-cbc -d out> ($file_name | str replace '.enc' '')
    } else {
        openssl enc -in $file_name -aes-256-cbc out> ($file_name + '.enc')
    }
    rm $file_name
}

export def ex [file_name : string] {
  let extensions = [
      ["extension" "command"];
      ["tar.bz2"   "tar xjf"]
      ["tar.gz"    "tar xzf"]
      ["bz2"       "bunzip2"]
      ["rar"       "unrar x"]
      ["gz"        "gunzip"] 
      ["tar"       "tar xf"] 
      ["tbz2"      "tar xjf"]
      ["tgz"       "tar xzf"]
      ["zip"       "unzip"]
      ["Z"         "uncompress"]
      ["7z"        "7z x"] 
      ["deb"       "ar x"] 
      ["tar.xz"    "tar xf"] 
      ["tar.zst"   "tar xf"] 
    ]
    let command = $extensions | filter {|x| $file_name | str contains $x.extension} | get command | first

    if $command != null {
        ^$command $file_name
    } else {
        echo "not supported format"
    }
}

export def set_volume [vol] {
    pactl set-sink-volume 0 $vol;
}

export def record_screen [target] {
    ffmpeg -framerate 30 -f x11grab -i :0.0 $"($target).mp4"
}

export def record_voice [target] {
    ffmpeg -f alsa -ac 2 -i hw:0 $"($target).mp3"
}


export def record_both [target] {
    ffmpeg -framerate 30 -f x11grab -i :0.0 -f alsa -ac 2 -i hw:0 $"($target).mp4"
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
