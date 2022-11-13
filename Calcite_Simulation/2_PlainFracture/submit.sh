#!/bin/bash

cycle=
loc="$(pwd)"
ssh -F $HOME/eofe-cluster/linux/config eofe7.mit.edu "
ls; 
scp -r andrew@10.58.7.144:${loc} .; 
ls;
cd ${loc##*/};
sbatch job_eofe${cycle}.sh;

"
#sleep 5;
#cd ../90;
#ls;
#sbatch job90.sh;
#HOST=-F $HOME/eofe-cluster/linux/config eofe7.mit.edu
#LOC=andrew@10.58.7.144:/home/andrew/source/Process_calcite

