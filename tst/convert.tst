#############################################################################
##
#W  convert.tst             XModAlg test files          Z. Arvasi - A. Odabas 
## 
gap> START_TEST( "XModAlg package: convert.tst" );
gap> saved_infolevel_xmodalg := InfoLevel( InfoXModAlg );; 
gap> SetInfoLevel( InfoXModAlg, 0 );

gap> ## make convert.tst independent of cat1.tst and xmod.tst 
gap> Ak4 := GroupRing( GF(5), DihedralGroup(4) );;
gap> SetName( Ak4, "GF5[k4]" );
gap> IAk4 := AugmentationIdeal( Ak4 );;
gap> SetName( IAk4, "I(GF5[k4])" );
gap> XIAk4 := XModAlgebraByIdeal( Ak4, IAk4 );;

gap> G := SmallGroup( 4, 2 );;
gap> F := GaloisField( 4 );;
gap> R := GroupRing( F, G );;
gap> SetName( R, "GF(2^2)[k4]" ); 
gap> e5 := Elements(R)[5];; 
gap> S := Subalgebra( R, [e5] );; 
gap> SetName( S, "<e5>" );
gap> act := AlgebraActionByMultipliers( R, S, R );;
gap> bdy := AlgebraHomomorphismByFunction( S, R, s->s );;
gap> IsAlgebraAction( act );; 
gap> IsAlgebraHomomorphism( bdy );; 
gap> XM := PreXModAlgebraByBoundaryAndAction( bdy, act );;
gap> IsXModAlgebra( XM );;

gap> F := GF(5);;
gap> one := One(F);;
gap> two := Z(5);; 
gap> z := Zero( F );; 
gap> l := [ [one,z,z], [z,one,z], [z,z,one] ];; 
gap> m := [ [z,one,two^3], [z,z,one], [z,z,z] ];;
gap> n := [ [z,z,one], [z,z,z], [z,z,z] ];; 
gap> A := Algebra( F, [l,m] );; 
gap> SetName( A, "A(l,m)" ); 
gap> B := Subalgebra( A, [m] );; 
gap> SetName( B, "A(m)" ); 
gap> IsIdeal( A, B );; 
gap> act := AlgebraActionByMultipliers( A, B, A );; 
gap> XAB := XModAlgebraByIdeal( A, B );; 
gap> SetName( XAB, "XAB" ); 

gap> C3 := Cat1AlgebraSelect( 2, 6, 2, 4 );; 

gap> ############################ 
gap> ## Chapter 5,  Section 5.1.1
gap> CAB := Cat1AlgebraOfXModAlgebra( XAB );
[Algebra( GF(5), [ v.1, v.2, v.3, v.4, v.5 ] ) -> A(l,m)]
gap> Display( CAB );

Cat1-algebra [..=>A(l,m)] :- 
:  range algebra has generators:
  
[ 
  [ [ Z(5)^0, 0*Z(5), 0*Z(5) ], [ 0*Z(5), Z(5)^0, 0*Z(5) ], 
      [ 0*Z(5), 0*Z(5), Z(5)^0 ] ], 
  [ [ 0*Z(5), Z(5)^0, Z(5)^3 ], [ 0*Z(5), 0*Z(5), Z(5)^0 ], 
      [ 0*Z(5), 0*Z(5), 0*Z(5) ] ] ]
: tail homomorphism maps source generators to:
: range embedding maps range generators to:
  [ v.1, v.2 ]
: kernel has generators:
  Algebra( GF(5), [ v.4, v.5 ] )

gap> X3 := XModAlgebraOfCat1Algebra( C3 );
[ <algebra of dimension 3 over GF(2)> -> <algebra of dimension 3 over GF(2)> ]
gap> Display( X3 ); 

Crossed module [..->..] :- 
: Source algebra has generators:
  [ (Z(2)^0)*()+(Z(2)^0)*(4,5), (Z(2)^0)*(1,2,3)+(Z(2)^0)*(1,2,3)(4,5), 
  (Z(2)^0)*(1,3,2)+(Z(2)^0)*(1,3,2)(4,5) ]
: Range algebra has generators:
  [ (Z(2)^0)*(), (Z(2)^0)*(1,2,3) ]
: Boundary homomorphism maps source generators to:
  [ <zero> of ..., <zero> of ..., <zero> of ... ]

gap> SetInfoLevel( InfoXModAlg, saved_infolevel_xmodalg );; 
gap> STOP_TEST( "convert.tst", 10000 );

############################################################################
##
#E  convert.tst  . . . . . . . . . . . . . . . . . . . . . . . . . ends here
