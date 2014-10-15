#!/bin/bash

### --------------------------------------------------------------
### Create a new Anaconda/Python environment, cloned from default
### --------------------------------------------------------------
env_name=custom_env   # name for new Anaconda environment
default_env=$(conda info --envs | grep '^root' | awk '{print $NF}')   # Absolute path of the 'root' environment

### Set up writeable location for custom environments ###
new_env_dir=${HOME}/conda_envs; mkdir -p $new_env_dir   # New dir to contain Anaconda environments

### Modify Conda Configuration (changes ~/.condarc) ###
conda config --add envs_dirs $new_env_dir   # Tell Conda that this directory will contain Anaconda environments
conda config --set changeps1 no   # Don't change the default bash prompt when activating environment
conda config --add create_default_packages pip   # Make sure pip is installed

### Create "package cache" with symlinks to save space
pkg_src=${default_env}/pkgs   # Location of root dir package cache
pkg_dst=${new_env_dir}/.pkgs; mkdir -p $pkg_dst   # New environment package cache dir
ln -s ${pkg_src}/* ${pkg_dst}/ 2> /dev/null   # Symlink all contents (tarballs AND dirs) of root cache to new environment cache

### Create a modifiable clone of the 'root' Anaconda environment ###
conda create --quiet --no-deps --yes --name ${env_name} --clone root

### Enable using this environment as the default ###
printf '\n%s \n%s \n%s \n' \
    "## Added automatically by ${0}" "## $(date)" \
    "source activate ${env_name}" >> ~/.bashrc   # Modify .bashrc file to auto-activate $env_name on login
printf '\n%s \n%s \n%s \n%s \n' \
    "## Added automatically by ${0}" "## $(date)" "set path = ( ${new_env_dir}/${env_name}/bin \$path )" \
    "setenv CONDA_DEFAULT_ENV ${env_name}" >> ~/.cshrc # Modify .bashrc file to point to $env_name on login

