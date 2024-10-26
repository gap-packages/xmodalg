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
c3 := Group( (1,2,3) );;
Rc3 := GroupRing( Rationals, c3 );;
SetName( Rc3, "GR(c3)" );
g3 := GeneratorsOfAlgebra( Rc3 )[2];;
mg3 := RegularAlgebraMultiplier( Rc3, Rc3, g3 );;
Amg3 := AlgebraByGenerators( Rationals, [ mg3 ] );;
homg3 := AlgebraHomomorphismByImages( A3, Amg3, [ m3 ], [ mg3 ] );;
actg3 := AlgebraActionByHomomorphism( homg3, Rc3 );
Print ( "action actg3 of A3 on Rc3:\n", actg3, "\n" );

## Section 4.1.6
bdy3 := AlgebraHomomorphismByImages( Rc3, A3, [ g3 ], [ m3 ] );
Print( "bdy3 = ", bdy3, "\n" );
X3 := XModAlgebraByBoundaryAndAction( bdy3, actg3 );
Print( "crossed module X3:\n" );
Display( X3 );

## Section 2.3
m3 := [ [0,1,0], [0,0,1], [1,0,0] ];;
A3 := Algebra( Rationals, [m3] );;
SetName( A3, "A3" );;
V3 := Rationals^3;;
M3 := LeftAlgebraModule( A3, \*, V3 );;
SetName( M3, "M3" );
famM3 := ElementsFamily( FamilyObj( M3 ) );;
v3 := [3,4,5];;
Print( "initial v3 in V3 = ", v3, "\n" );
v3 := ObjByExtRep( famM3, v3 );
Print( "v3 after conversion to M3 = ", v3, "\n" );
Print( "m3*v3 = ", m3*v3, "\n" );
genM3 := GeneratorsOfLeftModule( M3 );;
u4 := 6*genM3[1] + 7*genM3[2] + 8*genM3[3];
Print( "u4 = 6*genM3[1] + 7*genM3[2] + 8*genM3[3] = ", u4, "\n" );
u4 := ExtRepOfObj( u4 );
Print( "ExtRepOfObf( u4 ) = ", u4, "\n" );

## Section 2.3.1
D3 := LeftActingDomain( M3 );;
T3 := EmptySCTable( Dimension(M3), Zero(D3), "symmetric" );;
B3a := AlgebraByStructureConstants( D3, T3 );
Print( "B3a = ", B3a, "\n" );
Print( "B3a has generators: ", GeneratorsOfAlgebra( B3a ), "\n" );
B3 := ModuleAsAlgebra( M3 );             
Print( "B3 has name: ", Name( B3 ), "\n" );
Print( "B3 has generators: ", GeneratorsOfAlgebra( B3 ), "\n" );

## Section 2.3.2
Print( "IsModuleAsAlgebra( B3 )? ", IsModuleAsAlgebra( B3 ), "\n" );
Print( "IsModuleAsAlgebra( A3 )? ", IsModuleAsAlgebra( A3 ), "\n" );

## Section 2.3.3
Print( "the known attributes of B3 are:\n" );
Print( KnownAttributesOfObject( B3 ), "\n" );
M2B3 := ModuleToAlgebraIsomorphism( B3 );
Print( "M2B3 = ", M2B3, "\n" );
Print( "Source( M2B3 ) = M3? ", Source( M2B3 ) = M3, "\n" );
Print( "Source( M2B3 ) = V3? ", Source( M2B3 ) = V3, "\n" );
B2M3 := AlgebraToModuleIsomorphism( B3 );
Print( "B2M3 = ", B2M3, "\n" );
Print( "Range( B2M3 ) = M3? ", Range( B2M3 ) = M3, "\n" );
Print( "Range( B2M3 ) = V3? ", Range( B2M3 ) = V3, "\n" );

## Section 2.3.4
act3 := AlgebraActionByModule( A3, M3 );
Print( "the action act3 of A3 on M3 is:\n", act3, "\n" );
a3 := 2*m3 + 3*m3^2;
Print( "a3 = ", a3, ":\n" );
Print( "the image of a3 under act3 is:\n", Image( act3, a3 ), "\n" );
Print( "the image of the action act3 is:\n", Image( act3 ), "\n" );
Print( "\n" );

## Section 4.1.7
X4 := XModAlgebraByModule( A3, M3 );
Print( "Name( X4 ) = ", Name( X4 ), "\n" );
Display( X4 );

## Section 5.1.1
C4 := Cat1AlgebraOfXModAlgebra( X4 );
Print( "Name( C4 ) = ", Name( C4 ), "\n" );
Display( C4 );

## Section 2.4.1
A3Rc3 := DirectSumOfAlgebras( A3, Rc3 );;
SetName( A3Rc3, Concatenation( Name(A3), "(+)", Name(Rc3) ) );
SetDirectSumOfAlgebrasInfo( A3Rc3, 
  rec( algebras := [A3,Rc3], first := [1,Dimension(A3)+1],
       embeddings := [ ], projections := [ ] ) );;

## Section 2.4.2
Print( "\n first embedding into A3Rc3:\n", Embedding( A3Rc3, 1 ), "\n" );
Print( "second projection from A3Rc3:\n", Projection( A3Rc3, 2 ), "\n" );

## Section 2.4.3
hom33 := DirectSumOfAlgebraHomomorphisms( homg3, homg3 );
Print( "\nthe direct sum of homg3 with itself is:\n", hom33, "\n" );

## Section 2.4.4
actMA3 := AlgebraActionByMultipliers( A3, A3, A3 );;
act4 := AlgebraActionOnDirectSum( actMA3, actg3 );;
Print( "\naction of A on the direct sum of A3 and Rc3\n", act4, "\n" );

## Section 2.4.5
act5 := DirectSumOfAlgebraActions( actg3, act3 );;
A5 := Source( act5 );
B5 := AlgebraActedOn( act5 );
Print( "\nact5 is the direct sum action of ", A5, " on ", B5, "\n" );
em3 := ImageElm( Embedding( A5, 1 ), m3 ); 
Print( "matrix m3 embeds in A5 as: ", em3, "\n" );
iem3 := ImageElm( act5, em3 );                     
Print( "the action act5 maps em3 to:\n", iem3, "\n" );
ea3 := ImageElm( Embedding( A5, 2 ), a3 );
Print( "element a3 embeds in A5 as: ", ea3, "\n" );
iea3 := ImageElm( act5, ea3 );
Print( "the action act5 maps ea3 to:\n", iea3, "\n" );

############################################################################
##
#E  module.g . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here