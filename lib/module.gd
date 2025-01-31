############################################################################
##
#W  module.gd                 The XMODALG package              Chris Wensley
#W                                                             
#Y  Copyright (C) 2014-2025, Zekeriya Arvasi & Alper Odabas,  
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

