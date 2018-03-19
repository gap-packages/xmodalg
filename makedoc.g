##  makedoc.g for package XModAlg 
##  This builds the documentation of the XModAlg package
##  Needs: GAPDoc & AutoDoc packages, latex, pdflatex, mkindex
##  call this with GAP from within the package root directory 
  
LoadPackage( "GAPDoc" );
LoadPackage( "AutoDoc" ); 

AutoDoc( rec( 
    scaffold := rec(
        ## MainPage := false, 
        includes := [ "intro.xml", "cat1.xml", "xmod.xml" ],
        bib := "bib.xml", 
        gapdoc_latex_options := rec( EarlyExtraPreamble := """
            \usepackage[all]{xy} 
            \newcommand{\hello} {\mathrm{hello}}
        """ ),  
        entities := rec( 
            AutoDoc := "<Package>AutoDoc</Package>"
        )
    )
));

QUIT;
