#############################################################################
##
#W  dsum-xmod.tst          XModAlg test files          Z. Arvasi - A. Odabas      
##
#@local level,m,A1,m3,A3,c3, Rc3,g3,mg3,Amg3,homg3,m2,A2,S2,nat2,Q2,bdy3,X3,X4,hom2,hom22a,hom33a,hom33b,actMA3,act4,act5,A5,B5,em3,ea3,XY3,C4

gap> START_TEST( "XModAlg package: dsum-xmod.tst" );
gap> level := InfoLevel( InfoXModAlg );; 
gap> SetInfoLevel( InfoXModAlg, 0 );

## make this test independent of algebra.tst and module.tst
gap> m := [ [0,1,2,3], [0,0,1,2], [0,0,0,1], [0,0,0,0] ];; 
gap> A1 := Algebra( Rationals, [m] );;
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
gap> m2 := [ [0,1,2,3], [0,0,1,2], [0,0,0,1], [0,0,0,0] ];; 
gap> A2 := Algebra( Rationals, [m2] );;
gap> SetName( A2, "A2" );
gap> S2 := Subalgebra( A2, [m2^3] );; 
gap> nat2 := NaturalHomomorphismByIdeal( A2, S2 );; 
gap> Q2 := Image( nat2 );;
gap> SetName( Q2, "Q2" );

## Section 4.1.7
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

## Section 2.4.3
gap> hom2 := AlgebraHomomorphismByImages( A1, A1, [BA1[2]], [BA1[3]] );
[ (Z(5)^0)*(1,2,3,4,5,6) ] -> [ (Z(5)^0)*(1,3,5)(2,4,6) ]
gap> hom22a := DirectSumOfAlgebraHomomorphisms( hom2, hom2 );;
gap> Print( hom33a, "\n" );
AlgebraHomomorphismByImages( A3(+)A3, Algebra( Rationals, 
[ v.1, v.2, v.3, v.4, v.5, v.6 ] ), 
[ [ [ 0, 1, 0, 0, 0, 0 ], [ 0, 0, 1, 0, 0, 0 ], [ 1, 0, 0, 0, 0, 0 ], 
      [ 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ] ], 
  [ [ 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ], 
      [ 0, 0, 0, 0, 1, 0 ], [ 0, 0, 0, 0, 0, 1 ], [ 0, 0, 0, 1, 0, 0 ] ] ], 
[ v.1, v.4 ] )
gap> hom33a := DirectSumOfAlgebraHomomorphisms( homg3, homg3 );
gap> Print( "\nfirst direct sum of homg3 with itself is:\n", hom33a, "\n" );
gap> hom33b := AlgebraHomomorphismFromDirectSum( homg3, homg3 );;
gap> Print( hom33b, "\n" );

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
gap> B5 := AlgebraActedOn( act5 );CanonicalBasis(A1);
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

############################
## Section 4.1.9
gap> XY3 := DirectSumOfXModAlgebras( X3, Y3 );
[ GR(c3)(+)A(M3) -> A3(+)A3 ]

############################
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


gap> STOP_TEST( "dsum-xmod.tst", 10000 );

############################################################################
##
#E  xmod.tst . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
