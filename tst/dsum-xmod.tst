#############################################################################
##
#W  dsum-xmod.tst          XModAlg test files          Z. Arvasi - A. Odabas      
##
#@local level,m3,A3,c3,GRc3,g3,mg3,Amg3,homg3,actg3,bdy3,X3,V3,M3,act3,A1,BA1,m2,A2,S2,nat2,Q2,Y3,hom1,hom11,hom33a,hom33b,actMA3,act4,act5,A5,B5,em3,ea3,XY3,C3

gap> START_TEST( "XModAlg package: dsum-xmod.tst" );
gap> level := InfoLevel( InfoXModAlg );; 
gap> SetInfoLevel( InfoXModAlg, 0 );

## make this test independent of algebra.tst and module.tst
gap> m3 := [ [0,1,0], [0,0,1], [1,0,0] ];;
gap> A3 := Algebra( Rationals, [m3] );;
gap> SetName( A3, "A3" );
gap> c3 := Group( (1,2,3) );;
gap> GRc3 := GroupRing( Rationals, c3 );;
gap> SetName( GRc3, "GR(c3)" );
gap> g3 := GeneratorsOfAlgebra( GRc3 )[2];;
gap> mg3 := RegularAlgebraMultiplier( GRc3, GRc3, g3 );;
gap> Amg3 := AlgebraByGenerators( Rationals, [ mg3 ] );;
gap> SetName( Amg3, "Amg3" );
gap> homg3 := AlgebraHomomorphismByImages( A3, Amg3, [ m3 ], [ mg3 ] );;
gap> actg3 := AlgebraActionByHomomorphism( homg3, GRc3 );;
gap> bdy3 := AlgebraHomomorphismByImages( GRc3, A3, [ g3 ], [ m3 ] );;
gap> X3 := XModAlgebraByBoundaryAndAction( bdy3, actg3 );;
gap> V3 := Rationals^3;;
gap> M3 := LeftAlgebraModule( A3, \*, V3 );;
gap> SetName( M3, "M3" );
gap> act3 := AlgebraActionByModule( A3, M3 );;

gap> A1 := GroupRing( GF(5), Group( (1,2,3,4,5,6) ) );;
gap> SetName( A1, "A1" );
gap> BA1 := BasisVectors( Basis( A1 ) );; 
gap> m2 := [ [0,1,2,3], [0,0,1,2], [0,0,0,1], [0,0,0,0] ];; 
gap> A2 := Algebra( Rationals, [m2] );;
gap> SetName( A2, "A2" );
gap> S2 := Subalgebra( A2, [m2^3] );; 
gap> nat2 := NaturalHomomorphismByIdeal( A2, S2 );; 
gap> Q2 := Image( nat2 );;
gap> SetName( Q2, "Q2" );

## Section 4.1.7
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
gap> Y3 := XModAlgebraByModule( A3, M3 );
[A(M3)->A3]
gap> Display( Y3 );
Crossed module [A(M3)->A3] :- 
: Source algebra A(M3) has generators:
  [ [[ 1, 0, 0 ]], [[ 0, 1, 0 ]], [[ 0, 0, 1 ]] ]
: Range algebra A3 has generators:
  [ [ [ 0, 1, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ] ] ]
: Boundary homomorphism maps source generators to:
[ [ [ 0, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 0 ] ], 
  [ [ 0, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 0 ] ], 
  [ [ 0, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 0 ] ] ]
gap> Image( XModAlgebraAction( Y3 ), m3 ) = Image( act3, m3 ); 
true

## Section 2.4.3
gap> hom1 := AlgebraHomomorphismByImages( A1, A1, [BA1[2]], [BA1[3]] );
[ (Z(5)^0)*(1,2,3,4,5,6) ] -> [ (Z(5)^0)*(1,3,5)(2,4,6) ]
gap> hom11 := DirectSumOfAlgebraHomomorphisms( hom1, hom1 );;
gap> Print( hom11, "\n" );
AlgebraHomomorphismByImages( A1(+)A1, A1(+)A1, [ v.1, v.2, v.7, v.8 ], 
[ v.1, v.3, v.7, v.9 ] )
gap> hom33a := DirectSumOfAlgebraHomomorphisms( homg3, homg3 );;
gap> Print( "\nfirst direct sum of homg3 with itself is:\n", hom33a, "\n" );
first direct sum of homg3 with itself is:
AlgebraHomomorphismByImages( A3(+)A3, Amg3(+)Amg3, 
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
##
## The code for this operation is not yet correct, so commenting it out
##
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
## gap> a3 := 2*m3 + 3*m3^2;
## [ [ 0, 2, 3 ], [ 3, 0, 2 ], [ 2, 3, 0 ] ]
## gap> ea3 := ImageElm( Embedding( A5, 2 ), a3 );
## [ [ 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ], 
##   [ 0, 0, 0, 0, 2, 3 ], [ 0, 0, 0, 3, 0, 2 ], [ 0, 0, 0, 2, 3, 0 ] ]
## gap> ImageElm( act5, ea3 );
## Basis( GR(c3)(+)A(M3), [ v.1, v.2, v.3, v.4, v.5, v.6 ] ) -> 
## [ 0*v.1, 0*v.1, 0*v.1, (3)*v.5+(2)*v.6, (2)*v.4+(3)*v.6, (3)*v.4+(2)*v.5 ]

############################
## Section 4.1.9
##
## The code for this operation is not yet correct, so commenting it out
##
## gap> XY3 := DirectSumOfXModAlgebras( X3, Y3 );
## [ GR(c3)(+)A(M3) -> A3(+)A3 ]

############################
## Section 5.1.1
gap> C3 := Cat1AlgebraOfXModAlgebra( Y3 );
[A3 |X A(M3) -> A3]
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


gap> STOP_TEST( "dsum-xmod.tst", 10000 );

############################################################################
##
#E  xmod.tst . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
