#############################################################################
##
#W  alg2obj.gd                 The XMODALG package            Zekeriya Arvasi
#W                                                             & Alper Odabas
#Y  Copyright (C) 2014-2018, Zekeriya Arvasi & Alper Odabas,  
##

DeclareGlobalFunction( "ElementsLeftActing" );

DeclareProperty( "IsAlgebraAction", IsMapping );

DeclareInfoClass( "InfoXModAlg" );

DeclareGlobalFunction( "MultipleAlgebra",
    [ IsAlgebra ] );

DeclareProperty( "IsMultipleAlgebra", IsList );

DeclareOperation( "AlgebraHomomorphismByFunction",
    [ IsAlgebra, IsAlgebra, IsFunction ] );
    
DeclareOperation( "MultipleHomomorphism",
    [ IsAlgebra ] );
    
DeclareOperation( "ModuleHomomorphism",
    [ IsAlgebra, IsRing ] ); 

##################################################################### 

DeclareCategory( "Is2dAlgebra", Is2DimensionalDomain and IsAlgebra ); 
DeclareCategoryCollections( "Is2dAlgebra" ); 
BindGlobal( "Family2dAlgebra", 
    NewFamily( "Family2dAlgebra", Is2dAlgebra, CanEasilySortElements, 
               CanEasilySortElements ) ); 

DeclareProperty( "Is2dAlgebraObject", Is2DimensionalDomain );

DeclareRepresentation( "IsPreXModAlgebraObj", 
    Is2dAlgebra and IsAttributeStoringRep, [ "boundary", "action" ] );
DeclareRepresentation( "IsPreCat1AlgebraObj", 
    Is2dAlgebra and IsAttributeStoringRep, 
    [ "tailMap", "headMap", "rangeEmbedding" ] );

DeclareProperty( "IsPreCat1Algebra", Is2dAlgebra );

DeclareProperty( "IsPreXModAlgebra", Is2dAlgebra );
DeclareOperation( "XModAlgebraObj",
    [ IsAlgebraHomomorphism, IsAlgebraAction ] );
##  DeclareAttribute( "Source", IsPreXModAlgebra );
##  DeclareAttribute( "Range", IsPreXModAlgebra );    
##  DeclareAttribute( "Boundary", IsPreXModAlgebra );

DeclareAttribute( "XModAlgebraAction", IsPreXModAlgebra );

DeclareGlobalFunction( "AlgebraAction" );
DeclareOperation( "AlgebraAction1",
    [ IsAlgebra, IsList, IsAlgebra ] );
DeclareAttribute( "LeftElementOfCartesianProduct", IsAlgebraAction );
DeclareAttribute( "AlgebraActionType", IsAlgebraAction );
DeclareAttribute( "HasZeroModuleProduct", IsAlgebraAction );

DeclareOperation( "AlgebraAction2",[ IsAlgebra ] );
DeclareOperation( "AlgebraAction3",[ IsAlgebraHomomorphism ] );
DeclareOperation( "AlgebraAction4",[ IsAlgebra, IsRing ] );
DeclareOperation( "AlgebraAction5",[ IsAlgebra, IsAlgebra ] );

DeclareAttribute( "AllAutosOfAlgebras", IsAlgebra);

DeclareProperty( "IsXModAlgebra", Is2dAlgebra );
InstallTrueMethod( IsPreXModAlgebra, IsXModAlgebra );

DeclareOperation( "PreXModAlgebraByBoundaryAndAction",
   [ IsAlgebraHomomorphism, IsAlgebraAction ] );
 
DeclareGlobalFunction( "XModAlgebra" );
DeclareOperation( "XModAlgebraByBoundaryAndAction",
   [ IsAlgebraHomomorphism, IsAlgebraAction ] );
DeclareOperation( "XModAlgebraByCentralExtension", [ IsAlgebraHomomorphism ] );
DeclareOperation( "XModAlgebraByMultipleAlgebra", 
    [ IsAlgebra ] );
DeclareOperation( "XModAlgebraByModule", 
    [ IsAlgebra, IsRing ] );
DeclareOperation( "XModAlgebraByIdeal", 
    [ IsAlgebra, IsAlgebra ] );

DeclareOperation( "IsSubPreXModAlgebra", [ Is2dAlgebraObject, Is2dAlgebraObject ] );
DeclareOperation( "IsSubXModAlgebra", [ Is2dAlgebraObject, Is2dAlgebraObject ] );
DeclareOperation( "IsSubPreCat1Algebra", [ Is2dAlgebraObject, Is2dAlgebraObject ] );
DeclareOperation( "IsSubCat1Algebra", [ Is2dAlgebraObject, Is2dAlgebraObject ] );

DeclareOperation( "PreCat1AlgebraObj",
    [ IsAlgebraHomomorphism, IsAlgebraHomomorphism, IsAlgebraHomomorphism ] );
DeclareAttribute( "Equivalence", IsPreCat1Algebra );
DeclareAttribute( "HeadMap", IsPreCat1Algebra );
DeclareAttribute( "TailMap", IsPreCat1Algebra );
DeclareAttribute( "RangeEmbedding", IsPreCat1Algebra );
DeclareAttribute( "KernelEmbedding", IsPreCat1Algebra );

DeclareGlobalFunction( "PreCat1Algebra" );

DeclareProperty( "IsCat1Algebra", Is2dAlgebra );

DeclareOperation( "PreXModAlgebraByPreCat1Algebra", [ IsPreCat1Algebra ] );
DeclareAttribute( "Equivalence", IsPreCat1Algebra );
DeclareAttribute( "SourceForEquivalence", IsCat1Algebra );
DeclareAttribute( "BoundaryForEquivalence", IsCat1Algebra );
DeclareFilter( "IsEquivalenceHead", IsCat1Algebra );
DeclareFilter( "IsEquivalenceTail", IsCat1Algebra );
DeclareFilter( "IsXModAlgebraConst", IsCat1Algebra );
DeclareAttribute( "XModAlgebraConst", IsCat1Algebra );
DeclareAttribute( "XModAlgebraOfCat1Algebra", IsPreCat1Algebra );
DeclareOperation( "XModAlgebraByCat1Algebra", [ IsPreCat1Algebra ] );
DeclareAttribute( "Cat1AlgebraOfXModAlgebra", IsPreXModAlgebra );
DeclareOperation( "Cat1AlgebraByXModAlgebra", [ IsPreXModAlgebra ] );
DeclareOperation( "EquivalenceTail", [ IsEquivalenceTail ] );
DeclareOperation( "EquivalenceHead", [ IsEquivalenceHead ] );
DeclareOperation( "SDproduct", [ Is2dAlgebraObject ] );

DeclareGlobalFunction( "Cat1Algebra" );
DeclareOperation( "PreCat1AlgebraByEndomorphisms", 
    [ IsAlgebraHomomorphism, IsAlgebraHomomorphism ] );
DeclareOperation( "Cat1AlgebraSelect", [ IsInt, IsInt, IsInt, IsInt ] );

DeclareProperty( "IsIdentityCat1Algebra", IsCat1Algebra );

DeclareOperation( "Sub2dAlgebra", [ Is2dAlgebra, IsAlgebra, IsAlgebra ] );
DeclareOperation( "SubPreXModAlgebra", 
    [ IsPreXModAlgebra, IsAlgebra, IsAlgebra ] );
DeclareOperation( "SubXModAlgebra", [ IsXModAlgebra, IsAlgebra, IsAlgebra] );
DeclareOperation( "SubPreCat1Algebra", 
    [ IsPreCat1Algebra, IsAlgebra, IsAlgebra ] );
DeclareOperation( "SubCat1Algebra", [ IsCat1Algebra, IsAlgebra, IsAlgebra ] );

DeclareOperation( "AllHomsOfAlgebras", [ IsAlgebra, IsAlgebra ] );
DeclareOperation( "AllBijectiveHomsOfAlgebras", [ IsAlgebra, IsAlgebra ] );
DeclareOperation( "AllIdempotentHomsOfAlgebras", [ IsAlgebra, IsAlgebra ] );
DeclareOperation( "AllCat1Algebras", [ IsField, IsGroup ] );
DeclareOperation( "IsIsomorphicCat1Algebra", [ IsCat1Algebra, IsCat1Algebra ] );
DeclareOperation( "IsomorphicCat1AlgebraFamily", [ IsCat1Algebra, IsList ] );
DeclareOperation( "AllCat1AlgebrasUpToIsomorphism", [ IsList ] );
