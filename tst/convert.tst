#############################################################################
##
#W  convert.tst             XModAlg test files          Z. Arvasi - A. Odabas 
## 

gap> START_TEST( "XModAlg package: convert.tst" );
gap> level := InfoLevel( InfoXModAlg );; 
gap> SetInfoLevel( InfoXModAlg, 0 );

gap> ## make convert.tst independent of cat1.tst and xmod.tst 

## from 2.2.4
gap> m3 := [ [0,1,0], [0,0,1], [1,0,0] ];;
gap> A3 := Algebra( Rationals, [m3] );;
gap> SetName( A3, "A3" );
gap> c3 := Group( (1,2,3) );;
gap> Rc3 := GroupRing( Rationals, c3 );;
gap> SetName( Rc3, "GR(c3)" );
gap> g3 := GeneratorsOfAlgebra( Rc3 )[2];;
gap> mg3 := RegularAlgebraMultiplier( Rc3, Rc3, g3 );;
gap> Amg3 := AlgebraByGenerators( Rationals, [ mg3 ] );;
gap> homg3 := AlgebraHomomorphismByImages( A3, Amg3, [ m3 ], [ mg3 ] );;
gap> actg3 := AlgebraActionByHomomorphism( homg3, Rc3 );;

## Chapter 4, Section 4.1.2 
gap> F5 := GF(5);;
gap> id5 := One( F5 );;
gap> two := Z(5);; 
gap> z5 := Zero( F5 );; 
gap> n0 := [ [id5,z5,z5], [z5,id5,z5], [z5,z5,id5] ];; 
gap> n1 := [ [z5,id5,two^3], [z5,z5,id5], [z5,z5,z5] ];;
gap> n2 := [ [z5,z5,id5], [z5,z5,z5], [z5,z5,z5] ];; 
gap> An := Algebra( F5, [ n0, n1 ] );; 
gap> SetName( An, "An" ); 
gap> Bn := Subalgebra( An, [ n1 ] );; 
gap> SetName( Bn, "Bn" ); 
gap> IsIdeal( An, Bn ); 
true
gap> actn := AlgebraActionByMultipliers( An, Bn, An );; 
gap> Xn := XModAlgebraByIdeal( An, Bn ); 
[ Bn -> An ]
gap> SetName( Xn, "Xn" ); 

############################ 
## Chapter 5,  Section 5.1.1
gap> Cn := Cat1AlgebraOfXModAlgebra( Xn );
[An |X Bn -> An]
gap> Display( Cn );
Cat1-algebra [An |X Bn => An] :- 
:  range algebra has generators:
[ 
  [ [ Z(5)^0, 0*Z(5), 0*Z(5) ], [ 0*Z(5), Z(5)^0, 0*Z(5) ], 
      [ 0*Z(5), 0*Z(5), Z(5)^0 ] ], 
  [ [ 0*Z(5), Z(5)^0, Z(5)^3 ], [ 0*Z(5), 0*Z(5), Z(5)^0 ], 
      [ 0*Z(5), 0*Z(5), 0*Z(5) ] ] ]
: tail homomorphism maps source generators to:  
[ 
  [ [ Z(5)^0, 0*Z(5), 0*Z(5) ], [ 0*Z(5), Z(5)^0, 0*Z(5) ], 
      [ 0*Z(5), 0*Z(5), Z(5)^0 ] ], 
  [ [ 0*Z(5), Z(5)^0, Z(5)^3 ], [ 0*Z(5), 0*Z(5), Z(5)^0 ], 
      [ 0*Z(5), 0*Z(5), 0*Z(5) ] ], 
  [ [ 0*Z(5), 0*Z(5), Z(5)^0 ], [ 0*Z(5), 0*Z(5), 0*Z(5) ], 
      [ 0*Z(5), 0*Z(5), 0*Z(5) ] ], 
  [ [ 0*Z(5), 0*Z(5), 0*Z(5) ], [ 0*Z(5), 0*Z(5), 0*Z(5) ], 
      [ 0*Z(5), 0*Z(5), 0*Z(5) ] ], 
  [ [ 0*Z(5), 0*Z(5), 0*Z(5) ], [ 0*Z(5), 0*Z(5), 0*Z(5) ], 
      [ 0*Z(5), 0*Z(5), 0*Z(5) ] ] ]
: head homomorphism maps source generators to:  
[ 
  [ [ Z(5)^0, 0*Z(5), 0*Z(5) ], [ 0*Z(5), Z(5)^0, 0*Z(5) ], 
      [ 0*Z(5), 0*Z(5), Z(5)^0 ] ], 
  [ [ 0*Z(5), Z(5)^0, Z(5)^3 ], [ 0*Z(5), 0*Z(5), Z(5)^0 ], 
      [ 0*Z(5), 0*Z(5), 0*Z(5) ] ], 
  [ [ 0*Z(5), 0*Z(5), Z(5)^0 ], [ 0*Z(5), 0*Z(5), 0*Z(5) ], 
      [ 0*Z(5), 0*Z(5), 0*Z(5) ] ], 
  [ [ 0*Z(5), Z(5)^0, Z(5)^3 ], [ 0*Z(5), 0*Z(5), Z(5)^0 ], 
      [ 0*Z(5), 0*Z(5), 0*Z(5) ] ], 
  [ [ 0*Z(5), 0*Z(5), Z(5)^0 ], [ 0*Z(5), 0*Z(5), 0*Z(5) ], 
      [ 0*Z(5), 0*Z(5), 0*Z(5) ] ] ]
: range embedding maps range generators to:    [ v.1, v.2 ]
: kernel has generators:  [ v.4, v.5 ]

gap> bdy3 := AlgebraHomomorphismByImages( Rc3, A3, [ g3 ], [ m3 ] );;
gap> X3 := XModAlgebraByBoundaryAndAction( bdy3, actg3 );;
gap> C3 := Cat1AlgebraOfXModAlgebra( X3 );
[A3 |X GR(c3) -> A3]
gap> Display( C3 );                 
Cat1-algebra [A3 |X GR(c3) => A3] :- 
:  range algebra has generators:[ [ [ 0, 1, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ] ] ]
: tail homomorphism maps source generators to:  
[ [ [ 0, 1, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ] ], 
  [ [ 0, 0, 1 ], [ 1, 0, 0 ], [ 0, 1, 0 ] ], 
  [ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ] ], 
  [ [ 0, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 0 ] ], 
  [ [ 0, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 0 ] ], 
  [ [ 0, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 0 ] ] ]
: head homomorphism maps source generators to:  
[ [ [ 0, 1, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ] ], 
  [ [ 0, 0, 1 ], [ 1, 0, 0 ], [ 0, 1, 0 ] ], 
  [ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ] ], 
  [ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ] ], 
  [ [ 0, 1, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ] ], 
  [ [ 0, 0, 1 ], [ 1, 0, 0 ], [ 0, 1, 0 ] ] ]
: range embedding maps range generators to:    [ v.1 ]
: kernel has generators:  [ v.4, v.5, v.6 ]

gap> C6 := Cat1AlgebraSelect( 2, 6, 2, 4 );;
gap> X6 := XModAlgebraOfCat1Algebra( C6 );
[ <algebra of dimension 3 over GF(2)> -> <algebra of dimension 3 over GF(2)> ]
gap> Display( X6 ); 
Crossed module [..->..] :- 
: Source algebra has generators:
  [ (Z(2)^0)*()+(Z(2)^0)*(4,5), (Z(2)^0)*(1,2,3)+(Z(2)^0)*(1,2,3)(4,5), 
  (Z(2)^0)*(1,3,2)+(Z(2)^0)*(1,3,2)(4,5) ]
: Range algebra has generators:
  [ (Z(2)^0)*(), (Z(2)^0)*(1,2,3) ]
: Boundary homomorphism maps source generators to:
  [ <zero> of ..., <zero> of ..., <zero> of ... ]

gap> SetInfoLevel( InfoXModAlg, level );; 
gap> STOP_TEST( "convert.tst", 10000 );

############################################################################
##
#E  convert.tst  . . . . . . . . . . . . . . . . . . . . . . . . . ends here
