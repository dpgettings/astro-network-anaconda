#!/bin/bash

### --------------------------------------------------------------
### Create a new Anaconda/Python environment, cloned from default
### --------------------------------------------------------------
env_name=custom_env   # name for new Anaconda environment
default_env=$(conda info --envs | grep '^root' | awk '{print $NF}')   # Absolute path of the 'root' environment

### Set up writeable location for custom environments ###
new_env_dir=${HOME}/conda_envs; mkdir -p $new_env_dir   # New dir to contain Anaconda environments

### Modify Conda Configuration ###
printf '\n%s\n' '>>>>> Configuring Conda <<<<<' 
conda config --add envs_dirs $new_env_dir   # Tell Conda that this directory will contain Anaconda environments
conda config --set changeps1 no   # Don't change the default bash prompt when activating environment
conda config --add create_default_packages pip   # Make sure pip is installed
printf '%s\n' 'Contents of ~/.condarc:'
awk '{print "> "$0}' ~/.condarc

### Create "package cache" with symlinks to save space
pkg_src=${default_env}/pkgs
pkg_dst=${new_env_dir}/.pkgs; mkdir -p $pkg_dst   # New environment package cache dir
ln -s ${pkg_src}/* ${pkg_dst}/ 2> /dev/null

### Create a modifiable clone of the 'root' Anaconda environment ###
printf '\n%s\n' '>>>>> Creating New Anaconda Environment <<<<<'
conda create --quiet --no-deps --yes --name ${env_name} --clone root
conda info --env   # Double check that we created a new environment

### Use this environment as the default ###
printf '\n\n%s \n%s \n%s \n' \
    "## Added automatically by ${0}" \
    "## $(date)" "source activate ${env_name}" #>> ~/.cshrc   # Modify .cshrc file to auto-activate $env_name on login

