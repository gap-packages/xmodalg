#############################################################################
##
#W  readall.g                 The XMODALG package            Zekeriya Arvasi
#W                                                            & Alper Odabas
##
#Y  Copyright (C) 2014-2025, Zekeriya Arvasi & Alper Odabas,  
##

LoadPackage( "xmodalg", false ); 

xmodalg_examples_dir := DirectoriesPackageLibrary( "xmodalg", "examples" ); 

Read( Filename( xmodalg_examples_dir, "algebra.g" ) ); 
Read( Filename( xmodalg_examples_dir, "module.g" ) ); 
Read( Filename( xmodalg_examples_dir, "xmod.g" ) ); 
Read( Filename( xmodalg_examples_dir, "xmod-more.g" ) ); 
Read( Filename( xmodalg_examples_dir, "cat1.g" ) ); 
Read( Filename( xmodalg_examples_dir, "cat1-more.g" ) ); 
Read( Filename( xmodalg_examples_dir, "convert.g" ) ); 


