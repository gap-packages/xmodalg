#############################################################################
##
#W  module.gi                 The XMODALG package               Chris Wensley
#W                                                             
#Y  Copyright (C) 2014-2024, Zekeriya Arvasi & Alper Odabas,  
##

##############################  algebra actions  ############################ 

#############################################################################
##
#F  AlgebraActionByHomomorphism( <hom> <alg> )
##
InstallMethod( AlgebraActionByHomomorphism, 
    "for an algebra homomorphism and an algebra", true,
    [ IsAlgebraHomomorphism, IsAlgebra ], 0,
function ( hom, A )
    local C, genC;
    if not IsAlgebraAction( hom ) then
        Info( InfoXModAlg, 1, "hom is not an algebra action" );
        return fail;
    fi;
    C := Range( hom );
    genC := GeneratorsOfAlgebra( C );
    if not ( A = Source( genC[1] ) ) then
        Info( InfoXModAlg, 1, "Range(hom) not isomorphisms of A" );
        return fail;
    fi;
    SetAlgebraActionType( hom, "homomorphism" );
    SetAlgebraActedOn( hom, A );
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
        Error( "this boundary and action only defines a pre-crossed module" );
    fi;
    return PM;
end );


############################  direct sum operations  ####################### 

#############################################################################
##
#M  Embedding
##
InstallMethod( Embedding, "algebra direct sum and integer",
    [ IsAlgebra and HasDirectSumOfAlgebrasInfo, IsPosInt ],
    function( D, i )
    local info, A, imgs, hom;
    # check if exists already
    info := DirectSumOfAlgebrasInfo( D ); 
    if IsBound( info.embeddings[i] ) then
        return info.embeddings[i];
    fi;
    if not ( i in [1,2] ) then 
        Error( "require i in [1,2]" );
    fi;
    # compute the embedding
    A := info.algebras[i];
    imgs := Basis( D ){[info.first[i]..info.first[i]+Dimension(A)-1]};
    hom := AlgebraHomomorphismByImagesNC( A, D, Basis(A), imgs );
    SetIsInjective( hom, true );
    ## store information
    info.embeddings[i] := hom;
    return hom;
end);


#############################################################################
##
#M  Projection
##
InstallMethod( Projection, "algebra direct sum and integer",
    [ IsAlgebra and HasDirectSumOfAlgebrasInfo, IsPosInt ],
    function( D, i )
    local info, A, bass, dimA, dimD, imgs, hom;
    # check if exists already
    info := DirectSumOfAlgebrasInfo( D ); 
    if IsBound( info.projections[i] ) then
        return info.projections[i];
    fi;
    if not ( i in [1,2] ) then 
        Error( "require i in [1,2]" );
    fi;
    # compute the projection
    A := info.algebras[i];
    dimA := Dimension( A );
    dimD := Dimension( D );
    bass := Basis( D );
    if ( i = 1 ) then
        imgs := Concatenation( Basis( A ), 
                               List( [1..dimD-dimA], x -> Zero(A) ) );
    else
        imgs := Concatenation( List( [1..dimD-dimA], x -> Zero(A) ),
                               Basis( A ) );
    fi;
    hom := AlgebraHomomorphismByImagesNC( D, A, bass, imgs );
    SetIsSurjective( hom, true );
    ## store information
    info.projections[i] := hom;
    return hom;
end);

#############################################################################
##
#M  AlgebraActionOnDirectSum
##
InstallMethod( AlgebraActionOnDirectSum, "for two algebra actions", true,
    [ IsAlgebraAction, IsAlgebraAction ], 0,
function( act1, act2 )
    local  A, domA, genA, B1, basB1, B2, basB2, B, firstB, basB,
           eB1, eB2, genC, a, c1, c2, imc1, imc2, imB, C, act;
    A := Source( act1 );
    domA := LeftActingDomain( A );
    genA := BasisVectors( Basis( A ) );
    if not ( Source( act2 ) = A ) then
        Error( "act1, act2 must have the same source" ); 
    fi;
    B1 := AlgebraActedOn( act1 );
    basB1 := BasisVectors( Basis( B1 ) );
    B2 := AlgebraActedOn( act2 );
    basB2 := BasisVectors( Basis( B2 ) );
    B := DirectSumOfAlgebras( B1, B2 );
    firstB := [ 1, 1 + Dimension( B1 ) ];
    basB := BasisVectors( Basis( B ) );
    SetDirectSumOfAlgebrasInfo( B, 
        rec( algebras := [ B1, B2 ],
             first := firstB,
             embeddings := [ ],
             projections := [ ] ) );
    eB1 := Embedding( B, 1 );
    eB2 := Embedding( B, 2 );
    genC := [ ];
    for a in genA do
        c1 := ImageElm( act1, a );
        c2 := ImageElm( act2, a );
        imc2 := List( basB2, b -> ImageElm( eB2, ImageElm( c2, b ) ) );
        imc1 := List( basB1, b -> ImageElm( eB1, ImageElm( c1, b ) ) );
        imB := Concatenation( imc1, imc2 );
        Add( genC, LeftModuleHomomorphismByImages( B, B, basB, imB ) );
    od;
    C := AlgebraByGenerators( domA, genC );
    act := AlgebraHomomorphismByImages( A, C, genA, genC );
    SetIsAlgebraAction( act, true );
    SetAlgebraActionType( act, "direct sum" );
    return act;
end );


