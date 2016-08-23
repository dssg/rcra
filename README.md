# EPA-NY 
This repository contains the entire NYSDEC project which was built using the DSSG 2015 EPA project's repo. 

## Setup Instructions
Create a file called default_profile in the root directory with the following lines. 
```
PGHOST=
PGDATABASE=
PGUSER=
PGPASSWORD=

SQL_DIR=
DATA_DIR=
 ```
The DIRs above have been created inside the mnt directory on the aws box.
default_profile has already been included in the .gitignore. Once this
file is filled in, export the variables to the shell:
```
set -a && source default_profile
```
Before you run drain, you have to

1) Make sure you are using Eric's virtual environment
2) Create a symbolic link in your home directory to epa-ny/ called epa/
3) Export the environmental variables stored in 'epa-ny/default_profile'

To do this...

### Setting up the virtualenv

Drain requires a couple Python packages to run and is built upon Python 2 at the moment. The best way to make sure these requirements are satisfied is just to get the the relevant Python virtualenv from Eric Potash.

Make sure you activate the virtualenv before executing any of the drain commands below.

### Creating the symlink 

The reason you have to do this is because drain currently is hard-coded to look for an 'epa' directory and all of our stuff is under the 'epa-ny' directory. To get around this, you can create a symbolic link in your home directory named 'epa' which points to 'epa-ny':
```
ln -s epa-ny epa
```
## RUNNING DRAIN 

Models are run by invoking drain from the command line. Start by creating a directory to store the model output. Remember this directory because the drain Python module will require that you specify this directory to begin exploring the output.
```
mkdir /mnt/data/nysdec/epa-ny/YOURUSERNAME
```
Then to run a particular drain model, return to the root directory of the repo and execute a command like:
```
cd ~
drain --outputdir /mnt/data/nysdec/epa-ny/YOURUSERNAME epa.model.workflow::MY_MODEL
```
This runs the 'MY_MODEL' model function specified in the workflow file 'model/workflow.py'.

## EVALUATING OUTPUT USING DRAIN

See the [Drain Handbook](exploring/Drain\ Handbook.ipynb). 
