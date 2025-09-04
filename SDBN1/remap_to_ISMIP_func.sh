#!/bin/bash
# Remap BN to ISMIP6 grid

# path to weights
pwgts=../Data/Grid/

# resolution
inres=01000m
outres=01000m

# input/output grid description files
ingdf=./Grid/grid_BRISM_GrIS_${inres}.nc
outgdf=../Data/Grid/grid_ISMIP6_GrIS_${outres}.nc
#weights
wgts=./Grid/weights_ycon_BRISM${inres}_e${outres}.nc

#####################################################################################
# Conservative
#####################################################################################

#### All in one 
#cdo remapycon,${outgdf} -setmisstoc,0 -setgrid,${ingdf} ${infile} ${outfile}

### With weights file
# produce remap weights file
#cdo genycon,${outgdf} -setmisstoc,0 -setgrid,${ingdf} ${infile} ${wgts}
# remap with predefined weights
echo remapping ${infile}
cdo remap,${outgdf},${wgts} -setmisstoc,0 -setgrid,${ingdf} ${infile} ${outfile} #2> /dev/null

# remove old grid info
ncks -C -O -x -v LON,LAT $outfile $outfile
# remove lat, lon and the bounds
ncks -C -O -x -v lat,lon,lat_bnds,lon_bnds $outfile $outfile

# Add ISMIP xy
outres2=${outres%???m}
./add_ISMIP6_GrIS_coords.sh $outfile $outres2

if [ "$svar" != "$tvar" ] 
then   ncrename -v ${svar},${tvar} ${outfile}
fi

# Attributes
if [[ "$tvar" == "runoff" ]]; then
    ncatted -h -a standard_name,runoff,o,c,"land_ice_runoff_flux" $outfile
    ncatted -h -a long_name,runoff,o,c,"ice sheet runoff" $outfile
    ncatted -h -a units,runoff,o,c,"mm w.e. yr-1" $outfile
    ncatted -h -a actual_range,runoff,d,, $outfile
    ncatted -a units,time,o,c,"months since 1850-01-15 00:00:0" $outfile
    ncatted -a calendar,time,o,c,"noleap" $outfile
elif [[ "$tvar" == "acabf" ]]; then
    ncatted -h -a standard_name,acabf,o,c,"land_ice_surface_specific_mass_balance_flux" $outfile
    ncatted -h -a long_name,acabf,o,c,"surface mass balance flux" $outfile
    ncatted -h -a units,acabf,o,c,"mm w.e. yr-1" $outfile
    ncatted -h -a actual_range,acabf,d,, $outfile
    ncatted -a units,time,o,c,"months since 1850-01-15 00:00:0" $outfile
    ncatted -a calendar,time,o,c,"noleap" $outfile
elif [[ "$tvar" == "precip" ]]; then
    ncatted -h -a standard_name,precip,o,c,"precipitation_flux" $outfile
    ncatted -h -a long_name,precip,o,c,"precipitation" $outfile
    ncatted -h -a units,precip,o,c,"mm w.e. yr-1" $outfile
    ncatted -h -a actual_range,precip,d,, $outfile
    ncatted -a units,time,o,c,"months since 1850-01-15 00:00:0" $outfile
    ncatted -a calendar,time,o,c,"noleap" $outfile
elif [[ "$tvar" == "snowmelt" ]]; then
    ncatted -h -a standard_name,snowmelt,o,c,"surface_snow_melt_flux" $outfile
    ncatted -h -a long_name,snowmelt,o,c,"snowmelt" $outfile
    ncatted -h -a units,snowmelt,o,c,"mm w.e. yr-1" $outfile
    ncatted -h -a actual_range,snowmelt,d,, $outfile
    ncatted -a units,time,o,c,"months since 1850-01-15 00:00:0" $outfile
    ncatted -a calendar,time,o,c,"noleap" $outfile
elif [[ "$tvar" == "tas" ]]; then
    ncatted -h -a standard_name,tas,o,c,"air_temperature" $outfile
    ncatted -h -a long_name,tas,o,c,"Near-Surface Air Temperature" $outfile
    ncatted -h -a units,tas,o,c,"K" $outfile
    ncatted -h -a actual_range,tas,d,, $outfile
    ncatted -a units,time,o,c,"months since 1850-01-15 00:00:0" $outfile
    ncatted -a calendar,time,o,c,"noleap" $outfile
fi

# Manually fix monthly time axis
ncap2 -O -s "time=time-1+(${year}-1850)*12" $outfile $outfile


# fill missing with zero; may need to change for other variables!!
#ncap2 -O -s "t2m=t2m; t2m.change_miss(0.); t2m.delete_miss() " ${outfile} ${outfile}

if [[ "$tvar" == "acabf" ]]; then
    cdo -setmisstoc,0 ${outfile} tmp.nc
    /bin/mv tmp.nc ${outfile}
elif [[ "$tvar" == "runoff" ]]; then
    cdo -setmisstoc,0 ${outfile} tmp.nc
    /bin/mv tmp.nc ${outfile}
elif [[ "$tvar" == "precip" ]]; then
    cdo -setmisstoc,0 ${outfile} tmp.nc
    /bin/mv tmp.nc ${outfile}
elif [[ "$tvar" == "snowmelt" ]]; then
    cdo -setmisstoc,0 ${outfile} tmp.nc
    /bin/mv tmp.nc ${outfile}
elif [[ "$tvar" == "tas" ]]; then
    cdo -setmisstoc,0 ${outfile} tmp.nc
    /bin/mv tmp.nc ${outfile}
fi

# Info
ncatted -a title,global,d,, $outfile
ncatted -a grid,global,d,, $outfile
ncatted -a Comment,global,o,c,"Prepared for ISMIP7 by Heiko Goelzer heig@norceresearch.no" $outfile
ncatted -a Source,global,o,c,"SDBN1 - Brice Noel -  bnoel@uliege.be" $outfile
