#!/bin/bash

dot_files_dir=$HOME/.config/dot-files

create_dir_arr=("i3" "i3status" "rofi" "alacritty" "lazygit" "nvim" "fcitx5")
for dir in ${create_dir_arr[@]}; do
    ln -s "${dot_files_dir}/${dir}" "$HOME/.config/${dir}"
done

cp "${dot_files_dir}/xprofile" "$HOME/.xprofile"
cp "${dot_files_dir}/zshrc" "$HOME/.zshrc"
sed -i '/^export http/d' "$HOME/.zshrc"
