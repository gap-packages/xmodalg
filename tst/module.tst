############################################################################
##
#W  module.tst             XModAlg test files                  Chris Wensley 
## 
##
#@local level,A,V,M,famM,v,v2,m,genM,u2,u,D,T,B,M2B,B2M,act,genA
gap> START_TEST( "XModAlg package: module.tst" );
gap> level := InfoLevel( InfoXModAlg );; 
gap> SetInfoLevel( InfoXModAlg, 0 );

## Chapter 2, Section 2.2.3
gap> A := Rationals^[3,3];;
gap> SetName( A, "Q[3,3]" );;
gap> V := Rationals^3;;
gap> M := LeftAlgebraModule( A, \*, V );
<left-module over Q[3,3]>
gap> SetName( M, "M" );
gap> famM := ElementsFamily( FamilyObj( M ) );;
gap> v := [3,4,5];;
gap> v2 := ObjByExtRep( famM, v );
[ 3, 4, 5 ]
gap> m := [ [0,1,0], [0,0,1], [1,0,0] ];;
gap> m*v2;
[ 4, 5, 3 ]
gap> genM := GeneratorsOfLeftModule( M );;
gap> u2 := 6*genM[1] + 7*genM[2] + 8*genM[3];
[ 6, 7, 8 ]
gap> u := ExtRepOfObj( u2 );
[ 6, 7, 8 ]

## Chapter 2, Section 2.2.4
gap> D := LeftActingDomain( M );;
gap> T := EmptySCTable( Dimension(M), Zero(D), "symmetric" );;
gap> B := AlgebraByStructureConstants( D, T );
<algebra of dimension 3 over Rationals>
gap> GeneratorsOfAlgebra( B );
[ v.1, v.2, v.3 ]
gap> B := ModuleAsAlgebra( M );               
A(M)
gap> GeneratorsOfAlgebra( B );
[ [[ 1, 0, 0 ]], [[ 0, 1, 0 ]], [[ 0, 0, 1 ]] ]

## Chapter 2, Section 2.2.5
gap> IsModuleAsAlgebra( B );
true
gap> IsModuleAsAlgebra(A);
false

## Chapter 2, Section 2.2.6
gap> KnownAttributesOfObject(B);
[ "Name", "ZeroImmutable", "LeftActingDomain", "Dimension",
  "GeneratorsOfLeftOperatorAdditiveGroup", "GeneratorsOfLeftOperatorRing",
  "ModuleToAlgebraIsomorphism", "AlgebraToModuleIsomorphism" ]
gap> M2B := ModuleToAlgebraIsomorphism( B );
[ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ] ] -> [ [[ 1, 0, 0 ]], [[ 0, \
1, 0 ]], 
  [[ 0, 0, 1 ]] ]
gap> Source( M2B ) = M;
false
gap> Source( M2B ) = V;
true
gap> B2M := AlgebraToModuleIsomorphism( B );
[ [[ 1, 0, 0 ]], [[ 0, 1, 0 ]], [[ 0, 0, 1 ]] ] ->
[ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ] ]
gap> Range( B2M ) = M;
false
gap> Range( B2M ) = V;
true

## Chapter 2, Section 2.2.7
gap> act := AlgebraActionByModule( A, M );
[ [ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ] ],
  [ [ 1, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 0 ] ],
  [ [ 0, 0, 1 ], [ 1, 0, 0 ], [ 0, 1, 0 ] ] ] ->
[ [ [[ 1, 0, 0 ]], [[ 0, 1, 0 ]], [[ 0, 0, 1 ]] ] ->
    [ [[ 1, 0, 0 ]], [[ 0, 1, 0 ]], [[ 0, 0, 1 ]] ],
  [ [[ 1, 0, 0 ]], [[ 0, 1, 0 ]], [[ 0, 0, 1 ]] ] ->
    [ [[ 1, 0, 0 ]], 0*[[ 1, 0, 0 ]], 0*[[ 1, 0, 0 ]] ],
  [ [[ 1, 0, 0 ]], [[ 0, 1, 0 ]], [[ 0, 0, 1 ]] ] ->
    [ [[ 0, 1, 0 ]], [[ 0, 0, 1 ]], [[ 1, 0, 0 ]] ] ]
gap> genA := GeneratorsOfAlgebra(A);;
gap> m := 5*genA[1] -4*genA[2]+3*genA[3];
[ [ 1, 0, 3 ], [ 3, 5, 0 ], [ 0, 3, 5 ] ]
gap> Image( act, m );
Basis( A(M), [ [[ 1, 0, 0 ]], [[ 0, 1, 0 ]], [[ 0, 0, 1 ]] ] ) ->
[ [[ 1, 0, 0 ]]+(3)*[[ 0, 1, 0 ]], (5)*[[ 0, 1, 0 ]]+(3)*[[ 0, 0, 1 ]],
  (3)*[[ 1, 0, 0 ]]+(5)*[[ 0, 0, 1 ]] ]
gap> Image( act );
<algebra over Rationals, with 3 generators>

gap> SetInfoLevel( InfoXModAlg, level );; 
gap> STOP_TEST( "module.tst", 10000 );

############################################################################
##
#E  module.tst  . . . . . . . . . . . . . . . . . . . . . . . . . ends here
