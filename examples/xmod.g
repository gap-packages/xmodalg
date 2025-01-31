#############################################################################
##
#W  xmod.g              XModAlg example files          Z. Arvasi - A. Odabas      
##

LoadPackage( "xmodalg" );

## make this test independent of algebra.tst
m2 := [ [0,1,2,3], [0,0,1,2], [0,0,0,1], [0,0,0,0] ];; 
A2 := Algebra( Rationals, [m2] );;
SetName( A2, "A2" );
S2 := Subalgebra( A2, [m2^3] );; 
nat2 := NaturalHomomorphismByIdeal( A2, S2 );; 
Q2 := Image( nat2 );;
SetName( Q2, "Q2" );

## from 2.2.4
m3 := [ [0,1,0], [0,0,1], [1,0,0] ];;
A3 := Algebra( Rationals, [m3] );;
SetName( A3, "A3" );
c3 := Group( (1,2,3) );;
Rc3 := GroupRing( Rationals, c3 );;
SetName( Rc3, "GR(c3)" );
g3 := GeneratorsOfAlgebra( Rc3 )[2];;
mg3 := RegularAlgebraMultiplier( Rc3, Rc3, g3 );;
Amg3 := AlgebraByGenerators( Rationals, [ mg3 ] );;
homg3 := AlgebraHomomorphismByImages( A3, Amg3, [ m3 ], [ mg3 ] );;
actg3 := AlgebraActionByHomomorphism( homg3, Rc3 );;

V3 := Rationals^3;;
M3 := LeftAlgebraModule( A3, \*, V3 );;
SetName( M3, "M3" );
act3 := AlgebraActionByModule( A3, M3 );;

## Chapter 4, Section 4.1.2 
F5 := GF(5);;
id5 := One( F5 );;
two := Z(5);; 
z5 := Zero( F5 );; 
n0 := [ [id5,z5,z5], [z5,id5,z5], [z5,z5,id5] ];; 
n1 := [ [z5,id5,two^3], [z5,z5,id5], [z5,z5,z5] ];;
n2 := [ [z5,z5,id5], [z5,z5,z5], [z5,z5,z5] ];; 
An := Algebra( F5, [ n0, n1 ] );; 
SetName( An, "An" ); 
Bn := Subalgebra( An, [ n1 ] );; 
SetName( Bn, "Bn" ); 
Print( "IsIdeal( An, Bn )? ", IsIdeal( An, Bn ), "\n" ); 
actn := AlgebraActionByMultipliers( An, Bn, An );; 
Xn := XModAlgebraByIdeal( An, Bn ); 
Display( Xn );
SetName( Xn, "Xn" ); 


## Section 4.1.3 
Ak4 := GroupRing( GF(5), DihedralGroup(4) );
Print( "Ak4 has size ", Size( Ak4 ), "\n" );
SetName( Ak4, "GF5[k4]" );
IAk4 := AugmentationIdeal( Ak4 );
Print( "augmentation ideal IAk4 has size ", Size( IAk4 ), "\n" );
SetName( IAk4, "I(GF5[k4])" );
XIAk4 := XModAlgebraByIdeal( Ak4, IAk4 );
Print( "XIAk4 = ", XIAk4, "  has size ", Size2d( XIAk4 ),"\n" );
Display( XIAk4 );

############################
## Section 4.1.4
reps := RepresentationsOfObject( XIAk4 );
Print( "reps = RepresentationsOfObject( XIAk4 )\n" );
Print( "Set( reps ) = ", Set( reps ), "\n" );
kpo := KnownPropertiesOfObject( XIAk4 );;
Print( "kpo = KnownPropertiesOfObject( XIAk4 )\n" );
Print( "Set( kpo ) = ", Set( kpo ), "\n" );; 
kao := KnownAttributesOfObject( XIAk4 );;
Print( "kao = KnownAttributesOfObject( XIAk4 )\n" );
Print( "Set( kao ) = ", Set( kao ), "\n" );; 

############################
## Section 4.1.5
XAn := XModAlgebraByMultiplierAlgebra( An );
Print( "XAn = ", XAn, "  has action ", XModAlgebraAction( XAn ), "\n" );

############################
## Section 4.1.6
Print( "nat2 = ", nat2, "\n" );
Print( "X2 := XModAlgebraBySurjection( nat2 );\n" );
X2 := XModAlgebraBySurjection( nat2 );; 
Display( X2 ); 

############################
## Section 4.1.7
bdy3 := AlgebraHomomorphismByImages( Rc3, A3, [ g3 ], [ m3 ] );
Print( "bdy3 = AlgebraHomomorphismByImages( Rc3, A3, [ g3 ], [ m3 ] ): " );
Print( bdy3, "\n" );
X3 := XModAlgebraByBoundaryAndAction( bdy3, actg3 );
Print( "X3 = XModAlgebraByBoundaryAndAction( bdy3, actg3 ): ", X3, "\n" );
Display( X3 );

############################
## Section 4.1.8
Y3 := XModAlgebraByModule( A3, M3 );
Print( "\nY3 = XModAlgebraByModule( A3, M3 ): ", Y3, "\n" );
Print( "XModAlgebraAction( Y3 ) = act3? ", 
       Image( XModAlgebraAction( Y3 ), m3 ) = Image( act3, m3 ), "\n" );
Display( Y3 );

############################
## Section 4.1.10
e4 := Elements( IAk4 )[4];
Print( "\nelement e4 = ", e4, "\n" );
Je4 := Ideal( IAk4, [e4] );;
Print( "Je4 = Ideal( IAk4, [e4] ) has size ", Size( Je4 ), "\n" );
SetName( Je4, "<e4>" ); 
Ke4 := Subalgebra( Ak4, [e4] );;
Print( "Ke4 = Subalgebra( Ak4, [e4] ) has size ", Size( Ke4 ), "\n" );
Se4 := SubXModAlgebra( XIAk4, Je4, Ke4 );    
Print( "Se4 = SubXModAlgebra( XIAk4, Je4, Ke4 ): ", Se4, "\n" );    
Display( Se4 );
Print( "IsSubXModAlgebra( XIAk4, Se4 )? ", 
       IsSubXModAlgebra( XIAk4, Se4 ), "\n" );

############################
## Chapter 4,  Section 4.2.1 
c4 := CyclicGroup( 4 );;
Ac4 := GroupRing( GF(2), c4 );
SetName( Ac4, "GF2[c4]" );
IAc4 := AugmentationIdeal( Ac4 );
SetName( IAc4, "I(GF2[c4])" );
XIAc4 := XModAlgebra( Ac4, IAc4 );
Print( "XIAc4 := XModAlgebra( Ac4, IAc4 ): ", XIAc4, "\n" );
Display( XIAc4 );
Bk4 := GroupRing( GF(2), SmallGroup( 4, 2 ) );
SetName( Bk4, "GF2[k4]" );
IBk4 := AugmentationIdeal( Bk4 );
SetName( IBk4, "I(GF2[k4])" );
XIBk4 := XModAlgebra( Bk4, IBk4 );
Print( "XIBk4 := XModAlgebra( Bk4, IBk4 ): ", XIBk4, "\n" );
Display( XIBk4 );
Print( "IAc4 = IBk4? ", IAc4 = IBk4, "\n" );
homIAIB := AllAlgebraHomomorphisms( IAc4, IBk4 );; 
theta := homIAIB[3];; 
homAB := AllAlgebraHomomorphisms( Ac4, Bk4 );;
phi := homAB[7];; 
mor := XModAlgebraMorphism( XIAc4, XIBk4, theta, phi );
Print( "mor = XModAlgebraMorphism( XIAc4, XIBk4, theta, phi ):\n" );
Display( mor );
Print( "IsTotal( mor )? ", IsTotal( mor ), "\n" );
Print( "IsSingleValued( mor )? ", IsSingleValued( mor ), "\n" );

############################
## Section 4.2.2
Xmor := Kernel( mor );
Print( "Xmor = Kernel( mor ): ", Xmor, "\n" );
Print( "IsXModAlgebra( Xmor )? ", IsXModAlgebra( Xmor ), "\n" );
Print( "Xmor has size ", Size2d( Xmor ), "\n" );
Print( "IsSubXModAlgebra( XIAc4, Xmor )? ", 
       IsSubXModAlgebra( XIAc4, Xmor ), "\n" );

############################
## Section 4.2.4
ic4 := One( Ac4 );; 
e1 := ic4*c4.1 + ic4*c4.2;
Print( "ImageElm( theta, e1 ) = ", ImageElm( theta, e1 ), "\n" );  
e2 := ic4*c4.1;
Print( "ImageElm( phi, e2 ) = ", ImageElm( phi, e2 ), "\n" );
Print( "IsInjective( mor )? ", IsInjective( mor ), "\n" );
Print( "IsSurjective( mor )? ", IsSurjective( mor ), "\n" );
immor := ImagesSource2DimensionalMapping( mor );;
Print( "immor = ImagesSource2DimensionalMapping( mor ):\n" );
Display( immor );

############################################################################
##
#E  xmod.tst . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
