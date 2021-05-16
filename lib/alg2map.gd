#############################################################################
##
#W  alg2map.gd                 The XMODALG package            Zekeriya Arvasi
#W                                                             & Alper Odabas
#Y  Copyright (C) 2014-2021, Zekeriya Arvasi & Alper Odabas,  
##
   
#####################  morphisms of 2d-algebras  ########################### 

DeclareCategory( "Is2dAlgebraMorphism", IsGeneral2DimensionalMapping ); 
DeclareCategoryCollections( "Is2dAlgebraMorphism" );
DeclareCategoryCollections( "Is2dAlgebraMorphismCollection" );
DeclareCategoryCollections( "Is2dAlgebraMorphismCollColl" );

BindGlobal( "Family2dAlgebraMorphism", 
    NewFamily( "Family2dAlgebraMorphism", Is2dAlgebraMorphism, 
               CanEasilySortElements, CanEasilySortElements ) ); 

DeclareRepresentation( "Is2dAlgebraMorphismRep", 
    Is2dAlgebraMorphism and IsAttributeStoringRep,
    [ "Source", "Range", "SourceHom", "RangeHom" ] );
DeclareAttribute( "SourceHom", Is2dAlgebraMorphism );
DeclareAttribute( "RangeHom", Is2dAlgebraMorphism );
DeclareOperation( "Make2dAlgebraMorphism",
    [ Is2dAlgebraObject, Is2dAlgebraObject, IsAlgebraHomomorphism, 
      IsAlgebraHomomorphism ] );
    
DeclareOperation( "ImagesSource2DimensionalMapping",
    [ Is2DimensionalMapping ] );

#####################  morphisms of crossed modules  ####################### 

DeclareProperty( "IsPreXModAlgebraMorphism", Is2dAlgebraMorphism );
DeclareProperty( "IsXModAlgebraMorphism", Is2dAlgebraMorphism );
InstallTrueMethod( Is2dAlgebraMorphism, IsPreXModAlgebraMorphism );
InstallTrueMethod( Is2dAlgebraMorphism, IsXModAlgebraMorphism );

DeclareGlobalFunction( "PreXModAlgebraMorphism" );
DeclareGlobalFunction( "XModAlgebraMorphism" );

DeclareOperation( "PreXModAlgebraMorphismByHoms",
    [ IsPreXModAlgebra, IsPreXModAlgebra, IsAlgebraHomomorphism, 
      IsAlgebraHomomorphism ] );
DeclareOperation( "XModAlgebraMorphismByHoms",
    [ IsXModAlgebra, IsXModAlgebra, IsAlgebraHomomorphism, 
      IsAlgebraHomomorphism ] );

#####################  morphisms of cat1-algebras  ######################### 

DeclareProperty( "IsPreCat1AlgebraMorphism", Is2dAlgebraMorphism );
DeclareProperty( "IsCat1AlgebraMorphism", Is2dAlgebraMorphism );
InstallTrueMethod( Is2dAlgebraMorphism, IsPreCat1AlgebraMorphism );
InstallTrueMethod( Is2dAlgebraMorphism, IsCat1AlgebraMorphism );

DeclareGlobalFunction( "PreCat1AlgebraMorphism" );
DeclareGlobalFunction( "Cat1AlgebraMorphism" );

DeclareOperation( "PreCat1AlgebraMorphismByHoms",
    [ IsPreCat1Algebra, IsPreCat1Algebra, IsAlgebraHomomorphism, 
      IsAlgebraHomomorphism ] );
DeclareOperation( "Cat1AlgebraMorphismByHoms",
    [ IsCat1Algebra, IsCat1Algebra, IsAlgebraHomomorphism, 
      IsAlgebraHomomorphism ] );

DeclareAttribute( "AllAutosOfAlgebras", IsAlgebra);

