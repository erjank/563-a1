#!/bin/bash
module load gromacs
cp -r $GMXDATA/top ~/GMXLIB
cp pg.rtp ~/GMXLIB/opls.ff/.
gmx_mpi pdb2gmx -f pg.pdb # 15 then 2
gmx_mpi solvate -cs tip4p -o conf.gro -box 2.3 2.3 2.3 -p topol.top



