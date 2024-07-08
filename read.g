############################################################################
##
#W  read.g                 The XMODALG package               Zekeriya Arvasi
#W                                                            & Alper Odabas
#Y  Copyright (C) 2014-2024, Zekeriya Arvasi & Alper Odabas,  
##

## read the actual code 
ReadPackage( "xmodalg", "lib/algebra.gi" );
ReadPackage( "xmodalg", "lib/alg2obj.gi" );  
ReadPackage( "xmodalg", "lib/module.gi" );
ReadPackage( "xmodalg", "lib/alg2map.gi" );  

## temporary fix 
RereadPackage( "xmodalg", "lib/vspchom.gi" ); 
