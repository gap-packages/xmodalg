############################################################################
##
#W  module3.tst             XModAlg test files                 Chris Wensley 
## 
##
#@local level,m,A3,V3,M3,famM3,v,v2,genM3,u2,u,D3,T3,B3a,B3,M2B3,B2M3,act3,genA3,a
gap> START_TEST( "XModAlg package: module.tst" );
gap> level := InfoLevel( InfoXModAlg );; 
gap> SetInfoLevel( InfoXModAlg, 0 );

## Chapter 2, Section 2.2.3
gap> m := [ [0,1,0], [0,0,1], [1,0,0] ];;
gap> A3 := Rationals^[3,3];;
gap> SetName( A3, "A3" );;
gap> V3 := Rationals^3;;
gap> M3 := LeftAlgebraModule( A3, \*, V3 );;
gap> SetName( M3, "M3" );
gap> famM3 := ElementsFamily( FamilyObj( M3 ) );;
gap> v := [3,4,5];;
gap> v2 := ObjByExtRep( famM3, v );
[ 3, 4, 5 ]
gap> m*v2;
[ 4, 5, 3 ]
gap> genM3 := GeneratorsOfLeftModule( M3 );;
gap> u2 := 6*genM3[1] + 7*genM3[2] + 8*genM3[3];
[ 6, 7, 8 ]
gap> u := ExtRepOfObj( u2 );
[ 6, 7, 8 ]

## Chapter 2, Section 2.2.4
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

## Chapter 2, Section 2.2.5
gap> IsModuleAsAlgebra( B3 );
true
gap> IsModuleAsAlgebra( A3 );
false

## Chapter 2, Section 2.2.6
gap> KnownAttributesOfObject( B3 );
[ "Name", "ZeroImmutable", "LeftActingDomain", "Dimension",
  "GeneratorsOfLeftOperatorAdditiveGroup", "GeneratorsOfLeftOperatorRing",
  "ModuleToAlgebraIsomorphism", "AlgebraToModuleIsomorphism" ]
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

## Chapter 2, Section 2.2.7
gap> act3 := AlgebraActionByModule( A3, M3 );
[ [ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ] ],
  [ [ 1, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 0 ] ],
  [ [ 0, 0, 1 ], [ 1, 0, 0 ], [ 0, 1, 0 ] ] ] ->
[ [ [[ 1, 0, 0 ]], [[ 0, 1, 0 ]], [[ 0, 0, 1 ]] ] ->
    [ [[ 1, 0, 0 ]], [[ 0, 1, 0 ]], [[ 0, 0, 1 ]] ],
  [ [[ 1, 0, 0 ]], [[ 0, 1, 0 ]], [[ 0, 0, 1 ]] ] ->
    [ [[ 1, 0, 0 ]], 0*[[ 1, 0, 0 ]], 0*[[ 1, 0, 0 ]] ],
  [ [[ 1, 0, 0 ]], [[ 0, 1, 0 ]], [[ 0, 0, 1 ]] ] ->
    [ [[ 0, 1, 0 ]], [[ 0, 0, 1 ]], [[ 1, 0, 0 ]] ] ]
gap> genA3 := GeneratorsOfAlgebra( A3 );;
gap> a := 2*m + 3*m^2;
[ [ 0, 2, 3 ], [ 3, 0, 2 ], [ 2, 3, 0 ] ]
gap> Image( act3, a );
Basis( A(M3), [ [[ 1, 0, 0 ]], [[ 0, 1, 0 ]], [[ 0, 0, 1 ]] ] ) -> 
[ (3)*[[ 0, 1, 0 ]]+(2)*[[ 0, 0, 1 ]], (2)*[[ 1, 0, 0 ]]+(3)*[[ 0, 0, 1 ]], 
  (3)*[[ 1, 0, 0 ]]+(2)*[[ 0, 1, 0 ]] ]
gap> Image( act3 );
<algebra over Rationals, with 3 generators>

## Chapter 4, Section 4.1.7
gap> X3 := XModAlgebraByModule( A3, M3 );
[A(M3)->A3]
gap> Display( X3 );

Crossed module [A(M3)->A3] :- 
: Source algebra A(M3) has generators:
  [ [[ 1, 0, 0 ]], [[ 0, 1, 0 ]], [[ 0, 0, 1 ]] ]
: Range algebra A3 has generators:
  [ [ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ] ], 
  [ [ 1, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 0 ] ], 
  [ [ 0, 0, 1 ], [ 1, 0, 0 ], [ 0, 1, 0 ] ] ]
: Boundary homomorphism maps source generators to:
  [ [ [ 0, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 0 ] ], 
  [ [ 0, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 0 ] ], 
  [ [ 0, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 0 ] ] ]

## Chapter 5, Section 5.1.1
gap> C3 := Cat1AlgebraOfXModAlgebra( X3 );
[A3 |X A(M3)=>A3]
gap> Display( C3 );           
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

gap> SetInfoLevel( InfoXModAlg, level );; 
gap> STOP_TEST( "module.tst", 10000 );

############################################################################
##
#E  module3.tst . . . . . . . . . . . . . . . . . . . . . . . . . ends here
