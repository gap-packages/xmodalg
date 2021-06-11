#############################################################################
##
#W  alg2obj.gd                 The XMODALG package            Zekeriya Arvasi
#W                                                             & Alper Odabas
#Y  Copyright (C) 2014-2021, Zekeriya Arvasi & Alper Odabas,  
##

##############################  2d-algebras  ########################### 

DeclareCategory( "Is2dAlgebra", Is2DimensionalDomain and IsAlgebra ); 
DeclareCategoryCollections( "Is2dAlgebra" ); 
BindGlobal( "Family2dAlgebra", 
    NewFamily( "Family2dAlgebra", Is2dAlgebra, CanEasilySortElements, 
               CanEasilySortElements ) ); 

DeclareProperty( "Is2dAlgebraObject", Is2DimensionalDomain );

DeclareOperation( "Sub2dAlgebra", [ Is2dAlgebra, IsAlgebra, IsAlgebra ] );


#########################  (pre-)crossed modules  ###################### 

DeclareRepresentation( "IsPreXModAlgebraObj", 
    Is2dAlgebra and IsAttributeStoringRep, [ "boundary", "action" ] );
DeclareRepresentation( "IsPreCat1AlgebraObj", 
    Is2dAlgebra and IsAttributeStoringRep, 
    [ "tailMap", "headMap", "rangeEmbedding" ] );

DeclareProperty( "IsPreXModAlgebra", Is2dAlgebra );
DeclareProperty( "IsXModAlgebra", Is2dAlgebra );
InstallTrueMethod( IsPreXModAlgebra, IsXModAlgebra );

DeclareAttribute( "XModAlgebraAction", IsPreXModAlgebra );

DeclareOperation( "XModAlgebraObj",
    [ IsAlgebraHomomorphism, IsAlgebraAction ] );

DeclareOperation( "PreXModAlgebraByBoundaryAndAction",
   [ IsAlgebraHomomorphism, IsAlgebraAction ] );
 
DeclareGlobalFunction( "XModAlgebra" );
DeclareOperation( "XModAlgebraByBoundaryAndAction",
   [ IsAlgebraHomomorphism, IsAlgebraAction ] );
DeclareOperation( "XModAlgebraBySurjection", [ IsAlgebraHomomorphism ] );
DeclareOperation( "XModAlgebraByMultiplierAlgebra", 
    [ IsAlgebra ] );
DeclareOperation( "XModAlgebraByModule", 
    [ IsAlgebra, IsRing ] );
DeclareOperation( "XModAlgebraByIdeal", 
    [ IsAlgebra, IsAlgebra ] ); 
DeclareAttribute( "AugmentationXMod", IsGroupAlgebra ); 

DeclareOperation( "SubPreXModAlgebra", 
    [ IsPreXModAlgebra, IsAlgebra, IsAlgebra ] );
DeclareOperation( "SubXModAlgebra", [ IsXModAlgebra, IsAlgebra, IsAlgebra] );

DeclareOperation( "IsSubPreXModAlgebra", [ Is2dAlgebraObject, Is2dAlgebraObject ] );
DeclareOperation( "IsSubXModAlgebra", [ Is2dAlgebraObject, Is2dAlgebraObject ] );

#############################  cat1-algebras  ########################## 

DeclareProperty( "IsPreCat1Algebra", Is2dAlgebra );
DeclareProperty( "IsCat1Algebra", Is2dAlgebra );

DeclareGlobalFunction( "PreCat1Algebra" );
DeclareGlobalFunction( "Cat1Algebra" );

DeclareOperation( "PreCat1AlgebraObj",
    [ IsAlgebraHomomorphism, IsAlgebraHomomorphism, IsAlgebraHomomorphism ] );
DeclareOperation( "PreCat1AlgebraByTailHeadEmbedding",
    [ IsAlgebraHomomorphism, IsAlgebraHomomorphism, IsAlgebraHomomorphism ] );
DeclareAttribute( "HeadMap", IsPreCat1Algebra );
DeclareAttribute( "TailMap", IsPreCat1Algebra );
DeclareAttribute( "RangeEmbedding", IsPreCat1Algebra );
DeclareAttribute( "KernelEmbedding", IsPreCat1Algebra );

DeclareFilter( "IsXModAlgebraConst", IsCat1Algebra );
DeclareAttribute( "XModAlgebraConst", IsCat1Algebra );

DeclareOperation( "SubPreCat1Algebra", 
    [ IsPreCat1Algebra, IsAlgebra, IsAlgebra ] );
DeclareOperation( "SubCat1Algebra", [ IsCat1Algebra, IsAlgebra, IsAlgebra ] );

DeclareOperation( "IsSubPreCat1Algebra", [ Is2dAlgebraObject, Is2dAlgebraObject ] );
DeclareOperation( "IsSubCat1Algebra", [ Is2dAlgebraObject, Is2dAlgebraObject ] );

DeclareOperation( "PreCat1AlgebraByEndomorphisms", 
    [ IsAlgebraHomomorphism, IsAlgebraHomomorphism ] );
DeclareOperation( "Cat1AlgebraSelect", [ IsInt, IsInt, IsInt, IsInt ] );

DeclareProperty( "IsIdentityCat1Algebra", IsCat1Algebra );

DeclareOperation( "AllCat1Algebras", [ IsField, IsGroup ] );
DeclareOperation( "IsIsomorphicCat1Algebra", [ IsCat1Algebra, IsCat1Algebra ] );
DeclareOperation( "IsomorphicCat1AlgebraFamily", [ IsCat1Algebra, IsList ] );
DeclareOperation( "AllCat1AlgebrasUpToIsomorphism", [ IsList ] );

##########################  conversion functions  ####################### 

DeclareAttribute( "PreXModAlgebraOfPreCat1Algebra", IsPreCat1Algebra );
DeclareAttribute( "PreCat1AlgebraOfPreXModAlgebra", IsPreXModAlgebra );
DeclareAttribute( "XModAlgebraOfCat1Algebra", IsCat1Algebra );
DeclareAttribute( "Cat1AlgebraOfXModAlgebra", IsXModAlgebra );
DeclareOperation( "SDproduct", [ Is2dAlgebraObject ] );
