export def enc [file_name] {
    if ($file_name | str contains 'enc') {
        openssl enc -in $file_name -aes-256-cbc -d out> ($file_name | str replace '.enc' '')
    } else {
        openssl enc -in $file_name -aes-256-cbc out> ($file_name + '.enc')
    }
    rm $file_name
}

export def ex [file_path : path] {
    let exten = $file_path | path basename | parse "{name}.{exten}" | get exten | first;
    match $exten {
      "tar.bz2" => { tar xjf $file_path }
      "tar.gz" => { tar xzf $file_path }
      "tar" => { tar xf $file_path }
      "tbz2" => { tar xjf $file_path }
      "tgz" => { tar xzf $file_path }
      "tar.xz" => { tar xf $file_path }
      "tar.zst" => { tar xf $file_path }
      "zip" => { unzip $file_path }
      "7z" => { 7z x $file_path }
      "rar" => { unrar x $file_path }
      "bz2" => { bunzip2 $file_path }
      "gz" => { gunzip $file_path }
      "Z" => { uncompress $file_path }
      "deb" => { ar x $file_path }
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
