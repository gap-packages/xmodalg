#############################################################################
##
#W  algebra.g.           XModAlg example files          Z. Arvasi - A. Odabas 
## 

LoadPackage( "xmodalg" );

## Section 2.1.1
A1 := GroupRing( GF(5), Group( (1,2,3,4,5,6) ) );;
SetName( A1, "A1" );
BA1 := BasisVectors( Basis( A1 ) );; 
v := BA1[1] + BA1[3] + BA1[5];
Print( "v = BA1[1] + BA1[3] + BA1[5]: ", v, "\n" );
I1 := Ideal( A1, [v] );;
SetName( I1, "I1" );
v1 := BA1[2];
Print( "v1 = BA1[2]: ", v1, "\n" );
m1 := RegularAlgebraMultiplier( A1, I1, v1 ); 
Print( "m1 = RegularAlgebraMultiplier( A1, I1, v1 ): ", m1, "\n" ); 

## Section 2.1.2
Print( "IsAlgebraMultiplier( m1 )? ", IsAlgebraMultiplier( m1 ), "\n" ); 
id1 := One( A1 );; 
L1 := List( BA1, v -> id1 );; 
Print( "L1 = List( BA1, v -> id1 ):	 ", L1, "\n" ); 
h1 := LeftModuleHomomorphismByImages( A1, A1, BA1, L1 ); 
Print( "h1 = LeftModuleHomomorphismByImages( A1, A1, BA1, L1 ): ",h1,"\n" );
Print( "IsAlgebraMultiplier( h1 )? ", IsAlgebraMultiplier( h1 ), "\n" );

## Section 2.1.3
u1 := BA1[3];
Print( "\nu1 = BA1[3]: ", u1, "\n" );
S1 := Subalgebra( A1, [ u1 ] );; 
Print( "S1 = Subalgebra( A1, [ u1 ] ): ", S1, "\n" );; 
SetName( S1, "S1" );
MS1 := MultiplierAlgebraOfIdealBySubalgebra( A1, I1, S1 );
Print( "MS1 = MultiplierAlgebraOfIdealBySubalgebra( A1, I1, S1 ): ", 
       MS1, "\n" );
SetName( MS1, "MS1" );
BMS1 := BasisVectors( Basis( MS1 ) );; 
Print( "BMS1 = BasisVectors( Basis( MS1 ) )\n" );
Print( "BMS1[1[] = ", BMS1[1], "\n" ); 

## Section 2.1.4 
MA1 := MultiplierAlgebra( A1 );
Print( "\nMA1 = MultiplierAlgebra( A1 ): ", MA1, "\n" );
BMA1 := BasisVectors( Basis( MA1 ) );; 
Print( "BMA1 = BasisVectors( Basis( MA1 ) )\n" );
Print( "BMA1[3] = ", BMA1[3], "\n" );

## Section 2.1.5
hom1 := MultiplierHomomorphism( MA1 );;
Print( "\nhom1 = MultiplierHomomorphism( MA1 ): ", hom1, "\n" );
Print( "ImageElm( hom1, BA1[2] ) = ", ImageElm( hom1, BA1[2] ), "\n" ); 

## Section 2.2.2
A1 := GroupRing( GF(5), Group( (1,2,3,4,5,6) ) );;
BA1 := BasisVectors( Basis( A1 ) );; 
v := BA1[1] + BA1[3] + BA1[5];
I1 := Ideal( A1, [v] );; 
act1 := AlgebraActionByMultipliers( A1, I1, A1 );; 
act12 := Image( act1, BA1[2] );; 
Print( "\nact12 = Image( act1, BA1[2] ):\n" ); 
Print( "Image( act12, v ) = ", Image( act12, v ), "\n" );;

## Section 2.2.3
theta1 := NaturalHomomorphismByIdeal( A1, I1 );
Print( "\ntheta1 = NaturalHomomorphismByIdeal( A1, I1 ): ", theta1, "\n" );
Print( List( BA1, v -> ImageElm( theta1, v ) ), "\n" );; 
Print( "act1 = AlgebraActionBySurjection( theta1 ):\n" );
act0 := AlgebraActionBySurjection( theta1 );
Print( act0, "\n" );
## an example which does not fail: 
m2 := [ [0,1,2,3], [0,0,1,2], [0,0,0,1], [0,0,0,0] ];; 
Print( "m2 = ", m2, "\n" );
Print( "m2^2 = ", m2^2, "\n" );
Print( "m2^3 = ", m2^3, "\n" );
A2 := Algebra( Rationals, [m2] );;
SetName( A2, "A2" );
S2 := Subalgebra( A2, [m2^3] );; 
SetName( S2, "S2" );
nat2 := NaturalHomomorphismByIdeal( A2, S2 ); 
Print( "nat2 = NaturalHomomorphismByIdeal( A2, S2 ): ", nat2, "\n" );
Q2 := Image( nat2 );;
SetName( Q2, "Q2" );
Display( nat2 );
act2 := AlgebraActionBySurjection( nat2 );; 
I2 := Image( act2 );;
BI2 := BasisVectors( Basis( I2 ) );;
Print( "BI2 = BasisVectors( Basis( I2 ) ): ", BI2, "\n" );
b1 := BI2[1];;
Print( "b1 = ", b1, "\n" );
b2 := BI2[2];;
Print( "b2 = ", b2, "\n" );
Print( "Image(b1,m2)=m2^2? ", Image(b1,m2)=m2^2, "\n" );
Print( "Image(b1,m2^2)=m2^3? ", Image(b1,m2^2)=m2^3, "\n" ); Print( "Image(b1,m2^3)=Zero(A2)? ", Image(b1,m2^3)=Zero(A2), "\n" );
Print( "Image(b2,m2)=m2^3? ", Image(b2,m2)=m2^3, "\n" );
Print( "b2=b1^2? ", b2=b1^2, "\n" );

## Section 2.5.1
P1 := SemidirectProductOfAlgebras( A1, act1, I1 ); 
Print( "\nP1 = SemidirectProductOfAlgebras( A1, act1, I1 ): ", P1, "\n" ); 
Print( "Embedding( P1, 1 ) = ", Embedding( P1, 1 ), "\n" );
Print( "Embedding( P1, 2 ) = ", Embedding( P1, 2 ), "\n" );
Print( "Projection( P1, 1 ) = ", Projection( P1, 1 ), "\n" );
P2 := SemidirectProductOfAlgebras( Q2, act2, A2 );
Print( "P2 = SemidirectProductOfAlgebras( Q2, act2, A2 ): ", P2, "\n" );
Print( "Embedding( P2, 1 ) = ", Embedding( P2, 1 ), "\n" );
Print( "Embedding( P2, 2 ) = ", Embedding( P2, 2 ), "\n" );

## Section 2.6.1
A2c6 := GroupRing( GF(2), Group( (1,2,3,4,5,6) ) );;
Print( "\nA2c6 = GroupRing( GF(2), Group( (1,2,3,4,5,6) ) )\n" );
R2c3 := GroupRing( GF(2), Group( (7,8,9) ) );;
Print( "R2c3 = GroupRing( GF(2), Group( (7,8,9) ) ):\n" );
homAR := AllAlgebraHomomorphisms( A2c6, R2c3 );;
Print( "homAR = AllAlgebraHomomorphisms( A2c6, R2c3 )\n" );
Print( "List( homAR, h -> MappingGeneratorsImages(h) ):\n" );
Print( List( homAR, h -> MappingGeneratorsImages(h) ), "\n" );
homRA := AllAlgebraHomomorphisms( R2c3, A2c6 );;
Print( "homRA := AllAlgebraHomomorphisms( R2c3, A2c6 )\n" );
Print( "List( homRA, h -> MappingGeneratorsImages(h) ):\n" );
Print( List( homRA, h -> MappingGeneratorsImages(h) ), "\n" );;
bijAA := AllBijectiveAlgebraHomomorphisms( A2c6, A2c6 );;
Print( "bijAA = AllBijectiveAlgebraHomomorphisms( A2c6, A2c6 ): ", 
        bijAA, "\n" );;
Print( "List( bijAA, h -> MappingGeneratorsImages(h) ):\n" );;
Print( List( bijAA, h -> MappingGeneratorsImages(h) ), "\n" );
ideAA := AllIdempotentAlgebraHomomorphisms( A2c6, A2c6 );; 
Print( "ideAA = AllIdempotentAlgebraHomomorphisms( A2c6, A2c6 )\n" ); 
Print( "ideAA has length ", Length( ideAA ), "\n" );


############################################################################
##
#E  algebra.g  . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
