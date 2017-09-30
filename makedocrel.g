##  makedocrel.g,  version 02/11/15
##  This builds the documentation of the XModAlg package
##  Needs: GAPDoc package, latex, pdflatex, mkindex
##  
LoadPackage( "GAPDoc" );

 XModAlgDoc := Filename( DirectoriesPackageLibrary( "XModAlg", "doc" ), "" );

MakeGAPDocDoc( XModAlgDoc,# path to the directory containing the main file
               "manual",  # the name of the main file (without extension)
                          # list of (probably source code) files relative 
                          # to path which contain pieces of documentation 
                          # which must be included in the document
               [ "../PackageInfo.g" ], 
               "XModAlg", # the name of the book used by GAP's online help
               "../../..", # optional: relative path to the main GAP root 
                          # directory to produce HTML files with relative 
                          # paths to external books.
                "MathJax" # optional: use "MathJax", "Tth" and/or "MathML"
                          # to produce additional variants of HTML files
               );; 

# Copy the *.css and *.js files from the styles directory of the GAPDoc 
# package into the directory containing the package manual.
CopyHTMLStyleFiles( XModAlgDoc );

# Create the manual.lab file which is needed if the main manuals or another 
# package is referring to your package
GAPDocManualLab( "XModAlg" );; 
