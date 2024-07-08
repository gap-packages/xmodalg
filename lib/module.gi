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
#M  DirectSumOfAlgebraHomomorphisms
##
InstallMethod( DirectSumOfAlgebraHomomorphisms, 
    "for two algebra homomorphisms",
    [ IsAlgebraHomomorphism, IsAlgebraHomomorphism ],
    function( hom1, hom2 )
    local B1, A1, gen1, im1, B2, A2, gen2, im2,
          dom, B, eB1, eB2, genB, A, eA1, eA2, imhom, hom;
    B1 := Source( hom1 );
    A1 := Range( hom1 );
    gen1 := GeneratorsOfAlgebra( B1 );
    im1 := List( gen1, g -> ImageElm( hom1, g ) );
    B2 := Source( hom2 );
    A2 := Range( hom2 );
    gen2 := GeneratorsOfAlgebra( B2 );
    im2 := List( gen2, g -> ImageElm( hom2, g ) );
    dom := LeftActingDomain( B1 );
    if not ( dom = LeftActingDomain( B2 ) ) then
        Error( "homomorphisms are over different domains" );
    fi;
    B := DirectSumOfAlgebras( B1, B2 );
    if HasName( B1 ) and HasName( B2 ) then 
        SetName( B, Concatenation( Name(B1), "(+)", Name(B2) ) );
    fi;
    SetDirectSumOfAlgebrasInfo( B, 
        rec( algebras := [ B1, B2 ],
             first := [ 1, 1 + Dimension( B1 ) ],
             embeddings := [ ],
             projections := [ ] ) );
    eB1 := Embedding( B, 1 );
    eB2 := Embedding( B, 2 );
    A := DirectSumOfAlgebras( A1, A2 );
    if HasName( A1 ) and HasName( A2 ) then 
        SetName( A, Concatenation( Name(A1), "(+)", Name(A2) ) );
    fi;
    SetDirectSumOfAlgebrasInfo( A, 
        rec( algebras := [ A1, A2 ],
             first := [ 1, 1 + Dimension( A1 ) ],
             embeddings := [ ],
             projections := [ ] ) );
    eA1 := Embedding( A, 1 );
    eA2 := Embedding( A, 2 );
    genB := Concatenation( List( gen1, b -> ImageElm( eB1, b ) ),
                           List( gen2, b -> ImageElm( eB2, b ) ) );
    imhom := Concatenation( List( im1, a -> ImageElm( eA1, a ) ),
                            List( im2, a -> ImageElm( eA2, a ) ) );
    hom := AlgebraHomomorphismByImages( B, A, genB, imhom );
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
    SetAlgebraActedOn( act, B );
    SetAlgebraActionType( act, "on direct sum 1" );
    return act;
end );

#############################################################################
##
#M  DirectSumOfAlgebraActions
##
InstallMethod( DirectSumOfAlgebraActions, "for two algebra actions", true,
    [ IsAlgebraAction, IsAlgebraAction ], 0,
function( act1, act2 )
    local domA, A1, basA1, nA1, A2, basA2, nA2, A, basA, firstA,
          B1, basB1, nB1, B2, basB2, nB2, B, basB, firstB, zB, zB1, zB2,
          C1, basC1, nC1, C2, basC2, nC2, C, basC, c, imc, hom,
          eA1, imA1, eA2, imA2, eB1, imB1, eB2, imB2, i, act;
    A1 := Source( act1 );
    domA := LeftActingDomain( A1 );
    basA1 := BasisVectors( Basis( A1 ) );
    nA1 := Length( basA1 );
    B1 := AlgebraActedOn( act1 );
    basB1 := BasisVectors( Basis( B1 ) );
    nB1 := Length( basB1 );
    C1 := Range( act1 );
    basC1 := BasisVectors( Basis( C1 ) );
    nC1 := Length( basC1 );
    A2 := Source( act2 );
    if not ( domA = LeftActingDomain( A2 ) ) then 
        Error( "act1 and act2 have different left acting domains" );
    fi;
    basA2 := BasisVectors( Basis( A2 ) );
    nA2 := Length( basA2 );
    B2 := AlgebraActedOn( act2 );
    basB2 := BasisVectors( Basis( B2 ) );
    nB2 := Length( basB2 );
    C2 := Range( act2 );
    basC2 := BasisVectors( Basis( C2 ) );
    nC2 := Length( basC2 );
    A := DirectSumOfAlgebras( A1, A2 );
    if HasName( A1 ) and HasName( A2 ) then 
        SetName( A, Concatenation( Name(A1), "(+)", Name(A2) ) );
    fi;
    firstA := [ 1, 1 + Dimension( A1 ) ];
    SetDirectSumOfAlgebrasInfo( A, 
        rec( algebras := [ A1, A2 ],
             first := firstA,
             embeddings := [ ],
             projections := [ ] ) );
    eA1 := Embedding( A, 1 );
    imA1 := List( [1..nA1], i -> ImageElm( eA1, basA1[i] ) );
    eA2 := Embedding( A, 2 );
    imA2 := List( [1..nA2], j -> ImageElm( eA2, basA2[j] ) );
    basA := Concatenation( imA1, imA2 );
    B := DirectSumOfAlgebras( B1, B2 );
    if HasName( B1 ) and HasName( B2 ) then 
        SetName( B, Concatenation( Name(B1), "(+)", Name(B2) ) );
    fi;
    firstB := [ 1, 1 + Dimension( B1 ) ];
    SetDirectSumOfAlgebrasInfo( B, 
        rec( algebras := [ B1, B2 ],
             first := firstB,
             embeddings := [ ],
             projections := [ ] ) );
    eB1 := Embedding( B, 1 );
    imB1 := List( [1..nB1], i -> ImageElm( eB1, basB1[i] ) );
    eB2 := Embedding( B, 2 );
    imB2 := List( [1..nB2], j -> ImageElm( eB2, basB2[j] ) );
    basB := Concatenation( imB1, imB2 );
    basC := ListWithIdenticalEntries( nC1+nC2, 0 );
    zB := Zero( B );
    zB1 := List( [1..nB1], i -> zB );
    zB2 := List( [1..nB2], i -> zB );
    for i in [1..nC1] do
        ## c := ImageElm( act1, basA1[i] );
        c := basC1[i];
        imc := List( basB1, b -> ImageElm( eB1, ImageElm( c, b ) ) );
        imc := Concatenation( imc, zB2 );
        hom := LeftModuleHomomorphismByImages( B, B, basB, imc );
        if ( hom = fail ) then 
            Print( "!!!  hom = fail  !!!\n" );
        fi;
        basC[i] := hom;
    od;
    for i in [1..nC2] do
        ## c := ImageElm( act2, basA2[i] );
        c := basC2[i];
        imc := List( basB2, b -> ImageElm( eB2, ImageElm( c, b ) ) );
        imc := Concatenation( zB1, imc );
        hom := LeftModuleHomomorphismByImages( B, B, basB, imc );
        basC[nC1+i] := hom;
    od;

    C := AlgebraByGenerators( domA, basC );
    act := AlgebraGeneralMappingByImages( A, C, basA, basC );
    SetIsAlgebraAction( act, true );
    SetAlgebraActedOn( act, B );
    SetAlgebraActionType( act, "direct sum" );
    return act;
end );

#############################################################################
##
#M  DirectSumOfXModAlgebras
##
InstallMethod( DirectSumOfXModAlgebras, "for two crossed modules", true,
    [ IsXModAlgebra, IsXModAlgebra ], 0,
function( X1, X2 )
    local  bdy1, act1, bdy2, act2, bdy, act, X12;
    bdy1 := Boundary( X1 );
    act1 := XModAlgebraAction( X1 );
    bdy2 := Boundary( X2 );
    act2 := XModAlgebraAction( X2 );
    bdy := DirectSumOfAlgebraHomomorphisms( bdy1, bdy2 );
    act := DirectSumOfAlgebraActions( act1, act2 );
    X12 := PreXModAlgebraByBoundaryAndActionNC( bdy, act );
    SetIsXModAlgebra( X12, true );
    return X12;
end );
