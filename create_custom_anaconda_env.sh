#!/bin/bash

### --------------------------------------------------------------
### Method 1: Create a new Python environment, cloned from default
### --------------------------------------------------------------
# What is the default environment?
conda info --envs | grep '^root' | awk '{print $NF}'
default_env=$(conda info --envs | grep '^root' | awk '{print $NF}')

# 
# ----------------------------------
new_env_dir=${HOME}/conda_envs   # new dir for envs
mkdir -p $new_env_dir

# Clone default env into home directory 
# (i.e. where we have write permissions)

env_name=test_env   # name for new env
#conda create --yes --prefix ${new_env_dir}/${env_name} --clone $default_env
conda create --yes --prefix ${new_env_dir}/${env_name} --clone root

