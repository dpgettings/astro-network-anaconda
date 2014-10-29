import os
import subprocess as sp

# Try importing argparse. If argparse is not available, use wrapper 
# function to make optparse behave like argparse
try: from argparse import ArgumentParser
except ImportError: from optparse import OptionParser


### Assuming argparse imported correctly
"""
    Arguments we want:
       name for new env
       location for new env
          --> Default: $HOME/conda_envs
       old env to clone from
"""

parser = ArgumentParser()
parser.add_argument('-n', '--name', dest="env_name", default="custom_env", 
                    help="Name for new Anaconda environment.")
# parser.add_argument('-n', '--name', dest="env_name", default="custom_env", 
#                     help="Name for new Anaconda environment.")


envs_proc = sp.Popen("conda info --envs | grep '^root'", shell=True, stdout=sp.PIPE)
default_env_abspath = envs_proc.communicate()[0].split()[-1]
print default_env_abspath



