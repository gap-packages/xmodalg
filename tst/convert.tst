#############################################################################
##
#W  convert.tst             XModAlg test files          Z. Arvasi - A. Odabas 
## 
gap> START_TEST( "XModAlg package: convert.tst" );
gap> saved_infolevel_xmodalg := InfoLevel( InfoXModAlg );; 
gap> SetInfoLevel( InfoXModAlg, 0 );

gap> ## make convert.tst independent of cat1.tst and xmod.tst 
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
gap> ## Chapter 4,  Section 4.1.1
gap> CXM := Cat1AlgebraOfXModAlgebra( XM );
[GF(2^2)[k4] IX <e5> -> GF(2^2)[k4]]
gap> Display( CXM );

Cat1-algebra [..=>GF(2^2)[k4]] :- 
:  range algebra has generators:
  [ (Z(2)^0)*<identity> of ..., (Z(2)^0)*f1, (Z(2)^0)*f2 ]
: tail homomorphism maps source generators to:
: range embedding maps range generators to:
  [ [ (Z(2)^0)*<identity> of ..., <zero> of ... ], 
  [ (Z(2)^0)*f1, <zero> of ... ], [ (Z(2)^0)*f2, <zero> of ... ] ]
: kernel has generators:
  [ [ <zero> of ..., <zero> of ... ], 
  [ <zero> of ..., (Z(2)^0)*<identity> of ...+(Z(2)^0)*f1+(Z(2)^0)*f2+(Z(2)^
        0)*f1*f2 ], 
  [ <zero> of ..., (Z(2^2))*<identity> of ...+(Z(2^2))*f1+(Z(2^2))*f2+(
        Z(2^2))*f1*f2 ], 
  [ <zero> of ..., (Z(2^2)^2)*<identity> of ...+(Z(2^2)^2)*f1+(Z(2^2)^2)*f2+(
        Z(2^2)^2)*f1*f2 ] ]

gap> X3 := XModAlgebraOfCat1Algebra( C3 ); 
[ <algebra of dimension 3 over GF(2)> -> <algebra of dimension 3 over GF(2)> ]
gap> Display( X3 ); 

Crossed module [..->..] :- 
: Source algebra has generators:
  [ (Z(2)^0)*()+(Z(2)^0)*(4,5), (Z(2)^0)*(1,2,3)+(Z(2)^0)*(1,2,3)(4,5), 
  (Z(2)^0)*(1,3,2)+(Z(2)^0)*(1,3,2)(4,5) ]
: Range algebra has generators:
  [ (Z(2)^0)*(), (Z(2)^0)*(1,2,3), (Z(2)^0)*(1,3,2) ]
: Boundary homomorphism maps source generators to:
  [ <zero> of ..., <zero> of ..., <zero> of ... ]

gap> SetInfoLevel( InfoXModAlg, saved_infolevel_xmodalg );; 
gap> STOP_TEST( "convert.tst", 10000 );

############################################################################
##
#E  convert.tst  . . . . . . . . . . . . . . . . . . . . . . . . . ends here
