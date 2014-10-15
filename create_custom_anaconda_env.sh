#!/bin/bash

### --------------------------------------------------------------
### Method 1: Create a new Anaconda/Python environment, cloned from default
### --------------------------------------------------------------
env_name=custom_env   # name for new Anaconda environment

### Set up writeable location for custom environments ###
new_env_dir=${HOME}/conda_envs   # New dir to contain Anaconda environments
mkdir -p $new_env_dir
# Tell Conda that this directory will contain Anaconda environments
conda config --add envs_dirs $new_env_dir
printf '\n%s\n%s\n' '>>>>> Configuring Conda <<<<<' 'Contents of ~/.condarc:'; awk '{print "> "$0}' ~/.condarc

### Create a modifiable clone of the 'root' Anaconda environment ###
printf '\n%s\n' '>>>>> Creating New Anaconda Environment <<<<<'
conda create --yes --quiet --name ${env_name} --clone root
# Double check that we created a new environment
conda info --env

### Install Pip into our new environment ###
# >> Will allow downloading non-conda Python packages
# Use -n flag to indicate the new environment
printf '\n%s\n' '>>>>> Installing Pip (Just to be Sure) <<<<<'
conda install --no-deps --yes -n ${env_name} pip

### Use this environment as the default ###
# Add this line to ~/.cshrc?
#printf '\n\n%s \n%s \n%s \n' "## Line added automatically by ${0}" "## $(date)" "source activate ${env_name}" >> ~/.cshrc
printf '\n\n%s \n%s' "## Run this command to use your new Anaconda environment:" "source activate ${env_name}"
