############################################################################
##
#W  cat1-more.g          XMODALG example files               Zekeriya Arvasi
#W                                                            & Alper Odabas
#Y  Copyright (C) 2014-2024, Zekeriya Arvasi & Alper Odabas,  
##

Print("\nXModAlg test file cat1-more.g :-");
Print("\ntesting constructions of cat1-algebras\n\n");

LoadPackage( "xmodalg" ); 

A := GroupRing( GF(2), Group((1,2,3)(4,5)) );
SetName( A, "GF(2)[c6]" );
R := GroupRing( GF(2), Group( (1,2,3) ) );
SetName( R, "GF(2)[c3]" );
f := AllAlgebraHomomorphisms( A, R );
g := AllAlgebraHomomorphisms( R, A );
C4 := PreCat1AlgebraObj( f[6], f[6], g[8] );
IsCat1Algebra( C4 );
Size2d( C4 );
Dimension( C4 );
Display( C4 );

C2 := Cat1AlgebraSelect( 4, 6, 2, 2 );
Size2d( C2 );
Dimension(C2); 
Display( C2 ); 
C := Cat1AlgebraSelect(11);
C := Cat1AlgebraSelect(4,12);
C := Cat1AlgebraSelect(2,6,3);
C := Cat1AlgebraSelect(2,6,2);

C3 := Cat1AlgebraSelect( 2, 6, 2, 4 );; 
A3 := Source( C3 );
B3 := Range( C3 ); 
eA3 := Elements( A3 );;
eB3 := Elements( B3 );;
AA3 := Subalgebra( A3, [ eA3[1], eA3[2], eA3[3] ] );
[ Size(A3), Size(AA3) ]; 
BB3 := Subalgebra( B3, [ eB3[1], eB3[2] ] ); 
[ Size(B3), Size(BB3) ]; 
CC3 := SubCat1Algebra( C3, AA3, BB3 );
Display( CC3 );

C4 := Cat1AlgebraSelect( 2, 1, 1, 1 );

G := SmallGroup(4,2);
F := GaloisField(4);
R := GroupRing( F, G );
Size(R);
SetName( R, "GF(2^2)[k4]" ); 
e5 := Elements(R)[5]; 
S := Subalgebra( R, [e5] ); 
SetName( S, "<e5>" );

## the following may be included once AlgebraAction2 has been fixed
## RS := Cartesian( R, S );; 
## SetName( RS, "GF(2^2)[k4] x <e5>" ); 
## act := AlgebraAction( R, RS, S );;
## bdy := AlgebraHomomorphismByImages( S, R, [e5], [e5] );
## IsAlgebraAction( act ); 
## IsAlgebraHomomorphism( bdy );
## XM := PreXModAlgebraByBoundaryAndAction( bdy, act );
## CXM := Cat1AlgebraByXModAlgebra( XM );
## Display(CXM);
## X3 := XModAlgebraByCat1Algebra( C3 ); 
## Display( X3 ); 

#############################################################################
##
#E  cat1-more.g . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
