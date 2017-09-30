#############################################################################
##
#W  xmod.g                 XMODALG example files               Zekeriya Arvasi
#W                                                                & Alper Odabas
##  version 1.12, 14/11/2015 
##
#Y  Copyright (C) 2014-2015, Zekeriya Arvasi & Alper Odabas,  
##

Print("\nXModAlg test file xmod.g (version 10/11/15) :-");
Print("\ntesting constructions of crossed modules of algebras\n\n");

A := GroupRing(GF(5),DihedralGroup(4));
Size(A);
SetName(A,"GF5[D4]");
I := AugmentationIdeal(A);
Size(I);
SetName(I,"Aug");
CM := XModAlgebraByIdeal(A,I);
Display(CM);
Size(CM);
f := Boundary(CM);
Print( RepresentationsOfObject(CM), "\n" ); 
props := [ "CanEasilyCompareElements", "CanEasilySortElements", 
"IsDuplicateFree", "IsLeftActedOnByDivisionRing", "IsAdditivelyCommutative", 
"IsPreXModAlgebra", "IsXModAlgebra" ];;
known := KnownPropertiesOfObject(CM);;
ForAll( props, p -> (p in known) );
Print( KnownAttributesOfObject(CM), "\n" ); 

e4 := Elements(I)[4];
J := Ideal( I, [e4] );
Size(J);
SetName( J, "<e4>" ); 
PM := XModAlgebraByIdeal( A, J );
Display( PM );        
IsSubXModAlgebra( CM, PM );

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
IsXModAlgebra( XM );
Display( XM );

A:=GroupRing(GF(2),CyclicGroup(4));
B:=AugmentationIdeal(A);
X1:=XModAlgebra(A,B);
C:=GroupRing(GF(2),SmallGroup(4,2));
D:=AugmentationIdeal(C);
X2:=XModAlgebra(C,D);
B = D;
all_f := AllHomsOfAlgebras(A,C);;
all_g := AllHomsOfAlgebras(B,D);;
mor := XModAlgebraMorphism(X1,X2,all_g[1],all_f[2]);
Display(mor);
X3 := Kernel(mor);
IsTotal(mor);
IsSingleValued(mor);
IsXModAlgebra(X3);
Size(X3);
IsSubXModAlgebra(X1,X3);


#############################################################################
##
#E  alg2obj.g . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
