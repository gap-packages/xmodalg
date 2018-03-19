#############################################################################
##
#W  alg2map.gd                 The XMODALG package            Zekeriya Arvasi
#W                                                             & Alper Odabas
#Y  Copyright (C) 2014-2018, Zekeriya Arvasi & Alper Odabas,  
##
   
DeclareCategory( "Is2dAlgebraMorphism", IsGeneral2DimensionalMapping ); 
DeclareCategoryCollections( "Is2dAlgebraMorphism" );
DeclareCategoryCollections( "Is2dAlgebraMorphismCollection" );
DeclareCategoryCollections( "Is2dAlgebraMorphismCollColl" );
BindGlobal( "Family2dAlgebraMorphism", 
    NewFamily( "Family2dAlgebraMorphism", Is2dAlgebraMorphism, 
               CanEasilySortElements, CanEasilySortElements ) ); 

DeclareProperty( "IsPreXModAlgebraMorphism", Is2dAlgebraMorphism );
DeclareProperty( "IsXModAlgebraMorphism", Is2dAlgebraMorphism );

DeclareRepresentation( "Is2dAlgebraMorphismRep", 
    Is2dAlgebraMorphism and IsAttributeStoringRep,
    [ "Source", "Range", "SourceHom", "RangeHom" ] );
DeclareAttribute( "SourceHom", Is2dAlgebraMorphism );
DeclareAttribute( "RangeHom", Is2dAlgebraMorphism );
DeclareOperation( "Make2dAlgebraMorphism",
    [ Is2dAlgebraObject, Is2dAlgebraObject, IsAlgebraHomomorphism, IsAlgebraHomomorphism ] );
    
DeclareGlobalFunction( "PreXModAlgebraMorphism" );
DeclareOperation( "PreXModAlgebraMorphismByHoms",
    [ IsPreXModAlgebra, IsPreXModAlgebra, IsAlgebraHomomorphism, IsAlgebraHomomorphism ] );
DeclareGlobalFunction( "PreCat1AlgebraMorphism" );
DeclareOperation( "PreCat1AlgebraMorphismByHoms",
    [ IsPreCat1Algebra, IsPreCat1Algebra, IsAlgebraHomomorphism, IsAlgebraHomomorphism ] );

DeclareGlobalFunction( "XModAlgebraMorphism" );
DeclareOperation( "XModAlgebraMorphismByHoms",
    [ IsXModAlgebra, IsXModAlgebra, IsAlgebraHomomorphism, IsAlgebraHomomorphism ] );
DeclareGlobalFunction( "Cat1AlgebraMorphism" );
DeclareOperation( "Cat1AlgebraMorphismByHoms",
    [ IsCat1Algebra, IsCat1Algebra, IsAlgebraHomomorphism, IsAlgebraHomomorphism ] );

DeclareProperty( "IsPreCat1AlgebraMorphism", Is2dAlgebraMorphism );
DeclareProperty( "IsCat1AlgebraMorphism", Is2dAlgebraMorphism );





