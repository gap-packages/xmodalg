############################################################################
##
#W  init.g                 The XMODALG package               Zekeriya Arvasi
#W                                                            & Alper Odabas
#Y  Copyright (C) 2014-2024, Zekeriya Arvasi & Alper Odabas,  
##

if not IsBound( PreImagesRepresentativeNC ) then 
    BindGlobal( "PreImagesRepresentativeNC", PreImagesRepresentative ); 
fi; 

##  read the function declarations
ReadPackage( "xmodalg", "lib/algebra.gd" );
ReadPackage( "xmodalg", "lib/alg2obj.gd" );  
ReadPackage( "xmodalg", "lib/module.gd" );
ReadPackage( "xmodalg", "lib/alg2map.gd" );  
