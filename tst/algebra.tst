#############################################################################
##
#W  algebra.tst             XModAlg test files          Z. Arvasi - A. Odabas 
## 
gap> START_TEST( "XModAlg package: algebra.tst" );
gap> saved_infolevel_xmodalg := InfoLevel( InfoXModAlg );; 
gap> SetInfoLevel( InfoXModAlg, 0 );


gap> SetInfoLevel( InfoXModAlg, saved_infolevel_xmodalg );; 
gap> STOP_TEST( "algebra.tst", 10000 );

gap> Ac6 := GroupRing( GF(5), Group( (1,2,3,4,5,6) ) );;
gap> vecA := BasisVectors( Basis( Ac6 ) );; 
gap> v := vecA[1] + vecA[3] + vecA[5];
(Z(5)^0)*()+(Z(5)^0)*(1,3,5)(2,4,6)+(Z(5)^0)*(1,5,3)(2,6,4)
gap> Ic6 := Ideal( Ac6, [v] );; 
gap> act := AlgebraActionByMultiplication( Ac6, Ic6 );; 
gap> act2 := Image( act, vecA[2] );; 
gap> Image( act2, v );
(Z(5)^0)*(1,2,3,4,5,6)+(Z(5)^0)*(1,4)(2,5)(3,6)+(Z(5)^0)*(1,6,5,4,3,2)

gap> P := SemidirectProductOfAlgebras( Ac6, act, Ic6 ); 
<algebra of dimension 8 over GF(5)>
gap> Embedding( P, 1 );
[ (Z(5)^0)*(), (Z(5)^0)*(1,2,3,4,5,6), (Z(5)^0)*(1,3,5)(2,4,6), 
  (Z(5)^0)*(1,4)(2,5)(3,6), (Z(5)^0)*(1,5,3)(2,6,4), (Z(5)^0)*(1,6,5,4,3,2) 
 ] -> [ v.1, v.2, v.3, v.4, v.5, v.6 ]
gap> Embedding( P, 2 );
[ (Z(5)^0)*()+(Z(5)^0)*(1,3,5)(2,4,6)+(Z(5)^0)*(1,5,3)(2,6,4), 
  (Z(5)^0)*(1,2,3,4,5,6)+(Z(5)^0)*(1,4)(2,5)(3,6)+(Z(5)^0)*(1,6,5,4,3,2) ] -> 
[ v.7, v.8 ]
gap> Projection( P, 1 );
[ v.1, v.2, v.3, v.4, v.5, v.6, v.7, v.8 ] -> 
[ (Z(5)^0)*(), (Z(5)^0)*(1,2,3,4,5,6), (Z(5)^0)*(1,3,5)(2,4,6), 
  (Z(5)^0)*(1,4)(2,5)(3,6), (Z(5)^0)*(1,5,3)(2,6,4), (Z(5)^0)*(1,6,5,4,3,2), 
  <zero> of ..., <zero> of ... ]



############################################################################
##
#E  algebra.tst  . . . . . . . . . . . . . . . . . . . . . . . . . ends here
