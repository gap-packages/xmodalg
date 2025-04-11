#############################################################################
##
##  PackageInfo.g  file for the package XModAlg 
##  Zekeriya Arvasi and Alper Odabas 
##

SetPackageInfo( rec(

PackageName := "XModAlg",
Subtitle := "Crossed Modules and Cat1-Algebras",
Version := "1.32",
Date := "11/04/2025", # dd/mm/yyyy format
License := "GPL-2.0-or-later",

Persons := [
    rec(
    LastName      := "Arvasi",
    FirstNames    := "Zekeriya",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "zarvasi@ogu.edu.tr",
    PostalAddress := Concatenation( [ 
                       "Prof. Dr. Z. Arvasi \n",
                       "Osmangazi University \n",
                       "Arts and Sciences Faculty \n",
                       "Department of Mathematics and Computer Science \n",
                       "Eskisehir \n",
                       "Turkey"] ),
    Place         := "Eskisehir",
    Institution   := "Osmangazi University"
  ),
    rec(
    LastName      := "Odabas",
    FirstNames    := "Alper",
    IsAuthor      := true,
    IsMaintainer  := true,
    Email         := "aodabas@ogu.edu.tr",
    PostalAddress := Concatenation( [ 
                       "Dr. A. Odabas \n",
                       "Osmangazi University \n",
                       "Arts and Sciences Faculty \n",
                       "Department of Mathematics and Computer Science \n",
                       "Eskisehir \n",
                       "Turkey"] ),
    Place         := "Eskisehir",
    Institution   := "Osmangazi University"
  ),
  rec(
    LastName      := "Wensley",
    FirstNames    := "Chris",
    IsAuthor      := false,
    IsMaintainer  := true,
    Email         := "cdwensley.maths@btinternet.com",
    WWWHome       := "https://github.com/cdwensley",
    Place         := "Llanfairfechan",
    Institution   := ""
  )
],

Status := "deposited",
CommunicatedBy := "",
AcceptDate := "",

SourceRepository := rec( 
    Type            := "git", 
    URL             := "https://github.com/gap-packages/xmodalg" ),
    IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
    PackageWWWHome  := "https://gap-packages.github.io/xmodalg/",
    README_URL      := Concatenation( ~.PackageWWWHome, "README.md" ),
    PackageInfoURL  := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),
    ArchiveURL      := Concatenation( ~.SourceRepository.URL, 
                                      "/releases/download/v", ~.Version, 
                                      "/", ~.PackageName, "-", ~.Version ), 

SupportEmail := "aodabas@ogu.edu.tr",
ArchiveFormats  := ".tar.gz",

AbstractHTML :=
 "The <span class=\"pkgname\">XModAlg</span> package provides a collection \
of functions for computing with crossed modules and cat1-algebras \
and morphisms of these structures.",

PackageDoc := rec(
  BookName  := "XModAlg",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0_mj.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Crossed Modules and Cat1-Algebras in GAP"
),

Dependencies := rec(
  GAP := ">=4.12.0",
  NeededOtherPackages := [ ["XMod", ">=2.87"], 
                           ["LAGUNA", ">=3.9.3"] ],
  SuggestedOtherPackages := [ ],    
  ExternalConditions := [ ]
),

AvailabilityTest := ReturnTrue,

BannerString := Concatenation( 
  "-----------------------------------------------------------------------------\n",
  "Loading XModAlg ", String( ~.Version ), " (", String( ~.Date ), ") for GAP 4.14 \n", 
  "Methods for crossed modules of commutative algebras and cat1-algebras\n",
  "by Zekeriya Arvasi (zarvasi@ogu.edu.tr) and Alper Odabas (aodabas@ogu.edu.tr).\n",
  "-----------------------------------------------------------------------------\n"
),

TestFile := "tst/testall.g",

Keywords := ["crossed module of algebras", "cat1-algebra"], 

AutoDoc := rec(
    TitlePage := rec(
        Copyright := Concatenation(
            "© 2014-2025, Zekeriya Arvasi and Alper Odabas. <P/>\n", 
            "The &XModAlg; package is free software; you can redistribute it ", 
            "and/or modify it under the terms of the GNU General ", 
            "Public License as published by the Free Software Foundation; ", 
            "either version 2 of the License, or (at your option) ", 
            "any later version.\n"
            ),
        Abstract := Concatenation( 
            "The &XModAlg; package provides functions for computation ",
            "with crossed modules of commutative algebras ", 
            "and cat<M>^{1}</M>-algebras.",  
            "<P/>\n", 
            "Bug reports, suggestions and comments are, of course, welcome. ", 
            "Please submit an issue on GitHub at ", 
            "<URL>https://github.com/gap-packages/xmodalg/issues/</URL> ", 
            "or contact the second author at ", 
            "<Email>aodabas@ogu.edu.tr</Email>. \n", 
            "<P/>\n"
            ), 
        Acknowledgements := Concatenation( 
          "This documentation was prepared with the ", 
          "&GAPDoc; <Cite Key='GAPDoc'/> and ", 
          "&AutoDoc; <Cite Key='AutoDoc'/> packages.<P/>\n", 
          "The procedure used to produce new releases uses the package ", 
          "<Package>GitHubPagesForGAP</Package> ", 
          "<Cite Key='GitHubPagesForGAP' /> ", 
          "and the package <Package>ReleaseTools</Package>.<P/>\n", 
          "Both authors are very grateful to Chris Wensley ", 
          "(<URL>https://github.com/cdwensley</URL>) ",            
          "for helpful suggestions.<P/>\n",
          "This work was partially supported by T&#220;B&#304;TAK ", 
          "(The Scientific and Technical Research Council of Turkey), ", 
          "project number 107T542.<P/>" 
          ),
    ) 
),

));
