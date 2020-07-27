#############################################################################
##
#W  cat1.tst                XModAlg test files          Z. Arvasi - A. Odabas 
## 
gap> START_TEST( "XModAlg package: cat1.tst" );
gap> saved_infolevel_xmodalg := InfoLevel( InfoXModAlg );; 
gap> SetInfoLevel( InfoXModAlg, 0 );

gap> ## make cat1.tst independent of xmod.tst 
gap> Ak4 := GroupRing( GF(5), DihedralGroup(4) );;
gap> SetName( Ak4, "GF5[k4]" );
gap> IAk4 := AugmentationIdeal( Ak4 );;
gap> SetName( IAk4, "I(GF5[k4])" );
gap> XIAk4 := XModAlgebraByIdeal( Ak4, IAk4 );;
gap> G := SmallGroup( 4, 2 );;
gap> F := GaloisField( 4 );;
gap> R := GroupRing( F, G );;
gap> SetName( R, "GF(2^2)[k4]" ); 
gap> e5 := Elements(R)[5];; 
gap> S := Subalgebra( R, [e5] );; 
gap> SetName( S, "<e5>" );
gap> RS := Cartesian( R, S );; 
gap> SetName( RS, "GF(2^2)[k4] x <e5>" ); 
gap> act := AlgebraAction( R, RS, S );;
gap> bdy := AlgebraHomomorphismByFunction( S, R, r->r );;
gap> IsAlgebraAction( act );; 
gap> IsAlgebraHomomorphism( bdy );; 
gap> XM := PreXModAlgebraByBoundaryAndAction( bdy, act );;
gap> IsXModAlgebra( XM );;
gap> ############################ 
gap> ## Chapter 2,  Section 2.1.2
gap> Ac6 := GroupRing( GF(2), Group( (1,2,3)(4,5) ) );;
gap> Rc3 := GroupRing( GF(2), Group( (1,2,3) ) );;
gap> homAR := AllHomsOfAlgebras( Ac6, Rc3 );;
gap> mgiAR := List( homAR, h -> MappingGeneratorsImages(h) );;
gap> Print( mgiAR, "\n" );
[ [ [ (Z(2)^0)*(1,3,2)(4,5) ], [ <zero> of ... ] ], 
  [ [ (Z(2)^0)*(1,3,2)(4,5) ], [ (Z(2)^0)*() ] ], 
  [ [ (Z(2)^0)*(1,3,2)(4,5) ], [ (Z(2)^0)*()+(Z(2)^0)*(1,2,3) ] ], 
  [ [ (Z(2)^0)*(1,3,2)(4,5) ], 
      [ (Z(2)^0)*()+(Z(2)^0)*(1,2,3)+(Z(2)^0)*(1,3,2) ] ], 
  [ [ (Z(2)^0)*(1,3,2)(4,5) ], [ (Z(2)^0)*()+(Z(2)^0)*(1,3,2) ] ], 
  [ [ (Z(2)^0)*(1,3,2)(4,5) ], [ (Z(2)^0)*(1,2,3) ] ], 
  [ [ (Z(2)^0)*(1,3,2)(4,5) ], [ (Z(2)^0)*(1,2,3)+(Z(2)^0)*(1,3,2) ] ], 
  [ [ (Z(2)^0)*(1,3,2)(4,5) ], [ (Z(2)^0)*(1,3,2) ] ] ]
gap> homRA := AllHomsOfAlgebras( Rc3, Ac6 );;
gap> mgiRA := List( homRA, h -> MappingGeneratorsImages(h) );;
gap> Print( mgiRA, "\n" );
[ [ [ (Z(2)^0)*(1,2,3) ], [ <zero> of ... ] ], 
  [ [ (Z(2)^0)*(1,2,3) ], [ (Z(2)^0)*() ] ], 
  [ [ (Z(2)^0)*(1,2,3) ], [ (Z(2)^0)*()+(Z(2)^0)*(1,2,3) ] ], 
  [ [ (Z(2)^0)*(1,2,3) ], [ (Z(2)^0)*()+(Z(2)^0)*(1,2,3)+(Z(2)^0)*(1,3,2) ] ],
  [ [ (Z(2)^0)*(1,2,3) ], [ (Z(2)^0)*()+(Z(2)^0)*(1,3,2) ] ], 
  [ [ (Z(2)^0)*(1,2,3) ], [ (Z(2)^0)*(1,2,3) ] ], 
  [ [ (Z(2)^0)*(1,2,3) ], [ (Z(2)^0)*(1,2,3)+(Z(2)^0)*(1,3,2) ] ], 
  [ [ (Z(2)^0)*(1,2,3) ], [ (Z(2)^0)*(1,3,2) ] ] ]
gap> C4 := PreCat1AlgebraByTailHeadEmbedding( homAR[6], homAR[6], homRA[8] );
[AlgebraWithOne( GF(2), [ (Z(2)^0)*(1,2,3)(4,5) ] ) -> AlgebraWithOne( GF(2), 
[ (Z(2)^0)*(1,2,3) ] )]
gap> IsCat1Algebra( C4 );
true
gap> Size( C4 );
[ 64, 8 ]
gap> Display( C4 );

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
  [ (Z(2)^0)*()+(Z(2)^0)*(4,5), (Z(2)^0)*(1,2,3)+(Z(2)^0)*(1,2,3)(4,5), 
  (Z(2)^0)*(1,3,2)+(Z(2)^0)*(1,3,2)(4,5) ]
: boundary homomorphism maps generators of kernel to:
  [ <zero> of ..., <zero> of ..., <zero> of ... ]
: kernel embedding maps generators of kernel to:
  [ (Z(2)^0)*()+(Z(2)^0)*(4,5), (Z(2)^0)*(1,2,3)+(Z(2)^0)*(1,2,3)(4,5), 
  (Z(2)^0)*(1,3,2)+(Z(2)^0)*(1,3,2)(4,5) ]

gap> ############################
gap> ## Chapter 2,  Section 2.1.3
gap> C := Cat1AlgebraSelect( 11 );
|--------------------------------------------------------|
| 11 is invalid number for Galois Field (GFnum)             |
| Possible numbers for GFnum in the Data :              |
|--------------------------------------------------------|
 [ 2, 3, 4, 5, 7 ]
Usage: Cat1Algebra( GFnum, gpsize, gpnum, num );
fail
gap> C := Cat1AlgebraSelect( 4, 12 );
|--------------------------------------------------------|
| 12 is invalid number for size of group (gpsize)        |
| Possible numbers for the gpsize for GF(4) in the Data: |
|--------------------------------------------------------|
 [ 1, 2, 3, 4, 5, 6, 7, 8, 9 ]
Usage: Cat1Algebra( GFnum, gpsize, gpnum, num );
fail
gap> C := Cat1AlgebraSelect( 2, 6, 3 );
|--------------------------------------------------------|
| 3 is invalid number for group of order 6               |
| Possible numbers for the gpnum in the Data :           |
|--------------------------------------------------------|
 [ 1, 2 ]
Usage: Cat1Algebra( GFnum, gpsize, gpnum, num );
fail
gap> C := Cat1AlgebraSelect( 2, 6, 2 );
There are 4 cat1-structures for the algebra GF(2)_c6.
 Range Alg      Tail                    Head
|--------------------------------------------------------|
| GF(2)_c6      identity map            identity map     |
| -----         [ 2, 10 ]               [ 2, 10 ]        |
| -----         [ 2, 14 ]               [ 2, 14 ]        |
| -----         [ 2, 50 ]               [ 2, 50 ]        |
|--------------------------------------------------------|
Usage: Cat1Algebra( GFnum, gpsize, gpnum, num );
Algebra has generators [ (Z(2)^0)*(), (Z(2)^0)*(1,2,3)(4,5) ]
4
gap> C0 := Cat1AlgebraSelect( 4, 6, 2, 2 );
[GF(2^2)_c6 -> Algebra( GF(2^2), 
[ (Z(2)^0)*(), (Z(2)^0)*()+(Z(2)^0)*(1,3,5)(2,4,6)+(Z(2)^0)*(1,4)(2,5)(3,6)+(
    Z(2)^0)*(1,5,3)(2,6,4)+(Z(2)^0)*(1,6,5,4,3,2) ] )]
gap> Size( C0 ); 
[ 4096, 1024 ]
gap> Display( C0 ); 

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

gap> ## Chapter 2,  Section 2.1.4
gap> ## 
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

## Chapter 2,  Section 2.2.2
gap> C1 := Cat1AlgebraSelect( 2, 1, 1, 1 );
[GF(2)_triv -> GF(2)_triv]
gap> Display( C1 );

Cat1-algebra [GF(2)_triv=>GF(2)_triv] :- 
: source algebra has generators:
  [ (Z(2)^0)*(), (Z(2)^0)*() ]
:  range algebra has generators:
  [ (Z(2)^0)*(), (Z(2)^0)*() ]
: tail homomorphism maps source generators to:
  [ (Z(2)^0)*(), (Z(2)^0)*() ]
: head homomorphism maps source generators to:
  [ (Z(2)^0)*(), (Z(2)^0)*() ]
: range embedding maps range generators to:
  [ (Z(2)^0)*(), (Z(2)^0)*() ]
: the kernel is trivial.

gap> C2 := Cat1AlgebraSelect( 2, 2, 1, 2 );
[GF(2)_c2 -> GF(2)_triv]
gap> Display( C2 );                        

Cat1-algebra [GF(2)_c2=>GF(2)_triv] :- 
: source algebra has generators:
  [ (Z(2)^0)*(), (Z(2)^0)*(1,2) ]
:  range algebra has generators:
  [ (Z(2)^0)*(), (Z(2)^0)*() ]
: tail homomorphism maps source generators to:
  [ (Z(2)^0)*(), (Z(2)^0)*() ]
: head homomorphism maps source generators to:
  [ (Z(2)^0)*(), (Z(2)^0)*() ]
: range embedding maps range generators to:
  [ (Z(2)^0)*(), (Z(2)^0)*() ]
: kernel has generators:
  [ (Z(2)^0)*()+(Z(2)^0)*(1,2) ]
: boundary homomorphism maps generators of kernel to:
  [ <zero> of ... ]
: kernel embedding maps generators of kernel to:
  [ (Z(2)^0)*()+(Z(2)^0)*(1,2) ]

gap> C1 = C2;
false
gap> R1 := Source( C1 );;
gap> R2 := Source( C2 );
GF(2)_c2
gap> S1 := Range( C1 );;
gap> S2 := Range( C2 );;
gap> gR1 := GeneratorsOfAlgebra( R1 );
[ (Z(2)^0)*(), (Z(2)^0)*() ]
gap> gR2 := GeneratorsOfAlgebra( R2 );
[ (Z(2)^0)*(), (Z(2)^0)*(1,2) ]
gap> gS1 := GeneratorsOfAlgebra( S1 );
[ (Z(2)^0)*(), (Z(2)^0)*() ]
gap> gS2 := GeneratorsOfAlgebra( S2 );
[ (Z(2)^0)*(), (Z(2)^0)*() ]
gap> im1 := [ gR2[1], gR2[1] ];
[ (Z(2)^0)*(), (Z(2)^0)*() ]
gap> f1 := AlgebraHomomorphismByImages( R1, R2, gR1, im1 );
[ (Z(2)^0)*(), (Z(2)^0)*() ] -> [ (Z(2)^0)*(), (Z(2)^0)*() ]
gap> im2 := [ gS2[1], gS2[1] ];
[ (Z(2)^0)*(), (Z(2)^0)*() ]
gap> f2 := AlgebraHomomorphismByImages( S1, S2, gS1, im2 );
[ (Z(2)^0)*(), (Z(2)^0)*() ] -> [ (Z(2)^0)*(), (Z(2)^0)*() ]
gap> m := Cat1AlgebraMorphism( C1, C2, f1, f2 );
[[GF(2)_triv=>GF(2)_triv] => [GF(2)_c2=>GF(2)_triv]]
gap> Display( m );          

Morphism of cat1-algebras :- 
: Source = [GF(2)_triv=>GF(2)_triv] with generating sets:
  [ (Z(2)^0)*(), (Z(2)^0)*() ]
  [ (Z(2)^0)*(), (Z(2)^0)*() ]
:  Range = [GF(2)_c2=>GF(2)_triv] with generating sets:
  [ (Z(2)^0)*(), (Z(2)^0)*(1,2) ]
  [ (Z(2)^0)*(), (Z(2)^0)*() ]
: Source Homomorphism maps source generators to:
  [ (Z(2)^0)*(), (Z(2)^0)*() ]
: Range Homomorphism maps range generators to:
  [ (Z(2)^0)*(), (Z(2)^0)*() ]

## gap> Image2dAlgMapping( m );
## [GF(3)_c2^3=>GF(3)_c2^3]
gap> IsSurjective( m );
false
gap> IsInjective( m );
true
gap> IsBijective( m );
false

gap> SetInfoLevel( InfoXModAlg, saved_infolevel_xmodalg );; 
gap> STOP_TEST( "cat1.tst", 10000 );

############################################################################
##
#E  cat1.tst . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
