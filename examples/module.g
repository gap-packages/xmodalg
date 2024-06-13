############################################################################
##
#W  module.g             XModAlg example files                 Chris Wensley 
## 

LoadPackage( "xmodalg" );

## Chapter 2, Section 2.2.3
A := Rationals^[3,3];;
SetName( A, "Q[3,3]" );;
V := Rationals^3;;
M := LeftAlgebraModule( A, \*, V );
SetName( M, "M" );
famM := ElementsFamily( FamilyObj( M ) );;
v := [3,4,5];;
v2 := ObjByExtRep( famM, v );
Print( "v = ", v, ",  v2 = ", v2, "\n" );
m := [ [0,1,0], [0,0,1], [1,0,0] ];;
Print( "m = ", m, "\n" );
Print( "m*v2 = ", m*v2, "\n" );
genM := GeneratorsOfLeftModule( M );;
u2 := 6*genM[1] + 7*genM[2] + 8*genM[3];
u := ExtRepOfObj( u2 );
Print( "u2 = ", u2, ",  u = ", u, "\n" );

## Chapter 2, Section 2.2.4
D := LeftActingDomain( M );;
T := EmptySCTable( Dimension(M), Zero(D), "symmetric" );;
B1 := AlgebraByStructureConstants( D, T );
Print( "B1 = ", B1, "\n" );
Print( "B1 has generators: ", GeneratorsOfAlgebra( B1 ), "\n" );
B := ModuleAsAlgebra( M );             
Print( "B has name: ", B, "\n" );
Print( "B has generators: ", GeneratorsOfAlgebra( B ), "\n" );

## Chapter 2, Section 2.2.5
Print( "IsModuleAsAlgebra( B )? ", IsModuleAsAlgebra( B ), "\n" );
Print( "IsModuleAsAlgebra( A )? ", IsModuleAsAlgebra( A ), "\n" );

## Chapter 2, Section 2.2.6
Print( "the known attributes of B are:\n" );
Print( KnownAttributesOfObject( B ), "\n" );
M2B := ModuleToAlgebraIsomorphism( B );
Print( "M2B = ", M2B, "\n" );
Print( "Source( M2B ) = M? ", Source( M2B ) = M, "\n" );
Print( "Source( M2B ) = V? ", Source( M2B ) = V, "\n" );
B2M := AlgebraToModuleIsomorphism( B );
Print( "B2M = ", B2M, "\n" );
Print( "Range( B2M ) = M? ", Range( B2M ) = M, "\n" );
Print( "Range( B2M ) = V? ", Range( B2M ) = V, "\n" );

## Chapter 2, Section 2.2.7
act := AlgebraActionByModule( A, M );
Print( "the action act of A on B is:\n", act, "\n" );
genA := GeneratorsOfAlgebra(A);;
m := 5*genA[1] - 4*genA[2] + 3*genA[3];
Print( "m = ", m, ":\n" );
Print( "the image of m under act is: ", Image( act, m ), "\n" );
Print( "the image of the action act is:\n", Image(act ), "\n" );

############################################################################
##
#E  module.g  . . . . . . . . . . . . . . . . . . . . . . . . . . ends here