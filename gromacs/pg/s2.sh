#!/bin/bash
#SBATCH -p short #gpu-p100, shortgpu, shortgpu-p100, short, bsudfq, 
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=48
#SBATCH -t 60:00
#SBATCH -o pg.o%j
#SBATCH -J phloroglucinol-eql
#  #SBATCH --exclusive

module unload gcc
module load gromacs
export OMP_NUM_THREADS=48
export GMXLIB=$HOME/GMXLIB
bash gro-step eql
bash gro-step eql2


