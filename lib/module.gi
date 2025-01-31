#############################################################################
##
#W  module.gi                 The XMODALG package               Chris Wensley
#W                                                             
#Y  Copyright (C) 2014-2025, Zekeriya Arvasi & Alper Odabas,  
##

##############################  algebra actions  ############################ 

#############################################################################
##
#F  AlgebraActionByHomomorphism( <hom> <alg> )
##
InstallMethod( AlgebraActionByHomomorphism, 
    "for an algebra homomorphism and an algebra", true,
    [ IsAlgebraHomomorphism, IsAlgebra ], 0,
function ( hom, B )
    local C, genC;
    if not IsAlgebraAction( hom ) then
        Info( InfoXModAlg, 1, "hom is not an algebra action" );
        return fail;
    fi;
    C := Range( hom );
    genC := GeneratorsOfAlgebra( C );
    if not ( B = Source( genC[1] ) ) then
        Info( InfoXModAlg, 1, "Range(hom) not isomorphisms of B" );
        return fail;
    fi;
    SetAlgebraActionType( hom, "homomorphism" );
    SetAlgebraActedOn( hom, B );
    return hom;
end );

#############################  module operations  ########################### 

#############################################################################
##
#M  ModuleAsAlgebra
##
InstallMethod( ModuleAsAlgebra, "baseric method for a module", true,
    [ IsLeftModule ], 0,
function( M )
    local D, z, genM, num, L, T, B, genB, V, genV, MtoB, BtoM;
    D := LeftActingDomain( M );
    z := Zero( D );
    genM := List( GeneratorsOfLeftModule( M ), g -> ExtRepOfObj(g) );
    num := Length( genM );
    if HasIsAlgebraModule( M ) and IsAlgebraModule( M ) then 
        V := UnderlyingLeftModule( M );
        genV := GeneratorsOfLeftModule( V );
        L := List( genV, v -> Concatenation( "[", String(v), "]" ) );
    else
        L := List( genM, v -> Concatenation( "[", String(v), "]" ) );
    fi;
    T := EmptySCTable( num, z, "symmetric" ); 
    B := AlgebraByStructureConstants( D, T, L );
    SetIsModuleAsAlgebra( B, true );
    genB := GeneratorsOfAlgebra( B );
    if HasIsAlgebraModule( M ) and IsAlgebraModule( M ) then
        MtoB := LeftModuleHomomorphismByImages( V, B, genV, genB );
        BtoM := LeftModuleHomomorphismByImages( B, V, genB, genV );
    else
        MtoB := LeftModuleHomomorphismByImages( M, B, genM, genB );
        BtoM := LeftModuleHomomorphismByImages( B, M, genB, genM );
    fi;
    SetModuleToAlgebraIsomorphism( B, MtoB );
    SetAlgebraToModuleIsomorphism( B, BtoM );
    if HasName( M ) then 
        SetName( B, Concatenation( "A(", Name(M), ")" ) ); 
    fi;
    return B;
end );

#############################################################################
##
#F  IsModuleAsAlgebra( <A> )
##
InstallMethod( IsModuleAsAlgebra, "for an algebra", true, [ IsAlgebra ], 0,
function( A )
    return HasModuleToAlgebraIsomorphism( A );
end ); 

#############################################################################
##
#F  AlgebraActionByModule( <A>, <M> )
##
InstallMethod( AlgebraActionByModule,
    "for an algebra and an algebra module", true, 
    [ IsAlgebra, IsLeftModule ], 0,
function( A, M )
    local DA, genA, dimA, famM, B, genB, dimB, M2B, B2M, imact, i, a, imi, 
          j, v, m, C, act;
    DA := LeftActingDomain( A );
    genA := GeneratorsOfAlgebra( A );
    dimA := Length( genA );
    famM := ElementsFamily( FamilyObj( M ) );
    B := ModuleAsAlgebra( M );
    genB := GeneratorsOfAlgebra( B );
    dimB := Length( genB );
    M2B := ModuleToAlgebraIsomorphism( B );
    B2M := AlgebraToModuleIsomorphism( B );
    imact := ListWithIdenticalEntries( dimA, 0 ); 
    for i in [1..dimA] do 
        a := genA[i];
        imi := ListWithIdenticalEntries( dimB, 0 );
        for j in [1..dimB] do
            v := Image( B2M, genB[j] );
            m := ObjByExtRep( famM, v );
            imi[j] := Image( M2B, ExtRepOfObj( a^m ) );
        od;
        imact[i] := AlgebraGeneralMappingByImages( B, B, genB, imi );
    od;
    C := AlgebraByGenerators( DA, imact );
    if HasName( B ) then
        SetName( C, Concatenation( "Act(", Name(B), ")" ) );
    fi;
    act := AlgebraGeneralMappingByImages( A, C, genA, imact );
    SetIsAlgebraAction( act, true );
    SetAlgebraActedOn( act, B );
    SetAlgebraActionType( act, "module" );
    return act;
end );

#############################################################################
##
#M  XModAlgebraByModule
##
InstallMethod( XModAlgebraByModule, "crossed module from module", true,
    [ IsAlgebra, IsLeftModule ], 0,
function( A, M )
    local  genM, zA, B, genB, dimB, imbdy, bdy, PM, act;
    genM := GeneratorsOfLeftModule( M );
    zA := Zero( A );
    B := ModuleAsAlgebra( M ); 
    genB := GeneratorsOfAlgebra( B );
    dimB := Length( genB );
    imbdy := ListWithIdenticalEntries( dimB, zA );
    bdy := AlgebraHomomorphismByImages( B, A, genB, imbdy );
    act := AlgebraActionByModule( A, M );
    PM := PreXModAlgebraByBoundaryAndAction( bdy, act );
    if not IsXModAlgebra( PM ) then
        Error( "this boundary and action only define a pre-crossed module" );
    fi;
    return PM;
end );
