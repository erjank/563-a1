#!/bin/bash
#SBATCH -p short #gpu-p100, shortgpu, shortgpu-p100, short, bsudfq, 
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=48
#SBATCH -t 60:00
#SBATCH -o perf1
#SBATCH -J perf1
#  #SBATCH --exclusive

module unload gcc
module load gromacs
export OMP_NUM_THREADS=48
export GMXLIB=$HOME/GMXLIB
mpirun -np 1 -npernode 48 gmx_mpi solvate -cp conf.gro -o conf.gro -cs tip4p -p topol.top -box 2.3 2.3 2.3
bash gro-step min
bash gro-step min2
bash gro-step eql
bash gro-step eql2
bash gro-step prod


