#############################################################################
##
#W  cat1.tst, 04/11/15          XModAlg test files      Z. Arvasi - A. Odabas      
#############################################################################


gap> saved_infolevel_xmodalg := InfoLevel( InfoXModAlg );; 
gap> SetInfoLevel( InfoXModAlg, 0 );

## Chapter 3,  Section 3.1.2
gap> A := GroupRing(GF(2),Group((1,2,3)(4,5)));
<algebra-with-one over GF(2), with 1 generators>
gap> R := GroupRing(GF(2),Group((1,2,3)));
<algebra-with-one over GF(2), with 1 generators>
gap> f := AllHomsOfAlgebras(A,R);
[ [ (Z(2)^0)*(1,3,2)(4,5) ] -> [ <zero> of ... ], [ (Z(2)^0)*(1,3,2)(4,5) ] -> [ (Z(2)^0)*() ],
  [ (Z(2)^0)*(1,3,2)(4,5) ] -> [ (Z(2)^0)*()+(Z(2)^0)*(1,2,3) ],
  [ (Z(2)^0)*(1,3,2)(4,5) ] -> [ (Z(2)^0)*()+(Z(2)^0)*(1,2,3)+(Z(2)^0)*(1,3,2) ],
  [ (Z(2)^0)*(1,3,2)(4,5) ] -> [ (Z(2)^0)*()+(Z(2)^0)*(1,3,2) ], [ (Z(2)^0)*(1,3,2)(4,5) ] -> [ (Z(2)^0)*(1,2,3) ],
  [ (Z(2)^0)*(1,3,2)(4,5) ] -> [ (Z(2)^0)*(1,2,3)+(Z(2)^0)*(1,3,2) ], [ (Z(2)^0)*(1,3,2)(4,5) ] -> [ (Z(2)^0)*(1,3,2)
     ] ]
gap> g := AllHomsOfAlgebras(R,A);
[ [ (Z(2)^0)*(1,2,3) ] -> [ <zero> of ... ], [ (Z(2)^0)*(1,2,3) ] -> [ (Z(2)^0)*() ],
  [ (Z(2)^0)*(1,2,3) ] -> [ (Z(2)^0)*()+(Z(2)^0)*(1,2,3) ],
  [ (Z(2)^0)*(1,2,3) ] -> [ (Z(2)^0)*()+(Z(2)^0)*(1,2,3)+(Z(2)^0)*(1,3,2) ],
  [ (Z(2)^0)*(1,2,3) ] -> [ (Z(2)^0)*()+(Z(2)^0)*(1,3,2) ], [ (Z(2)^0)*(1,2,3) ] -> [ (Z(2)^0)*(1,2,3) ],
  [ (Z(2)^0)*(1,2,3) ] -> [ (Z(2)^0)*(1,2,3)+(Z(2)^0)*(1,3,2) ], [ (Z(2)^0)*(1,2,3) ] -> [ (Z(2)^0)*(1,3,2) ] ]
gap> C4 := PreCat1ByTailHeadEmbedding(f[6],f[6],g[8]);
[AlgebraWithOne( GF(2), [ (Z(2)^0)*(1,2,3)(4,5) ] ) -> AlgebraWithOne( GF(2), [ (Z(2)^0)*(1,2,3) ] )]
gap> IsCat1Algebra(C4);
true
gap> Size(C4);
[ 64, 8 ]
gap> Display(C4);

Cat1-algebra [..=>..] :-
: source algebra has generators:
  [ (Z(2)^0)*(), (Z(2)^0)*(1,2,3)(4,5) ]
:  range algebra has generators:
  [ (Z(2)^0)*(), (Z(2)^0)*(1,2,3) ]
: tail homomorphism maps source generators to:
  [ (Z(2)^0)*(), (Z(2)^0)*(1,3,2) ]
: head homomorphism maps source generators to:
  [ (Z(2)^0)*(), (Z(2)^0)*(1,3,2) ]
: range embedding maps range generators to:
  [ (Z(2)^0)*(), (Z(2)^0)*(1,3,2) ]
: kernel has generators:
  [ (Z(2)^0)*()+(Z(2)^0)*(4,5), (Z(2)^0)*(1,2,3)+(Z(2)^0)*(1,2,3)(4,5), (Z(2)^0)*(1,3,2)+(Z(2)^0)*(1,3,2)(4,5) ]
: boundary homomorphism maps generators of kernel to:
  [ <zero> of ..., <zero> of ..., <zero> of ... ]
: kernel embedding maps generators of kernel to:
  [ (Z(2)^0)*()+(Z(2)^0)*(4,5), (Z(2)^0)*(1,2,3)+(Z(2)^0)*(1,2,3)(4,5), (Z(2)^0)*(1,3,2)+(Z(2)^0)*(1,3,2)(4,5) ]

## Chapter 3,  Section 3.1.3

gap> C2 := Cat1AlgebraSelect( 4, 6, 2, 2 );
[GF(2^2)_c6 -> Algebra( GF(2^2),
[ (Z(2)^0)*(), (Z(2)^0)*()+(Z(2)^0)*(1,3,5)(2,4,6)+(Z(2)^0)*(1,4)(2,5)(3,6)+(
    Z(2)^0)*(1,5,3)(2,6,4)+(Z(2)^0)*(1,6,5,4,3,2) ] )]
gap> Size( C2 ); 
[ 4096, 1024 ]
gap> Display( C2 ); 

Cat1-algebra [GF(2^2)_c6=>..] :-
: source algebra has generators:
  [ (Z(2)^0)*(), (Z(2)^0)*(1,2,3,4,5,6) ]
:  range algebra has generators:
  [ (Z(2)^0)*(), (Z(2)^0)*()+(Z(2)^0)*(1,3,5)(2,4,6)+(Z(2)^0)*(1,4)(2,5)
    (3,6)+(Z(2)^0)*(1,5,3)(2,6,4)+(Z(2)^0)*(1,6,5,4,3,2) ]
: tail homomorphism maps source generators to:
  [ (Z(2)^0)*(), (Z(2)^0)*()+(Z(2)^0)*(1,3,5)(2,4,6)+(Z(2)^0)*(1,4)(2,5)
    (3,6)+(Z(2)^0)*(1,5,3)(2,6,4)+(Z(2)^0)*(1,6,5,4,3,2) ]
: head homomorphism maps source generators to:
  [ (Z(2)^0)*(), (Z(2)^0)*()+(Z(2)^0)*(1,3,5)(2,4,6)+(Z(2)^0)*(1,4)(2,5)
    (3,6)+(Z(2)^0)*(1,5,3)(2,6,4)+(Z(2)^0)*(1,6,5,4,3,2) ]
: range embedding maps range generators to:
  [ (Z(2)^0)*(), (Z(2)^0)*()+(Z(2)^0)*(1,3,5)(2,4,6)+(Z(2)^0)*(1,4)(2,5)
    (3,6)+(Z(2)^0)*(1,5,3)(2,6,4)+(Z(2)^0)*(1,6,5,4,3,2) ]
: kernel has generators:
  [ (Z(2)^0)*()+(Z(2)^0)*(1,2,3,4,5,6)+(Z(2)^0)*(1,3,5)(2,4,6)+(Z(2)^0)*(1,4)
    (2,5)(3,6)+(Z(2)^0)*(1,5,3)(2,6,4)+(Z(2)^0)*(1,6,5,4,3,2) ]
: boundary homomorphism maps generators of kernel to:
  [ <zero> of ... ]
: kernel embedding maps generators of kernel to:
  [ (Z(2)^0)*()+(Z(2)^0)*(1,2,3,4,5,6)+(Z(2)^0)*(1,3,5)(2,4,6)+(Z(2)^0)*(1,4)
    (2,5)(3,6)+(Z(2)^0)*(1,5,3)(2,6,4)+(Z(2)^0)*(1,6,5,4,3,2) ]
	
gap> C := Cat1AlgebraSelect(11);
|--------------------------------------------------------|
| 11 is invalid number for Galois Field (gf)             |
| Possible numbers for the gf in the Data :              |
|--------------------------------------------------------|
 [ 2, 3, 4, 5, 7 ]
Usage: Cat1Algebra( gf, gpsize, gpnum, num );
fail

gap> C := Cat1AlgebraSelect(4,12);
|--------------------------------------------------------|
| 12 is invalid number for size of group (gpsize)        |
| Possible numbers for the gpsize for GF(4) in the Data: |
|--------------------------------------------------------|
 [ 1, 2, 3, 4, 5, 6, 7, 8, 9 ]
Usage: Cat1Algebra( gf, gpsize, gpnum, num );
fail

gap> C := Cat1AlgebraSelect(2,6,3);
|--------------------------------------------------------|
| 3 is invalid number for group of order 6               |
| Possible numbers for the gpnum in the Data :           |
|--------------------------------------------------------|
 [ 1, 2 ]
Usage: Cat1Algebra( gf, gpsize, gpnum, num );
fail

gap> C := Cat1AlgebraSelect(2,6,2);
There are 4 cat1-structures for the algebra GF(2)_c6.
 Range Alg      Tail                    Head
|--------------------------------------------------------|
| GF(2)_c6      identity map            identity map     |
| -----         [ 2, 10 ]               [ 2, 10 ]        |
| -----         [ 2, 14 ]               [ 2, 14 ]        |
| -----         [ 2, 50 ]               [ 2, 50 ]        |
|--------------------------------------------------------|
Usage: Cat1Algebra( gf, gpsize, gpnum, num );
Algebra has generators [ (Z(2)^0)*(), (Z(2)^0)*(1,2,3)(4,5) ]
4




## Chapter 3,  Section 3.1.4

gap> C3 := Cat1AlgebraSelect( 2, 6, 2, 4 );; 
gap> A3 := Source( C3 );
GF(2)_c6
gap> B3 := Range( C3 ); 
<algebra of dimension 3 over GF(2)>
gap> eA3 := Elements( A3 );;
gap> eB3 := Elements( B3 );;
gap> AA3 := Subalgebra( A3, [ eA3[1], eA3[2], eA3[3] ] );
<algebra over GF(2), with 3 generators>
gap> [ Size(A3), Size(AA3) ]; 
[ 64, 4 ]
gap> BB3 := Subalgebra( B3, [ eB3[1], eB3[2] ] ); 
<algebra over GF(2), with 2 generators>
gap> [ Size(B3), Size(BB3) ]; 
[ 8, 2 ]
gap> CC3 := SubCat1Algebra( C3, AA3, BB3 );
[Algebra( GF(2), [ <zero> of ..., (Z(2)^0)*(), (Z(2)^0)*()+(Z(2)^0)*(4,5) 
 ] ) -> Algebra( GF(2), [ <zero> of ..., (Z(2)^0)*() ] )]
gap> Display( CC3 );

Cat1-algebra [..=>..] :-
: source algebra has generators:
  [ <zero> of ..., (Z(2)^0)*(), (Z(2)^0)*()+(Z(2)^0)*(4,5) ]
:  range algebra has generators:
  [ <zero> of ..., (Z(2)^0)*() ]
: tail homomorphism maps source generators to:
  [ <zero> of ..., (Z(2)^0)*(), <zero> of ... ]
: head homomorphism maps source generators to:
  [ <zero> of ..., (Z(2)^0)*(), <zero> of ... ]
: range embedding maps range generators to:
  [ <zero> of ..., (Z(2)^0)*() ]
: kernel has generators:
  [ <zero> of ..., (Z(2)^0)*()+(Z(2)^0)*(4,5) ]
: boundary homomorphism maps generators of kernel to:
  [ <zero> of ..., <zero> of ... ]
: kernel embedding maps generators of kernel to:
  [ <zero> of ..., (Z(2)^0)*()+(Z(2)^0)*(4,5) ]

## Chapter 3,  Section 3.2.2

gap> C4 := Cat1AlgebraSelect( 2, 1, 1, 1 );
[GF(2)_triv -> GF(2)_triv]

## Chapter 3,  Section 3.3.1

gap> CXM := Cat1AlgebraByXModAlgebra( XM );
[GF(2^2)[k4] IX <e5> -> GF(2^2)[k4]]
gap> Display(CXM);

Cat1-algebra [..=>GF(2^2)[k4]] :-
:  range algebra has generators:
  [ (Z(2)^0)*<identity> of ..., (Z(2)^0)*f1, (Z(2)^0)*f2 ]
: tail homomorphism maps source generators to:
: range embedding maps range generators to:
  [ [ (Z(2)^0)*<identity> of ..., <zero> of ... ], [ (Z(2)^0)*f1, <zero> of ... ], [ (Z(2)^0)*f2, <zero> of ... ] ]
: kernel has generators:
  [ [ <zero> of ..., <zero> of ... ],
  [ <zero> of ..., (Z(2)^0)*<identity> of ...+(Z(2)^0)*f1+(Z(2)^0)*f2+(Z(2)^0)*f1*f2 ],
  [ <zero> of ..., (Z(2^2))*<identity> of ...+(Z(2^2))*f1+(Z(2^2))*f2+(Z(2^2))*f1*f2 ],
  [ <zero> of ..., (Z(2^2)^2)*<identity> of ...+(Z(2^2)^2)*f1+(Z(2^2)^2)*f2+(Z(2^2)^2)*f1*f2 ] ]


gap> X3 := XModAlgebraByCat1Algebra( C3 ); 
[Algebra( GF(2),
[ (Z(2)^0)*()+(Z(2)^0)*(4,5), (Z(2)^0)*(1,2,3)+(Z(2)^0)*(1,2,3)(4,5),
  (Z(2)^0)*(1,3,2)+(Z(2)^0)*(1,3,2)(4,5) ] )->Algebra( GF(2),
[ (Z(2)^0)*(), (Z(2)^0)*(1,2,3), (Z(2)^0)*(1,3,2) ] )]
gap> Display( X3 ); 

Crossed module [..->..] :-
: Source algebra has generators:
  [ (Z(2)^0)*()+(Z(2)^0)*(4,5), (Z(2)^0)*(1,2,3)+(Z(2)^0)*(1,2,3)(4,5),
  (Z(2)^0)*(1,3,2)+(Z(2)^0)*(1,3,2)(4,5) ]
: Range algebra has generators:
  [ (Z(2)^0)*(), (Z(2)^0)*(1,2,3), (Z(2)^0)*(1,3,2) ]
: Boundary homomorphism maps source generators to:
  [ <zero> of ..., <zero> of ..., <zero> of ... ]



############################################################################
##
#E  cat1.tst . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
