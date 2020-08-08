#############################################################################
##
#W  xmod.tst                XModAlg test files          Z. Arvasi - A. Odabas      
##
gap> START_TEST( "XModAlg package: xmod.tst" );
gap> saved_infolevel_xmodalg := InfoLevel( InfoXModAlg );; 
gap> SetInfoLevel( InfoXModAlg, 0 );

## Chapter 3,  Section 3.1.2
gap> Ak4 := GroupRing( GF(5), DihedralGroup(4) );
<algebra-with-one over GF(5), with 2 generators>
gap> Size( Ak4 );
625
gap> SetName( Ak4, "GF5[k4]" );
gap> IAk4 := AugmentationIdeal( Ak4 );
<two-sided ideal in GF5[k4], (2 generators)>
gap> Size( IAk4 );
125
gap> SetName( IAk4, "I(GF5[k4])" );
gap> XIAk4 := XModAlgebraByIdeal( Ak4, IAk4 );
[ I(GF5[k4]) -> GF5[k4] ]
gap> Display( XIAk4 );

Crossed module [I(GF5[k4])->GF5[k4]] :- 
: Source algebra I(GF5[k4]) has generators:
  [ (Z(5)^2)*<identity> of ...+(Z(5)^0)*f1, (Z(5)^2)*<identity> of ...+(Z(5)^
    0)*f2 ]
: Range algebra GF5[k4] has generators:
  [ (Z(5)^0)*<identity> of ..., (Z(5)^0)*f1, (Z(5)^0)*f2 ]
: Boundary homomorphism maps source generators to:
  [ (Z(5)^2)*<identity> of ...+(Z(5)^0)*f1, (Z(5)^2)*<identity> of ...+(Z(5)^
    0)*f2 ]

gap> Size( XIAk4 );
[ 125, 625 ]
gap> f := Boundary( XIAk4 );
MappingByFunction( I(GF5[k4]), GF5[k4], function( i ) ... end )
gap> Print( RepresentationsOfObject(XIAk4), "\n" ); 
[ "IsComponentObjectRep", "IsAttributeStoringRep", "IsPreXModAlgebraObj" ]
gap> props := [ "CanEasilyCompareElements", "CanEasilySortElements", 
>  "IsDuplicateFree", "IsLeftActedOnByDivisionRing", "IsAdditivelyCommutative", 
>  "IsLDistributive", "IsRDistributive", "IsPreXModDomain", "Is2dAlgebraObject", 
>  "IsPreXModAlgebra", "IsXModAlgebra" ];;
gap> known := KnownPropertiesOfObject( XIAk4 );;
gap> ForAll( props, p -> (p in known) );
true
gap> Print( KnownAttributesOfObject(XIAk4), "\n" ); 
[ "Name", "Size", "Range", "Source", "Boundary", "XModAlgebraAction" ]
gap> ## Chapter 3,  Section 3.1.3
gap> e4 := Elements( IAk4 )[4];
(Z(5)^0)*<identity> of ...+(Z(5)^0)*f1+(Z(5)^2)*f2+(Z(5)^2)*f1*f2
gap> Je4 := Ideal( IAk4, [e4] );;
gap> Size( Je4 );
5
gap> SetName( Je4, "<e4>" ); 
gap> XJe4 := XModAlgebraByIdeal( Ak4, Je4 );
[ <e4> -> GF5[k4] ]
gap> Display( XJe4 );        

Crossed module [<e4>->GF5[k4]] :- 
: Source algebra <e4> has generators:
  [ (Z(5)^0)*<identity> of ...+(Z(5)^0)*f1+(Z(5)^2)*f2+(Z(5)^2)*f1*f2 ]
: Range algebra GF5[k4] has generators:
  [ (Z(5)^0)*<identity> of ..., (Z(5)^0)*f1, (Z(5)^0)*f2 ]
: Boundary homomorphism maps source generators to:
  [ (Z(5)^0)*<identity> of ...+(Z(5)^0)*f1+(Z(5)^2)*f2+(Z(5)^2)*f1*f2 ]

gap> IsSubXModAlgebra( XIAk4, XJe4 );
true
gap> ############################
gap> ## Chapter 3,  Section 3.1.4
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
gap> S := Subalgebra( R, [e5] );;
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

gap> ############################
gap> ## Chapter 3,  Section 3.2.1 
gap> c4 := CyclicGroup( 4 );;
gap> Ac4 := GroupRing( GF(2), c4 );
<algebra-with-one over GF(2), with 2 generators>
gap> SetName( Ac4, "GF2[c4]" );
gap> IAc4 := AugmentationIdeal( Ac4 );
<two-sided ideal in GF2[c4], (dimension 3)>
gap> SetName( IAc4, "I(GF2[c4])" );
gap> XIAc4 := XModAlgebra( Ac4, IAc4 );
[ I(GF2[c4]) -> GF2[c4] ]
gap> Bk4 := GroupRing( GF(2), SmallGroup( 4, 2 ) );
<algebra-with-one over GF(2), with 2 generators>
gap> SetName( Bk4, "GF2[k4]" );
gap> IBk4 := AugmentationIdeal( Bk4 );
<two-sided ideal in GF2[k4], (dimension 3)>
gap> SetName( IBk4, "I(GF2[k4])" );
gap> XIBk4 := XModAlgebra( Bk4, IBk4 );
[ I(GF2[k4]) -> GF2[k4] ]
gap> IAc4 = IBk4;
false
gap> homAB := AllHomsOfAlgebras( Ac4, Bk4 );;
gap> homIAIB := AllHomsOfAlgebras( IAc4, IBk4 );;
gap> mor := XModAlgebraMorphism( XIAc4, XIBk4, homIAIB[1], homAB[2] );
[[I(GF2[c4])->GF2[c4]] => [I(GF2[k4])->GF2[k4]]]
gap> Display( mor );

Morphism of crossed modules :- 
: Source = [I(GF2[c4])->GF2[c4]]
:  Range = [I(GF2[k4])->GF2[k4]]
: Source Homomorphism maps source generators to:
  [ <zero> of ..., <zero> of ..., <zero> of ... ]
: Range Homomorphism maps range generators to:
  [ (Z(2)^0)*<identity> of ..., (Z(2)^0)*<identity> of ..., 
  (Z(2)^0)*<identity> of ... ]

gap> IsTotal( mor );
true
gap> IsSingleValued( mor );
true
gap> ############################
gap> ## Chapter 3,  Section 3.2.2
gap> Xmor := Kernel( mor );
[ <algebra of dimension 3 over GF(2)> -> <algebra of dimension 3 over GF(2)> ]
gap> IsXModAlgebra( Xmor );
true
gap> Size( Xmor );
[ 8, 8 ]
gap> IsSubXModAlgebra( XIAc4, Xmor );
true
gap> ############################
gap> ## Chapter 3,  Section 3.2.4
gap> ic4 := One( Ac4 );;                                      
gap> theta := SourceHom( mor );;
gap> e1 := ic4*c4.1 + ic4*c4.2;
(Z(2)^0)*f1+(Z(2)^0)*f2
gap> ImageElm( theta, e1 );  
<zero> of ...
gap> phi := RangeHom( mor );;
gap> e2 := ic4*c4.1;
(Z(2)^0)*f1
gap> ImageElm( phi, e2 );
(Z(2)^0)*<identity> of ...
gap> IsInjective( mor );
false
gap> IsSurjective( mor );
false
gap> ImagesSource2DimensionalMapping( mor );
Srng is not an ideal of Prng
fail
gap> STOP_TEST( "xmod.tst", 10000 );

############################################################################
##
#E  xmod.tst . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
