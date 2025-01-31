#############################################################################
##
#W  alg2obj.gd                 The XMODALG package            Zekeriya Arvasi
#W                                                             & Alper Odabas
#Y  Copyright (C) 2014-2025, Zekeriya Arvasi & Alper Odabas,  
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

DeclareProperty( "IsPreXModAlgebra", Is2dAlgebra );
DeclareProperty( "IsXModAlgebra", Is2dAlgebra );
InstallTrueMethod( IsPreXModAlgebra, IsXModAlgebra );

BindGlobal( "PreXModAlgebraObjType",
    NewType( Family2dAlgebra, IsPreXModAlgebraObj ) );

DeclareAttribute( "XModAlgebraAction", IsPreXModAlgebra );

DeclareOperation( "XModAlgebraObj",
    [ IsAlgebraHomomorphism, IsAlgebraAction ] );
DeclareOperation( "XModAlgebraObjNC",
    [ IsAlgebraHomomorphism, IsAlgebraAction ] );

DeclareGlobalFunction( "XModAlgebra" );

## section 4.1.7
############################################################################
##
## XModAlgebraByBoundaryAndAction( <hom> <alg> )
##
## <#GAPDoc Label="XModAlgebraByBoundaryAndAction"> 
## <ManSection>
##    <Oper Name="XModAlgebraByBoundaryAndAction"
##          Arg="bdy act" />
##    <Oper Name="PreXModAlgebraByBoundaryAndAction"
##          Arg="bdy,act" />
## <Description>
## When a suitable pair of algebra homomorphisms are available,
## these operations may be used.
## The example uses the algebra action created in section
## <Ref Sect="AlgebraActionByHomomorphism" />.
## </Description>
## </ManSection>
## <Example>
## <![CDATA[
## gap> bdy3 := AlgebraHomomorphismByImages( Rc3, A3, [ g3 ], [ m3 ] );
## [ (1)*(1,2,3) ] -> [ [ [ 0, 1, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ] ] ]
## gap> X3 := XModAlgebraByBoundaryAndAction( bdy3, actg3 );
## [ GR(c3) -> A3 ]
## gap> Display( X3 );
## Crossed module [GR(c3) -> A3] :- 
## : Source algebra GR(c3) has generators:
##   [ (1)*(), (1)*(1,2,3) ]
## : Range algebra A3 has generators:
##   [ [ [ 0, 1, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ] ] ]
## : Boundary homomorphism maps source generators to:
##   [ [ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ] ], 
##   [ [ 0, 1, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ] ] ]
## ]]>
## </Example>
## <#/GAPDoc>
##
DeclareOperation( "PreXModAlgebraByBoundaryAndAction",
   [ IsAlgebraHomomorphism, IsAlgebraAction ] );
DeclareOperation( "PreXModAlgebraByBoundaryAndActionNC",
   [ IsAlgebraHomomorphism, IsAlgebraAction ] );
 DeclareOperation( "XModAlgebraByBoundaryAndAction",
   [ IsAlgebraHomomorphism, IsAlgebraAction ] );
DeclareOperation( "XModAlgebraByBoundaryAndActionNC",
   [ IsAlgebraHomomorphism, IsAlgebraAction ] );

DeclareOperation( "XModAlgebraBySurjection", [ IsAlgebraHomomorphism ] );
DeclareOperation( "XModAlgebraByMultiplierAlgebra", 
    [ IsAlgebra ] );
DeclareOperation( "XModAlgebraByIdeal", 
    [ IsAlgebra, IsAlgebra ] ); 
DeclareAttribute( "AugmentationXMod", IsGroupAlgebra ); 

DeclareOperation( "SubPreXModAlgebra", 
    [ IsPreXModAlgebra, IsAlgebra, IsAlgebra ] );
DeclareOperation( "SubXModAlgebra", [ IsXModAlgebra, IsAlgebra, IsAlgebra] );

DeclareOperation( "IsSubPreXModAlgebra", [ Is2dAlgebraObject, Is2dAlgebraObject ] );
DeclareOperation( "IsSubXModAlgebra", [ Is2dAlgebraObject, Is2dAlgebraObject ] );

#############################  cat1-algebras  ########################## 

DeclareRepresentation( "IsPreCat1AlgebraObj", 
    Is2dAlgebra and IsAttributeStoringRep, 
    [ "tailMap", "headMap", "rangeEmbedding" ] );
BindGlobal( "PreCat1AlgebraObjType",
    NewType( Family2dAlgebra, IsPreCat1AlgebraObj ) );

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

DeclareOperation( "SubPreCat1Algebra", 
    [ IsPreCat1Algebra, IsAlgebra, IsAlgebra ] );
DeclareOperation( "SubCat1Algebra", 
    [ IsCat1Algebra, IsAlgebra, IsAlgebra ] );

DeclareOperation( "IsSubPreCat1Algebra", 
    [ Is2dAlgebraObject, Is2dAlgebraObject ] );
DeclareOperation( "IsSubCat1Algebra", 
    [ Is2dAlgebraObject, Is2dAlgebraObject ] );

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
## addition to Cat1AlgebraOfXModAlgebra, section 5.1.1
############################################################################
##
## <#GAPDoc Label="Cat1AlgebraOfXModAlgebra"> 
## <P/>
## As a second example, we convert the crossed module <M>X4</M>
## constructed in section <Ref Sect="XModAlgebraByModule"/>
##
## <Example>
## <![CDATA[
## gap> C3 := Cat1AlgebraOfXModAlgebra( X3 );
## [A3 |X GR(c3) -> A3]
## gap> Display( C3 );                 
## Cat1-algebra [A3 |X GR(c3) => A3] :- 
## : range algebra has generators:[ [ [ 0, 1, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ] ] ]
## : tail homomorphism maps source generators to:  
## [ [ [ 0, 1, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ] ], 
##   [ [ 0, 0, 1 ], [ 1, 0, 0 ], [ 0, 1, 0 ] ], 
##   [ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ] ], 
##   [ [ 0, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 0 ] ], 
##   [ [ 0, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 0 ] ], 
##   [ [ 0, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 0 ] ] ]
## : head homomorphism maps source generators to:  
## [ [ [ 0, 1, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ] ], 
##   [ [ 0, 0, 1 ], [ 1, 0, 0 ], [ 0, 1, 0 ] ], 
##   [ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ] ], 
##   [ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ] ], 
##   [ [ 0, 1, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ] ], 
##   [ [ 0, 0, 1 ], [ 1, 0, 0 ], [ 0, 1, 0 ] ] ]
## : range embedding maps range generators to:    [ v.1 ]
## : kernel has generators:  [ v.4, v.5, v.6 ]
## ]]>
## </Example>
## <#/GAPDoc>
##
DeclareOperation( "SDproduct", [ Is2dAlgebraObject ] );
