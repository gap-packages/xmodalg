#############################################################################
##
#W  algebra.tst             XModAlg test files          Z. Arvasi - A. Odabas 
## 
#@local level,A1,BA1,v,I1,v1,m1,id1,L1,h1,u1,S1,MS1,BMS1,MA1,BMA1,hom1,act1,act12,theta1,m2,A2,S2,nat2,Q2,act2,I2,BI2,b1,b2,P1,P2,A2c6,R2c3,homAR,homRA,bijAA,ideAA

gap> START_TEST( "XModAlg package: algebra.tst" );
gap> level := InfoLevel( InfoXModAlg );; 
gap> SetInfoLevel( InfoXModAlg, 0 );

## Section 2.1.1
gap> A1 := GroupRing( GF(5), Group( (1,2,3,4,5,6) ) );;
gap> SetName( A1, "A1" );
gap> BA1 := BasisVectors( Basis( A1 ) );; 
gap> v := BA1[1] + BA1[3] + BA1[5];
(Z(5)^0)*()+(Z(5)^0)*(1,3,5)(2,4,6)+(Z(5)^0)*(1,5,3)(2,6,4)
gap> I1 := Ideal( A1, [v] );;
gap> SetName( I1, "I1" );
gap> v1 := BA1[2];
(Z(5)^0)*(1,2,3,4,5,6)
gap> m1 := RegularAlgebraMultiplier( A1, I1, v1 ); 
[ (Z(5)^0)*()+(Z(5)^0)*(1,3,5)(2,4,6)+(Z(5)^0)*(1,5,3)(2,6,4), 
  (Z(5)^0)*(1,2,3,4,5,6)+(Z(5)^0)*(1,4)(2,5)(3,6)+(Z(5)^0)*(1,6,5,4,3,2) ] -> 
[ (Z(5)^0)*(1,2,3,4,5,6)+(Z(5)^0)*(1,4)(2,5)(3,6)+(Z(5)^0)*(1,6,5,4,3,2), 
  (Z(5)^0)*()+(Z(5)^0)*(1,3,5)(2,4,6)+(Z(5)^0)*(1,5,3)(2,6,4) ]

## Section 2.1.2
gap> IsAlgebraMultiplier( m1 ); 
true
gap> id1 := One( A1 );; 
gap> L1 := List( BA1, v -> id1 );; 
gap> h1 := LeftModuleHomomorphismByImages( A1, A1, BA1, L1 ); 
[ (Z(5)^0)*(), (Z(5)^0)*(1,2,3,4,5,6), (Z(5)^0)*(1,3,5)(2,4,6), 
  (Z(5)^0)*(1,4)(2,5)(3,6), (Z(5)^0)*(1,5,3)(2,6,4), (Z(5)^0)*(1,6,5,4,3,2) 
 ] -> [ (Z(5)^0)*(), (Z(5)^0)*(), (Z(5)^0)*(), (Z(5)^0)*(), (Z(5)^0)*(), 
  (Z(5)^0)*() ]
gap> IsAlgebraMultiplier( h1 );                                                
false

## Section 2.1.3
gap> u1 := BA1[3];
(Z(5)^0)*(1,3,5)(2,4,6)
gap> S1 := Subalgebra( A1, [ u1 ] );; 
gap> SetName( S1, "S1" );
gap> MS1 := MultiplierAlgebraOfIdealBySubalgebra( A1, I1, S1 );
<algebra of dimension 1 over GF(5)>
gap> SetName( MS1, "MS1" );
gap> BMS1 := BasisVectors( Basis( MS1 ) );; 
gap> BMS1[1];
<linear mapping by matrix, I1 -> I1>

## Section 2.1.4 
gap> MA1 := MultiplierAlgebra( A1 );
<algebra of dimension 6 over GF(5)>
gap> BMA1 := BasisVectors( Basis( MA1 ) );; 
gap> BMA1[3];
<linear mapping by matrix, A1 -> A1>

## Section 2.1.5
gap> hom1 := MultiplierHomomorphism( MA1 );;
gap> ImageElm( hom1, BA1[2] ); 
Basis( A1, [ (Z(5)^0)*(), (Z(5)^0)*(1,2,3,4,5,6), (Z(5)^0)*(1,3,5)(2\
,4,6), 
  (Z(5)^0)*(1,4)(2,5)(3,6), (Z(5)^0)*(1,5,3)(2,6,4), (Z(5)^0)*(1,6,5,4,3,2) 
 ] ) -> [ (Z(5)^0)*(1,2,3,4,5,6), (Z(5)^0)*(1,3,5)(2,4,6), 
  (Z(5)^0)*(1,4)(2,5)(3,6), (Z(5)^0)*(1,5,3)(2,6,4), (Z(5)^0)*(1,6,5,4,3,2), 
  (Z(5)^0)*() ]

## Section 2.2.2
gap> A1 := GroupRing( GF(5), Group( (1,2,3,4,5,6) ) );;
gap> BA1 := BasisVectors( Basis( A1 ) );; 
gap> v := BA1[1] + BA1[3] + BA1[5];
(Z(5)^0)*()+(Z(5)^0)*(1,3,5)(2,4,6)+(Z(5)^0)*(1,5,3)(2,6,4)
gap> I1 := Ideal( A1, [v] );; 
gap> act1 := AlgebraActionByMultipliers( A1, I1, A1 );; 
gap> act12 := Image( act1, BA1[2] );; 
gap> Image( act12, v );
(Z(5)^0)*(1,2,3,4,5,6)+(Z(5)^0)*(1,4)(2,5)(3,6)+(Z(5)^0)*(1,6,5,4,3,2)

## Section 2.2.3
gap> theta1 := NaturalHomomorphismByIdeal( A1, I1 );
<linear mapping by matrix, <algebra-with-one of dimension 
6 over GF(5)> -> <algebra of dimension 4 over GF(5)>>
gap> List( BA1, v -> ImageElm( theta1, v ) ); 
[ v.1, v.2, v.3, v.4, (Z(5)^2)*v.1+(Z(5)^2)*v.3, (Z(5)^2)*v.2+(Z(5)^2)*v.4 ]
gap> AlgebraActionBySurjection( theta1 );
kernel of hom is not in the annihilator of A
fail
gap> ## an example which does not fail: 
gap> m2 := [ [0,1,2,3], [0,0,1,2], [0,0,0,1], [0,0,0,0] ];; 
gap> m2^2;
[ [ 0, 0, 1, 4 ], [ 0, 0, 0, 1 ], [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ] ]
gap> m2^3;
[ [ 0, 0, 0, 1 ], [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ] ]
gap> A2 := Algebra( Rationals, [m2] );;
gap> SetName( A2, "A2" );
gap> S2 := Subalgebra( A2, [m2^3] );; 
gap> SetName( S2, "S2" );
gap> nat2 := NaturalHomomorphismByIdeal( A2, S2 ); 
<linear mapping by matrix, A2 -> <algebra of dimension 2 over Ration\
als>>
gap> Q2 := Image( nat2 );;
gap> SetName( Q2, "Q2" );
gap> Display( nat2 );
LeftModuleHomomorphismByMatrix( Basis( A2, 
[ [ [ 0, 0, 0, 1 ], [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ] ], 
  [ [ 0, 1, 2, 3 ], [ 0, 0, 1, 2 ], [ 0, 0, 0, 1 ], [ 0, 0, 0, 0 ] ], 
  [ [ 0, 0, 1, 4 ], [ 0, 0, 0, 1 ], [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ] ] ] ), 
[ [ 0, 0 ], [ 1, 0 ], [ 0, 1 ] ], CanonicalBasis( Q2 ) )
gap> act2 := AlgebraActionBySurjection( nat2 );; 
gap> I2 := Image( act2 );;
gap> BI2 := BasisVectors( Basis( I2 ) );;
gap> b1 := BI2[1];;  b2 := BI2[2];;
gap> [ Image(b1,m2)=m2^2, Image(b1,m2^2)=m2^3, Image(b1,m2^3)=Zero(A2) ];
[ true, true, true ]
gap> [ Image(b2,m2)=m2^3, b2=b1^2 ];
[true, true ]

## Section 2.5.1
gap> P1 := SemidirectProductOfAlgebras( A1, act1, I1 ); 
<algebra of dimension 8 over GF(5)>
gap> Embedding( P1, 1 );
[ (Z(5)^0)*(), (Z(5)^0)*(1,2,3,4,5,6), (Z(5)^0)*(1,3,5)(2,4,6), 
  (Z(5)^0)*(1,4)(2,5)(3,6), (Z(5)^0)*(1,5,3)(2,6,4), (Z(5)^0)*(1,6,5,4,3,2) 
 ] -> [ v.1, v.2, v.3, v.4, v.5, v.6 ]
gap> Embedding( P1, 2 );
[ (Z(5)^0)*()+(Z(5)^0)*(1,3,5)(2,4,6)+(Z(5)^0)*(1,5,3)(2,6,4), 
  (Z(5)^0)*(1,2,3,4,5,6)+(Z(5)^0)*(1,4)(2,5)(3,6)+(Z(5)^0)*(1,6,5,4,3,2) ] -> 
[ v.7, v.8 ]
gap> Projection( P1, 1 );
[ v.1, v.2, v.3, v.4, v.5, v.6, v.7, v.8 ] -> 
[ (Z(5)^0)*(), (Z(5)^0)*(1,2,3,4,5,6), (Z(5)^0)*(1,3,5)(2,4,6), 
  (Z(5)^0)*(1,4)(2,5)(3,6), (Z(5)^0)*(1,5,3)(2,6,4), (Z(5)^0)*(1,6,5,4,3,2), 
  <zero> of ..., <zero> of ... ]
gap> P2 := SemidirectProductOfAlgebras( Q2, act2, A2 );
Q2 |X A2
gap> Embedding( P2, 1 );
[ v.1, v.2 ] -> [ v.1, v.2 ]
gap> Embedding( P2, 2 );
[ [ [ 0, 1, 2, 3 ], [ 0, 0, 1, 2 ], [ 0, 0, 0, 1 ], [ 0, 0, 0, 0 ] ], 
  [ [ 0, 0, 1, 4 ], [ 0, 0, 0, 1 ], [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ] ], 
  [ [ 0, 0, 0, 1 ], [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ] ] ] -> 
[ v.3, v.4, v.5 ]

## Section 2.6.1
gap> A2c6 := GroupRing( GF(2), Group( (1,2,3,4,5,6) ) );;
gap> R2c3 := GroupRing( GF(2), Group( (7,8,9) ) );;
gap> homAR := AllAlgebraHomomorphisms( A2c6, R2c3 );;
gap> List( homAR, h -> MappingGeneratorsImages(h) );
[ [ [ (Z(2)^0)*(1,6,5,4,3,2) ], [ <zero> of ... ] ], 
  [ [ (Z(2)^0)*(1,6,5,4,3,2) ], [ (Z(2)^0)*() ] ], 
  [ [ (Z(2)^0)*(1,6,5,4,3,2) ], [ (Z(2)^0)*()+(Z(2)^0)*(7,8,9) ] ], 
  [ [ (Z(2)^0)*(1,6,5,4,3,2) ], 
      [ (Z(2)^0)*()+(Z(2)^0)*(7,8,9)+(Z(2)^0)*(7,9,8) ] ], 
  [ [ (Z(2)^0)*(1,6,5,4,3,2) ], [ (Z(2)^0)*()+(Z(2)^0)*(7,9,8) ] ], 
  [ [ (Z(2)^0)*(1,6,5,4,3,2) ], [ (Z(2)^0)*(7,8,9) ] ], 
  [ [ (Z(2)^0)*(1,6,5,4,3,2) ], [ (Z(2)^0)*(7,8,9)+(Z(2)^0)*(7,9,8) ] ], 
  [ [ (Z(2)^0)*(1,6,5,4,3,2) ], [ (Z(2)^0)*(7,9,8) ] ] ]
gap> homRA := AllAlgebraHomomorphisms( R2c3, A2c6 );;
gap> List( homRA, h -> MappingGeneratorsImages(h) );
[ [ [ (Z(2)^0)*(7,8,9) ], [ <zero> of ... ] ], 
  [ [ (Z(2)^0)*(7,8,9) ], [ (Z(2)^0)*() ] ], 
  [ [ (Z(2)^0)*(7,8,9) ], [ (Z(2)^0)*()+(Z(2)^0)*(1,3,5)(2,4,6) ] ], 
  [ [ (Z(2)^0)*(7,8,9) ], 
      [ (Z(2)^0)*()+(Z(2)^0)*(1,3,5)(2,4,6)+(Z(2)^0)*(1,5,3)(2,6,4) ] ], 
  [ [ (Z(2)^0)*(7,8,9) ], [ (Z(2)^0)*()+(Z(2)^0)*(1,5,3)(2,6,4) ] ], 
  [ [ (Z(2)^0)*(7,8,9) ], [ (Z(2)^0)*(1,3,5)(2,4,6) ] ], 
  [ [ (Z(2)^0)*(7,8,9) ], [ (Z(2)^0)*(1,3,5)(2,4,6)+(Z(2)^0)*(1,5,3)(2,6,4) ] 
     ], [ [ (Z(2)^0)*(7,8,9) ], [ (Z(2)^0)*(1,5,3)(2,6,4) ] ] ]
gap> bijAA := AllBijectiveAlgebraHomomorphisms( A2c6, A2c6 );;
gap> List( bijAA, h -> MappingGeneratorsImages(h) );
[ [ [ (Z(2)^0)*(1,6,5,4,3,2) ], 
      [ (Z(2)^0)*()+(Z(2)^0)*(1,3,5)(2,4,6)+(Z(2)^0)*(1,4)(2,5)(3,6) ] ], 
  [ [ (Z(2)^0)*(1,6,5,4,3,2) ], 
      [ (Z(2)^0)*()+(Z(2)^0)*(1,4)(2,5)(3,6)+(Z(2)^0)*(1,5,3)(2,6,4) ] ], 
  [ [ (Z(2)^0)*(1,6,5,4,3,2) ], [ (Z(2)^0)*(1,2,3,4,5,6) ] ], 
  [ [ (Z(2)^0)*(1,6,5,4,3,2) ], 
      [ (Z(2)^0)*(1,2,3,4,5,6)+(Z(2)^0)*(1,3,5)(2,4,6)+(Z(2)^0)*(1,5,3)
            (2,6,4) ] ], 
  [ [ (Z(2)^0)*(1,6,5,4,3,2) ], 
      [ (Z(2)^0)*(1,3,5)(2,4,6)+(Z(2)^0)*(1,5,3)(2,6,4)+(Z(2)^0)*
            (1,6,5,4,3,2) ] ], 
  [ [ (Z(2)^0)*(1,6,5,4,3,2) ], [ (Z(2)^0)*(1,6,5,4,3,2) ] ] ]
gap> ideAA := AllIdempotentAlgebraHomomorphisms( A2c6, A2c6 );; 
gap> Length( ideAA );
14

gap> SetInfoLevel( InfoXModAlg, level );; 
gap> STOP_TEST( "algebra.tst", 10000 );

############################################################################
##
#E  algebra.tst  . . . . . . . . . . . . . . . . . . . . . . . . . ends here
