#!/usr/bin/env bash

function handle {
    if [[ ${1:0:10} == "openwindow" ]]
    then
        window_id=$(echo $1 | cut --delimiter ">" --fields=3 | cut --delimiter "," --fields=1)
        workspace_id=$(echo $1 | cut --delimiter ">" --fields=3 | cut --delimiter "," --fields=2)
        windows=$(hyprctl workspaces -j | jq ".[] | select(.id == $workspace_id) | .windows")

        if [[ $windows -eq 1 ]]
        then
            hyprctl setprop address:0x$window_id forcenoborder 1 lock
        elif [[ $windows -eq 2 ]]
        then
            addresses=$(hyprctl clients -j | jq -r --arg foo "$foo" ".[] | select(.workspace.id == $workspace_id) | .address")
            for address in $addresses
            do
                if [[ "$address" != "$window_id" ]]; then
                    hyprctl setprop address:$(echo $address | xargs) forcenoborder 0 lock
                fi
            done
        fi

    elif [[ ${1:0:10} == "movewindow"  ]]
    then
        window_id=$(echo $1 | cut --delimiter ">" --fields=3 | cut --delimiter "," --fields=1)
        workspace_id=$(echo $1 | cut --delimiter ">" --fields=3 | cut --delimiter "," --fields=2)
        windows=$(hyprctl workspaces -j | jq ".[] | select(.id == $workspace_id) | .windows")

        if [[ $windows -eq 1 ]]
        then
            hyprctl setprop address:0x$window_id forcenoborder 1 lock
        elif [[ $windows -eq 2 ]]
        then
            addresses=$(hyprctl clients -j | jq -r --arg foo "$foo" ".[] | select(.workspace.id == $workspace_id) | .address")
            for address in $addresses
            do
                if [[ "$address" != "$window_id" ]]; then
                    hyprctl setprop address:$(echo $address | xargs) forcenoborder 0 lock
                fi
            done
        fi

        # Handle all the other workspaces with only one window
        single_window_workspaces=$(hyprctl workspaces -j | jq '.[] | select(.windows == 1)' | jq ".id")
        for workspace in $single_window_workspaces
        do
            window=$(hyprctl clients -j | jq ".[] | select(.workspace.id == $workspace) | .address")
            hyprctl setprop address:$(echo $window | xargs) forcenoborder 1 lock
        done

    elif [[ ${1:0:11} == "closewindow" ]]
    then
        workspace_id=$(hyprctl activewindow -j | jq ".workspace.id")
        windows=$(hyprctl workspaces -j | jq ".[] | select(.id == $workspace_id) | .windows")

        if [[ $windows -eq 1 ]]
        then
            window_id=$(hyprctl activewindow -j | jq -r ".address")
            hyprctl setprop address:$window_id forcenoborder 1 lock
        fi

    elif [[ ${1:0:18} == "changefloatingmode" ]]
    then
        floating_status=$(echo $1 | cut --delimiter ">" --fields 3 | cut --delimiter "," --fields 2)
        address="0x$(echo $1 | cut --delimiter ">" --fields 3 | cut --delimiter "," --fields 1)"
        workspace_id=$(hyprctl clients -j | jq --arg address "$address" '.[] | select(.address == $address) | .workspace.id')
        if [[ $floating_status -eq 1 ]]
        then
            hyprctl setprop address:$address forcenoborder 0 lock
        else
            no_windows=$(hyprctl workspaces -j | jq ".[] | select(.id == $workspace_id) | .windows")
            if [[ $no_windows -eq 1 ]]
            then
                hyprctl setprop address:$address forcenoborder 1 lock
            else
                hyprctl setprop address:$address forcenoborder 0 lock
            fi
        fi
    fi
}

socat - UNIX-CONNECT:/tmp/hypr/$(echo $HYPRLAND_INSTANCE_SIGNATURE)/.socket2.sock | while read line; do handle $line; done
