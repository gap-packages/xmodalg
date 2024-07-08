############################################################################
##
#W  module.g            XModAlg example files                 Chris Wensley 
## 

LoadPackage( "xmodalg" );

## Section 2.2.4
m3 := [ [0,1,0], [0,0,1], [1,0,0] ];
Print( "m3 = ", m3, "\n" );
A3 := Algebra( Rationals, [m3] );
SetName( A3, "A3" );;
G := Group( (1,2,3) );;
B3 := GroupRing( Rationals, G );;
SetName( B3, "GR(G)" );
g3 := GeneratorsOfAlgebra( B3 )[2];;
mg3 := RegularAlgebraMultiplier( B3, B3, g3 );;
MB3 := AlgebraByGenerators( Rationals, [ mg3 ] );;
hom3 := AlgebraHomomorphismByImages( A3, MB3, [ m3 ], [ mg3 ] );;
act3 := AlgebraActionByHomomorphism( hom3, B3 );
Print ( "action act3 of A3 on B3:\n", act3, "\n" );

## Section 4.1.6
bdy3 := AlgebraHomomorphismByImages( B3, A3, [ g3 ], [ m3 ] );
Print( "bdy3 = ", bdy3, "\n" );
X3 := XModAlgebraByBoundaryAndAction( bdy3, act3 );
Print( "crossed module X3:\n" );
Display( X3 );

## Section 2.3
m3 := [ [0,1,0], [0,0,1], [1,0,0] ];;
A4 := Algebra( Rationals, [m3] );;
SetName( A4, "A4" );;
V4 := Rationals^3;;
M4 := LeftAlgebraModule( A4, \*, V4 );;
SetName( M4, "M4" );
famM4 := ElementsFamily( FamilyObj( M4 ) );;
v4 := [3,4,5];;
Print( "initial v4 in V4 = ", v4, "\n" );
v4 := ObjByExtRep( famM4, v4 );
Print( "v4 after conversion to M4 = ", v4, "\n" );
Print( "m3*v4 = ", m3*v4, "\n" );
genM4 := GeneratorsOfLeftModule( M4 );;
u4 := 6*genM4[1] + 7*genM4[2] + 8*genM4[3];
Print( "u4 = 6*genM4[1] + 7*genM4[2] + 8*genM4[3] = ", u4, "\n" );
u4 := ExtRepOfObj( u4 );
Print( "ExtRepOfObf( u4 ) = ", u4, "\n" );

## Section 2.3.1
D4 := LeftActingDomain( M4 );;
T4 := EmptySCTable( Dimension(M4), Zero(D4), "symmetric" );;
B4a := AlgebraByStructureConstants( D4, T4 );
Print( "B4a = ", B4a, "\n" );
Print( "B4a has generators: ", GeneratorsOfAlgebra( B4a ), "\n" );
B4 := ModuleAsAlgebra( M4 );             
Print( "B4 has name: ", Name( B4 ), "\n" );
Print( "B4 has generators: ", GeneratorsOfAlgebra( B4 ), "\n" );

## Section 2.3.2
Print( "IsModuleAsAlgebra( B4 )? ", IsModuleAsAlgebra( B4 ), "\n" );
Print( "IsModuleAsAlgebra( A4 )? ", IsModuleAsAlgebra( A4 ), "\n" );

## Section 2.3.3
Print( "the known attributes of B4 are:\n" );
Print( KnownAttributesOfObject( B4 ), "\n" );
M2B4 := ModuleToAlgebraIsomorphism( B4 );
Print( "M2B4 = ", M2B4, "\n" );
Print( "Source( M2B4 ) = M4? ", Source( M2B4 ) = M4, "\n" );
Print( "Source( M2B4 ) = V4? ", Source( M2B4 ) = V4, "\n" );
B2M4 := AlgebraToModuleIsomorphism( B4 );
Print( "B2M4 = ", B2M4, "\n" );
Print( "Range( B2M4 ) = M4? ", Range( B2M4 ) = M4, "\n" );
Print( "Range( B2M4 ) = V4? ", Range( B2M4 ) = V4, "\n" );

## Section 2.3.4
act4 := AlgebraActionByModule( A4, M4 );
Print( "the action act4 of A4 on B4 is:\n", act4, "\n" );
a4 := 2*m3 + 3*m3^2;
Print( "a4 = ", a4, ":\n" );
Print( "the image of a4 under act4 is:\n", Image( act4, a4 ), "\n" );
Print( "the image of the action act4 is:\n", Image( act4 ), "\n" );
Print( "\n" );

## Section 4.1.7
X4 := XModAlgebraByModule( A4, M4 );
Print( "Name( X4 ) = ", Name( X4 ), "\n" );
Display( X4 );

## Section 5.1.1
C4 := Cat1AlgebraOfXModAlgebra( X4 );
Print( "Name( C4 ) = ", Name( C4 ), "\n" );
Display( C4 );

## Section 2.4.1
A3B3 := DirectSumOfAlgebras( A3, B3 );;
SetName( A3B3, Concatenation( Name(A3), "(+)", Name(B3) ) );
SetDirectSumOfAlgebrasInfo( A3B3, 
  rec( algebras := [A3,B3], first := [1,Dimension(A3)+1],
       embeddings := [ ], projections := [ ] ) );;

## Section 2.4.2
Print( "\n first embedding into A3B3:\n", Embedding( A3B3, 1 ), "\n" );
Print( "second projection from A3B3:\n", Projection( A3B3, 2 ), "\n" );

## Section 2.4.3
hom := DirectSumOfAlgebraHomomorphisms( hom3, hom3 );
Print( "\nthe direct sum of hom3 with itself is:\n", hom, "\n" );

## Section 2.4.4
actMA3 := AlgebraActionByMultipliers( A3, A3, A3 );;
act5 := AlgebraActionOnDirectSum( actMA3, act3 );;
Print( "\naction of A on the direct sum of A3 and B3\n", act5, "\n" );

## Section 2.4.5
act6 := DirectSumOfAlgebraActions( act3, act4 );;
A6 := Source( act6 );
B6 := AlgebraActedOn( act6 );
Print( "\nact6 is the direct sum action of ", A6, " on ", B6, "\n" );
em3 := ImageElm( Embedding( A6, 1 ), m3 ); 
Print( "matrix m3 embeds in A6 as: ", em3, "\n" );
iem3 := ImageElm( act6, em3 );                     
Print( "the action act6 maps em3 to:\n", iem3, "\n" );
ea4 := ImageElm( Embedding( A6, 2 ), a4 );
Print( "matrix m4 embeds in A6 as: ", ea4, "\n" );
iea4 := ImageElm( act6, ea4 );
Print( "the action act6 maps ea4 to:\n", iea4, "\n" );

############################################################################
##
#E  module.g . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here