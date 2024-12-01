export def enc [file_name] {
    if ($file_name | str contains 'enc') {
        openssl enc -in $file_name -aes-256-cbc -d out> ($file_name | str replace '.enc' '')
    } else {
        openssl enc -in $file_name -aes-256-cbc out> ($file_name + '.enc')
    }
    rm $file_name
}

export def ex [file_name : string] {
    let exten = $file_name | parse "{name}.{exten}" | get exten | first | str trim;
    match $exten {
      "tar.bz2" => { tar xjf $file_name }
      "tar.gz" => { tar xzf $file_name }
      "tar" => { tar xf $file_name }
      "tbz2" => { tar xjf $file_name }
      "tgz" => { tar xzf $file_name }
      "tar.xz" => { tar xf $file_name }
      "tar.zst" => { tar xf $file_name }
      "zip" => { unzip $file_name }
      "7z" => { 7z x $file_name }
      "rar" => { unrar x $file_name }
      "bz2" => { bunzip2 $file_name }
      "gz" => { gunzip $file_name }
      "Z" => { uncompress $file_name }
      "deb" => { ar x $file_name }
      _ => {print $"not supported extension ($exten)"}
    };
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
