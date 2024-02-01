


if [[ $- == *i* ]]
then
    if [[ -z "$ZELLIJ" ]]; then
        if [[ "$ZELLIJ_AUTO_ATTACH" == "true" ]]; then
            zellij --config ~/magit/dotfiles/zellij/config.kdl attach -c 
        else
            zellij --config ~/magit/dotfiles/zellij/config.kdl
        fi

        if [[ "$ZELLIJ_AUTO_EXIT" == "true" ]]; then
            exit
        fi
    fi
fi

