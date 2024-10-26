#############################################################################
##
#W  testing.g                XModAlg test files         Z. Arvasi - A. Odabas 
##
#############################################################################

LoadPackage( "xmodalg" );

TestXModAlg := function( pkgname )
    local  pkgdir, testfiles, testresult, ff, fn;
    LoadPackage( pkgname );
    pkgdir := DirectoriesPackageLibrary( pkgname, "tst" );
    # Arrange chapters as required
    testfiles := [ "algebra.tst", "module.tst", "cat1.tst", 
                   "xmod.tst", "convert.tst" ];
    testresult := true;
    for ff in testfiles do
        fn := Filename( pkgdir, ff );
        Print( "#I  Testing ", fn, "\n" );
        if not Test( fn, rec(compareFunction := "uptowhitespace") ) then
            testresult := false;
        fi;
    od;
    if testresult then
        Print("#I  No errors detected while testing package ", pkgname, "\n");
    else
        Print("#I  Errors detected while testing package ", pkgname, "\n");
    fi;
end;

##  Set the name of the package here
TestXModAlg( "xmodalg" );
