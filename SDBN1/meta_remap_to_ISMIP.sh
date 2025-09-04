# run remap for monthly variables

# conda encironment with netcdf tools
# conda create -n nc 
# conda activate nc
# conda install -c conda-forge cdo nco netCDF4 scipy

# conda activate nc

#svar=smb_rec
#tvar=acabf
#dirvarname=smb_rec
#filevarname=smb_rec

#svar=precipcorr
#tvar=precip
#dirvarname=precip
#filevarname=precip

#svar=snowmeltcorr
#tvar=snowmelt
#dirvarname=snowmelt
#filevarname=snowmelt

svar=runoffcorr
tvar=runoff
dirvarname=runoff
filevarname=runoff

### historical
aesm=CESM2-WACCM
ascen=historical
inpath=/nird/datalake/NS5011K/ISMIP/ISMIP7/GrIS/RDP/SDBN1/download/IND/${dirvarname}
outpath=/nird/datalake/NS5011K/ISMIP/ISMIP7/GrIS/Forcing/Surface/${aesm}/${ascen}/mon/${tvar}/SDBN1
mkdir -p $outpath

#for year in {1850..1852}; do # testing
for year in {1850..1949}; do

    infile=${inpath}/${filevarname}.${year}.IND-1.1km.MM.nc
    outfile=${outpath}/${tvar}_${aesm}_${ascen}_SDBN1_${year}.nc 
    . ./remap_to_ISMIP_func.sh 

done

####
aesm=CESM2-WACCM
ascen=historical
inpath=/nird/datalake/NS5011K/ISMIP/ISMIP7/GrIS/RDP/SDBN1/download/HIST/${dirvarname}
outpath=/nird/datalake/NS5011K/ISMIP/ISMIP7/GrIS/Forcing/Surface/${aesm}/${ascen}/mon/${tvar}/SDBN1
mkdir -p $outpath

#for year in {1950..1952}; do # testing
for year in {1950..2014}; do

    infile=${inpath}/${filevarname}.${year}.HIST-1.1km.MM.nc
    outfile=${outpath}/${tvar}_${aesm}_${ascen}_SDBN1_${year}.nc 
    . ./remap_to_ISMIP_func.sh 

done

#### projection
aesm=CESM2-WACCM
ascen=ssp585
inpath=/nird/datalake/NS5011K/ISMIP/ISMIP7/GrIS/RDP/SDBN1/download/SSP-23C/${dirvarname}
outpath=/nird/datalake/NS5011K/ISMIP/ISMIP7/GrIS/Forcing/Surface/${aesm}/${ascen}/mon/${tvar}/SDBN1
mkdir -p $outpath

#for year in {2015..2017}; do # testing
for year in {2015..2299}; do

    infile=${inpath}/${filevarname}.${year}.CESM2-WACCM.SSP8.5-1.1km.MM.nc
    outfile=${outpath}/${tvar}_${aesm}_${ascen}_SDBN1_${year}.nc 
    . ./remap_to_ISMIP_func.sh 

done
