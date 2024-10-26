############################################################################
##
#W  module.gd                 The XMODALG package              Chris Wensley
#W                                                             
#Y  Copyright (C) 2014-2024, Zekeriya Arvasi & Alper Odabas,  
##
############################  algebra actions  ############################# 

## section 2.2.4
############################################################################
##
## AlgebraActionByHomomorphism( <hom> <alg> )
##
## <#GAPDoc Label="AlgebraActionByHomomorphism"> 
## <ManSection>
## <Oper Name="AlgebraActionByHomomorphism" Arg="hom alg" />
##
## <Description>
## If <M>\alpha : A \to C</M> is an algebra homomorphism
## where <M>C</M> is an algebra of left module isomorphisms
## of an algebra <M>B</M>, then
## <C>AlgebraActionByHomomorphism( alpha, B )</C>
## attempts to return an action of <M>A</M> on <M>B</M>.
## <P/>
## In the example the matrix algebra <C>A3</C>
## and the group algebra <C>Rc3</C> are isomorphic algebras,
## so the resulting action is equivalent to the multiplier
## action of <C>Rc3</C> on itself.
## </Description>
## </ManSection>
## <Example>
## <![CDATA[
## gap> m3 := [ [0,1,0], [0,0,1], [1,0,0,] ];;
## gap> A3 := Algebra( Rationals, [m3] );;
## gap> SetName( A3, "A3" );;
## gap> c3 := Group( (1,2,3) );;
## gap> Rc3 := GroupRing( Rationals, c3 );;
## gap> SetName( Rc3, "GR(c3)" );
## gap> g3 := GeneratorsOfAlgebra( Rc3 )[2];;
## gap> mg3 := RegularAlgebraMultiplier( Rc3, Rc3, g3 );;
## gap> Amg3 := AlgebraByGenerators( Rationals, [ mg3 ] );;
## gap> homg3 := AlgebraHomomorphismByImages( A3, Amg3, [ m3 ], [ mg3 ] );;
## gap> actg3 := AlgebraActionByHomomorphism( homg3, Rc3 );
## [ [ [ 0, 1, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ] ] ] -> 
## [ [ (1)*(), (1)*(1,2,3), (1)*(1,3,2) ] -> [ (1)*(1,2,3), (1)*(1,3,2), (1)*() 
##     ] ]
## ]]>
## </Example>
## <#/GAPDoc>
##
DeclareOperation( "AlgebraActionByHomomorphism", 
    [ IsAlgebraHomomorphism, IsAlgebra ] );

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
DeclareOperation( "XModAlgebraByBoundaryAndAction", 
    [ IsAlgebraHomomorphism, IsAlgebra ] );
DeclareOperation( "PreXModAlgebraByBoundaryAndAction", 
    [ IsAlgebraHomomorphism, IsAlgebra ] );


############################  module operations  ########################### 

## section 2.3
############################################################################
##
## <#GAPDoc Label="AlgebraModules"> 
## Recall that a module can be made into an algebra
## by defining every product to be zero.
## When we apply this construction to a (left) algebra module,
## we obtain an algebra action on an algebra.
## <P/>
## Recall the construction of algebra modules 
## from Chapter 62 of the &GAP; reference manual.
## In the example, the vector space <M>V3</M> becomes an algebra module 
## <M>M3</M> with a left action by <M>A3</M>.
## Conversion between vectors in <M>V3</M> and those in <M>M3</M> is achieved
## using the operations <C>ObjByExtRep</C> and <C>ExtRepOfObj</C>.
## These vectors are indistinguishable when printed.
##
## <Example>
## <![CDATA[
## gap> V3 := Rationals^3;;
## gap> M3 := LeftAlgebraModule( A3, \*, V3 );;
## gap> SetName( M3, "M3" );
## gap> famM3 := ElementsFamily( FamilyObj( M3 ) );;
## gap> v3 := [3,4,5];;
## gap> v3 := ObjByExtRep( famM3, v3 );
## [ 3, 4, 5 ]
## gap> m3*v3;
## [ 4, 5, 3 ]
## gap> genM3 := GeneratorsOfLeftModule( M3 );;
## gap> u4 := 6*genM3[1] + 7*genM3[2] + 8*genM3[3];
## [ 6, 7, 8 ]
## gap> u4 := ExtRepOfObj( u4 );
## [ 6, 7, 8 ]
## ]]>
## </Example>
## <#/GAPDoc>
##

## section 2.3.1
############################################################################
##
## ModuleAsAlgebra( <leftmod> )
##
## <#GAPDoc Label="ModuleAsAlgebra"> 
## <ManSection>
## <Attr Name="ModuleAsAlgebra" Arg="leftmod" />
##
## <Description>
## To form an algebra <M>B</M> from <M>M</M> with zero products
## we may construct an algebra with the correct dimension using an empty
## structure constants table, as shown below.
## In doing so, the remaining information about <M>M</M> is lost,
## so it is essential to form isomorphisms between the corresponding
## underlying vector spaces.
## <P/>
## If the module <M>M</M> has been given a name, then the operation
## <C>ModuleAsAlgebra</C> assigns a name to the resulting algebra.
## The operation <C>AlgebraByStructureConstants</C> assigns names
## <M>v_i</M> to the basis vectors unless a list of names is provided.
## The operation <C>ModuleAsAlgebra</C> converts the basis elements of
## <M>M</M> into strings, with additional brackets added, and uses these
## as the names for the basis vectors.
## Note that these <C>[[i,j,k]]</C> are just strings, and not vectors.
## </Description>
## </ManSection>
## <Example>
## <![CDATA[
## gap> D3 := LeftActingDomain( M3 );;
## gap> T3 := EmptySCTable( Dimension(M3), Zero(D3), "symmetric" );;
## gap> B3a := AlgebraByStructureConstants( D3, T3 );
## <algebra of dimension 3 over Rationals>
## gap> GeneratorsOfAlgebra( B3a );
## [ v.1, v.2, v.3 ]
## gap> B3 := ModuleAsAlgebra( M3 );               
## A(M3)
## gap> GeneratorsOfAlgebra( B3 );
## [ [[ 1, 0, 0 ]], [[ 0, 1, 0 ]], [[ 0, 0, 1 ]] ]
## ]]>
## </Example>
## <#/GAPDoc>
##
DeclareAttribute( "ModuleAsAlgebra", IsLeftModule ); 

## section 2.3.2
############################################################################
##
## IsModuleAsAlgebra( <alg> )
##
## <#GAPDoc Label="IsModuleAsAlgebra"> 
## <ManSection>
## <Oper Name="IsModuleAsAlgebra" Arg="alg" />
##
## <Description>
## This is the property acquired when a module is converted into an algebra.
## </Description>
## </ManSection>
## <Example>
## <![CDATA[
## gap> IsModuleAsAlgebra( B3 );
## true
## gap> IsModuleAsAlgebra( A3 );   
## false
## ]]>
## </Example>
## <#/GAPDoc>
##
DeclareProperty( "IsModuleAsAlgebra", IsAlgebra ); 

## section 2.3.3
############################################################################
##
## ModuleToAlgebraIsomorphism( <alg> )
## AlgebraToModuleIsomorphism( <alg> )
##
## <#GAPDoc Label="ModuleToAlgebraIsomorphism"> 
## <ManSection>
## <Oper Name="ModuleToAlgebraIsomorphism" Arg="alg" />
## <Oper Name="AlgebraToModuleIsomorphism" Arg="alg" />
##
## <Description>
## These two algebra mappings are attributes of a module converted into 
## an algebra. They are required for the process of converting 
## the action of <M>A</M> on <M>M</M> into an action on <M>B</M>.
## Note that these left module homomorphisms have as source 
## or range the underlying module <M>V</M>, not <M>M</M>. 
## </Description>
## </ManSection>
## <Example>
## <![CDATA[
## gap> KnownAttributesOfObject( B3 );
## [ "Name", "ZeroImmutable", "LeftActingDomain", "Dimension",
##   "GeneratorsOfLeftOperatorAdditiveGroup", "GeneratorsOfLeftOperatorRing",
##   "ModuleToAlgebraIsomorphism", "AlgebraToModuleIsomorphism" ]
## gap> M2B3 := ModuleToAlgebraIsomorphism( B3 );
## [ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ] ] -> [ [[ 1, 0, 0 ]], [[ 0, 1, 0 ]], 
##   [[ 0, 0, 1 ]] ]
## gap> Source( M2B3 ) = M3;
## false
## gap> Source( M2B3 ) = V3;
## true
## gap> B2M3 := AlgebraToModuleIsomorphism( B3 );
## [ [[ 1, 0, 0 ]], [[ 0, 1, 0 ]], [[ 0, 0, 1 ]] ] ->
## [ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ] ]
## gap> Range( B2M3 ) = M3;
## false
## gap> Range( B2M3 ) = V3;
## true
## ]]>
## </Example>
## <#/GAPDoc>
##
DeclareAttribute( "ModuleToAlgebraIsomorphism", IsAlgebra );
DeclareAttribute( "AlgebraToModuleIsomorphism", IsAlgebra );

## section 2.3.4
############################################################################
##
## AlgebraActionByModule( <alg> <leftmod> )
##
## <#GAPDoc Label="AlgebraActionByModule"> 
## <ManSection>
## <Oper Name="AlgebraActionByModule" Arg="alg leftmod" />
##
## <Description>
## This operation converts the action of <M>A</M> on <M>M</M>
## into an action of <M>A</M> on <M>B</M>.
## </Description>
## </ManSection>
## <Example>
## <![CDATA[
## gap> act3 := AlgebraActionByModule( A3, M3 );
## [ [ [ 0, 1, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ] ] ] -> 
## [ [ [[ 1, 0, 0 ]], [[ 0, 1, 0 ]], [[ 0, 0, 1 ]] ] -> 
##     [ [[ 0, 0, 1 ]], [[ 1, 0, 0 ]], [[ 0, 1, 0 ]] ] ]
## gap> a3 := 2*m3 + 3*m3^2;
## [ [ 0, 2, 3 ], [ 3, 0, 2 ], [ 2, 3, 0 ] ]
## gap> Image( act3, a3 );
## Basis( A(M3), [ [[ 1, 0, 0 ]], [[ 0, 1, 0 ]], [[ 0, 0, 1 ]] ] ) -> 
## [ (3)*[[ 0, 1, 0 ]]+(2)*[[ 0, 0, 1 ]], (2)*[[ 1, 0, 0 ]]+(3)*[[ 0, 0, 1 ]], 
##   (3)*[[ 1, 0, 0 ]]+(2)*[[ 0, 1, 0 ]] ]
## gap> Image( act3 );
## <algebra over Rationals, with 1 generator>
## ]]>
## </Example>
## <#/GAPDoc>
##
DeclareOperation( "AlgebraActionByModule", [ IsAlgebra, IsLeftModule ] );

## section 4.1.8
############################################################################
##
## XModAlgebraByModule( <alg> <leftmod> )
##
## <#GAPDoc Label="XModAlgebraByModule"> 
## <ManSection>
## <Oper Name="XModAlgebraByModule" Arg="alg leftmod" />
##
## <Description>
## Let <M>M</M> be an <M>A</M>-module.  
## Then <M>\mathcal{X} = (0 : A(M) \rightarrow A)</M> is a crossed module,
## where <M>A(M)</M> is <M>M</M> considered as an algebra with zero products
## (see section <Ref Sect="ModuleAsAlgebra" />).
## The example uses the action <C>act3</C> constructed in section
## <Ref Sect="AlgebraActionByModule" />.
## <P/>
## Conversely, given a crossed module 
## <M>\mathcal{X} = (\partial :M\rightarrow R)</M>,
## one can get that <M>\ker\partial</M> is a <M>(R/\partial M)</M>-module.
## <P/>
## </Description>
## </ManSection>
## <Example>
## <![CDATA[
## gap> Y3 := XModAlgebraByModule( A3, M3 );
## [ A(M3) -> A3 ]
## gap> Image( XModAlgebraAction( Y3 ), m3 ) = Image( act3, m3 ); 
## true
## gap> Display( Y3 );
## Crossed module [A(M3) -> A3] :- 
## : Source algebra A(M3) has generators:  [ [[ 1, 0, 0 ]], [[ 0, 1, 0 ]], 
##   [[ 0, 0, 1 ]] ]
## : Range algebra A3 has generators:  
## [ [ [ 0, 1, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ] ] ]
## : Boundary homomorphism maps source generators to:
## [ [ [ 0, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 0 ] ], 
##   [ [ 0, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 0 ] ], 
##   [ [ 0, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 0 ] ] ]
## ]]>
## </Example>
## <#/GAPDoc>
##
DeclareOperation( "XModAlgebraByModule", [ IsAlgebra, IsLeftModule ] );

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

############################  direct sum operations  ####################### 

## section 2.4.1
#############################################################################
##
#A DirectSumOfAlgebrasInfo( <A> )
##
## <#GAPDoc Label="DirectSumOfAlgebrasInfo"> 
## <ManSection>
## <Attr Name="DirectSumOfAlgebrasInfo" Arg='A'/>
##
## <Description>
## This attribute for direct sums of algebras is missing from
## the main library, and is added here to be used in methods
## for <C>Embedding</C> and <C>Projection</C>. 
## </Description>
## </ManSection>
## <Example>
## <![CDATA[
## gap> A3Rc3 := DirectSumOfAlgebras( A3, Rc3 );;
## gap> SetName( A3Rc3, Concatenation( Name(A3), "(+)", Name(Rc3) ) );
## gap> SetDirectSumOfAlgebrasInfo( A3Rc3, 
## > rec( algebras := [A3,Rc3], first := [1,Dimension(A3)+1],
## >      embeddings := [ ], projections := [ ] ) );;
## ]]>
## </Example>
## <#/GAPDoc>
##
DeclareAttribute( "DirectSumOfAlgebrasInfo", IsAlgebra, "mutable" );

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

## section 2.4.3
############################################################################
##
## DirectSumOfAlgebraHomomorphisms( <hom> <hom> )
##
## <#GAPDoc Label="DirectSumOfAlgebraHomomorphisms"> 
## <ManSection>
## <Oper Name="DirectSumOfAlgebraHomomorphisms" Arg="hom1 hom2" />
##
## <Description>
## Let <M>\theta_1 : B_1 \to A_1</M> and <M>\theta_2 : B_2 \to A_2</M>
## be algebra homomorphisms. 
## The embeddings into <M>A = A_1 \oplus A_2</M> 
## and <M>B = B_1 \oplus B_2</M> may be used to construct
## <M>\theta = \theta_1 \oplus \theta_2 : B \to A</M>
## where <M>\theta(b_1,b_2) = (\theta_1b_1,\theta_2b_2)</M>.
## The example uses the homomorphism <C>homg3</C> used in 
## Section <Ref Sect="AlgebraActionByHomomorphism" />
## <P/>
## </Description>
## </ManSection>
## <Example>
## <![CDATA[
## gap> hom33 := DirectSumOfAlgebraHomomorphisms( homg3, homg3 );;
## gap> Print( hom33, "\n" );
## AlgebraHomomorphismByImages( A3(+)A3, Algebra( Rationals, 
## [ v.1, v.2, v.3, v.4, v.5, v.6 ] ), 
## [ [ [ 0, 1, 0, 0, 0, 0 ], [ 0, 0, 1, 0, 0, 0 ], [ 1, 0, 0, 0, 0, 0 ], 
##       [ 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ] ], 
##   [ [ 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ], 
##       [ 0, 0, 0, 0, 1, 0 ], [ 0, 0, 0, 0, 0, 1 ], [ 0, 0, 0, 1, 0, 0 ] ] ], 
## [ v.1, v.4 ] )
## ]]>
## </Example>
## <#/GAPDoc>
##
DeclareOperation( "DirectSumOfAlgebraHomomorphisms", 
    [ IsAlgebraHomomorphism, IsAlgebraHomomorphism ] );

## section 2.4.4
############################################################################
##
## AlgebraActionOnDirectSum( <act> <act> )
##
## <#GAPDoc Label="AlgebraActionOnDirectSum"> 
## <ManSection>
## <Oper Name="AlgebraActionOnDirectSum" Arg="act act" />
##
## <Description>
## If <M>\alpha_1 : A \to C_1</M> is an action on algebra <M>B_1</M>
## and <M>\alpha_2 : A \to C_2</M> is an action on algebra <M>B_2</M>
## by the same algebra <M>A</M>, 
## then <M>A</M> acts on the direct sum <M>B_1 \oplus B_2</M>
## by <M>a \cdot (b_1,b_2) = (a \cdot b_1, a \cdot b_2)</M>.
## <P/>
## In Section <Ref Sect="AlgebraActionByModule" /> there is created
## an action <C>actB3</C> of <C>A3</C> on an isomorphic <C>B3</C>.
## In the example here we construct <C>actA3</C>, with <C>A3</C> acting
## on itself, formed using <C>AlgebraActionByMultipliers</C>.
## Then we construct the direcct sum of these actions.
## </Description>
## </ManSection>
## <Example>
## <![CDATA[
## gap> actMA3 := AlgebraActionByMultipliers( A3, A3, A3 );;
## gap> act4 := AlgebraActionOnDirectSum( actMA3, actg3 );
## [ [ [ 0, 1, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ] ], 
##   [ [ 0, 0, 1 ], [ 1, 0, 0 ], [ 0, 1, 0 ] ], 
##   [ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ] ] ] -> 
## [ [ v.1, v.2, v.3, v.4, v.5, v.6 ] -> [ v.2, v.3, v.1, v.5, v.6, v.4 ], 
##   [ v.1, v.2, v.3, v.4, v.5, v.6 ] -> [ v.3, v.1, v.2, v.6, v.4, v.5 ], 
##   [ v.1, v.2, v.3, v.4, v.5, v.6 ] -> [ v.1, v.2, v.3, v.4, v.5, v.6 ] ]
## ]]>
## </Example>
## <#/GAPDoc>
##
DeclareOperation( "AlgebraActionOnDirectSum", 
    [ IsAlgebraAction, IsAlgebraAction ] );

## section 2.4.5
############################################################################
##
## DirectSumOfAlgebraActions( <act> <act> )
##
## <#GAPDoc Label="DirectSumOfAlgebraActions"> 
## <ManSection>
## <Oper Name="DirectSumOfAlgebraActions" Arg="act act" />
##
## <Description>
## Let 
## If <M>\alpha_1 : A_1 \to C_1</M> is an action on algebra <M>B_1</M>,
## and <M>\alpha_2 : A_2 \to C_2</M> is an action on algebra <M>B_2</M>, 
## then <M>A_1 \oplus A_2</M> acts on the direct sum <M>B_1 \oplus B_2</M>
## by <M>(a_1,a_2) \cdot (b_1,b_2) = (a_1 \cdot b_1, a_2 \cdot b_2)</M>.
## The example forms the direct sum of the actions constructed in
## sections <Ref Sect="AlgebraActionBySurjection" /> 
## and <Ref Sect="AlgebraActionByHomomorphism" />
## <P/>
## </Description>
## </ManSection>
## <Example>
## <![CDATA[
## gap> act5 := DirectSumOfAlgebraActions( actg3, act3 );;
## gap> A5 := Source( act5 );
## A3(+)A3
## gap> B5 := AlgebraActedOn( act5 );
## GR(c3)(+)A(M3)
## gap> em3 := ImageElm( Embedding( A5, 1 ), m3 ); 
## [ [ 0, 1, 0, 0, 0, 0 ], [ 0, 0, 1, 0, 0, 0 ], [ 1, 0, 0, 0, 0, 0 ], 
##   [ 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ] ]
## gap> ImageElm( act5, em3 );                     
## Basis( GR(c3)(+)A(M3), [ v.1, v.2, v.3, v.4, v.5, v.6 ] ) -> 
## [ v.2, v.3, v.1, 0*v.1, 0*v.1, 0*v.1 ]
## gap> ea3 := ImageElm( Embedding( A5, 2 ), a3 );
## [ [ 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ], 
##   [ 0, 0, 0, 0, 2, 3 ], [ 0, 0, 0, 3, 0, 2 ], [ 0, 0, 0, 2, 3, 0 ] ]
### gap> ImageElm( act5, ea3 );
## Basis( GR(c3)(+)A(M3), [ v.1, v.2, v.3, v.4, v.5, v.6 ] ) -> 
## [ 0*v.1, 0*v.1, 0*v.1, (3)*v.5+(2)*v.6, (2)*v.4+(3)*v.6, (3)*v.4+(2)*v.5 ]
## ]]>
## </Example>
## <#/GAPDoc>
##
DeclareOperation( "DirectSumOfAlgebraActions", 
    [ IsAlgebraAction, IsAlgebraAction ] );

## section 4.1.9
############################################################################
##
## DirectSumOfXModAlgebras( <X1> <X2> )
##
## <#GAPDoc Label="DirectSumOfXModAlgebras"> 
## <ManSection>
## <Oper Name="DirectSumOfXModAlgebras" Arg="X1 X2" />
##
## <Description>
## In Sections <Ref Sect="DirectSumOfAlgebraHomomorphisms" />
## and <Ref Sect="DirectSumOfAlgebraActions" />
## we constructed direct sums of algebra homomorphisms and algebra actions.
## So, given two crossed modules of algebras <M>X_1, X_2</M>,
## we can form the direct sums of their boundaries and actions
## to form a direct sum <M>X_1 \oplus X_2</M> of crossed modules.
## <P/>
## In the example we combine crossed modules <C>X3</C> from section
## <Ref Sect="XModAlgebraByBoundaryAndAction" /> and <C>X4</C>
## from section <Ref Sect="XModAlgebraByModule" />.
## <P/>
## </Description>
## </ManSection>
## <Example>
## <![CDATA[
## gap> XY3 := DirectSumOfXModAlgebras( X3, Y3 );
## [ GR(c3)(+)A(M3) -> A3(+)A3 ]
## ]]>
## </Example>
## <#/GAPDoc>
##
DeclareOperation( "DirectSumOfXModAlgebras", 
    [ IsXModAlgebra, IsXModAlgebra ] );

