#############################################################################
##
#W  cat1.tst                XModAlg test files          Z. Arvasi - A. Odabas 
## 
#@local level,Ak4,IAk4,XIAk4,m,A1,A3,nat13,X13,G,F,R,e5,S,act,bdy,XM,A2c6,R2c3,homAR,homRA,t4,e4,C4,C,C0,C6,A6,B6,eA6,eB6,SA6,SB6,SC6,C1,C2,SC1,SC2,RC1,RC2,gSC1,gSC2,gRC1,gRC2,imS,homS,imR,homR,m12,im12

gap> START_TEST( "XModAlg package: cat1.tst" );
gap> level := InfoLevel( InfoXModAlg );; 
gap> SetInfoLevel( InfoXModAlg, 0 );

## make cat1.tst independent of xmod.tst 
gap> Ak4 := GroupRing( GF(5), DihedralGroup(4) );;
gap> SetName( Ak4, "GF5[k4]" );
gap> IAk4 := AugmentationIdeal( Ak4 );;
gap> SetName( IAk4, "I(GF5[k4])" );
gap> XIAk4 := XModAlgebraByIdeal( Ak4, IAk4 );;

gap> m := [ [0,1,2,3], [0,0,1,2], [0,0,0,1], [0,0,0,0] ];; 
gap> A1 := Algebra( Rationals, [m] );;
gap> A3 := Subalgebra( A1, [m^3] );; 
gap> nat13 := NaturalHomomorphismByIdeal( A1, A3 );; 
gap> X13 := XModAlgebraBySurjection( nat13 );; 

gap> G := SmallGroup( 4, 2 );;
gap> F := GaloisField( 4 );;
gap> R := GroupRing( F, G );;
gap> SetName( R, "GF(2^2)[k4]" ); 
gap> e5 := Elements(R)[5];; 
gap> S := Subalgebra( R, [e5] );; 
gap> SetName( S, "<e5>" );
gap> act := AlgebraActionByMultipliers( R, S, R );;
gap> bdy := AlgebraHomomorphismByImages( S, R, [e5], [e5] );;
gap> IsAlgebraAction( act );; 
gap> IsAlgebraHomomorphism( bdy );; 
gap> XM := PreXModAlgebraByBoundaryAndAction( bdy, act );;
gap> IsXModAlgebra( XM );;

gap> A2c6 := GroupRing( GF(2), Group( (1,2,3,4,5,6) ) );;
gap> R2c3 := GroupRing( GF(2), Group( (7,8,9) ) );;
gap> homAR := AllAlgebraHomomorphisms( A2c6, R2c3 );;
gap> homRA := AllAlgebraHomomorphisms( R2c3, A2c6 );; 

############################ 
## Chapter 3,  Section 3.1.2 
gap> t4 := homAR[8]; 
[ (Z(2)^0)*(1,6,5,4,3,2) ] -> [ (Z(2)^0)*(7,9,8) ]
gap> e4 := homRA[8];
[ (Z(2)^0)*(7,8,9) ] -> [ (Z(2)^0)*(1,5,3)(2,6,4) ]
gap> C4 := PreCat1AlgebraByTailHeadEmbedding( t4, t4, e4 );
[AlgebraWithOne( GF(2), [ (Z(2)^0)*(1,2,3,4,5,6) 
 ] ) -> AlgebraWithOne( GF(2), [ (Z(2)^0)*(7,8,9) ] )]
gap> IsCat1Algebra( C4 );
true
gap> Size2d( C4 );
[ 64, 8 ]
gap> Dimension( C4 );
[ 6, 3 ]
gap> Display( C4 );

Cat1-algebra [..=>..] :- 
: source algebra has generators:
  [ (Z(2)^0)*(), (Z(2)^0)*(1,2,3,4,5,6) ]
:  range algebra has generators:
  [ (Z(2)^0)*(), (Z(2)^0)*(7,8,9) ]
: tail homomorphism maps source generators to:
  [ (Z(2)^0)*(), (Z(2)^0)*(7,8,9) ]
: head homomorphism maps source generators to:
  [ (Z(2)^0)*(), (Z(2)^0)*(7,8,9) ]
: range embedding maps range generators to:
  [ (Z(2)^0)*(), (Z(2)^0)*(1,5,3)(2,6,4) ]
: kernel has generators:
  [ (Z(2)^0)*()+(Z(2)^0)*(1,4)(2,5)(3,6), (Z(2)^0)*(1,2,3,4,5,6)+(Z(2)^0)*
    (1,5,3)(2,6,4), (Z(2)^0)*(1,3,5)(2,4,6)+(Z(2)^0)*(1,6,5,4,3,2) ]
: boundary homomorphism maps generators of kernel to:
  [ <zero> of ..., <zero> of ..., <zero> of ... ]
: kernel embedding maps generators of kernel to:
  [ (Z(2)^0)*()+(Z(2)^0)*(1,4)(2,5)(3,6), (Z(2)^0)*(1,2,3,4,5,6)+(Z(2)^0)*
    (1,5,3)(2,6,4), (Z(2)^0)*(1,3,5)(2,4,6)+(Z(2)^0)*(1,6,5,4,3,2) ]

############################
## Chapter 3,  Section 3.1.3
gap> C := Cat1AlgebraSelect( 11 );
|--------------------------------------------------------| 
| 11 is invalid value for the Galois Field (GFnum) 	 | 
| Available values for GFnum in the data : 	 	 | 
|--------------------------------------------------------| 
 [ 2, 3, 4, 5, 7 ] 
Usage: Cat1Algebra( GFnum, gpsize, gpnum, num );
fail
gap> C := Cat1AlgebraSelect( 4, 12 );
|--------------------------------------------------------| 
| 12 is invalid value for size of group (gpsize)  	 | 
| Available values for gpsize with GF(4) in the data: 	 | 
|--------------------------------------------------------| 
Usage: Cat1Algebra( GFnum, gpsize, gpnum, num );
[ 1, 2, 3, 4, 5, 6, 7, 8, 9 ]
gap> C := Cat1AlgebraSelect( 2, 6, 3 );
|--------------------------------------------------------| 
| 3 is invalid value for groups of order 6	 	 | 
| Available values for gpnum for groups of size 6 : 	 | 
|--------------------------------------------------------| 
Usage: Cat1Algebra( GFnum, gpsize, gpnum, num );
[ 1, 2 ]
gap> C := Cat1AlgebraSelect( 2, 6, 2 );
There are 4 cat1-structures for the group algebra GF(2)_c6.
 Range Alg     	Tail       		Head      
|--------------------------------------------------------| 
| GF(2)_c6  	identity map 		identity map   	 |
| ----- 	[ 2, 10 ]	 	[ 2, 10 ]	 | 
| ----- 	[ 2, 14 ]	 	[ 2, 14 ]	 | 
| ----- 	[ 2, 50 ]	 	[ 2, 50 ]	 | 
|--------------------------------------------------------| 
Usage: Cat1Algebra( GFnum, gpsize, gpnum, num );
Algebra has generators [ (Z(2)^0)*(), (Z(2)^0)*(1,2,3)(4,5) ]
4
gap> C0 := Cat1AlgebraSelect( 4, 6, 2, 2 );
[GF(2^2)_c6 -> Algebra( GF(2^2), 
[ (Z(2)^0)*(), (Z(2)^0)*()+(Z(2)^0)*(1,3,5)(2,4,6)+(Z(2)^0)*(1,4)(2,5)(3,6)+(
    Z(2)^0)*(1,5,3)(2,6,4)+(Z(2)^0)*(1,6,5,4,3,2) ] )]
gap> Size2d( C0 ); 
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

############################ 
## Chapter 3,  Section 3.1.4
gap> C6 := Cat1AlgebraSelect( 2, 6, 2, 4 );;
gap> A6 := Source( C6 );
GF(2)_c6
gap> B6 := Range( C6 );
<algebra of dimension 3 over GF(2)>
gap> eA6 := Elements( A6 );;
gap> eB6 := Elements( B6 );;
gap> SA6 := Subalgebra( A6, [ eA6[1], eA6[2], eA6[3] ] );
<algebra over GF(2), with 3 generators>
gap> [ Size(A6), Size(SA6) ]; 
[ 64, 4 ]
gap> SB6 := Subalgebra( B6, [ eB6[1], eB6[2] ] ); 
<algebra over GF(2), with 2 generators>
gap> [ Size(B6), Size(SB6) ]; 
[ 8, 2 ]
gap> SC6 := SubCat1Algebra( C6, SA6, SB6 );
[Algebra( GF(2), [ <zero> of ..., (Z(2)^0)*(), (Z(2)^0)*()+(Z(2)^0)*(4,5) 
 ] ) -> Algebra( GF(2), [ <zero> of ..., (Z(2)^0)*() ] )]
gap> Display( SC6 );
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
gap> IsSubCat1Algebra( C6, SC6 );
true

############################ 
## Chapter 3,  Section 3.2.2
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
gap> SC1 := Source( C1 );;
gap> SC2 := Source( C2 );
GF(2)_c2
gap> RC1 := Range( C1 );;
gap> RC2 := Range( C2 );;
gap> gSC1 := GeneratorsOfAlgebra( SC1 );
[ (Z(2)^0)*(), (Z(2)^0)*() ]
gap> gSC2 := GeneratorsOfAlgebra( SC2 );
[ (Z(2)^0)*(), (Z(2)^0)*(1,2) ]
gap> gRC1 := GeneratorsOfAlgebra( RC1 );
[ (Z(2)^0)*(), (Z(2)^0)*() ]
gap> gRC2 := GeneratorsOfAlgebra( RC2 );
[ (Z(2)^0)*(), (Z(2)^0)*() ]
gap> imS := [ gSC2[1], gSC2[1] ];
[ (Z(2)^0)*(), (Z(2)^0)*() ]
gap> homS := AlgebraHomomorphismByImages( SC1, SC2, gSC1, imS );
[ (Z(2)^0)*(), (Z(2)^0)*() ] -> [ (Z(2)^0)*(), (Z(2)^0)*() ]
gap> imR := [ gRC2[1], gRC2[1] ];
[ (Z(2)^0)*(), (Z(2)^0)*() ]
gap> homR := AlgebraHomomorphismByImages( RC1, RC2, gRC1, imR );
[ (Z(2)^0)*(), (Z(2)^0)*() ] -> [ (Z(2)^0)*(), (Z(2)^0)*() ]
gap> m12 := Cat1AlgebraMorphism( C1, C2, homS, homR );
[[GF(2)_triv=>GF(2)_triv] => [GF(2)_c2=>GF(2)_triv]]
gap> Display( m12 );

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

## gap> Image2dAlgMapping( m12 );
## [GF(3)_c2^3=>GF(3)_c2^3]
gap> IsSurjective( m12 );
false
gap> IsInjective( m12 );
true
gap> IsBijective( m12 );
false

########################### 
## Chapter 3, Section 3.2.3 
gap> im12 := ImagesSource2DimensionalMapping( m12 );;
gap> Display( im12 ); 
Cat1-algebra [..=>..] :- 
: source algebra has generators:
  [ (Z(2)^0)*(), (Z(2)^0)*() ]
:  range algebra has generators:
  [ (Z(2)^0)*() ]
: tail homomorphism maps source generators to:
  [ (Z(2)^0)*(), (Z(2)^0)*() ]
: head homomorphism maps source generators to:
  [ (Z(2)^0)*(), (Z(2)^0)*() ]
: range embedding maps range generators to:
  [ (Z(2)^0)*() ]
: the kernel is trivial.

gap> SetInfoLevel( InfoXModAlg, level );; 
gap> STOP_TEST( "cat1.tst", 10000 );

############################################################################
##
#E  cat1.tst . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
