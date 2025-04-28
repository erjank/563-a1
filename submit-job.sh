#!/bin/bash
#SBATCH -p (partition name) #gpu-p100, shortgpu, shortgpu-p100, short, bsudfq, 
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=48
#SBATCH --gres=gpu:(number of GPUs requested) #HOOMD & LAMMPS peeps, Gromacs peeps remove
#SBATCH -t DD-HH:MM:SS
#SBATCH -o (output file name)
#SBATCH -J (job name)
#SBATCH --exclusive

module load XXX
export OMP_NUM_THREADS=4
export GMXLIB=$HOME/GMXLIB
#mpirun -np 1 -npernode 4 gmx_mpi ...
#mpirun -np 1 -npernode 14 lmp -sf gpu -pk gpu 1 -in in.nvt...
