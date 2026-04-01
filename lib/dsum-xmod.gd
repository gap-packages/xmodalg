 #############################################################################
##
#W  dsum-xmod.gd               The XMODALG package            Zekeriya Arvasi
#W                                                             & Alper Odabas
#Y  Copyright (C) 2014-2025, Zekeriya Arvasi & Alper Odabas,  
##

############################################################################
##
## AlgebraActionByDirectSum( <act> <act> )
##
## <#GAPDoc Label="AlgebraActionByDirectSum"> 
## <ManSection>
## <Oper Name="AlgebraActionByDirectSum" Arg="act act" />
##
## <Description>
## If <M>\alpha_1 : A_1 \to C_1</M> and <M>\alpha_2: A_2 \to C_2</M>
## are two actions on algebra <M>B</M>
## then the direct sum <M>A_1 \oplus A_2</M> acts on <M>B</M> by
## <M>(a_1,a_2)\cdot b = a_1\cdot(a_2\cdot b) = a_2\cdot(a_1 \cdot b)</M>
## provided the two actions commute.
## <P/>
## </Description>
## </ManSection>
## <Example>
## <![CDATA[
## gap> 
## ]]>
## </Example>
## <#/GAPDoc>
##
DeclareOperation( "AlgebraActionByDirectSum", 
    [ IsAlgebraAction, IsAlgebraAction ] );

## section 2.4.3
############################################################################
##
#O DirectSumOfAlgebraHomomorphisms( <hom> <hom> )
#O AlgebraHomomorphismFromDirectSum( <hom> <hom> )
##
## <#GAPDoc Label="DirectSumOfAlgebraHomomorphisms"> 
## <ManSection>
## <Oper Name="DirectSumOfAlgebraHomomorphisms" Arg="hom1 hom2" />
## <Oper Name="AlgebraHomomorphismFromDirectSum" Arg="hom1 hom2" />
##
## <Description>
## Let <M>\theta_1 : B_1 \to A_1</M> and <M>\theta_2 : B_2 \to A_2</M>
## be algebra homomorphisms. 
## The first operation uses embeddings into <M>A = A_1 \oplus A_2</M> 
## and <M>B = B_1 \oplus B_2</M> to construct
## <M>\theta = \theta_1 \oplus \theta_2 : B \to A</M>
## where <M>\theta(b_1,b_2) = (\theta_1b_1,\theta_2b_2)</M>.
## <P/>
## When <M>A_1=A_2</M> the second operation constructs
## <M>\theta = \theta_1 \oplus \theta_2 : B \to A_1</M>
## where <M>\theta(b_1,b_2) = \theta_1b_1 + \theta_2b_2</M>.
## <P/>
## The example uses the homomorphism <C>homg3</C> used in 
## Section <Ref Sect="AlgebraActionByHomomorphism" />
## <P/>
## </Description>
## </ManSection>
## <Example>
## <![CDATA[
## gap> hom33a := DirectSumOfAlgebraHomomorphisms( homg3, homg3 );;
## gap> Print( hom33a, "\n" );
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
DeclareOperation( "AlgebraHomomorphismFromDirectSum", 
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

