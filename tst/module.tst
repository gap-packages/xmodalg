############################################################################
##
#W  module.tst              XModAlg test files                 Chris Wensley
##
#@local level,m3,A3,G,B3,g3,mg3,MB3,hom3,act3,bdy3,X3,A4,V4,M4,famM4,v4,genM4,u4,D4,T4,B4a,B4,M2B4,B2M4,act4,a4,X4,C4,A3B3,actMA3,act5,act6,A6,B6,em3,ea4

gap> START_TEST( "XModAlg package: module.tst" );
gap> level := InfoLevel( InfoXModAlg );; 
gap> SetInfoLevel( InfoXModAlg, 0 );

## Section 2.2.4
gap> m3 := [ [0,1,0], [0,0,1], [1,0,0,] ];;
gap> A3 := Algebra( Rationals, [m3] );;
gap> SetName( A3, "A3" );;
gap> G := Group( (1,2,3) );;
gap> B3 := GroupRing( Rationals, G );;
gap> SetName( B3, "GR(G)" );
gap> g3 := GeneratorsOfAlgebra( B3 )[2];;
gap> mg3 := RegularAlgebraMultiplier( B3, B3, g3 );;
gap> MB3 := AlgebraByGenerators( Rationals, [ mg3 ] );;
gap> hom3 := AlgebraHomomorphismByImages( A3, MB3, [ m3 ], [ mg3 ] );;
gap> act3 := AlgebraActionByHomomorphism( hom3, B3 );
[ [ [ 0, 1, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ] ] ] -> 
[ [ (1)*(), (1)*(1,2,3), (1)*(1,3,2) ] -> [ (1)*(1,2,3), (1)*(1,3,2), (1)*() 
    ] ]

## Section 4.1.6
gap> hom3 := AlgebraHomomorphismByImages( A3, MB3, [ m3 ], [ mg3 ] );
[ [ [ 0, 1, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ] ] ] -> 
[ [ (1)*(), (1)*(1,2,3), (1)*(1,3,2) ] -> [ (1)*(1,2,3), (1)*(1,3,2), (1)*() 
     ] ]
gap> bdy3 := AlgebraHomomorphismByImages( B3, A3, [ g3 ], [ m3 ] );
[ (1)*(1,2,3) ] -> [ [ [ 0, 1, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ] ] ]
gap> X3 := XModAlgebraByBoundaryAndAction( bdy3, act3 );
[ GR(G) -> A3 ]
gap> Display( X3 );

Crossed module [GR(G) -> A3] :- 
: Source algebra GR(G) has generators:
  [ (1)*(), (1)*(1,2,3) ]
: Range algebra A3 has generators:
  [ [ [ 0, 1, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ] ] ]
: Boundary homomorphism maps source generators to:
  [ [ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ] ], 
  [ [ 0, 1, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ] ] ]

## Section 2.3
gap> m3 := [ [0,1,0], [0,0,1], [1,0,0] ];;
gap> A4 := Algebra( Rationals, [m3] );;
gap> SetName( A4, "A4" );;
gap> V4 := Rationals^3;;
gap> M4 := LeftAlgebraModule( A4, \*, V4 );;
gap> SetName( M4, "M4" );
gap> famM4 := ElementsFamily( FamilyObj( M4 ) );;
gap> v4 := [3,4,5];;
gap> v4 := ObjByExtRep( famM4, v4 );
[ 3, 4, 5 ]
gap> m3*v4;
[ 4, 5, 3 ]
gap> genM4 := GeneratorsOfLeftModule( M4 );;
gap> u4 := 6*genM4[1] + 7*genM4[2] + 8*genM4[3];
[ 6, 7, 8 ]
gap> u4 := ExtRepOfObj( u4 );
[ 6, 7, 8 ]

## Section 2.3.1
gap> D4 := LeftActingDomain( M4 );;
gap> T4 := EmptySCTable( Dimension(M4), Zero(D4), "symmetric" );;
gap> B4a := AlgebraByStructureConstants( D4, T4 );
<algebra of dimension 3 over Rationals>
gap> GeneratorsOfAlgebra( B4a );
[ v.1, v.2, v.3 ]
gap> B4 := ModuleAsAlgebra( M4 );               
A(M4)
gap> GeneratorsOfAlgebra( B4 );
[ [[ 1, 0, 0 ]], [[ 0, 1, 0 ]], [[ 0, 0, 1 ]] ]

## Section 2.3.2
gap> IsModuleAsAlgebra( B4 );
true
gap> IsModuleAsAlgebra( A4 );
false

## Section 2.3.3
gap> KnownAttributesOfObject( B4 );
[ "Name", "ZeroImmutable", "LeftActingDomain", "Dimension",
  "GeneratorsOfLeftOperatorAdditiveGroup", "GeneratorsOfLeftOperatorRing",
  "ModuleToAlgebraIsomorphism", "AlgebraToModuleIsomorphism" ]
gap> M2B4 := ModuleToAlgebraIsomorphism( B4 );
[ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ] ] -> [ [[ 1, 0, 0 ]], [[ 0, \
1, 0 ]], 
  [[ 0, 0, 1 ]] ]
gap> Source( M2B4 ) = M4;
false
gap> Source( M2B4 ) = V4;
true
gap> B2M4 := AlgebraToModuleIsomorphism( B4 );
[ [[ 1, 0, 0 ]], [[ 0, 1, 0 ]], [[ 0, 0, 1 ]] ] ->
[ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ] ]
gap> Range( B2M4 ) = M4;
false
gap> Range( B2M4 ) = V4;
true

## Section 2.3.4
gap> act4 := AlgebraActionByModule( A4, M4 );
[ [ [ 0, 1, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ] ] ] -> 
[ [ [[ 1, 0, 0 ]], [[ 0, 1, 0 ]], [[ 0, 0, 1 ]] ] -> 
    [ [[ 0, 0, 1 ]], [[ 1, 0, 0 ]], [[ 0, 1, 0 ]] ] ]
gap> a4 := 2*m3 + 3*m3^2;
[ [ 0, 2, 3 ], [ 3, 0, 2 ], [ 2, 3, 0 ] ]
gap> Image( act4, a4 );
Basis( A(M4), [ [[ 1, 0, 0 ]], [[ 0, 1, 0 ]], [[ 0, 0, 1 ]] ] ) -> 
[ (3)*[[ 0, 1, 0 ]]+(2)*[[ 0, 0, 1 ]], (2)*[[ 1, 0, 0 ]]+(3)*[[ 0, 0, 1 ]], 
  (3)*[[ 1, 0, 0 ]]+(2)*[[ 0, 1, 0 ]] ]
gap> Image( act4 );
<algebra over Rationals, with 1 generator>

## Section 4.1.7
gap> X4 := XModAlgebraByModule( A4, M4 );
[A(M4)->A4]
gap> Display( X4 );

Crossed module [A(M4)->A4] :- 
: Source algebra A(M4) has generators:
  [ [[ 1, 0, 0 ]], [[ 0, 1, 0 ]], [[ 0, 0, 1 ]] ]
: Range algebra A4 has generators:
  [ [ [ 0, 1, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ] ] ]
: Boundary homomorphism maps source generators to:
  [ [ [ 0, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 0 ] ], 
  [ [ 0, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 0 ] ], 
  [ [ 0, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 0 ] ] ]

## Section 5.1.1
gap> C4 := Cat1AlgebraOfXModAlgebra( X4 );
[A4 |X A(M4) -> A4]
gap> Display( C4 );           
Cat1-algebra [A4 |X A(M4)=>A4] :- 
:  range algebra has generators:
  [ [ [ 0, 1, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ] ] ]
: tail homomorphism = head homomorphism
  they map the source generators to:
  [ [ [ 0, 1, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ] ], 
  [ [ 0, 0, 1 ], [ 1, 0, 0 ], [ 0, 1, 0 ] ], 
  [ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ] ], 
  [ [ 0, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 0 ] ], 
  [ [ 0, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 0 ] ], 
  [ [ 0, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 0 ] ] ]
: range embedding maps range generators to:
  [ v.1 ]
: kernel has generators:
  [ v.4, v.5, v.6 ]

## Section 2.4.1
gap> A3B3 := DirectSumOfAlgebras( A3, B3 );;
gap> SetName( A3B3, Concatenation( Name(A3), "(+)", Name(B3) ) );
gap> SetDirectSumOfAlgebrasInfo( A3B3, 
> rec( algebras := [A3,B3], first := [1,Dimension(A3)+1],
>      embeddings := [ ], projections := [ ] ) );;

## Section 2.4.2
gap> Embedding( A3B3, 1 );
Basis( A3, [ [ [ 0, 1, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ] ], 
  [ [ 0, 0, 1 ], [ 1, 0, 0 ], [ 0, 1, 0 ] ], 
  [ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ] ] ] ) -> [ v.1, v.2, v.3 ]
gap> Projection( A3B3, 2 );
CanonicalBasis( A3(+)GR(G) ) -> [ <zero> of ..., <zero> of ..., 
  <zero> of ..., (1)*(), (1)*(1,2,3), (1)*(1,3,2) ]

## Section 2.4.3
gap> actMA3 := AlgebraActionByMultipliers( A3, A3, A3 );;
gap> act5 := AlgebraActionOnDirectSum( actMA3, act3 );
[ [ [ 0, 1, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ] ], 
  [ [ 0, 0, 1 ], [ 1, 0, 0 ], [ 0, 1, 0 ] ], 
  [ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ] ] ] -> 
[ [ v.1, v.2, v.3, v.4, v.5, v.6 ] -> [ v.2, v.3, v.1, v.5, v.6, v.4 ], 
  [ v.1, v.2, v.3, v.4, v.5, v.6 ] -> [ v.3, v.1, v.2, v.6, v.4, v.5 ], 
  [ v.1, v.2, v.3, v.4, v.5, v.6 ] -> [ v.1, v.2, v.3, v.4, v.5, v.6 ] ]

## Section 2.4.4
gap> act6 := DirectSumAlgebraActions( act3, act4 );;
gap> A6 := Source( act6 );
A3(+)A4
gap> B6 := AlgebraActedOn( act6 );
GR(G)(+)A(M4)
gap> em3 := ImageElm( Embedding( A6, 1 ), m3 ); 
[ [ 0, 1, 0, 0, 0, 0 ], [ 0, 0, 1, 0, 0, 0 ], [ 1, 0, 0, 0, 0, 0 ], 
  [ 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ] ]
gap> ImageElm( act6, em3 );                     
Basis( GR(G)(+)A(M4), [ v.1, v.2, v.3, v.4, v.5, v.6 ] ) -> 
[ v.2, v.3, v.1, 0*v.1, 0*v.1, 0*v.1 ]
gap> ea4 := ImageElm( Embedding( A6, 2 ), a4 );
[ [ 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ], 
  [ 0, 0, 0, 0, 2, 3 ], [ 0, 0, 0, 3, 0, 2 ], [ 0, 0, 0, 2, 3, 0 ] ]
gap> ImageElm( act6, ea4 );
Basis( GR(G)(+)A(M4), [ v.1, v.2, v.3, v.4, v.5, v.6 ] ) -> 
[ 0*v.1, 0*v.1, 0*v.1, (3)*v.5+(2)*v.6, (2)*v.4+(3)*v.6, (3)*v.4+(2)*v.5 ]

gap> SetInfoLevel( InfoXModAlg, level );; 
gap> STOP_TEST( "module.tst", 10000 );

############################################################################
##
#E  module.tst . . . . . . . . . . . . . . . . . . . . . . . . . . ends here