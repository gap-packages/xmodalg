############################################################################
##
#W  dsum-xmod.gi               The XMODALG package           Zekeriya Arvasi
#W                                                            & Alper Odabas
#Y  Copyright (C) 2014-2025, Zekeriya Arvasi & Alper Odabas,  
##

#############################################################################
##
#M  AlgebraActionByDirectSum
##
InstallMethod( AlgebraActionByDirectSum, "for two algebra actions", true,
    [ IsAlgebraAction, IsAlgebraAction ], 0,
function( act1, act2 )
    local A1, domA, basA1, n1, A2, basA2, n2, B, basB, C1, basC1, C2, basC2, 
          A, firstA, basA, eA1, im1, eA2, im2, i, c1, j, c2, b, basC, C,
          act, b1,b2,b3,b4,b5,b6, v1,v2,v3,v4,v5,v6,v  ;
    A1 := Source( act1 );
    domA := LeftActingDomain( A1 );
    basA1 := BasisVectors( Basis( A1 ) );
    n1 := Length( basA1 );
    C1 := Range( act1 );
    basC1 := BasisVectors( Basis( C1 ) );
    B := AlgebraActedOn( act1 );
    if not ( AlgebraActedOn( act2 ) = B ) then
        Error( "act1, act2 must act on the same algebra" ); 
    fi;
    basB := BasisVectors( Basis( B ) );
    A2 := Source( act2 );
    basA2 := BasisVectors( Basis( A2 ) );
    n2 := Length( basA2 );
    C2 := Range( act2 );
    basC2 := BasisVectors( Basis( C2 ) );
    A := DirectSumOfAlgebras( A1, A2 );
    firstA := [ 1, 1 + Dimension( A1 ) ];
    SetDirectSumOfAlgebrasInfo( A, 
        rec( algebras := [ A1, A2 ],
             first := firstA,
             embeddings := [ ],
             projections := [ ] ) );
    eA1 := Embedding( A, 1 );
    im1 := List( [1..n1], i -> ImageElm( eA1, basA1[i] ) );
    eA2 := Embedding( A, 2 );
    im2 := List( [1..n2], j -> ImageElm( eA2, basA2[j] ) );
    basA := Concatenation( im1, im2 );
    for i in [1..n1] do
        c1 := Image( act1, basA1[i] );
        for j in [1..n2] do
            c2 := ImageElm( act2, basA2[j] );
            for b in basB do
                if Image(c2,Image(c1,b)) <> Image(c1,Image(c2,b)) then 
                    Error( "the actions on B do not commute" );
                fi;
            od;
        od;
    od;
    for i in [1..n1] do
        if Image( eA1, basA1[i] ) <> basA[i] then 
            Error( "unexpected image of eA1" ); 
        fi;
    od;
    for j in [1..n2] do
        if Image( eA2, basA2[j] ) <> basA[n1+j] then 
            Error( "unexpected image of eA2" ); 
        fi;
    od;
    basC1 := List( [1..n1], i -> ImageElm( act1, basA1[i] ) );
Print( "basC1 = ", basC1, "\n" );
    basC2 := List( [1..n2], j -> ImageElm( act2, basA2[j] ) );
Print( "basC2 = ", basC2, "\n" );
    basC := Concatenation( basC1, basC2 );
    C := AlgebraByGenerators( domA, basC );

    v1:=basC[1]; v2:=basC[2]; v3:=basC[3]; 
    v4:=basC[4]; v5:=basC[5]; v6:=basC[6];
    v := [v1,v2,v3,v4,v5,v6];
    b1:=basA[1]; b2:=basA[2]; b3:=basA[3];
    b4:=basA[4]; b5:=basA[5]; b6:=basA[6];
    b := [b1,b2,b3,b4,b5,b6];
    Print( "\nmultiplication table for v\n" );
        Print( List( v, g -> v1*g ), "\n" );
        Print( List( v, g -> v2*g ), "\n" );
        Print( List( v, g -> v3*g ), "\n" );
        Print( List( v, g -> v4*g ), "\n" );
        Print( List( v, g -> v5*g ), "\n" );
        Print( List( v, g -> v6*g ), "\n" );
    Print( "multiplication table for b\n" );
        Print( List( b, g -> b1*g ), "\n" );
        Print( List( b, g -> b2*g ), "\n" );
        Print( List( b, g -> b3*g ), "\n" );
        Print( List( b, g -> b4*g ), "\n" );
        Print( List( b, g -> b5*g ), "\n" );
        Print( List( b, g -> b6*g ), "\n" );


    act := AlgebraHomomorphismByImages( A, C, basA, basC );
    SetIsAlgebraAction( act, true );
    SetAlgebraActionType( act, "direct sum 2" );
    return act;
end );

#############################################################################
##
#M  DirectSumOfXModAlgebras
##
InstallMethod( DirectSumOfXModAlgebras, "for two crossed modules", true,
    [ IsXModAlgebra, IsXModAlgebra ], 0,
function( X1, X2 )
    local  S1, basS1, nS1, R1, basR1, nR1, bdy1, act1, dom,
           S2, basS2, nS2, R2, basR2, nR2, bdy2, act2,
           bdy12, S12, eS1, imS1, pS1, eS2, imS2, pS2, basS12,
           R12, eR1, imR1, pR1, eR2, imR2, pR2, basR12,
           basQ12, i, r, pr, hpr, imh, j, s, ps, hps, h, 
           Q12, act12, X12;
    S1 := Source( X1 );
    basS1 := CanonicalBasis( S1 );
    nS1 := Length( basS1 );
    R1 := Range( X1 );
    basR1 := CanonicalBasis( R1 );
    nR1 := Length( basR1 );
    bdy1 := Boundary( X1 );
    act1 := XModAlgebraAction( X1 );
    dom := LeftActingDomain( S1 );
    S2 := Source( X2 );
    if not ( LeftActingDomain( S1 ) = dom ) then
        Error( "conflicting domains" );
    fi;
    basS2 := CanonicalBasis( S2 );
    nS2 := Length( basS2 );
    R2 := Range( X2 );
    basR2 := CanonicalBasis( R2 );
    nR2 := Length( basR2 );
    bdy2 := Boundary( X2 );
    act2 := XModAlgebraAction( X2 );
    ## now construct the combined boundary
    bdy12 := DirectSumOfAlgebraHomomorphisms( bdy1, bdy2 );
    S12 := Source( bdy12 );
    eS1 := Embedding( S12, 1 );
    imS1 := List( [1..nS1], i -> ImageElm( eS1, basS1[i] ) );
    pS1 := Projection( S12, 1 );
    eS2 := Embedding( S12, 2 );
    imS2 := List( [1..nS2], i -> ImageElm( eS2, basS2[i] ) );
    pS2 := Projection( S12, 2 );
    basS12 := Concatenation( imS1, imS2 );
    R12 := Range( bdy12 );
    eR1 := Embedding( R12, 1 );
    imR1 := List( [1..nR1], i -> ImageElm( eR1, basR1[i] ) );
    pR1 := Projection( R12, 1 );
    eR2 := Embedding( R12, 2 );
    imR2 := List( [1..nR2], i -> ImageElm( eR2, basR2[i] ) );
    pR2 := Projection( R12, 2 );
    basR12 := Concatenation( imR1, imR2 );
    ## now construct the combined action
    basQ12 := ListWithIdenticalEntries( nR1+nR2, 0 );
    for i in [1..nR1] do
        r := imR1[i];
        pr := ImageElm( pR1, r );
        hpr := ImageElm( act1, pr );
        imh := ListWithIdenticalEntries( nS1, 0 );
        for j in [1..nS1] do
            s := imS1[j];
            ps := ImageElm( pS1, s );
            hps := ImageElm( hpr, ps );
            imh[j] := ImageElm( eS1, hps );
        od;
        imh := Concatenation( imh, imS2 );
        h := AlgebraGeneralMappingByImages( S12, S12, basS12, imh );
Error("here");
        basQ12[i] := h;
    od;
Error("here");
    Q12 := AlgebraByGenerators( dom, basQ12 );
    act12 := AlgebraGeneralMappingByImages( R12, Q12, basR12, basQ12 );
    X12 := PreXModAlgebraByBoundaryAndAction( bdy12, act12 );
##    SetIsXModAlgebra( X12, true );
    return X12;
end );

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
    B := DirectSumOfAlgebrasWithInfo( B1, B2 );
    eB1 := Embedding( B, 1 );
    eB2 := Embedding( B, 2 );
    A := DirectSumOfAlgebrasWithInfo( A1, A2 );
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
#M  AlgebraHomomorphismFromDirectSum
##
InstallMethod( AlgebraHomomorphismFromDirectSum, 
    "for two algebra homomorphisms",
    [ IsAlgebraHomomorphism, IsAlgebraHomomorphism ],
    function( hom1, hom2 )
    local B1, A, gen1, im1, B2, gen2, im2,
          dom, B, eB1, eB2, genB, imhom, hom;
    B1 := Source( hom1 );
    A := Range( hom1 );
    gen1 := GeneratorsOfAlgebra( B1 );
    im1 := List( gen1, g -> ImageElm( hom1, g ) );
    B2 := Source( hom2 );
    if not ( A = Range( hom2 ) ) then
        Error( "hom1 and hom2 should have the same range" );
    fi;
    gen2 := GeneratorsOfAlgebra( B2 );
    im2 := List( gen2, g -> ImageElm( hom2, g ) );
    dom := LeftActingDomain( B1 );
    if not ( dom = LeftActingDomain( B2 ) ) then
        Error( "homomorphisms are over different domains" );
    fi;
    B := DirectSumOfAlgebrasWithInfo( B1, B2 );
    eB1 := Embedding( B, 1 );
    eB2 := Embedding( B, 2 );
    genB := Concatenation( List( gen1, b -> ImageElm( eB1, b ) ),
                           List( gen2, b -> ImageElm( eB2, b ) ) );
Print( "genB = ", genB, "\n" );
    imhom := Concatenation( im1, im2 );
Print( "imhom = ", imhom, "\n" );
Error("here");
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
## Print( "B = ", B, "\n", "has zero ", Zero(B), "\n" );
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
##    zB1 := imB1;
##    zB2 := imB2;
## Print( "zB1 = ", zB1, "\n" );
## Print( "zB2 = ", zB2, "\n" );
    for i in [1..nC1] do
        ## c := ImageElm( act1, basA1[i] );
        c := basC1[i];
        imc := List( basB1, b -> ImageElm( eB1, ImageElm( c, b ) ) );
        imc := Concatenation( imc, zB2 );
## Print( "\nimc1 = ", imc,  "\n\n" );
        hom := LeftModuleHomomorphismByImages( B, B, basB, imc );
## Error("here");
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
## Print( "\nimc2 = ", imc, "\n\n" );
        hom := LeftModuleHomomorphismByImages( B, B, basB, imc );
        basC[nC1+i] := hom;
    od;

## Print( "\nbasC = ", basC, "\n\n" );

    C := AlgebraByGenerators( domA, basC );
    act := AlgebraGeneralMappingByImages( A, C, basA, basC );
    SetIsAlgebraAction( act, true );
    SetAlgebraActedOn( act, B );
    SetAlgebraActionType( act, "direct sum" );
## Error("here");
    return act;
end );

#############################################################################
##
#M  DirectSumOfXModAlgebras
##
InstallMethod( DirectSumOfXModAlgebras, "for two crossed modules", true,
    [ IsXModAlgebra, IsXModAlgebra ], 0,
function( X1, X2 )
    local  S1, basS1, nS1, R, basR, nR, bdy1, act1, dom,
           S2, basS2, nS2, bdy2, act2, bdy12, act12, X12, ok;
    S1 := Source( X1 );
    basS1 := CanonicalBasis( S1 );
    nS1 := Length( basS1 );
    R := Range( X1 );
    basR := CanonicalBasis( R );
    nR := Length( basR );
    bdy1 := Boundary( X1 );
    act1 := XModAlgebraAction( X1 );
    dom := LeftActingDomain( S1 );
    S2 := Source( X2 );
    if not ( LeftActingDomain( S1 ) = dom ) then
        Error( "conflicting domains" );

    fi;
    basS2 := CanonicalBasis( S2 );
    nS2 := Length( basS2 );
    if not ( R = Range( X2 ) ) then
        Error( "X1, X2 do not have a common range" );
    fi;
    bdy2 := Boundary( X2 );
    act2 := XModAlgebraAction( X2 );
    ## now construct the combined boundary
    bdy12 := DirectSumOfAlgebraHomomorphisms( bdy1, bdy2 );
    act12 := AlgebraActionOnDirectSum( act1, act2 );
    X12 := PreXModAlgebraByBoundaryAndAction( bdy12, act12 );
    ok := IsPreXModAlgebra( X12 );
    Print( "X12 is a pre-crossed module of algebras? ", ok, "\n" );
    ok := IsXModAlgebra( X12 );
    Print( "X12 is a crossed module of algebras? ", ok, "\n" );
    return X12;
end );
