#############################################################################
##
##  PackageInfo.g  file for the package XModAlg 
##  Zekeriya Arvasi and Alper Odabas 
##

SetPackageInfo( rec(
PackageName := "XModAlg",
Packagename := "xmodalg",
Subtitle := "Crossed Modules and Cat1-Algebras",

Version := "1.16",
Date := "29/01/2018",

##  duplicate these values for inclusion in the manual: 
##  <#GAPDoc Label="PKGVERSIONDATA">
##  <!ENTITY VERSION "1.16">
##  <!ENTITY TARFILENAME "xmodalg-1.16.tar.gz">
##  <!ENTITY HTMLFILENAME "xmodalg.html">
##  <!ENTITY RELEASEDATE "29/01/2018">
##  <!ENTITY LONGRELEASEDATE "29nd January 2018">
##  <!ENTITY COPYRIGHTYEARS "2014-2018">
##  <#/GAPDoc>

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
  )
],

Status := "deposited",
CommunicatedBy := "",
AcceptDate := "",

SourceRepository := rec( 
  Type := "git", 
  URL := "https://github.com/gap-packages/xmodalg"
),
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
 "The <span class=\"pkgname\">XModAlg</span> package provides a collection of \
functions for computing with crossed modules and cat1-algebras \
and morphisms of these structures.",

PackageDoc := rec(
  BookName  := "XModAlg",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Crossed Modules and Cat1-Algebras in GAP",
  Autoload  := true
),

Dependencies := rec(
  GAP := ">=4.8.8",
  NeededOtherPackages := [ ["XMod", ">=2.64"], ["LAGUNA", ">=3.7.0"] ],
  SuggestedOtherPackages := [ ["GAPDoc", ">= 1.5.1" ] ],   
  ExternalConditions := [ ]
),

AvailabilityTest := ReturnTrue,

BannerString := Concatenation( 
  "-----------------------------------------------------------------------------\n",
  "Loading XModAlg ", String( ~.Version ), " (", String( ~.Date ), ") for GAP 4.8 \n", 
  "Methods for crossed modules of commutative algebras and cat1-algebras\n",
  "by Zekeriya Arvasi (zarvasi@ogu.edu.tr) and Alper Odabas (aodabas@ogu.edu.tr).\n",
  "-----------------------------------------------------------------------------\n"
),

TestFile := "tst/testall.g",

Keywords := ["crossed module of algebras","cat1-algebras"]

));
