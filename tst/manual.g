##  manual.g 
LoadPackage("xmodalg");
Print( "running xmodalg02.tst\n" );
Test( "tst/xmodalg02.tst", rec(compareFunction := "uptowhitespace") ); 
Print( "running xmodalg03.tst\n" );
Test( "tst/xmodalg03.tst", rec(compareFunction := "uptowhitespace") ); 
Print( "running xmodalg04.tst\n" );
Test( "tst/xmodalg04.tst", rec(compareFunction := "uptowhitespace") ); 
