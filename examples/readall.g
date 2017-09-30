#############################################################################
##
#W  readall.g                 The XMODALG package           Zekeriya Arvasi
#W                                                             & Alper Odabas
##  version 1.12, 10/11/2015 
##
#Y  Copyright (C) 2014-2015, Zekeriya Arvasi & Alper Odabas,  
##

LoadPackage( "xmodalg", false ); 
xmodalg_examples_dir := DirectoriesPackageLibrary( "xmodalg", "examples" ); 

Read( Filename( xmodalg_examples_dir, "xmod.g" ) ); 
Read( Filename( xmodalg_examples_dir, "cat1.g" ) ); 


