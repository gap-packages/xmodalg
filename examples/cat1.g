#############################################################################
##
#W  cat1.g                 XMODALG example files               Zekeriya Arvasi
#W                                                                & Alper Odabas
##  version 1.12, 10/11/2015 
##
#Y  Copyright (C) 2014-2015, Zekeriya Arvasi & Alper Odabas,  
##

Print("\nXModAlg test file cat1.g (version 10/11/15) :-");
Print("\ntesting constructions of cat1-algebras\n\n");

A := GroupRing(GF(2),Group((1,2,3)(4,5)));
R := GroupRing(GF(2),Group((1,2,3)));
f := AllHomsOfAlgebras(A,R);
g := AllHomsOfAlgebras(R,A);
C4 := PreCat1ByTailHeadEmbedding(f[6],f[6],g[8]);
IsCat1Algebra(C4);
Size(C4);
Display(C4);

C2 := Cat1AlgebraSelect( 4, 6, 2, 2 );
Size( C2 ); 
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
RS := Cartesian( R, S );; 
SetName( RS, "GF(2^2)[k4] x <e5>" ); 
act := AlgebraAction( R, RS, S );;
bdy := AlgebraHomomorphismByFunction( S, R, r->r );
IsAlgebraAction( act ); 
IsAlgebraHomomorphism( bdy );
XM := PreXModAlgebraByBoundaryAndAction( bdy, act );
CXM := Cat1AlgebraByXModAlgebra( XM );
Display(CXM);
X3 := XModAlgebraByCat1Algebra( C3 ); 
Display( X3 ); 

#############################################################################
##
#E  cat1.g . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
