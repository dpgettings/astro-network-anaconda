#!/bin/bash

### --------------------------------------------------------------
### Method 1: Create a new Python environment, cloned from default
### --------------------------------------------------------------

# Set up location for custom environments
# ---------------------------------------
# New dir for envs
new_env_dir=${HOME}/conda_envs   
mkdir -p $new_env_dir
# Tell Conda that this directory will contain Python environments
conda config --add envs_dirs $new_env_dir
printf '\n   %s\n' "'${new_env_dir}' added to environment locations in ~/.condarc"

# Clone default env into home directory 
# (i.e. where we have write permissions)
env_name=test_env   # name for new env
#conda create --yes --prefix ${new_env_dir}/${env_name} --clone $default_env
#conda create --yes --prefix ${new_env_dir}/${env_name} --clone root

