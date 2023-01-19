#!/bin/bash

machinefile=machinefile.cuda
number_of_iterations=2
nwarmup=1
# gpu memory
minN=1000
maxN=20000
stepN=1000

for ((a=${minN};a<=${maxN};a+=${stepN})); do
        configfile=configfile.${a}
        echo "number_of_iterations = ${number_of_iterations}" > ${configfile}
        echo "number_of_warmup_steps = ${nwarmup}" >> ${configfile}
        echo "mnk=$a $a $a" >> ${configfile}
        echo "datatype = real32" >> ${configfile}
        ntcl-examples/bin/timed_mm.x configfile=${configfile} machinefile=${machinefile} > output.${a}
done

