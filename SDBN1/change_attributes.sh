#!/bin/bash
# change nc attributes

set -x
set -e

avar=runoff
#avar=snowmelt

# historical
inpath=../../Forcing/Surface/CESM2-WACCM/historical/mon/${avar}/SDBN1

for year in {1850..2014}; do

    ncfile=${inpath}/${avar}_CESM2-WACCM_historical_SDBN1_${year}.nc
    # Change attributes
    ncatted -h -a units,${avar},o,c,"mm w.e. yr-1" $ncfile
    
done

# projection
inpath=../../Forcing/Surface/CESM2-WACCM/ssp585/mon/${avar}/SDBN1

for year in {2015..2299}; do

    ncfile=${inpath}/${avar}_CESM2-WACCM_ssp585_SDBN1_${year}.nc
    # Change attributes
    ncatted -h -a units,${avar},o,c,"mm w.e. yr-1" $ncfile
    
done
