############################################################################
##
#W  module3.g            XModAlg example files                 Chris Wensley 
## 

LoadPackage( "xmodalg" );

## Chapter 2, Section 2.2.3
m := [ [0,1,0], [0,0,1], [1,0,0] ];
Print( "m = ", m, "\n" );
A3 := Algebra( Rationals, [m] );
SetName( A3, "A3" );;
V3 := Rationals^3;;
M3 := LeftAlgebraModule( A3, \*, V3 );
SetName( M3, "M3" );
famM3 := ElementsFamily( FamilyObj( M3 ) );;
v := [3,4,5];;
v2 := ObjByExtRep( famM3, v );
Print( "v = ", v, ",  v2 = ", v2, "\n" );
Print( "m*v2 = ", m*v2, "\n" );
genM3 := GeneratorsOfLeftModule( M3 );;
u2 := 6*genM3[1] + 7*genM3[2] + 8*genM3[3];
u := ExtRepOfObj( u2 );
Print( "u2 = ", u2, ",  u = ", u, "\n" );

## Chapter 2, Section 2.2.4
D3 := LeftActingDomain( M3 );;
T3 := EmptySCTable( Dimension(M3), Zero(D3), "symmetric" );;
B3a := AlgebraByStructureConstants( D3, T3 );
Print( "B3a = ", B3a, "\n" );
Print( "B3a has generators: ", GeneratorsOfAlgebra( B3a ), "\n" );
B3 := ModuleAsAlgebra( M3 );             
Print( "B3 has name: ", Name( B3 ), "\n" );
Print( "B3 has generators: ", GeneratorsOfAlgebra( B3 ), "\n" );

## Chapter 2, Section 2.2.5
Print( "IsModuleAsAlgebra( B3 )? ", IsModuleAsAlgebra( B3 ), "\n" );
Print( "IsModuleAsAlgebra( A3 )? ", IsModuleAsAlgebra( A3 ), "\n" );

## Chapter 2, Section 2.2.6
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

## Chapter 2, Section 2.2.7
act3 := AlgebraActionByModule( A3, M3 );
Print( "the action act3 of A3 on B3 is:\n", act3, "\n" );
genA3 := GeneratorsOfAlgebra( A3 );;
a := 2*m + 3*m^2;
Print( "a = ", a, ":\n" );
Print( "the image of a under act3 is:\n", Image( act3, a ), "\n" );
Print( "the image of the action act3 is:\n", Image( act3 ), "\n" );
Print( "\n" );

## Chapter 4, Section 4.1.7
X3 := XModAlgebraByModule( A3, M3 );
Print( "Name( X3 ) = ", Name( X3 ), "\n" );
Display( X3 );


############################################################################
##
#E  module3.g . . . . . . . . . . . . . . . . . . . . . . . . . . ends here