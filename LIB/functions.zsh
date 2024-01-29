function install_functions() {
    echo
    read -k1 "install?Install related convenience functions? RECOMMENDED (y/n): "
    echo
    if [[ ! ${install} =~ ^[Yy]$ ]]; then
        return
    fi

    functions_dir=~/.devopschris/functions
    target_dir=$functions_dir/$1
    functions_list=($(ls functions))

    echo Installing: ${functions_list}
    mkdir -p $target_dir
    cp -r functions/* $target_dir

    grep -qxF 'source ~/.devopschris/functions/activate' ~/.zshenv 2> /dev/null \
      || echo 'source ~/.devopschris/functions/activate' >> ~/.zshenv

    cat <<'EOF' >$functions_dir/activate
#!/usr/bin/env zsh
directory_list=($(ls -d ~/.devopschris/functions/*/))

fpath=($directory_list $fpath)

for dir_name in ${directory_list[@]}; do
  for app in $(ls $dir_name); do
    autoload $app
  done
done
EOF

    # Check if the script is not already sourced
    if [ "$ZSH_EVAL_CONTEXT" != "toplevel" ]; then
        echo "Sourcing the activation script automatically."
        # Source the activation script automatically
        source $functions_dir/activate
    else
        echo "To activate the functions in the current shell, run the following once this setup is finished:"
        echo
        echo '    source ~/.devopschris/functions/activate'
        echo
    fi

    echo "Functions have been installed and will be available in a new shell."
}
