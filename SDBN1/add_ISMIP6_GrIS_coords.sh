#!/bin/bash
# Add x,y to ISMIP6 GrIS file

if [ $# -lt 2 ]
  then
    echo "Not enough arguments supplied. Need file in 1 and res in 2"
    exit
fi

fout=$1
res=$2

if [ $res == "01" ]; then

    ncap2 -O -s 'x=(array(-720000.,1000.,$x))' ${fout} ${fout}
    ncap2 -O -s 'y=(array(-3450000.,1000.,$y))' ${fout} ${fout}
     
elif [ $res == "02" ]; then

    ncap2 -O -s 'x=(array(-720000.,2000.,$x))' ${fout} ${fout}
    ncap2 -O -s 'y=(array(-3450000.,2000.,$y))' ${fout} ${fout}
     
elif [ $res == "04" ]; then
     
    ncap2 -O -s 'x=(array(-720000.,4000.,$x))' ${fout} ${fout}
    ncap2 -O -s 'y=(array(-3450000.,4000.,$y))' ${fout} ${fout}
    
elif [ $res == "05" ]; then
     
    ncap2 -O -s 'x=(array(-720000.,5000.,$x))' ${fout} ${fout}
    ncap2 -O -s 'y=(array(-3450000.,5000.,$y))' ${fout} ${fout}
    
elif [ $res == "08" ]; then
     
    ncap2 -O -s 'x=(array(-720000.,8000.,$x))' ${fout} ${fout}
    ncap2 -O -s 'y=(array(-3450000.,8000.,$y))' ${fout} ${fout}
     
elif [ $res == "16" ]; then
     
    ncap2 -O -s 'x=(array(-720000.,16000.,$x))' ${fout} ${fout}
    ncap2 -O -s 'y=(array(-3450000.,16000.,$y))' ${fout} ${fout}
     
elif [ $res == "32" ]; then
     
    ncap2 -O -s 'x=(array(-720000.,32000.,$x))' ${fout} ${fout}
    ncap2 -O -s 'y=(array(-3450000.,32000.,$y))' ${fout} ${fout}
     
elif [ $res == "64" ]; then
     
    ncap2 -O -s 'x=(array(-720000.,64000.,$x))' ${fout} ${fout}
    ncap2 -O -s 'y=(array(-3450000.,64000.,$y))' ${fout} ${fout}
     
fi

ncatted -a long_name,x,o,c,"Cartesian x-coordinate" ${fout}
ncatted -a units,x,o,c,"meter" ${fout}
ncatted -a axis,x,o,c,"X" ${fout}
ncatted -a long_name,y,o,c,"Cartesian y-coordinate" ${fout}
ncatted -a units,y,o,c,"meter" ${fout}
ncatted -a axis,y,o,c,"Y" ${fout}
