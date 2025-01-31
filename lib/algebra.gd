 #############################################################################
##
#W  algebra.gd                 The XMODALG package            Zekeriya Arvasi
#W                                                             & Alper Odabas
#Y  Copyright (C) 2014-2025, Zekeriya Arvasi & Alper Odabas,  
##

DeclareInfoClass( "InfoXModAlg" );

############################  algebra operations  ################### 

DeclareProperty( "HasZeroAnnihilator", IsAlgebra and IsCommutative ); 

DeclareOperation( "RegularAlgebraMultiplier", 
    [ IsAlgebra, IsAlgebra, IsObject ] ); 
DeclareProperty( "IsAlgebraMultiplier", IsMapping ); 

DeclareOperation( "MultiplierAlgebraOfIdealBySubalgebra", 
    [ IsAlgebra, IsAlgebra, IsAlgebra ] );
DeclareOperation( "MultiplierAlgebraByGenerators", [ IsAlgebra, IsList ] ); 
DeclareAttribute( "MultiplierAlgebra", IsAlgebra, "mutable" ); 
DeclareAttribute( "MultiplierHomomorphism", IsAlgebra, "mutable" );
DeclareProperty( "IsMultiplierAlgebra", IsList ); 

#############################  algebra mappings  #################### 

DeclareOperation( "InclusionMappingAlgebra", [ IsAlgebra, IsAlgebra ] );
DeclareOperation( "RestrictionMappingAlgebra", 
   [ IsAlgebraHomomorphism, IsAlgebra, IsAlgebra ] );

DeclareOperation( "AllAlgebraHomomorphisms", 
    [ IsAlgebra, IsAlgebra ] );
DeclareOperation( "AllBijectiveAlgebraHomomorphisms", 
    [ IsAlgebra, IsAlgebra ] );
DeclareOperation( "AllIdempotentAlgebraHomomorphisms", 
    [ IsAlgebra, IsAlgebra ] );

##############################  algebra actions  #################### 

DeclareProperty( "IsAlgebraAction", IsAlgebraHomomorphism );
DeclareGlobalFunction( "AlgebraAction" );
DeclareAttribute( "LeftElementOfCartesianProduct", IsAlgebraAction );
DeclareAttribute( "AlgebraActionType", IsAlgebraAction );
DeclareAttribute( "AlgebraActedOn", IsAlgebraAction );
DeclareAttribute( "HasZeroModuleProduct", IsAlgebraAction );

DeclareOperation( "AlgebraActionByMultipliers", 
    [ IsAlgebra, IsAlgebra, IsAlgebra ] );
DeclareOperation( "AlgebraActionBySurjection", [ IsAlgebraHomomorphism ] );

DeclareOperation ( "SemidirectProductOfAlgebras", 
    [ IsAlgebra, IsAlgebraAction, IsAlgebra ] ); 
DeclareAttribute( "SemidirectProductOfAlgebrasInfo", IsAlgebra, "mutable" );

##################################################################### 

################  direct sum of algebras with info  ################# 

## section 2.4.1
#############################################################################
##
#O DirectSumOfAlgebrasWithInfo( <A> )
#A DirectSumOfAlgebrasInfo( <A> )
##
## <#GAPDoc Label="DirectSumOfAlgebrasInfo"> 
## <ManSection>
## <Oper Name="DirectSumOfAlgebrasWithInfo" Arg='A1 A2'/>
## <Attr Name="DirectSumOfAlgebrasInfo" Arg='A'/>
##
## <Description>
## This attribute for direct sums of algebras is missing from
## the main library, and is added here to be used in methods
## for <C>Embedding</C> and <C>Projection</C>.
## In order to construct a direct sum with this information attribute
## the operation <C>DirectSumOfAlgebrasWithInfo</C> may be used.
## This just calls <C>DirectSumOfAlgebras</C> and sets up the attribute.
## </Description>
## </ManSection>
## <Example>
## <![CDATA[
## gap> A3Rc3 := DirectSumOfAlgebrasWithInfo( A3, Rc3 );;
## gap> SetName( A3Rc3, Concatenation( Name(A3), "(+)", Name(Rc3) ) );
## gap> DirectSumOfAlgebrasInfo( A3Rc3 );
## rec( algebras := [ A3, GR(c3) ], 
##   embeddings := 
##     [ 
##       Basis( A3, [ [ [ 0, 1, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ] ], 
##           [ [ 0, 0, 1 ], [ 1, 0, 0 ], [ 0, 1, 0 ] ], 
##           [ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ] ] ] ) -> [ v.1, v.2, v.3 ], 
##       CanonicalBasis( GR(c3) ) -> [ v.4, v.5, v.6 ] ], first := [ 1, 4 ], 
##   projections := 
##     [ CanonicalBasis( A3(+)GR(c3) ) -> 
##         [ [ [ 0, 1, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ] ], 
##           [ [ 0, 0, 1 ], [ 1, 0, 0 ], [ 0, 1, 0 ] ], 
##           [ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ] ], 
##           [ [ 0, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 0 ] ], 
##           [ [ 0, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 0 ] ], 
##           [ [ 0, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 0 ] ] ], 
##       CanonicalBasis( A3(+)GR(c3) ) -> [ <zero> of ..., <zero> of ..., 
##           <zero> of ..., (1)*(), (1)*(1,2,3), (1)*(1,3,2) ] ] )
## ]]>
## </Example>
## <#/GAPDoc>
##
DeclareAttribute( "DirectSumOfAlgebrasInfo", IsAlgebra, "mutable" );
DeclareOperation( "DirectSumOfAlgebrasWithInfo", [ IsAlgebra, IsAlgebra ] );

## section 2.4.2
############################################################################
##
## Embedding( <alg> )
##
## <#GAPDoc Label="EmbeddingForDirectSumOfAlgebras"> 
## <ManSection>
## <Oper Name="Embedding" Label="for direct sum of algebras" 
##       Arg="A nr" />
## <Oper Name="Projection" Label="for direct sum of algebras" 
##       Arg="A nr" />
##
## <Description>
## Methods for <C>Embedding</C> and <C>Projection</C> for direct sums
## of algebras are missing from the main library, and so are included here.
## <P/>
## </Description>
## </ManSection>
## <Example>
## <![CDATA[
## gap> Embedding( A3Rc3, 1 );
## Basis( A3, [ [ [ 0, 1, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ] ], 
##   [ [ 0, 0, 1 ], [ 1, 0, 0 ], [ 0, 1, 0 ] ], 
##   [ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ] ] ] ) -> [ v.1, v.2, v.3 ]
## gap> Projection( A3Rc3, 2 );
## CanonicalBasis( A3(+)GR(c3) ) -> [ <zero> of ..., <zero> of ..., 
##   <zero> of ..., (1)*(), (1)*(1,2,3), (1)*(1,3,2) ]
## ]]>
## </Example>
## <#/GAPDoc>
##
