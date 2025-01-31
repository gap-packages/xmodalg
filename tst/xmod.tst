#############################################################################
##
#W  xmod.tst                XModAlg test files          Z. Arvasi - A. Odabas      
##
#@local level,m2,A2,S2,nat2,Q2,m3,A3,c3,Rc3,g3,mg3,Amg3,homg3,actg3,V3,M3,act3,F5,id5,two,z5,n0,n1,n2,An,Bn,actn,Xn,Ak4,IAk4,XIAk4,XAn,X2,bdy3,X3,Y3,e4,Je4,Ke4,Se4,c4,Ac4,IAc4,XIAc4,Bk4,IBk4,XIBk4,homIAIB,theta,homAB,phi,mor,Xmor,ic4,e1,e2,immor

gap> START_TEST( "XModAlg package: xmod.tst" );
gap> level := InfoLevel( InfoXModAlg );; 
gap> SetInfoLevel( InfoXModAlg, 0 );

## make this test independent of algebra.tst and module.tst
gap> m2 := [ [0,1,2,3], [0,0,1,2], [0,0,0,1], [0,0,0,0] ];; 
gap> A2 := Algebra( Rationals, [m2] );;
gap> SetName( A2, "A2" );
gap> S2 := Subalgebra( A2, [m2^3] );; 
gap> nat2 := NaturalHomomorphismByIdeal( A2, S2 );; 
gap> Q2 := Image( nat2 );;
gap> SetName( Q2, "Q2" );

## from 2.2.4
gap> m3 := [ [0,1,0], [0,0,1], [1,0,0] ];;
gap> A3 := Algebra( Rationals, [m3] );;
gap> SetName( A3, "A3" );
gap> c3 := Group( (1,2,3) );;
gap> Rc3 := GroupRing( Rationals, c3 );;
gap> SetName( Rc3, "GR(c3)" );
gap> g3 := GeneratorsOfAlgebra( Rc3 )[2];;
gap> mg3 := RegularAlgebraMultiplier( Rc3, Rc3, g3 );;
gap> Amg3 := AlgebraByGenerators( Rationals, [ mg3 ] );;
gap> homg3 := AlgebraHomomorphismByImages( A3, Amg3, [ m3 ], [ mg3 ] );;
gap> actg3 := AlgebraActionByHomomorphism( homg3, Rc3 );;

gap> V3 := Rationals^3;;
gap> M3 := LeftAlgebraModule( A3, \*, V3 );;
gap> SetName( M3, "M3" );
gap> act3 := AlgebraActionByModule( A3, M3 );;

## Chapter 4, Section 4.1.2 
gap> F5 := GF(5);;
gap> id5 := One( F5 );;
gap> two := Z(5);; 
gap> z5 := Zero( F5 );; 
gap> n0 := [ [id5,z5,z5], [z5,id5,z5], [z5,z5,id5] ];; 
gap> n1 := [ [z5,id5,two^3], [z5,z5,id5], [z5,z5,z5] ];;
gap> n2 := [ [z5,z5,id5], [z5,z5,z5], [z5,z5,z5] ];; 
gap> An := Algebra( F5, [ n0, n1 ] );; 
gap> SetName( An, "An" ); 
gap> Bn := Subalgebra( An, [ n1 ] );; 
gap> SetName( Bn, "Bn" ); 
gap> IsIdeal( An, Bn ); 
true
gap> actn := AlgebraActionByMultipliers( An, Bn, An );; 
gap> Xn := XModAlgebraByIdeal( An, Bn ); 
[ Bn -> An ]
gap> SetName( Xn, "Xn" ); 

############################
## Section 4.1.3 
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
gap> Size2d( XIAk4 );
[ 125, 625 ]

############################
## Section 4.1.4
gap> RepresentationsOfObject( XIAk4 );
[ "IsComponentObjectRep", "IsAttributeStoringRep", "IsPreXModAlgebraObj" ]
gap> Set( KnownPropertiesOfObject( XIAk4 ) );
[ "CanEasilyCompareElements", "CanEasilySortElements", "Is2dAlgebraObject", 
  "IsAdditivelyCommutative", "IsDuplicateFree", "IsLDistributive", 
  "IsLeftActedOnByDivisionRing", "IsPreXModAlgebra", "IsPreXModDomain", 
  "IsRDistributive", "IsXModAlgebra" ]
gap> Set( KnownAttributesOfObject( XIAk4 ) );
[ "Boundary", "LeftActingDomain", "Name", "Range", "Size2d", "Source", 
  "XModAlgebraAction" ]

############################
gap> ## Section 4.1.5
gap> XAn := XModAlgebraByMultiplierAlgebra( An );
[ An -> <algebra of dimension 3 over GF(5)> ]
gap> XModAlgebraAction( XAn );
IdentityMapping( <algebra of dimension 3 over GF(5)> )

############################
## Section 4.1.6
gap> X2 := XModAlgebraBySurjection( nat2 );; 
gap> Display( X2 ); 
Crossed module [A2->Q2] :- 
: Source algebra A2 has generators:
  [ [ [ 0, 1, 2, 3 ], [ 0, 0, 1, 2 ], [ 0, 0, 0, 1 ], [ 0, 0, 0, 0 ] ] ]
: Range algebra Q2 has generators:
  [ v.1, v.2 ]
: Boundary homomorphism maps source generators to:
  [ v.1 ]

############################
## Section 4.1.7
gap> bdy3 := AlgebraHomomorphismByImages( Rc3, A3, [ g3 ], [ m3 ] );
[ (1)*(1,2,3) ] -> [ [ [ 0, 1, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ] ] ]
gap> X3 := XModAlgebraByBoundaryAndAction( bdy3, actg3 );
[ GR(c3) -> A3 ]
gap> Display( X3 );
Crossed module [GR(c3) -> A3] :- 
: Source algebra GR(c3) has generators:
  [ (1)*(), (1)*(1,2,3) ]
: Range algebra A3 has generators:
  [ [ [ 0, 1, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ] ] ]
: Boundary homomorphism maps source generators to:
  [ [ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ] ], 
  [ [ 0, 1, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ] ] ]

gap> ############################
gap> ## Section 4.1.8
gap> Y3 := XModAlgebraByModule( A3, M3 );
[ A(M3) -> A3 ]
gap> Image( XModAlgebraAction( Y3 ), m3 ) = Image( act3, m3 ); 
true
gap> Display( Y3 );
Crossed module [A(M3) -> A3] :- 
: Source algebra A(M3) has generators:  [ [[ 1, 0, 0 ]], [[ 0, 1, 0 ]], 
  [[ 0, 0, 1 ]] ]
: Range algebra A3 has generators:  
[ [ [ 0, 1, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ] ] ]
: Boundary homomorphism maps source generators to:
[ [ [ 0, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 0 ] ], 
  [ [ 0, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 0 ] ], 
  [ [ 0, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, 0 ] ] ]

############################
## Section 4.1.10
gap> e4 := Elements( IAk4 )[4];
(Z(5)^0)*<identity> of ...+(Z(5)^0)*f1+(Z(5)^2)*f2+(Z(5)^2)*f1*f2
gap> Je4 := Ideal( IAk4, [e4] );;
gap> SetName( Je4, "<e4>" );
gap> Ke4 := Subalgebra( Ak4, [e4] );;
gap> [ Size( Je4 ), Size( Ke4 ) ];
[ 5, 5 ]
gap> Se4 := SubXModAlgebra( XIAk4, Je4, Ke4 );
[ <e4> -> <algebra of dimension 1 over GF(5)> ]
gap> IsSubXModAlgebra( XIAk4, Se4 ); 
true
gap> Display( Se4 );
Crossed module [<e4> -> ..] :- 
: Source algebra <e4> has generators:  
[ (Z(5)^0)*<identity> of ...+(Z(5)^0)*f1+(Z(5)^2)*f2+(Z(5)^2)*f1*f2 ]
: Range algebra has generators:  
[ (Z(5)^0)*<identity> of ...+(Z(5)^0)*f1+(Z(5)^2)*f2+(Z(5)^2)*f1*f2 ]
: Boundary homomorphism maps source generators to:
[ (Z(5)^0)*<identity> of ...+(Z(5)^0)*f1+(Z(5)^2)*f2+(Z(5)^2)*f1*f2 ]

############################
## Chapter 4,  Section 4.2.1 
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
gap> homIAIB := AllAlgebraHomomorphisms( IAc4, IBk4 );; 
gap> theta := homIAIB[3];; 
gap> homAB := AllAlgebraHomomorphisms( Ac4, Bk4 );;
gap> phi := homAB[7];; 
gap> mor := XModAlgebraMorphism( XIAc4, XIBk4, theta, phi );
[[I(GF2[c4])->GF2[c4]] => [I(GF2[k4])->GF2[k4]]]
gap> Display( mor );

Morphism of crossed modules :- 
: Source = [I(GF2[c4])->GF2[c4]]
:  Range = [I(GF2[k4])->GF2[k4]]
: Source Homomorphism maps source generators to:
  [ <zero> of ..., (Z(2)^0)*<identity> of ...+(Z(2)^0)*f1+(Z(2)^0)*f2+(Z(2)^
    0)*f1*f2, (Z(2)^0)*<identity> of ...+(Z(2)^0)*f1+(Z(2)^0)*f2+(Z(2)^
    0)*f1*f2 ]
: Range Homomorphism maps range generators to:
  [ (Z(2)^0)*<identity> of ..., (Z(2)^0)*f1+(Z(2)^0)*f2+(Z(2)^0)*f1*f2, 
  (Z(2)^0)*<identity> of ... ]

gap> IsTotal( mor );
true
gap> IsSingleValued( mor );
true

############################
## Section 4.2.2
gap> Xmor := Kernel( mor );
[ <algebra of dimension 2 over GF(2)> -> <algebra of dimension 2 over GF(2)> ]
gap> IsXModAlgebra( Xmor );
true
gap> Size2d( Xmor );
[ 4, 4 ]
gap> IsSubXModAlgebra( XIAc4, Xmor );
true

############################
## Section 4.2.4
gap> ic4 := One( Ac4 );; 
gap> e1 := ic4*c4.1 + ic4*c4.2;
(Z(2)^0)*f1+(Z(2)^0)*f2
gap> ImageElm( theta, e1 );  
(Z(2)^0)*<identity> of ...+(Z(2)^0)*f1+(Z(2)^0)*f2+(Z(2)^0)*f1*f2
gap> e2 := ic4*c4.1;
(Z(2)^0)*f1
gap> ImageElm( phi, e2 );
(Z(2)^0)*f1+(Z(2)^0)*f2+(Z(2)^0)*f1*f2
gap> IsInjective( mor );
false
gap> IsSurjective( mor );
false
gap> immor := ImagesSource2DimensionalMapping( mor );;
gap> Display( immor );

Crossed module [..->..] :- 
: Source algebra has generators:
  [ (Z(2)^0)*<identity> of ...+(Z(2)^0)*f1+(Z(2)^0)*f2+(Z(2)^0)*f1*f2 ]
: Range algebra has generators:
  [ (Z(2)^0)*f1+(Z(2)^0)*f2+(Z(2)^0)*f1*f2, (Z(2)^0)*<identity> of ... ]
: Boundary homomorphism maps source generators to:
  [ (Z(2)^0)*<identity> of ...+(Z(2)^0)*f1+(Z(2)^0)*f2+(Z(2)^0)*f1*f2 ]

gap> SetInfoLevel( InfoXModAlg, level );; 
gap> STOP_TEST( "xmod.tst", 10000 );

############################################################################
##
#E  xmod.tst . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
