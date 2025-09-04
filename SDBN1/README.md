# Process SDBN1 data (statistical downscaling Brice Noel) for ISMIP7

## Processing Monthly variables
meta_remap_to_ISMIP.sh
  remap_to_ISMIP_func.sh


## Monthly runoff processing
meta_remap_runoff_to_ISMIP.sh
  remap_runoff_to_ISMIP_func.sh
    add_ISMIP_GrIS_coords.sh

## Change attributes
change_attributes.sh

## Compress files
compress.sh

