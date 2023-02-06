#############################################################################
##
#W  testall.g           GAP4 package `XModAlg'          Z. Arvasi - A. Odabas
## 
#############################################################################

LoadPackage( "xmodalg" ); 
dir := DirectoriesPackageLibrary("xmodalg","tst");
TestDirectory(dir, rec(exitGAP := true,
    testOptions:=rec(compareFunction := "uptowhitespace")));
FORCE_QUIT_GAP(1);
