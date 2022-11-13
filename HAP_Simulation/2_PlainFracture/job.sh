#!/bin/bash
#SBATCH --job-name="HAP_1930"
#SBATCH --qos=regular
#SBATCH --constraint=haswell
#SBATCH --mem=40G
#SBATCH -N 5
#SBATCH -n 80
#SBATCH --time=1:30:00
#SBATCH --exclusive

#srun check-mpi.intel.cori

module load lammps/2018.12.12-hsw

srun lmp_cori < HAP_1930.in > HAP_1930tenz

module unload lammps/2018.12.12-hsw

