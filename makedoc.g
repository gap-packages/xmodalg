##  makedoc.g for package XModAlg 
##  This builds the documentation of the XModAlg package
##  Needs: GAPDoc & AutoDoc packages, latex, pdflatex, mkindex
##  call this with GAP from within the package root directory 
  
LoadPackage( "GAPDoc" );
LoadPackage( "AutoDoc" ); 

AutoDoc( rec( 
    gapdoc := rec( 
        LaTeXOptions := rec( EarlyExtraPreamble := """
            \usepackage[all]{xy} 
            \newcommand{\hello} {\mathrm{hello}}
        """ )
    ),  
    scaffold := rec(
        ## MainPage := false, 
        includes := [ "intro.xml", "algebra.xml", "cat1.xml", 
                      "xmod.xml",  "convert.xml" ],
        bib := "bib.xml", 
        entities := rec( 
            AutoDoc := "<Package>AutoDoc</Package>",
            XMod := "<Package>XMod</Package>"
        )
    )
));
