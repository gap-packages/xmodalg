#############################################################################
##
#W  xmod.tst                XModAlg test files          Z. Arvasi - A. Odabas      
##
gap> START_TEST( "XModAlg package: xmod.tst" );
gap> saved_infolevel_xmodalg := InfoLevel( InfoXModAlg );; 
gap> SetInfoLevel( InfoXModAlg, 0 );

## Chapter 2,  Section 2.1.2
gap> A := GroupRing( GF(5), DihedralGroup(4) );
<algebra-with-one over GF(5), with 2 generators>
gap> Size( A );
625
gap> SetName( A, "GF5[D4]" );
gap> I := AugmentationIdeal( A );
<two-sided ideal in GF5[D4], (2 generators)>
gap> Size( I );
125
gap> SetName( I, "Aug" );
gap> CM := XModAlgebraByIdeal( A, I );
[Aug->GF5[D4]]
gap> Display( CM );

Crossed module [Aug->GF5[D4]] :- 
: Source algebra Aug has generators:
  [ (Z(5)^2)*<identity> of ...+(Z(5)^0)*f1, (Z(5)^2)*<identity> of ...+(Z(5)^0)*f2 ]
: Range algebra GF5[D4] has generators:
  [ (Z(5)^0)*<identity> of ..., (Z(5)^0)*f1, (Z(5)^0)*f2 ]
: Boundary homomorphism maps source generators to:
  [ (Z(5)^2)*<identity> of ...+(Z(5)^0)*f1, (Z(5)^2)*<identity> of ...+(Z(5)^0)*f2 ]

gap> Size( CM );
[ 125, 625 ]
gap> f := Boundary( CM );
MappingByFunction( Aug, GF5[D4], function( i ) ... end )
gap> Print( RepresentationsOfObject(CM), "\n" ); 
[ "IsComponentObjectRep", "IsAttributeStoringRep", "IsPreXModAlgebraObj" ]
gap> props := [ "CanEasilyCompareElements", "CanEasilySortElements", 
>  "IsDuplicateFree", "IsLeftActedOnByDivisionRing", "IsAdditivelyCommutative", 
>  "IsLDistributive", "IsRDistributive", "IsPreXModDomain", "Is2dAlgebraObject", 
>  "IsPreXModAlgebra", "IsXModAlgebra" ];;
gap> known := KnownPropertiesOfObject( CM );;
gap> ForAll( props, p -> (p in known) );
true 
gap> Print( KnownAttributesOfObject(CM), "\n" ); 
[ "Name", "Size", "Range", "Source", "Boundary", "XModAlgebraAction" ]


## Chapter 2,  Section 2.1.3
gap> e4 := Elements( I )[4];
(Z(5)^0)*<identity> of ...+(Z(5)^0)*f1+(Z(5)^2)*f2+(Z(5)^2)*f1*f2
gap> J := Ideal( I, [e4] );
<two-sided ideal in Aug, (1 generators)>
gap> Size( J );
5
gap> SetName( J, "<e4>" ); 
gap> PM := XModAlgebraByIdeal( A, J );
[<e4>->GF5[D4]]
gap> Display( PM );        

Crossed module [<e4>->GF5[D4]] :- 
: Source algebra <e4> has generators:
  [ (Z(5)^0)*<identity> of ...+(Z(5)^0)*f1+(Z(5)^2)*f2+(Z(5)^2)*f1*f2 ]
: Range algebra GF5[D4] has generators:
  [ (Z(5)^0)*<identity> of ..., (Z(5)^0)*f1, (Z(5)^0)*f2 ]
: Boundary homomorphism maps source generators to:
  [ (Z(5)^0)*<identity> of ...+(Z(5)^0)*f1+(Z(5)^2)*f2+(Z(5)^2)*f1*f2 ]

gap> IsSubXModAlgebra( CM, PM );
true


## Chapter 2,  Section 2.1.4
gap> G := SmallGroup( 4, 2 );
<pc group of size 4 with 2 generators>
gap> F := GaloisField( 4 );
GF(2^2)
gap> R := GroupRing( F, G );
<algebra-with-one over GF(2^2), with 2 generators>
gap> Size( R );
256
gap> SetName( R, "GF(2^2)[k4]" ); 
gap> e5 := Elements( R )[5]; 
(Z(2)^0)*<identity> of ...+(Z(2)^0)*f1+(Z(2)^0)*f2+(Z(2)^0)*f1*f2
gap> S := Subalgebra( R, [e5] ); 
<algebra over GF(2^2), with 1 generators>
gap> SetName( S, "<e5>" );
gap> RS := Cartesian( R, S );; 
gap> SetName( RS, "GF(2^2)[k4] x <e5>" ); 
gap> act := AlgebraAction( R, RS, S );;
gap> bdy := AlgebraHomomorphismByFunction( S, R, r->r );
MappingByFunction( <e5>, GF(2^2)[k4], function( r ) ... end )
gap> IsAlgebraAction( act ); 
true
gap> IsAlgebraHomomorphism( bdy );
true
gap> XM := PreXModAlgebraByBoundaryAndAction( bdy, act );
[<e5>->GF(2^2)[k4]]
gap> IsXModAlgebra( XM );
true
gap> Display( XM );

Crossed module [<e5>->GF(2^2)[k4]] :-
: Source algebra has generators:
  [ (Z(2)^0)*<identity> of ...+(Z(2)^0)*f1+(Z(2)^0)*f2+(Z(2)^0)*f1*f2 ]
: Range algebra GF(2^2)[k4] has generators:
  [ (Z(2)^0)*<identity> of ..., (Z(2)^0)*f1, (Z(2)^0)*f2 ]
: Boundary homomorphism maps source generators to:
  [ (Z(2)^0)*<identity> of ...+(Z(2)^0)*f1+(Z(2)^0)*f2+(Z(2)^0)*f1*f2 ]

## Chapter 2,  Section 2.2.1
  
gap> A := GroupRing( GF(2), CyclicGroup(4) );
<algebra-with-one over GF(2), with 2 generators>
gap> B := AugmentationIdeal( A );
<two-sided ideal in <algebra-with-one over GF(2), with 2 generators>, (dimension 3)>
gap> X1 := XModAlgebra( A, B );
[Algebra( GF(2), [ (Z(2)^0)*<identity> of ...+(Z(2)^0)*f2, (Z(2)^0)*f1+(Z(2)^0)*f2, (Z(2)^0)*f2+(Z(2)^0)*f1*f2
 ] )->AlgebraWithOne( GF(2), [ (Z(2)^0)*f1, (Z(2)^0)*f2 ] )]
gap> C := GroupRing( GF(2), SmallGroup( 4, 2 ) );
<algebra-with-one over GF(2), with 2 generators>
gap> D := AugmentationIdeal( C );
<two-sided ideal in <algebra-with-one over GF(2), with 2 generators>, (dimension 3)>
gap> X2 := XModAlgebra( C, D );
[Algebra( GF(2), [ (Z(2)^0)*<identity> of ...+(Z(2)^0)*f2, (Z(2)^0)*f1+(Z(2)^0)*f2, (Z(2)^0)*f2+(Z(2)^0)*f1*f2
 ] )->AlgebraWithOne( GF(2), [ (Z(2)^0)*f1, (Z(2)^0)*f2 ] )]
gap> B = D;
false
gap> all_f := AllHomsOfAlgebras( A, C );;
gap> all_g := AllHomsOfAlgebras( B, D );;
gap> mor := XModAlgebraMorphism( X1, X2, all_g[1], all_f[2] );
[[..] => [..]]
gap> Display( mor );

Morphism of crossed modules :-
: Source = [Algebra( GF(2), [ (Z(2)^0)*<identity> of ...+(Z(2)^0)*f2, (Z(2)^0)*f1+(Z(2)^0)*f2,
  (Z(2)^0)*f2+(Z(2)^0)*f1*f2 ] )->AlgebraWithOne( GF(2), [ (Z(2)^0)*f1, (Z(2)^0)*f2 ] )] with generating sets:
  [ (Z(2)^0)*<identity> of ...+(Z(2)^0)*f2, (Z(2)^0)*f1+(Z(2)^0)*f2, (Z(2)^0)*f2+(Z(2)^0)*f1*f2 ]
  [ (Z(2)^0)*<identity> of ..., (Z(2)^0)*f1, (Z(2)^0)*f2 ]
:  Range = [Algebra( GF(2), [ (Z(2)^0)*<identity> of ...+(Z(2)^0)*f2, (Z(2)^0)*f1+(Z(2)^0)*f2,
  (Z(2)^0)*f2+(Z(2)^0)*f1*f2 ] )->AlgebraWithOne( GF(2), [ (Z(2)^0)*f1, (Z(2)^0)*f2 ] )] with generating sets:
  [ (Z(2)^0)*<identity> of ...+(Z(2)^0)*f2, (Z(2)^0)*f1+(Z(2)^0)*f2, (Z(2)^0)*f2+(Z(2)^0)*f1*f2 ]
  [ (Z(2)^0)*<identity> of ..., (Z(2)^0)*f1, (Z(2)^0)*f2 ]
: Source Homomorphism maps source generators to:
  [ <zero> of ..., <zero> of ..., <zero> of ... ]
: Range Homomorphism maps range generators to:
  [ (Z(2)^0)*<identity> of ..., (Z(2)^0)*<identity> of ..., (Z(2)^0)*<identity> of ... ]

gap> IsTotal( mor );
true
gap> IsSingleValued( mor );
true

## Chapter 2,  Section 2.2.2
gap> X3 := Kernel( mor );
[Algebra( GF(2), [ (Z(2)^0)*<identity> of ...+(Z(2)^0)*f2, (Z(2)^0)*f1+(Z(2)^0)*f2, (Z(2)^0)*f2+(Z(2)^0)*f1*f2
 ] )->Algebra( GF(2), [ (Z(2)^0)*f1+(Z(2)^0)*f2, (Z(2)^0)*f1+(Z(2)^0)*f1*f2, (Z(2)^0)*<identity> of ...+(Z(2)^0)*f1
 ] )]
gap> IsXModAlgebra( X3 );
true
gap> Size( X3 );
[ 8, 8 ]
gap> IsSubXModAlgebra( X1, X3 );
true

## Chapter 2,  Section 2.2.4

gap> theta := SourceHom( mor );;
gap> Print( MappingGeneratorsImages( theta ), "\n" ); 
[ [ (Z(2)^0)*<identity> of ...+(Z(2)^0)*f2, (Z(2)^0)*f1+(Z(2)^0)*f2, 
      (Z(2)^0)*f2+(Z(2)^0)*f1*f2 ], 
  [ <zero> of ..., <zero> of ..., <zero> of ... ] ]
gap> phi := RangeHom( mor );
[ (Z(2)^0)*f1 ] -> [ (Z(2)^0)*<identity> of ... ]
gap> IsInjective( mor );
false
gap> IsSurjective( mor );
false

gap> SetInfoLevel( InfoXModAlg, saved_infolevel_xmodalg );; 
gap> STOP_TEST( "xmod.tst", 10000 );

############################################################################
##
#E  xmod.tst . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
