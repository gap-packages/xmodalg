############################################################################
##
#W  module.tst              XModAlg test files                 Chris Wensley
##
#@local level,m3,A3,c3,Rc3,g3,mg3,Amg3,homg3,actg3,bdy3,X3,V3,M3,famM3,v3,genM3,u4,D3,T3,B3a,B3,M2B3,B2M3,act3,a3,X4,C4,A3Rc3,hom33,actMA3,act4,act5,A5,B5,em3,ea3

gap> START_TEST( "XModAlg package: module.tst" );
gap> level := InfoLevel( InfoXModAlg );; 
gap> SetInfoLevel( InfoXModAlg, 0 );

## Section 2.2.4
gap> m3 := [ [0,1,0], [0,0,1], [1,0,0,] ];;
gap> A3 := Algebra( Rationals, [m3] );;
gap> SetName( A3, "A3" );;
gap> c3 := Group( (1,2,3) );;
gap> Rc3 := GroupRing( Rationals, c3 );;
gap> SetName( Rc3, "GR(c3)" );
gap> g3 := GeneratorsOfAlgebra( Rc3 )[2];;
gap> mg3 := RegularAlgebraMultiplier( Rc3, Rc3, g3 );;
gap> Amg3 := AlgebraByGenerators( Rationals, [ mg3 ] );;
gap> homg3 := AlgebraHomomorphismByImages( A3, Amg3, [ m3 ], [ mg3 ] );;
gap> actg3 := AlgebraActionByHomomorphism( homg3, Rc3 );
[ [ [ 0, 1, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ] ] ] -> 
[ [ (1)*(), (1)*(1,2,3), (1)*(1,3,2) ] -> [ (1)*(1,2,3), (1)*(1,3,2), (1)*() 
    ] ]

## Section 4.1.7
gap> homg3 := AlgebraHomomorphismByImages( A3, Amg3, [ m3 ], [ mg3 ] );
[ [ [ 0, 1, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ] ] ] -> 
[ [ (1)*(), (1)*(1,2,3), (1)*(1,3,2) ] -> [ (1)*(1,2,3), (1)*(1,3,2), (1)*() 
     ] ]
gap> bdy3 := AlgebraHomomorphismByImages( Rc3, A3, [ g3 ], [ m3 ] );
[ (1)*(1,2,3) ] -> [ [ [ 0, 1, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ] ] ]
gap> X3 := XModAlgebraByBoundaryAndAction( bdy3, actg3 );
[ GR(c3) -> A3 ]
gap> Display( X3 );
Crossed module [GR(c3) -> A3] :- 
: Source algebra GR(c3) has generators:
  [ (1)*(), (1)*(1,2,3) ]
: Range algebra A3 has generators:
  [ [ [ 0, 1, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ] ] ]
: Boundary homomorphism maps source generators to:
  [ [ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ] ], 
  [ [ 0, 1, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ] ] ]

## Section 2.3
gap> V3 := Rationals^3;;
gap> M3 := LeftAlgebraModule( A3, \*, V3 );;
gap> SetName( M3, "M3" );
gap> famM3 := ElementsFamily( FamilyObj( M3 ) );;
gap> v3 := [3,4,5];;
gap> v3 := ObjByExtRep( famM3, v3 );
[ 3, 4, 5 ]
gap> m3*v3;
[ 4, 5, 3 ]
gap> genM3 := GeneratorsOfLeftModule( M3 );;
gap> u4 := 6*genM3[1] + 7*genM3[2] + 8*genM3[3];
[ 6, 7, 8 ]
gap> u4 := ExtRepOfObj( u4 );
[ 6, 7, 8 ]

## Section 2.3.1
gap> D3 := LeftActingDomain( M3 );;
gap> T3 := EmptySCTable( Dimension(M3), Zero(D3), "symmetric" );;
gap> B3a := AlgebraByStructureConstants( D3, T3 );
<algebra of dimension 3 over Rationals>
gap> GeneratorsOfAlgebra( B3a );
[ v.1, v.2, v.3 ]
gap> B3 := ModuleAsAlgebra( M3 );               
A(M3)
gap> GeneratorsOfAlgebra( B3 );
[ [[ 1, 0, 0 ]], [[ 0, 1, 0 ]], [[ 0, 0, 1 ]] ]

## Section 2.3.2
gap> IsModuleAsAlgebra( B3 );
true
gap> IsModuleAsAlgebra( A3 );
false

## Section 2.3.3
gap> Set( KnownAttributesOfObject( B3 ) );
[ "AlgebraToModuleIsomorphism", "Dimension", 
  "GeneratorsOfLeftOperatorAdditiveGroup", "GeneratorsOfLeftOperatorRing", 
  "LeftActingDomain", "ModuleToAlgebraIsomorphism", "Name", "ZeroImmutable" ]
gap> M2B3 := ModuleToAlgebraIsomorphism( B3 );
[ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ] ] -> [ [[ 1, 0, 0 ]], [[ 0, \
1, 0 ]], 
  [[ 0, 0, 1 ]] ]
gap> Source( M2B3 ) = M3;
false
gap> Source( M2B3 ) = V3;
true
gap> B2M3 := AlgebraToModuleIsomorphism( B3 );
[ [[ 1, 0, 0 ]], [[ 0, 1, 0 ]], [[ 0, 0, 1 ]] ] ->
[ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ] ]
gap> Range( B2M3 ) = M3;
false
gap> Range( B2M3 ) = V3;
true

## Section 2.3.4
gap> act3 := AlgebraActionByModule( A3, M3 );
[ [ [ 0, 1, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ] ] ] -> 
[ [ [[ 1, 0, 0 ]], [[ 0, 1, 0 ]], [[ 0, 0, 1 ]] ] -> 
    [ [[ 0, 0, 1 ]], [[ 1, 0, 0 ]], [[ 0, 1, 0 ]] ] ]
gap> a3 := 2*m3 + 3*m3^2;
[ [ 0, 2, 3 ], [ 3, 0, 2 ], [ 2, 3, 0 ] ]
gap> Image( act3, a3 );
Basis( A(M3), [ [[ 1, 0, 0 ]], [[ 0, 1, 0 ]], [[ 0, 0, 1 ]] ] ) -> 
[ (3)*[[ 0, 1, 0 ]]+(2)*[[ 0, 0, 1 ]], (2)*[[ 1, 0, 0 ]]+(3)*[[ 0, 0, 1 ]], 
  (3)*[[ 1, 0, 0 ]]+(2)*[[ 0, 1, 0 ]] ]
gap> Image( act3 );
<algebra over Rationals, with 1 generator>

## Section 4.1.8
gap> X4 := XModAlgebraByModule( A3, M3 );
[A(M3)->A3]
gap> XModAlgebraAction( X4 ) = act3;
true
gap> Display( X4 );
Crossed module [A(M3)->A3] :- 
: Source algebra A(M3) has generators:
  [ [[ 1, 0, 0 ]], [[ 0, 1, 0 ]], [[ 0, 0, 1 ]] ]
: Range algebra A3 has generators:
  [ [ [ 0, 1, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ] ] ]
: Boundary homomorphism maps source generators to:
  [ [ [ 0, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 0 ] ], 
  [ [ 0, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 0 ] ], 
  [ [ 0, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 0 ] ] ]

## Section 5.1.1
gap> C4 := Cat1AlgebraOfXModAlgebra( X4 );
[A3 |X A(M3) -> A3]
gap> Display( C4 );           
Cat1-algebra [A3 |X A(M3)=>A3] :- 
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
gap> A3Rc3 := DirectSumOfAlgebras( A3, Rc3 );;
gap> SetName( A3Rc3, Concatenation( Name(A3), "(+)", Name(Rc3) ) );
gap> SetDirectSumOfAlgebrasInfo( A3Rc3, 
> rec( algebras := [A3,Rc3], first := [1,Dimension(A3)+1],
>      embeddings := [ ], projections := [ ] ) );;

## Section 2.4.2
gap> Embedding( A3Rc3, 1 );
Basis( A3, [ [ [ 0, 1, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ] ], 
  [ [ 0, 0, 1 ], [ 1, 0, 0 ], [ 0, 1, 0 ] ], 
  [ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ] ] ] ) -> [ v.1, v.2, v.3 ]
gap> Projection( A3Rc3, 2 );
CanonicalBasis( A3(+)GR(c3) ) -> [ <zero> of ..., <zero> of ..., 
  <zero> of ..., (1)*(), (1)*(1,2,3), (1)*(1,3,2) ]

## Section 2.4.3
gap> hom33 := DirectSumOfAlgebraHomomorphisms( homg3, homg3 );;
gap> Print( hom33, "\n" );
AlgebraHomomorphismByImages( A3(+)A3, Algebra( Rationals, 
[ v.1, v.2, v.3, v.4, v.5, v.6 ] ), 
[ [ [ 0, 1, 0, 0, 0, 0 ], [ 0, 0, 1, 0, 0, 0 ], [ 1, 0, 0, 0, 0, 0 ], 
      [ 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ] ], 
  [ [ 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ], 
      [ 0, 0, 0, 0, 1, 0 ], [ 0, 0, 0, 0, 0, 1 ], [ 0, 0, 0, 1, 0, 0 ] ] ], 
[ v.1, v.4 ] )

## Section 2.4.4
gap> actMA3 := AlgebraActionByMultipliers( A3, A3, A3 );;
gap> act4 := AlgebraActionOnDirectSum( actMA3, actg3 );
[ [ [ 0, 1, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ] ], 
  [ [ 0, 0, 1 ], [ 1, 0, 0 ], [ 0, 1, 0 ] ], 
  [ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ] ] ] -> 
[ [ v.1, v.2, v.3, v.4, v.5, v.6 ] -> [ v.2, v.3, v.1, v.5, v.6, v.4 ], 
  [ v.1, v.2, v.3, v.4, v.5, v.6 ] -> [ v.3, v.1, v.2, v.6, v.4, v.5 ], 
  [ v.1, v.2, v.3, v.4, v.5, v.6 ] -> [ v.1, v.2, v.3, v.4, v.5, v.6 ] ]

## Section 2.4.5
gap> act5 := DirectSumOfAlgebraActions( actg3, act3 );;
gap> A5 := Source( act5 );
A3(+)A3
gap> B5 := AlgebraActedOn( act5 );
GR(c3)(+)A(M3)
gap> em3 := ImageElm( Embedding( A5, 1 ), m3 ); 
[ [ 0, 1, 0, 0, 0, 0 ], [ 0, 0, 1, 0, 0, 0 ], [ 1, 0, 0, 0, 0, 0 ], 
  [ 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ] ]
gap> ImageElm( act5, em3 );                     
Basis( GR(c3)(+)A(M3), [ v.1, v.2, v.3, v.4, v.5, v.6 ] ) -> 
[ v.2, v.3, v.1, 0*v.1, 0*v.1, 0*v.1 ]
gap> ea3 := ImageElm( Embedding( A5, 2 ), a3 );
[ [ 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ], 
  [ 0, 0, 0, 0, 2, 3 ], [ 0, 0, 0, 3, 0, 2 ], [ 0, 0, 0, 2, 3, 0 ] ]
gap> ImageElm( act5, ea3 );
Basis( GR(c3)(+)A(M3), [ v.1, v.2, v.3, v.4, v.5, v.6 ] ) -> 
[ 0*v.1, 0*v.1, 0*v.1, (3)*v.5+(2)*v.6, (2)*v.4+(3)*v.6, (3)*v.4+(2)*v.5 ]

gap> SetInfoLevel( InfoXModAlg, level );; 
gap> STOP_TEST( "module.tst", 10000 );

############################################################################
##
#E  module.tst . . . . . . . . . . . . . . . . . . . . . . . . . . ends here