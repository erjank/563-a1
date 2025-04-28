#!/bin/bash
#SBATCH -p short #gpu-p100, shortgpu, shortgpu-p100, short, bsudfq, 
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=48
#SBATCH -t 30:00
#SBATCH -o perf1
#SBATCH -J perf1
#  #SBATCH --exclusive

module unload gcc
module load gromacs
export OMP_NUM_THREADS=48
export GMXLIB=$HOME/GMXLIB
mpirun -np 1 -npernode 48 gmx_mpi grompp -f mdp/min.mdp -o min.tpr -pp min.top -po min.mdp
mpirun -np 1 -npernode 48 gmx_mpi mdrun -s min.tpr -o min.trr -x min.xtc -c min.gro -e min.edr -g min.log
mpirun -np 1 -npernode 48 gmx_mpi grompp -f mdp/min2.mdp -o min2.tpr -pp min2.top -po min2.mdp -c min2.gro
mpirun -np 1 -npernode 48 gmx_mpi mdrun -s min2.tpr -o min2.trr -x min2.xtc -c min2.gro -e min2.edr -g min2.log
mpirun -np 1 -npernode 48 gmx_mpi grompp -f mdp/eql.mdp -o eql.tpr -pp eql.top -po eql.mdp -c min2.gro
mpirun -np 1 -npernode 48 gmx_mpi mdrun -s eql.tpr -o eql.trr -x eql.xtc -c eql.gro -e eql.edr -g eql.log
mpirun -np 1 -npernode 48 gmx_mpi grompp -f mdp/eql2.mdp -o eql2.tpr -pp eql2.top -po eql2.mdp -c eql.gro
mpirun -np 1 -npernode 48 gmx_mpi mdrun -s eql2.tpr -o eql2.trr -x eql2.xtc -c eql2.gro -e eql2.edr -g eql2.log
mpirun -np 1 -npernode 48 gmx_mpi grompp -f mdp/prd.mdp -o prd.tpr -pp prd.top -po prd.mdp -c eql2.gro
mpirun -np 1 -npernode 48 gmx_mpi mdrun -s prd.tpr -o prd.trr -x prd.xtc -c prd.gro -e prd.edr -g prd.log

