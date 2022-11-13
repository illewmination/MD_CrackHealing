#!/bin/bash
#SBATCH --job-name="HAPWater"
##SBATCH --gres=gpu:1 
#SBATCH --partition=sched_mit_buehler #any_quicktest #*#sched_mit_buehler
#SBATCH --constraint=centos7
#SBATCH --mem=40G
#SBATCH -N 5#1 #5
#SBATCH -n 80#16 #80
#SBATCH --time=9:00:00 #15:00 #6:00:00
#SBATCH --workdir=.
#SBATCH --output=cout.txt
#SBATCH --error=cerr.txt
#SBATCH --exclusive
###SBATCH --test-only

echo
echo "============================ Messages from Goddess ============================"
echo " * Job starting from: "`date`
echo " * Job ID           : "$SLURM_JOBID
echo " * Job name         : "$SLURM_JOB_NAME
echo " * Working directory: "${SLURM_SUBMIT_DIR/$HOME/"~"}
echo "==============================================================================="
echo

module load lammps/12Dec18

mpirun lmp_mpi < in.HAPWater > HAPWater

module unload lammps/12Dec18

echo
echo "============================ Messages from Goddess ============================"
echo " * Job ended at     : "`date`
echo "==============================================================================="
echo
