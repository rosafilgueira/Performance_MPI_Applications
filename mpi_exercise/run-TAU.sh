#!/bin/bash

## Especifica l‚Äôint√®rpret de comandes pel treball (Bash)
#$ -S /bin/bash

## Exporta totes les variables d‚Äôentorn al context del treball
#$ -V

## Executa el treball desde el directori de treball actual.
#$ -cwd

## La cua sobre la que es vol llan√ßar (high.q, low.q, all.q)
#$ -q high.q

## Entorn de programaci√≥ paral¬∑lel pel treball i numero de processos
#$ -pe mpich 4

## El nom del treball (opcional)
#$ -N tau_hello

MPICH_MACHINES=$TMPDIR/mpich_machines
cat $PE_HOSTFILE | awk '{print $1":"$2}' > $MPICH_MACHINES

export TAU_TRACE=1  # This line is needed only for tracing.
export TAU_PROFILE=1

## Aquesta l√≠nia es la que realment executa l'aplicaci√≥
mpiexec -f $MPICH_MACHINES -n $NSLOTS tau_exec -T PROFILE ./hello


rm -rf $MPICH_MACHINES
