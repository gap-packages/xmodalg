############################################################################
##
#W  module.gd                 The XMODALG package              Chris Wensley
#W                                                             
#Y  Copyright (C) 2014-2024, Zekeriya Arvasi & Alper Odabas,  
##

############################  module operations  ################### 

############################################################################
##
## <#GAPDoc Label="AlgebraModules"> 
## <Subsection><Heading>Algebra modules</Heading>
## Recall that a module can be made into an algebra
## by defining every product to be zero.
## When we apply this construction to a (left) algebra module,
## we obtain an algebra action on an algebra.
## <P/>
## Recall the construction of algebra modules 
## from Chapter 62 of the &GAP; reference manual.
## In the example, the vector space <M>V</M> becomes an algebra module 
## <M>M</M> with a left action by <M>A</M>.
## Conversion between vectors in <M>V</M> and those in <M>M</M> is achieved
## using the operations <C>ObjByExtRep</C> and <C>ExtRepOfObj</C>.
## These vectors are indistinguishable when printed.
##
## <Example>
## <![CDATA[
## gap> A := Rationals^[3,3];;
## gap> SetName( A, "Q[3,3]" );;
## gap> V := Rationals^3;;
## gap> M := LeftAlgebraModule( A, \*, V );
## <left-module over Q[3,3]>
## gap> SetName( M, "M" );
## gap> famM := ElementsFamily( FamilyObj( M ) );;
## gap> v := [3,4,5];;
## gap> v2 := ObjByExtRep( famM, v );                                                                                                                                                                   
## gap> m := [ [0,1,0], [0,0,1], [1,0,0] ];;
## gap> m*v2;
## [ 4, 5, 3 ]
## gap> genM := GeneratorsOfLeftModule( M );;
## gap> u2 := 6*genM[1] + 7*genM[2] + 8*genM[3];
## [ 6, 7, 8 ]
## gap> u := ExtRepOfObj( u2 );
## [ 6, 7, 8 ]
## ]]>
## </Example>
## </Subsection>
## <#/GAPDoc>
##

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
## The operation <C>AlgebraByStyructureConstants</C> assigns names
## <M>v_i</M> to the basis vectors unless a list of names is provided.
## The operation <C>ModuleAsAlgebra</C> converts the basis elements of
## <M>M</M> into strings, with additional brackets added, and uses these
## as the names for the basis vectors.
## Note that these <C>[[i,j,k]]</C> are just strings, and not vectors.
## </Description>
## </ManSection>
## <Example>
## <![CDATA[
## gap> D := LeftActingDomain( M );;
## gap> T := EmptySCTable( Dimension(M), Zero(D), "symmetric" );;
## gap> B := AlgebraByStructureConstants( D, T );
## <algebra of dimension 3 over Rationals>
## gap> GeneratorsOfAlgebra( B );
## [ v.1, v.2, v.3 ]
## gap> B := ModuleAsAlgebra( M );               
## A(M)
## gap> GeneratorsOfAlgebra( B );
## [ [[ 1, 0, 0 ]], [[ 0, 1, 0 ]], [[ 0, 0, 1 ]] ]
## ]]>
## </Example>
## <#/GAPDoc>
##
DeclareAttribute( "ModuleAsAlgebra", IsLeftModule ); 


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
## gap> IsModuleAsAlgebra( B );
## true
## gap> IsModuleAsAlgebra(A);   
## false
## ]]>
## </Example>
## <#/GAPDoc>
##
DeclareProperty( "IsModuleAsAlgebra", IsAlgebra ); 

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
## gap> KnownAttributesOfObject(B);    
## [ "Name", "ZeroImmutable", "LeftActingDomain", "Dimension", 
##   "GeneratorsOfLeftOperatorAdditiveGroup", "GeneratorsOfLeftOperatorRing", 
##   "ModuleToAlgebraIsomorphism", "AlgebraToModuleIsomorphism" ]
## gap> M2B := ModuleToAlgebraIsomorphism( B );
## [ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ] ] -> [ [[ 1, 0, 0 ]], [[ 0, 1, ## 0 ]], 
##   [[ 0, 0, 1 ]] ]
## gap> Source( M2B ) = M;
## false
## gap> Source( M2B ) = V;
## true
## gap> B2M := AlgebraToModuleIsomorphism( B );
## [ [[ 1, 0, 0 ]], [[ 0, 1, 0 ]], [[ 0, 0, 1 ]] ] -> 
## [ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ] ]
## gap> Range( B2M ) = M;
## false
## gap> Range( B2M ) = V;
## true
## ]]>
## </Example>
## <#/GAPDoc>
##
DeclareAttribute( "ModuleToAlgebraIsomorphism", IsAlgebra );
DeclareAttribute( "AlgebraToModuleIsomorphism", IsAlgebra );


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
## gap> act := AlgebraActionByModule( A, M );
## [ [ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ] ], 
##   [ [ 1, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 0 ] ], 
##   [ [ 0, 0, 1 ], [ 1, 0, 0 ], [ 0, 1, 0 ] ] ] -> 
## [ [ [[ 1, 0, 0 ]], [[ 0, 1, 0 ]], [[ 0, 0, 1 ]] ] -> 
##     [ [[ 1, 0, 0 ]], [[ 0, 1, 0 ]], [[ 0, 0, 1 ]] ], 
##   [ [[ 1, 0, 0 ]], [[ 0, 1, 0 ]], [[ 0, 0, 1 ]] ] -> 
##     [ [[ 1, 0, 0 ]], 0*[[ 1, 0, 0 ]], 0*[[ 1, 0, 0 ]] ], 
##   [ [[ 1, 0, 0 ]], [[ 0, 1, 0 ]], [[ 0, 0, 1 ]] ] -> 
##     [ [[ 0, 1, 0 ]], [[ 0, 0, 1 ]], [[ 1, 0, 0 ]] ] ]
## gap> genA := GeneratorsOfAlgebra(A);;
## gap> m := 5*genA[1] -4*genA[2]+3*genA[3];
## [ [ 1, 0, 3 ], [ 3, 5, 0 ], [ 0, 3, 5 ] ]
## gap> Image( act, m );
## Basis( A(M), [ [[ 1, 0, 0 ]], [[ 0, 1, 0 ]], [[ 0, 0, 1 ]] ] ) -> 
## [ [[ 1, 0, 0 ]]+(3)*[[ 0, 1, 0 ]], (5)*[[ 0, 1, 0 ]]+(3)*[[ 0, 0, 1 ]], 
##   (3)*[[ 1, 0, 0 ]]+(5)*[[ 0, 0, 1 ]] ]
## gap> Image( act ); 
## <algebra over Rationals, with 3 generators>
## ]]>
## </Example>
## <#/GAPDoc>
##
DeclareOperation( "AlgebraActionByModule", [ IsAlgebra, IsLeftModule ] );
