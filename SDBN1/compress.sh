#!/bin/bash
# compress files
# Check and manually move compressed files afterwards!

set -x
set -e

avar=runoff
#avar=acabf
#avar=snowmelt
#avar=precip

outpath=/nird/datalake/NS5011K/ISMIP/ISMIP7/GrIS/Forcing/Surface/${aesm}/${ascen}/mon/${tvar}/SDBN1

# historical
inpath=../../Forcing/Surface/CESM2-WACCM/historical/mon/${avar}/SDBN1
outpath=../../Forcing/Surface/CESM2-WACCM/historical/mon/${avar}/SDBN1_compr

mkdir -p ${outpath}

#for year in {1850..1852}; do
for year in {1850..2014}; do

    nccopy -d 9 ${inpath}/${avar}_CESM2-WACCM_historical_SDBN1_${year}.nc ${outpath}/${avar}_CESM2-WACCM_historical_SDBN1_${year}.nc
    
done


# projection
inpath=../../Forcing/Surface/CESM2-WACCM/ssp585/mon/${avar}/SDBN1
outpath=../../Forcing/Surface/CESM2-WACCM/ssp585/mon/${avar}/SDBN1_compr

mkdir -p ${outpath}

#for year in {2015..2017}; do
for year in {2015..2299}; do

    nccopy -d 9 ${inpath}/${avar}_CESM2-WACCM_ssp585_SDBN1_${year}.nc ${outpath}/${avar}_CESM2-WACCM_ssp585_SDBN1_${year}.nc
    
done
