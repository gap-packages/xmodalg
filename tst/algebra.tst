#############################################################################
##
#W  algebra.tst             XModAlg test files          Z. Arvasi - A. Odabas 
## 
gap> START_TEST( "XModAlg package: algebra.tst" );
gap> saved_infolevel_xmodalg := InfoLevel( InfoXModAlg );; 
gap> SetInfoLevel( InfoXModAlg, 0 );


gap> SetInfoLevel( InfoXModAlg, saved_infolevel_xmodalg );; 
gap> STOP_TEST( "algebra.tst", 10000 );

## Chapter 2, Section 2.1.1
gap> A5c6 := GroupRing( GF(5), Group( (1,2,3,4,5,6) ) );;
gap> vecA := BasisVectors( Basis( A5c6 ) );; 
gap> v := vecA[1] + vecA[3] + vecA[5];
(Z(5)^0)*()+(Z(5)^0)*(1,3,5)(2,4,6)+(Z(5)^0)*(1,5,3)(2,6,4)
gap> I5c6 := Ideal( A5c6, [v] );; 
gap> v2 := vecA[2];
(Z(5)^0)*(1,2,3,4,5,6)
gap> m2 := RegularAlgebraMultiplier( A5c6, I5c6, v2 ); 
[ (Z(5)^0)*()+(Z(5)^0)*(1,3,5)(2,4,6)+(Z(5)^0)*(1,5,3)(2,6,4), 
  (Z(5)^0)*(1,2,3,4,5,6)+(Z(5)^0)*(1,4)(2,5)(3,6)+(Z(5)^0)*(1,6,5,4,3,2) ] -> 
[ (Z(5)^0)*(1,2,3,4,5,6)+(Z(5)^0)*(1,4)(2,5)(3,6)+(Z(5)^0)*(1,6,5,4,3,2), 
  (Z(5)^0)*()+(Z(5)^0)*(1,3,5)(2,4,6)+(Z(5)^0)*(1,5,3)(2,6,4) ]

## Section 2.1.2
gap> IsAlgebraMultiplier( m2 ); 
true
gap> one := One( A5c6 );; 
gap> L := List( vecA, v -> one );; 
gap> m1 := LeftModuleHomomorphismByImages( A5c6, A5c6, vecA, L ); 
[ (Z(5)^0)*(), (Z(5)^0)*(1,2,3,4,5,6), (Z(5)^0)*(1,3,5)(2,4,6), 
  (Z(5)^0)*(1,4)(2,5)(3,6), (Z(5)^0)*(1,5,3)(2,6,4), (Z(5)^0)*(1,6,5,4,3,2) 
 ] -> [ (Z(5)^0)*(), (Z(5)^0)*(), (Z(5)^0)*(), (Z(5)^0)*(), (Z(5)^0)*(), 
  (Z(5)^0)*() ]
gap> IsAlgebraMultiplier( m1 );                                                
false

## Section 2.1.3
gap> v3 := vecA[3];
(Z(5)^0)*(1,3,5)(2,4,6)
gap> B5c3 := Subalgebra( A5c6, [ v3 ] );; 
gap> M := MultiplierAlgebraOfIdealBySubalgebra( A5c6, I5c6, B5c3 );
<algebra of dimension 1 over GF(5)>
gap> vecM := BasisVectors( Basis( M ) );; 
gap> vecM[1];
<linear mapping by matrix, 
<two-sided ideal in <algebra-with-one of dimension 6 over GF(5)>, (dimension 2
 )> -> <two-sided ideal in <algebra-with-one of dimension 6 over GF(5)>, 
  (dimension 2)>>

## Section 2.1.4 
gap> MA5c6 := MultiplierAlgebra( A5c6 );
<algebra of dimension 6 over GF(5)>
gap> vecM := BasisVectors( Basis( MA5c6 ) );; 
gap> vecM[3];
<linear mapping by matrix, <algebra-with-one of dimension 
6 over GF(5)> -> <algebra-with-one of dimension 6 over GF(5)>>

## Section 2.1.5
gap> hom := MultiplierHomomorphism( MA5c6 );; 
gap> ImageElm( hom, vecA[2] ); 
Basis( <algebra-with-one of dimension 6 over GF(5)>, 
[ (Z(5)^0)*(), (Z(5)^0)*(1,2,3,4,5,6), (Z(5)^0)*(1,3,5)(2,4,6), 
  (Z(5)^0)*(1,4)(2,5)(3,6), (Z(5)^0)*(1,5,3)(2,6,4), (Z(5)^0)*(1,6,5,4,3,2) 
 ] ) -> [ (Z(5)^0)*(1,2,3,4,5,6), (Z(5)^0)*(1,3,5)(2,4,6), 
  (Z(5)^0)*(1,4)(2,5)(3,6), (Z(5)^0)*(1,5,3)(2,6,4), (Z(5)^0)*(1,6,5,4,3,2), 
  (Z(5)^0)*() ]

## Chapter 2, Section 2.2.1
gap> A5c6 := GroupRing( GF(5), Group( (1,2,3,4,5,6) ) );;
gap> vecA := BasisVectors( Basis( A5c6 ) );; 
gap> v := vecA[1] + vecA[3] + vecA[5];
(Z(5)^0)*()+(Z(5)^0)*(1,3,5)(2,4,6)+(Z(5)^0)*(1,5,3)(2,6,4)
gap> I5c6 := Ideal( A5c6, [v] );; 
gap> actm := AlgebraActionByMultipliers( A5c6, I5c6, A5c6 );; 
gap> actm2 := Image( actm, vecA[2] );; 
gap> Image( actm2, v );
(Z(5)^0)*(1,2,3,4,5,6)+(Z(5)^0)*(1,4)(2,5)(3,6)+(Z(5)^0)*(1,6,5,4,3,2)

## Section 2.2.2
gap> theta := NaturalHomomorphismByIdeal( A5c6, I5c6 );
<linear mapping by matrix, <algebra-with-one of dimension 
6 over GF(5)> -> <algebra of dimension 4 over GF(5)>>
gap> List( vecA, v -> ImageElm( theta, v ) ); 
[ v.1, v.2, v.3, v.4, (Z(5)^2)*v.1+(Z(5)^2)*v.3, (Z(5)^2)*v.2+(Z(5)^2)*v.4 ]
gap> actp := AlgebraActionBySurjection( theta );
kernel of hom is not in the annihilator of A
fail
gap> ## an example which does not fail: 
gap> m := [ [0,1,2,3], [0,0,1,2], [0,0,0,1], [0,0,0,0] ];; 
gap> m^2;
[ [ 0, 0, 1, 4 ], [ 0, 0, 0, 1 ], [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ] ]
gap> m^3;
[ [ 0, 0, 0, 1 ], [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ] ]
gap> A1 := Algebra( Rationals, [m] );;
gap> A3 := Subalgebra( A1, [m^3] );; 
gap> nat3 := NaturalHomomorphismByIdeal( A1, A3 ); 
<linear mapping by matrix, <algebra of dimension 
3 over Rationals> -> <algebra of dimension 2 over Rationals>>
gap> act3 := AlgebraActionBySurjection( nat3 );; 
gap> a3 := Image( act3, BasisVectors( Basis( Image( nat3 ) ) )[1] );;  
gap> [ Image( a3, m ) = m^2, Image( a3, m^2 ) = m^3 ];
[ true, true ]

## Section 2.2.3
gap> P := SemidirectProductOfAlgebras( A5c6, actm, I5c6 ); 
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

## Section 2.3.1
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


############################################################################
##
#E  algebra.tst  . . . . . . . . . . . . . . . . . . . . . . . . . ends here
