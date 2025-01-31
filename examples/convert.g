#############################################################################
##
#W  convert.g            XModAlg example files          Z. Arvasi - A. Odabas 
## 

LoadPackage( "xmodalg" );

START_TEST( "XModAlg package: convert.tst" );
saved_infolevel_xmodalg := InfoLevel( InfoXModAlg );; 
SetInfoLevel( InfoXModAlg, 0 );

## make convert.g independent of module.g, cat1.g and xmod.g
m3 := [ [0,1,0], [0,0,1], [1,0,0] ];;
A3 := Algebra( Rationals, [m3] );;
SetName( A3, "A3" );;
c3 := Group( (1,2,3) );;
Rc3 := GroupRing( Rationals, c3 );;
SetName( Rc3, "GR(c3)" );
g3 := GeneratorsOfAlgebra( Rc3 )[2];;
mg3 := RegularAlgebraMultiplier( Rc3, Rc3, g3 );;
Amg3 := AlgebraByGenerators( Rationals, [ mg3 ] );;
homg3 := AlgebraHomomorphismByImages( A3, Amg3, [ m3 ], [ mg3 ] );;
actg3 := AlgebraActionByHomomorphism( homg3, Rc3 );;

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

############################ 
## Chapter 5,  Section 5.1.1
Cn := Cat1AlgebraOfXModAlgebra( Xn );
Print( "Cn = Cat1AlgebraOfXModAlgebra( Xn ): ", Cn, "\n" );
Display( Cn );

bdy3 := AlgebraHomomorphismByImages( Rc3, A3, [ g3 ], [ m3 ] );;
X3 := XModAlgebraByBoundaryAndAction( bdy3, actg3 );;
C3 := Cat1AlgebraOfXModAlgebra( X3 );
Print( "\nC3 = Cat1AlgebraOfXModAlgebra( X3 ): ", C3, "\n" );
Display( C3 );                 

C6 := Cat1AlgebraSelect( 2, 6, 2, 4 );;
X6 := XModAlgebraOfCat1Algebra( C6 );
Print( "\nX6 = XModAlgebraOfCat1Algebra( C6 ):\n", X6, "\n" );
Display( X6 ); 

SetInfoLevel( InfoXModAlg, saved_infolevel_xmodalg );; 
STOP_TEST( "convert.tst", 10000 );

############################################################################
##
#E  convert.g  . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
