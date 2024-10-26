#############################################################################
##
#W  cat1.g              XModAlg example files          Z. Arvasi - A. Odabas 
##   

LoadPackage( "xmodalg" );

## copy in variables from xmod.g
Ak4 := GroupRing( GF(5), DihedralGroup(4) );;
SetName( Ak4, "GF5[k4]" );
IAk4 := AugmentationIdeal( Ak4 );;
SetName( IAk4, "I(GF5[k4])" );
XIAk4 := XModAlgebraByIdeal( Ak4, IAk4 );;

m := [ [0,1,2,3], [0,0,1,2], [0,0,0,1], [0,0,0,0] ];; 
A1 := Algebra( Rationals, [m] );;
A3 := Subalgebra( A1, [m^3] );; 
nat13 := NaturalHomomorphismByIdeal( A1, A3 );; 
X13 := XModAlgebraBySurjection( nat13 );; 

G := SmallGroup( 4, 2 );;
F := GaloisField( 4 );;
R := GroupRing( F, G );;
SetName( R, "GF(2^2)[k4]" ); 
e5 := Elements(R)[5];; 
S := Subalgebra( R, [e5] );; 
SetName( S, "<e5>" );
act := AlgebraActionByMultipliers( R, S, R );;
bdy := AlgebraHomomorphismByImages( S, R, [e5], [e5] );;
IsAlgebraAction( act );; 
IsAlgebraHomomorphism( bdy );; 
XM := PreXModAlgebraByBoundaryAndAction( bdy, act );;
IsXModAlgebra( XM );;

A2c6 := GroupRing( GF(2), Group( (1,2,3,4,5,6) ) );;
R2c3 := GroupRing( GF(2), Group( (7,8,9) ) );;
homAR := AllAlgebraHomomorphisms( A2c6, R2c3 );;
homRA := AllAlgebraHomomorphisms( R2c3, A2c6 );; 

############################ 
## Chapter 3,  Section 3.1.2 
t4 := homAR[8]; 
Print( "t4 = ", t4, "\n" );
e4 := homRA[8];
Print( "e4 = ", e4, "\n" );
C4 := PreCat1AlgebraByTailHeadEmbedding( t4, t4, e4 );
Print( "C4 = PreCat1AlgebraByTailHeadEmbedding( t4, t4, e4 ): ", C4, "\n" );
Print( "IsCat1Algebra( C4 )? ", IsCat1Algebra( C4 ), "\n" );
Print( "C4 has size: ", Size2d( C4 ), 
       " and dimension: ", Dimension( C4 ), "\n" );
Display( C4 );

############################
## Chapter 3,  Section 3.1.3
Print( "\n" );
C := Cat1AlgebraSelect( 2, 6, 2 );

C0 := Cat1AlgebraSelect( 4, 6, 2, 2 );
Print( "\nC0 := Cat1AlgebraSelect( 4, 6, 2, 2 ): ", C0, "\n" );
Print( "C0 has size: ", Size2d( C0 ), "\n" ); 
Display( C0 ); 

############################ 
## Chapter 3,  Section 3.1.4
## 
C6 := Cat1AlgebraSelect( 2, 6, 2, 4 );; 
A6 := Source( C6 );
Print( "\nA6 = ", A6, "\n" );
B6 := Range( C6 ); 
Print( "B6 = ", B6, "\n" );
eA6 := Elements( A6 );;
eB6 := Elements( B6 );;
SA6 := Subalgebra( A6, [ eA6[1], eA6[2], eA6[3] ] );
Print( "SA6 = Subalgebra( A6, [ eA6[1], eA6[2], eA6[3] ] ): ", SA6, "\n" );
Print( "[ Size(A6), Size(SA6) ] = ", [ Size(A6), Size(SA6) ], "\n" ); 
SB6 := Subalgebra( B6, [ eB6[1], eB6[2] ] ); 
Print( "SB6 = Subalgebra( B6, [ eB6[1], eB6[2] ] ): ", SB6, "\n" ); 
Print( "[ Size(B6), Size(SB6) ] = ", [ Size(B6), Size(SB6) ], "\n" ); 
SC6 := SubCat1Algebra( C6, SA6, SB6 );
Print( "SC6 = SubCat1Algebra( C6, SA6, SB6 ): ", SC6, "\n" );
Display( SC6 );
Print( "IsSubCat1Algebra( C6, SC6 )? ", IsSubCat1Algebra( C6, SC6 ), "\n" );

############################ 
## Chapter 3,  Section 3.2.2
C1 := Cat1AlgebraSelect( 2, 1, 1, 1 );
Print( "\nC1 = Cat1AlgebraSelect( 2, 1, 1, 1 ): ", C1, "\n" );
Display( C1 );
C2 := Cat1AlgebraSelect( 2, 2, 1, 2 );
Print( "C2 = Cat1AlgebraSelect( 2, 2, 1, 2 ): ", C2, "\n" );
Display( C2 );                        
Print( "C1 = C2? ", C1 = C2, "\n" );
SC1 := Source( C1 );;
SC2 := Source( C2 );
RC1 := Range( C1 );;
RC2 := Range( C2 );;
gSC1 := GeneratorsOfAlgebra( SC1 );
Print( "GeneratorsOfAlgebra( SC1 ) = ", gSC1, "\n" );
gSC2 := GeneratorsOfAlgebra( SC2 );
Print( "GeneratorsOfAlgebra( SC2 ) = ", gSC2, "\n" );
gRC1 := GeneratorsOfAlgebra( RC1 );
Print( "GeneratorsOfAlgebra( RC1 ) = ", gRC1, "\n" );
gRC2 := GeneratorsOfAlgebra( RC2 );
Print( "GeneratorsOfAlgebra( RC2 ) = ", gRC2, "\n" );
imS := [ gSC2[1], gSC2[1] ];
Print( "imS = ", imS, "\n" );
homS := AlgebraHomomorphismByImages( SC1, SC2, gSC1, imS );
Print( "homS = ", homS, "\n" );
imR := [ gRC2[1], gRC2[1] ];
Print( "imR = ", imR, "\n" );
homR := AlgebraHomomorphismByImages( RC1, RC2, gRC1, imR );
Print( "homR = ", homR, "\n" );
m12 := Cat1AlgebraMorphism( C1, C2, homS, homR );
Print( "m12 = Cat1AlgebraMorphism( C1, C2, homS, homR ):\n" );
Display( m12 );

Print( "IsSurjective( m12 )? ", IsSurjective( m12 ), "\n" );
Print( "IsInjective( m12 )? ", IsInjective( m12 ), "\n" );
Print( "IsBijective( m12 )? ", IsBijective( m12 ), "\n" );

########################### 
## Chapter 3, Section 3.2.3 
im12 := ImagesSource2DimensionalMapping( m12 );;
Print( "\nim12 = ImagesSource2DimensionalMapping( m12 ):\n" );
Display( im12 ); 

############################################################################
##
#E  cat1.g . . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
