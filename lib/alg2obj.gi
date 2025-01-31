############################################################################
##
#W  alg2obj.gi                 The XMODALG package           Zekeriya Arvasi
#W                                                            & Alper Odabas
#Y  Copyright (C) 2014-2025, Zekeriya Arvasi & Alper Odabas,  
##
    
CAT1ALG_LIST_MAX_SIZE := 7;
CAT1ALG_LIST_GROUP_SIZES:=[0,0,10,20,30,40,50,60];
CAT1ALG_LIST_CLASS_SIZES := 
   [ 1, 1, 1, 2, 1, 2, 1, 5, 2, 2,
   1, 1, 1, 2, 1, 2, 1, 1, 1, 0,
   1, 1, 1, 2, 1, 2, 1, 1, 1, 0,
   1, 1, 1, 2, 0, 0, 0, 0, 0, 0,
   1, 1, 1, 2, 0, 0, 0, 0, 0, 0  ];
CAT1ALG_LIST_LOADED := false;
CAT1ALG_LIST := [ ];

##############################  2d-algebras  ############################### 

############################################################################
##
#M  Is2dAlgebraObject
##
##  InstallMethod( Is2dAlgebraObject, 
##  "generic method for 2-dimensional algebra objects",
##      true, [ IsObject ], 0,
##  function( obj )
##      return ( HasSource( obj ) and HasRange( obj ) );
##  end );

############################################################################
##
#M  Sub2dAlgebra               
##
InstallMethod( Sub2dAlgebra, "generic method for 2d-objects", true,
    [ Is2dAlgebra, IsAlgebra, IsAlgebra ], 0,
function( obj, src, rng )
    if IsXModAlgebra( obj ) then
        return SubXModAlgebra( obj, src, rng );
    elif IsPreXModAlgebra( obj ) then
        return SubPreXModAlgebra( obj, src, rng );
    elif IsCat1Algebra( obj) then
        return SubCat1Algebra( obj, src, rng );
    elif IsPreCat1Algebra( obj ) then
        return SubPreCat1Algebra( obj, src, rng );
    else
        Error( "unknown type of 2d-object" );
    fi;
end );


#########################  (pre-)crossed algebras  ######################## 

###########################################################################
##
#M  IsPreXModAlgebra        check that the first crossed module axiom holds
##
InstallMethod( IsPreXModAlgebra, "generic method for pre-crossed modules",
    true, [ Is2dAlgebra ], 0,
function( P )

    local R, S, bdy, act, basR, basS, i, j, r, m, s, ims, acts, z1, z2;

    if not IsPreXModAlgebraObj( P ) then
        return false;
    fi;
    R := Range( P );
    S := Source( P );
    bdy := Boundary( P );
    act := XModAlgebraAction( P );
    # Check  P.boundary: P.source -> P.range
    if not ( ( Source( bdy ) = S ) and ( Range( bdy ) = R ) ) then
        Info( InfoXModAlg, 1, "source/range error" );
        return false;
    fi;
    # checking
    if not IsAlgebraHomomorphism( bdy ) then
        Info( InfoXModAlg, 1, "bdy is not a homomorphism" );
        return false;
    fi;
    if not ( ( Source( act ) = R ) ) then
        Info( InfoXModAlg, 1, "Source( act ) <> R" );
        return false;
    fi; 
    basR := CanonicalBasis( R );
    basS := CanonicalBasis( S ); 
    for i in [1..Length(basR)] do
        r := basR[i]; 
        m := ImageElm( act, r );
        for j in [1..Length(basS)] do
            s := basS[j]; 
            ims := Image( bdy, s ); 
            acts := Image( m, s );
            z1 := ImageElm( bdy, acts ); 
            z2 := r * ims; 
            if not ( z1 = z2 ) then
                Info( InfoXModAlg, 1, "XModAlg1: ", z1, " <> ", z2 );
                return false; 
            fi;
        od; 
    od; 
    return true;
end );

###########################################################################
##
#M  XModAlgebraObj( <bdy>, <act> )  . . . . . . . make a pre-crossed module
#M  XModAlgebraObjNC( <bdy>, <act> )  . . . . . . make a pre-crossed module
##
InstallMethod( XModAlgebraObjNC, "for homomorphism and action", true,
    [ IsAlgebraHomomorphism, IsAlgebraAction ], 0,
function( bdy, act )

    local A, B, DA, DB, type, PM, AB, BB;
    type := PreXModAlgebraObjType;
    B := Source( bdy );
    A := Range( bdy );
    DA := LeftActingDomain( A );
    DB := LeftActingDomain( B );
    if not ( DA = DB ) then 
        Error( "conflicting domains" );
    fi;
    AB := Source( act );
    BB := Range( act );
    if ( IsLeftModuleGeneralMapping( act ) = true ) then
        if not ( A = AB ) then
            Error( "require Range( bdy ) = Source( act )" );
        fi;
    else
        if not ( B = BB ) then
            return fail;
        fi;
    fi;
    ## create the object
    PM := rec();
    ObjectifyWithAttributes( PM, type,
        Source, B,
        Range, A,
        Boundary, bdy,
        XModAlgebraAction, act,
        LeftActingDomain, DA,
        IsPreXModDomain, true,
        Is2dAlgebraObject, true );
    return PM;
end );

InstallMethod( XModAlgebraObj, "for homomorphism and action", true,
    [ IsAlgebraHomomorphism, IsAlgebraAction ], 0,
function( bdy, act )
    local PM;
    PM := XModAlgebraObjNC( bdy, act );
    ## check axiom XModAlg1
    if not IsPreXModAlgebra( PM ) then
        return fail;
    fi;
    return PM;
end );

############################################################################
##
#M  \=( <P>, <Q> )  . . . . . . .  test if two pre-crossed modules are equal
##
InstallMethod( \=, "generic method for two pre-crossed modules of algebras",
    IsIdenticalObj, [ IsPreXModAlgebra, IsPreXModAlgebra ], 0,
function ( P, Q )
    
    local  S, R, aP, aQ, gR, gS, s, r, im1, im2;

    if not ( Boundary( P ) = Boundary( Q ) ) then
        return false;
    fi;
    S := Source(Boundary(P));
    R := Range(Boundary(P));
    aP := XModAlgebraAction(P);
    aQ := XModAlgebraAction(Q);
    ##    if not ( Range( aP ) = Range( aQ ) ) then
    ##        return false;
    ##    fi;
    ##    if not ( Source( aP ) = Source( aQ ) ) then
    ##        return false;
    ##    fi;    
    ######    
    if HasGeneratorsOfAlgebra( R ) then
        gR := GeneratorsOfAlgebra( R );
    else
        gR := R;        
    fi;
    if HasGeneratorsOfAlgebra( S ) then
        gS := GeneratorsOfAlgebra( S );
    else
        gS := S;        
    fi; 
    ######
    for r in gR do
        for s in gS do
        im1 := Image( aP, [r,s] );
        im2 := Image( aQ, [r,s] );
           if ( im1 <> im2 ) then
                return false;                
            fi;
        od;
    od;    
    return true;
end );

############################################################################
##
#M  ViewObj( <PM> ) . . . . . . . . . . . . . .  view a (pre-)crossed module
##
InstallMethod( ViewObj, "method for a pre-crossed module of algebras", true,
    [ IsPreXModAlgebra ], 0,
    function( PM )
    
    local  type, Pact, name, bdy, act;

    if HasName( PM ) then
        Print( Name( PM ), "\n" );
    else       
        Pact := XModAlgebraAction( PM );
        if IsLeftModuleGeneralMapping( Pact ) then
            Print( "[ " ); 
            ViewObj( Source( PM ) ); 
            Print( " -> " ); 
            ViewObj( Range( PM ) ); 
            Print( " ]" ); 
        else
            type := AlgebraActionType( Pact ); 
            if (type = "multiplier") then
                Print( "[", Source( PM ), " -> ", Range( PM ), "]" );
            fi;  
            if (type = "surjection") then
                Print( "[", Source( PM ), " -> ", Range( PM ), "]" );
            fi;
            if (type = "module") then
                Print( "[", Source( PM ), " -> ", Range( PM ), "]" );
            fi;
        fi;
    fi;
end );

############################################################################
##
#M  PrintObj( <PM> ) . . . . . . . . . . . . . . view a (pre-)crossed module
##
InstallMethod( PrintObj, "method for a pre-crossed algebra module", true,
    [ IsPreXModAlgebra ], 0,
    function( PM )
    if HasName( PM ) then
        Print( Name( PM ), "\n" );
    else
        Print( "[", Source( PM ), " -> ", Range( PM ), "]" );
    fi;
end );

############################################################################
##
#F  Display( <PM> ) . . . . . . . .  print details of a (pre-)crossed module
##
InstallOtherMethod( Display, "display a pre-crossed module of algebras", 
    true, [IsPreXModAlgebra], 0,
function( PM )

    local  name, bdy, act, aut, len, i, ispar, Xsrc, Xrng, gensrc, genrng,
           mor, triv, imact, a, Arec, Pact, type ;

    name := Name( PM );
    Xsrc := Source( PM );
    Xrng := Range( PM );
    Pact := XModAlgebraAction( PM );
    type := AlgebraActionType( Pact );
    gensrc := GeneratorsOfAlgebra( Xsrc );
    genrng := GeneratorsOfAlgebra( Xrng );
    if IsXModAlgebra( PM ) then
        Print( "Crossed module ", name, " :- \n" );
    else
        Print( "Pre-crossed module ", name, " :- \n" );
    fi;
    ispar := not HasParent( Xsrc );
    if ( ispar and HasName( Xsrc ) ) then
        Print( ": Source algebra ", Xsrc );
    elif ( ispar and HasName( Parent( Xsrc ) ) ) then
        Print( ": Source algebra has parent ( ", Parent( Xsrc), " ) and" );
    else
        Print( ": Source algebra" );
    fi;
    Print( " has generators:  " );
    Print( gensrc, "\n" );
    ispar := not HasParent( Xrng );
    if ( ispar and HasName( Xrng ) ) then
        Print( ": Range algebra ", Xrng );
    elif ( ispar and HasName( Parent( Xrng ) ) ) then
        Print( ": Range algebra has parent ( ", Parent( Xrng ), " ) and" );
    else
        Print( ": Range algebra" );
    fi;
    Print( " has generators:  " );
    Print( genrng, "\n" );
    Print( ": Boundary homomorphism maps source generators to:" );
    bdy := Boundary( PM );
    Print( List( gensrc, s -> Image( bdy, s ) ), "\n" );
end ); 

############################################################################
##
#M  Name                                               for a pre-XModAlgebra
##
InstallMethod( Name, "method for a pre-crossed module", true, 
    [ IsPreXModAlgebra ], 0,
function( PM )

    local  nsrc, nrng, name, mor;

    if HasName( Source( PM ) ) then
        nsrc := Name( Source( PM ) );
    else
        nsrc := "..";
    fi;
    if HasName( Range( PM ) ) then
        nrng := Name( Range( PM ) );
    else
        nrng := "..";
    fi;
    name := Concatenation( "[", nsrc, " -> ", nrng, "]" );
    SetName( PM, name );
    return name;
end );

############################################################################
##
#M  Dimension( <PM> ) . . . . . . . . . dimension of a 2-dimensional algebra
##
InstallOtherMethod( Dimension, "method for a 2-dimensional algebra", true,
    [ Is2dAlgebraObject ], 20,
    function( obj )
    return [ Dimension( Source( obj ) ), Dimension( Range( obj ) ) ]; 
end );

############################################################################
##
#M  IsXModAlgebra           check that the second crossed module axiom holds
##
InstallMethod( IsXModAlgebra, "generic method for pre-crossed modules",
    true, [ Is2dAlgebra ], 0,
    function( P )

    local  bdy, act, S, genS, s1, r1, m1, s2, z1, z2;

    if not ( IsPreXModAlgebraObj( P ) and IsPreXModAlgebra( P ) ) then
        return false;
    fi;
    bdy := Boundary( P );
    act := XModAlgebraAction( P );
    S := Source( bdy ); 
    genS := CanonicalBasis( S ); 
    for s1 in genS do
        r1 := ImageElm( bdy, s1 ); 
        m1 := ImageElm( act, r1 ); 
        for s2 in genS do
            z1 := ImageElm( m1, s2 ); 
            z2 := s1 * s2;
            if ( z1 <> z2 ) then                
                Info( InfoXModAlg, 1, "XModAlg2: ", z1, " <> ", z2 ); 
                return false;
            fi;
        od;
    od;
    return true;
end );

############################################################################
##
#M  PreXModAlgebraByBoundaryAndAction
#M  PreXModAlgebraByBoundaryAndActionNC
##
InstallMethod( PreXModAlgebraByBoundaryAndAction,
    "pre-crossed module from boundary and action maps",
    true, [ IsAlgebraHomomorphism, IsAlgebraAction ], 0,
function( bdy, act )
    if not ( Source( act ) = Range( bdy ) ) then 
        Info( InfoXModAlg, 1, "Source(act) <> Range(bdy)" );
        return fail;
    fi;
    return XModAlgebraObj( bdy, act );
end );

InstallMethod( PreXModAlgebraByBoundaryAndActionNC,
    "pre-crossed module from boundary and action maps",
    true, [ IsAlgebraHomomorphism, IsAlgebraAction ], 0,
function( bdy, act )
    return XModAlgebraObjNC( bdy, act );
end );

############################################################################
##
#M  XModAlgebraByBoundaryAndAction
#M  XModAlgebraByBoundaryAndActionNC
##
InstallMethod( XModAlgebraByBoundaryAndAction,
    "crossed module from boundary and action maps", true,
    [ IsAlgebraHomomorphism, IsAlgebraAction ], 0,
function( bdy, act )
    local  PM;
    PM := PreXModAlgebraByBoundaryAndAction( bdy, act );
    if not IsXModAlgebra( PM ) then
        Error( "boundary and action only define a pre-crossed module" );
    fi;
    return PM;
end );

InstallMethod( XModAlgebraByBoundaryAndActionNC,
    "crossed module from boundary and action maps", true,
    [ IsAlgebraHomomorphism, IsAlgebraAction ], 0,
function( bdy, act )
    local  PM;
    PM := PreXModAlgebraByBoundaryAndActionNC( bdy, act );
    SetIsXModAlgebra( PM, true );
    return PM;
end );

############################################################################
##
#M  XModAlgebraByMultiplierAlgebra
##
InstallMethod( XModAlgebraByMultiplierAlgebra,
    "crossed module from Multiplier algebra", true,
    [ IsAlgebra ], 0,
function( A )
    local MA, PM, act, bdy; 
    MA := MultiplierAlgebra( A ); 
    bdy := MultiplierHomomorphism( MA );
    act := IdentityMapping( MA ); 
    SetIsAlgebraAction( act, true ); 
    SetAlgebraActionType( act, "multiplier" ); 
    PM := PreXModAlgebraByBoundaryAndAction( bdy, act );
    if not IsXModAlgebra( PM ) then
        Error( "this boundary & action only define a pre-crossed module" );
    fi;
    return PM;
end );

############################################################################
##
#M  XModAlgebraBySurjection
##
InstallMethod( XModAlgebraBySurjection,
    "crossed module from Central Extension", true, [IsAlgebraHomomorphism], 0,
function( hom )
    local  PM,act,bdy;
    if not IsSurjective( hom ) then
        Error( " hom is not a surjective algebra homomorphism" ); 
    fi;
    act := AlgebraActionBySurjection( hom );
    PM := PreXModAlgebraByBoundaryAndAction( hom, act );
    if not IsXModAlgebra( PM ) then
        Error( "this boundary & action only define a pre-crossed module" );
    fi;
    return PM;
end );

############################################################################
##
#M  XModAlgebraByIdeal
##
InstallMethod( XModAlgebraByIdeal,
    "crossed module from module", true,
    [ IsAlgebra, IsAlgebra ], 0,
function( A, I )
    local PM, act, genI, bdy, AI;
    if not IsIdeal( A,I ) then
        Error( "I not a ideal" );
    fi;
    genI := GeneratorsOfAlgebra( I );
    act := AlgebraActionByMultipliers( A, I, A );
    bdy := AlgebraHomomorphismByImages( I, A, genI, genI );
    IsAlgebraAction( act );
    IsAlgebraHomomorphism( bdy );
    PM := PreXModAlgebraByBoundaryAndAction( bdy, act );
    # if not IsXModAlgebra( PM ) then
    #   Error( "this boundary & action only define a pre-crossed module" );
    # fi;
    return PM;
end );

############################################################################
##
#M  AugmentationXMod
##
InstallMethod( AugmentationXMod, "XModByIdeal using the augmentation ideal", 
    true, [ IsGroupAlgebra ], 0,
function( A )
    local AI;
    AI := AugmentationIdeal( A ); 
    return XModAlgebraByIdeal( A, AI ); 
end );

############################################################################
##
#F  XModAlgebra( <bdy>, <act> )   crossed module from given boundary & action
##
InstallGlobalFunction( XModAlgebra, function( arg )

    local  nargs;
    nargs := Length( arg );
    # two homomorphisms
    if ( ( nargs = 2 ) and IsAlgebraHomomorphism( arg[1] )
                       and IsAlgebraAction( arg[2] ) ) then
        return XModAlgebraByBoundaryAndAction( arg[1], arg[2] );
    # ideal
    elif ( ( nargs = 2 ) and IsAlgebra( arg[1] )
            and IsAlgebra( arg[2] ) and IsIdeal(arg[1],arg[2]) ) then 
        return XModAlgebraByIdeal( arg[1],arg[2] );
    # surjective homomorphism
    elif ( ( nargs = 1 ) and IsAlgebraHomomorphism( arg[1] )
                         and IsSurjective( arg[1] ) ) then
        return XModAlgebraBySurjection( arg[1] );
    # convert a cat1-algebra
    elif ( ( nargs = 1 ) and Is2dAlgebra( arg[1] ) ) then
        return XModAlgebraOfCat1Algebra( arg[1] );
    # Multiplier algebra
    elif ( ( nargs = 1 ) and IsAlgebra( arg[1] )) then
        return XModAlgebraByMultiplierAlgebra( arg[1] );
    # module
    elif ( ( nargs = 2 ) and IsAlgebra( arg[1] )
                         and IsLeftModule( arg[2] ) ) then 
        return XModAlgebraByModule( arg[1], arg[2] );
    else
        # alternatives not allowed
        Error( "usage: XModAlgebra( bdy, act ); " );
    fi;
end );

############################################################################
##
#M  IsSubPreXModAlgebra
##
InstallMethod( IsSubPreXModAlgebra, "generic method for pre-crossed modules", 
    true, [ Is2dAlgebraObject, Is2dAlgebraObject ], 0,
function( PM, SM )

    local ok, Ssrc, Srng, Psrc, Prng, gensrc, genrng, i,j, s, r, r1, r2, 
          im1, im2, basPrng, vecPrng, dimPrng, genPsrc, basPsrc, 
          maps_P, im_P, cp, actp, basSrng, vecSrng, dimSrng, genSsrc, 
          basSsrc, maps_S, im_S, cs, acts;

    if not ( IsPreXModAlgebra( PM ) and IsPreXModAlgebra( SM ) ) then
        return false;
    fi;
    if ( HasParent( SM ) and ( Parent( SM ) = PM ) ) then
        return true;
    fi;
    Ssrc := Source( SM );
    Srng := Range( SM );
    if not ( IsIdeal( Source( PM ), Ssrc ) ) then
        Info( InfoXModAlg, 3, "IsIdeal failure in IsSubPreXModAlgebra" );
        return false;
    fi;
    ok := true;
    if HasGeneratorsOfAlgebra( Ssrc ) then
        gensrc := GeneratorsOfAlgebra( Ssrc );
    else
        gensrc := Ssrc;        
    fi;
    if HasGeneratorsOfAlgebra( Srng ) then
        genrng := GeneratorsOfAlgebra( Srng );
    else
        genrng := Srng;        
    fi; 
    for s in gensrc do
        if ( Image( Boundary( PM ), s ) <> Image( Boundary( SM ), s ) ) then
            ok := false;
        fi;
    od;
    if not ok then
        Info( InfoXModAlg, 3, "boundary maps have different images" );
        return false;
    fi;
    if ( IsLeftModuleGeneralMapping(XModAlgebraAction( PM )) = true ) then
        Psrc := Source( PM ); # B
        Prng := Range( PM ); # A
        basPrng := Basis(Prng);    
        vecPrng := BasisVectors(basPrng);
        dimPrng := Dimension(Prng);
        genPsrc := GeneratorsOfAlgebra( Psrc );
        basPsrc := Basis(Psrc);
        maps_P := ListWithIdenticalEntries(dimPrng,0);
        for j in [1..dimPrng] do
            im_P := List(basPsrc, b -> vecPrng[j]*b);
            maps_P[j] := 
                LeftModuleHomomorphismByImages(Psrc,Psrc,basPsrc,im_P);
        od;
        basSrng := Basis(Srng);
        vecSrng := BasisVectors(basSrng);
        dimSrng := Dimension(Srng);
        genSsrc := GeneratorsOfAlgebra( Ssrc );
        basSsrc := Basis(Ssrc);
        maps_S := ListWithIdenticalEntries(dimSrng,0);
        for j in [1..dimSrng] do
            im_S := List(basSsrc, b -> vecSrng[j]*b);
            maps_S[j] := 
                LeftModuleHomomorphismByImages(Ssrc,Ssrc,basSsrc,im_S);
        od;
        for r in genrng do
            cp := Coefficients(basPrng,r);
            actp := Sum(List([1..dimPrng], i -> cp[i]*maps_P[i]));
            cs := Coefficients(basSrng,r);
            acts := Sum(List([1..dimSrng], i -> cs[i]*maps_S[i]));            
            for s in gensrc do
                im1 := Image( actp, s );
                im2 := Image( acts, s );
                if ( im1 <> im2 ) then
                    ok := false;
                    Info( InfoXModAlg, 3, "s,im1,im2 = ", [s,im1,im2] );
                fi;
            od;
        od;
    else    
        for r in genrng do
            for s in gensrc do
                im1 := Image( XModAlgebraAction( PM ), [r,s] );
                im2 := Image( XModAlgebraAction( SM ), [r,s] );
                if ( im1 <> im2 ) then
                    ok := false;
                    Info( InfoXModAlg, 3, "s,im1,im2 = ", [s,im1,im2] );
                fi;
            od;
        od;
    fi;
    if not ok then
        Info( InfoXModAlg, 3, "actions have different images" );
        return false;
    fi;
    if ( PM <> SM ) then
        SetParent( SM, PM );
    fi;
    return true;
end );

###########################################################################
##
#M  IsSubXModAlgebra( <XM>, <SM> )
##
InstallMethod( IsSubXModAlgebra, "generic method for crossed modules", true,
    [ Is2dAlgebraObject, Is2dAlgebraObject ], 0,
function( XM, SM )

    if not ( IsXModAlgebra( XM ) and IsXModAlgebra( SM ) ) then
        return false;
    fi;
    return IsSubPreXModAlgebra( XM, SM );
end );

###########################################################################
##
#M  SubPreXModAlgebra         creates SubPreXMod Of Algebra from Ssrc<=Psrc 
##
InstallMethod( SubPreXModAlgebra, "generic method for pre-crossed modules", 
    true, [ IsPreXModAlgebra, IsAlgebra, IsAlgebra ], 0,
function( PM, Ssrc, Srng )

    local  Psrc, Prng, Pbdy, Pact, Paut, genSsrc, genSrng, Pname, Sname,
           SM, Sbdy, Saut, Sact, i, list, f, B, K, surf, type ;

    Psrc := Source( PM );
    Prng := Range( PM );    
    if not IsSubset( Psrc, Ssrc ) then
        Print( "Ssrc is not a subalgebra of Psrc\n" );
        return fail;
    fi;
    if not IsSubset( Prng, Srng ) then
        Print( "Srng is not an subalgebra of Prng\n" );
        return fail;
    fi;
    Pbdy := Boundary( PM );
    Pact := XModAlgebraAction( PM );
    type := AlgebraActionType( Pact );
    if ( type = "multiplier" ) then
        Info( InfoXModAlg, 1, "multiplier type" );
        SM := XModAlgebraByIdeal( Srng, Ssrc );
    elif ( type = "surjection") then
        Info( InfoXModAlg, 1, "surjection type" );
        genSsrc := GeneratorsOfAlgebra( Ssrc );
        B := Range(Pbdy);
        list := [];    
        for i in genSsrc do
            Add( list, Image( Pbdy, i ) ); 
        od;
        f := AlgebraHomomorphismByImages( Ssrc, B, genSsrc, list );
        K := Image(f);
        surf := AlgebraHomomorphismByImages( Ssrc,K,genSsrc,list );
        SM := XModAlgebraBySurjection( surf );
    elif ( type = "module" ) then
        Info( InfoXModAlg, 1, "module type" );
        SM := XModAlgebraByModule( Ssrc, Srng );
    else
        Print( "Uyumsuz xmod\n" );
        return false;
    fi;
    if HasParent( PM ) then
        SetParent( SM, Parent( PM ) );
    else
        SetParent( SM, PM );
    fi;
    return SM;
end );

###########################################################################
##
#M  SubXModAlgebra . . . . creates SubXModAlgebra from Ssrc<=Psrc & Srng<=Prng
##
InstallMethod( SubXModAlgebra, "generic method for crossed modules", true,
    [ IsXModAlgebra, IsAlgebra, IsAlgebra ], 0,
function( XM, Ssrc, Srng )

    local  SM;
    SM := SubPreXModAlgebra( XM, Ssrc, Srng );
    if ( SM = fail ) then
        return fail;
    fi;
    if not IsXModAlgebra( SM ) then
        Error( "the result is only a pre-crossed module" );
    fi;
    return SM;
end );

#############################  cat1-algebras  ############################## 

############################################################################
##
#M  IsPreCat1Algebra       check that the first pre-cat1-algebra axiom holds
##
InstallMethod( IsPreCat1Algebra, "generic method for pre-cat1-algebra",
    true, [ Is2dAlgebra ], 0,
function( C1A )

    local  Csrc, Crng, x, e, t, h, idrng, he, te, kert, kerh, kerth;

    if not IsPreCat1AlgebraObj( C1A ) then
        return false;
    fi;
    Crng := Range( C1A );
    h := HeadMap( C1A );
    t := TailMap( C1A );
    e := RangeEmbedding( C1A );
    # checking the first condition of cat-1 group
    idrng := IdentityMapping( Crng );
    he := CompositionMapping( h, e );
    te := CompositionMapping( t, e );
    if not ( te = idrng ) then
        Print( "te <> range identity \n" );
        return false;
    fi;
    if not ( he = idrng ) then
        Print( "he <> range identity \n" );
        return false;
    fi;
    return true;
end );

############################################################################
##
#M  IsSubPreCat1Algebra
##
InstallMethod( IsSubPreCat1Algebra, "generic method for pre-cat1-algebras", 
    true, [ Is2dAlgebraObject, Is2dAlgebraObject ], 0,
function( C0, S0 )

    local  ok, Ssrc, Srng, gensrc, genrng, tc, hc, ec, ts, hs, es, s, r;

    if not ( IsPreCat1Algebra( C0 ) and IsPreCat1Algebra( S0 ) ) then
        return false;
    fi;
    if ( HasParent( S0 ) and ( Parent( S0 ) = C0 ) ) then
        return true;
    fi;
    Ssrc := Source( S0 );
    Srng := Range( S0 );
    if not (     IsSubset( Source( C0 ), Ssrc )
             and IsSubset( Range( C0 ), Srng ) ) then
        Info( InfoXModAlg, 3, "IsSubgroup failure in IsSubPreCat1Algebra" );
        return false;
    fi;
    ok := true;
    gensrc := GeneratorsOfAlgebra( Ssrc );
    genrng := GeneratorsOfAlgebra( Srng );
    tc := TailMap(C0);  hc := HeadMap(C0);  ec := RangeEmbedding(C0);
    ts := TailMap(S0);  hs := HeadMap(S0);  es := RangeEmbedding(S0);
    for s in gensrc do
        if ( Image( tc, s ) <> Image( ts, s ) ) then
            ok := false;
        fi;
        if ( Image( hc, s ) <> Image( hs, s ) ) then
            ok := false;
        fi;
    od;
    if not ok then
        Info( InfoXModAlg, 3, "tail/head maps have different images" );
        return false;
    fi;
    for r in genrng do
        if ( Image( ec, r ) <> Image( es, r ) ) then
            ok := false;
        fi;
    od;
    if not ok then
        Info( InfoXModAlg, 3, "embeddingss have different images" );
        return false;
    fi;
    if ( C0 <> S0 ) then
        SetParent( S0, C0 );
    fi;
    return true;
end );

############################################################################
##
#M  IsSubCat1Algebra( <C1>, <S1> )
##
InstallMethod( IsSubCat1Algebra, "generic method for cat1-algebras", true,
    [ Is2dAlgebraObject, Is2dAlgebraObject ], 0,
function( C1, S1 )

    if not ( IsCat1Algebra( C1 ) and IsCat1Algebra( S1 ) ) then
        return false;
    fi;
    return IsSubPreCat1Algebra( C1, S1 );
end );

############################################################################
##
#M  SubPreCat1  creates SubPreCat1 from PreCat1 and a subgroup of the source
##
InstallMethod( SubPreCat1Algebra, "generic method for (pre-)cat1-algebras", 
    true, [ IsPreCat1Algebra, IsAlgebra, IsAlgebra ], 0,
function( C, R, S )

    local  Csrc, Crng, Ct, Ch, Ce, t, h, e, CC, ok;

    Csrc := Source( C );
    Crng := Range( C );
    Ct := TailMap( C );
    Ch := HeadMap( C );
    Ce := RangeEmbedding( C );
    ok := true;
    if not ( ( S = Image( Ct, R ) ) and
             ( S = Image( Ch, R ) ) ) then
        Print( "restrictions of Ct, Ch to R must have common image S\n" );
        ok := false;
    fi;
    t := RestrictionMappingAlgebra( Ct, R, S );
    h := RestrictionMappingAlgebra( Ch, R, S );
    e := RestrictionMappingAlgebra( Ce, S, R );
    CC := PreCat1AlgebraByTailHeadEmbedding( t, h, e );
    if not ( C = CC ) then
        SetParent( CC, C );
    fi;
    return CC;
end );

############################################################################
##
#M  SubCat1Algebra . . . . . . creates SubCat1Algebra from Cat1Algebra 
##                             and a subalgebra of the source
##
InstallMethod( SubCat1Algebra, "generic method for cat1-algebras", true,
    [ IsCat1Algebra, IsAlgebra, IsAlgebra ], 0,
function( C, R, S )
    local  CC;
    CC := SubPreCat1Algebra( C, R, S );
    if not IsCat1Algebra( CC ) then
        Error( "result is only a pre-cat1-algebra" );
    fi;
    return CC;
end );

############################################################################
##
#M  \=( <C1>, <C2> ) . . . . . . . . . . . test if two pre-cat1-algebras are equal
##
InstallMethod( \=, "generic method for pre-cat1-algebras",
    IsIdenticalObj, [ IsPreCat1Algebra, IsPreCat1Algebra ], 0,
    function( C1, C2 )
    return ( ( TailMap( C1 ) = TailMap( C2 ) ) 
             and ( HeadMap( C1 ) = HeadMap( C2 ) )
             and ( RangeEmbedding( C1 ) = RangeEmbedding( C2 ) ) );
end );

############################################################################
##
#M  PreCat1AlgebraObj . . . . . . . . . . . . . . .  make a pre-cat1-algebra
##
InstallMethod( PreCat1AlgebraObj, "for tail, head, embedding", true,
    [ IsAlgebraHomomorphism, IsAlgebraHomomorphism, IsAlgebraHomomorphism ], 0,
    function( t, h, e )

    local  filter, fam, C1A, ok, src, rng, name;
    
    fam := Family2dAlgebra;
    filter := IsPreCat1AlgebraObj;
    if not ( ( Source(h) = Source(t) ) and ( Range(h) = Range(t) ) ) then
        Error( "tail & head must have same source and range" );
    fi;
    if not ( ( Source(e) = Range(t) ) and ( Range(e) = Source(t) ) ) then
        Error( "tail, embedding must have opposite source and range" );
    fi;
    C1A := rec();
    ObjectifyWithAttributes( C1A, NewType( fam, filter ),
        Source, Source( t ),
        Range, Range( t ),
        TailMap, t, 
        HeadMap, h, 
        RangeEmbedding, e,
        IsPreCat1Domain, true );
    SetHeadMap( C1A, h );
    SetRangeEmbedding( C1A, e );
    SetIs2dAlgebraObject( C1A, true );    
    ok := IsPreCat1Algebra( C1A );
    # name := Name( C1A );
    if not ok then
        return fail;
    fi;
##    ok := IsCat1Algebra( C1A );
    return C1A;
end );

############################################################################
##
#M  ViewObj( <C1A> ) . . . . . . . . . . . . . . . . view a pre-cat1-algebra
##
InstallMethod( ViewObj, "method for a pre-cat1-algebra", true, 
    [ IsPreCat1Algebra ], 0,
function( C1A )
    
    local Pact, type, PM;
    
    if HasName( C1A ) then
        Print( Name( C1A ), "\n" );
    else
        Print( "[", Source( C1A ), " -> ", Range( C1A ), "]" );
    fi;
end );

############################################################################
##
#M  PrintObj( <C1A> )  . . . . . . . . . . . . . view a (pre-)crossed module
##
InstallMethod( PrintObj, "method for a pre-cat1-algebra", true,
    [ IsPreCat1Algebra ], 0,
function( C1A )
    if HasName( C1A ) then
        Print( Name( C1A ), "\n" );
    else
        Print( "[", Source( C1A ), " => ", Range( C1A ), "]" );
    fi;
end );

############################################################################
##
#M  Display( <C1A> ) . . . . . . . . . . print details of a pre-cat1-algebra
##
InstallOtherMethod( Display, "display a pre-cat1-algebra", 
    true, [ IsPreCat1Algebra ], 0,
function( C1A )

    local  Csrc, Crng, Cker, gensrc, genrng, genker, name,
           t, h, e, b, k, imt, imh, ime, imb, imk, eqth;

    name := Name( C1A );
    Csrc := Source( C1A );
    gensrc := GeneratorsOfAlgebra( Csrc );
    Crng := Range( C1A );
    genrng := GeneratorsOfAlgebra( Crng );
    Cker := Kernel( C1A );
    genker := GeneratorsOfAlgebra( Cker );    
    t := TailMap( C1A );
    h := HeadMap( C1A );
    e := RangeEmbedding( C1A );
    imt := List( gensrc, x -> Image( t, x ) );
    imh := List( gensrc, x -> Image( h, x ) );
    eqth := imt = imh;
    ime := List( genrng, x -> Image( e, x ) );
    if HasXModAlgebraOfCat1Algebra(C1A) then
        if IsCat1Algebra( C1A ) then
            Print( "Cat1-algebra ", name, " :- \n" );
        else
            Print( "Pre-cat1-algebra ", name, " :- \n" );
        fi;
        Print( ":  range algebra has generators:" );
        Print( genrng, "\n" );
        if eqth then 
            Print( ": tail homomorphism = head homomorphism\n" );
            Print( "  they map the source generators to:  " );
            Print( imt, "\n" );
        else
            Print( ": tail homomorphism maps source generators to:  " );
            Print( imt, "\n" );
            Print( ": head homomorphism maps source generators to:  " );
            Print( imh, "\n" );
        fi;
        Print( ": range embedding maps range generators to:  " );
        Print( "  ", ime, "\n" );
        if ( Size( Cker ) = 1 ) then
            Print( ": the kernel is trivial.\n" );
        else
            Print( ": kernel has generators:  " );
            Print( genker, "\n" );
        fi;    
    else
        b := Boundary( C1A );
        k := KernelEmbedding( C1A );
        imb := List( genker, x -> Image( b, x ) );
        imk := List( genker, x -> Image( k, x ) );

        if IsCat1Algebra( C1A ) then
            Print( "Cat1-algebra ", name, " :- \n" );
        else
            Print( "Pre-cat1-algebra ", name, " :- \n" );
        fi;
        Print( ": source algebra has generators: \n" );
        Print( gensrc, "\n" );
        Print( ":  range algebra has generators: \n" );
        Print( genrng, "\n" );
        Print( ": tail homomorphism maps source generators to: \n" );
        Print( imt, "\n" );
        Print( ": head homomorphism maps source generators to: \n" );
        Print( imh, "\n" );
        Print( ": range embedding maps range generators to: \n" );
        Print( ime, "\n" );
        if ( Size( Cker ) = 1 ) then
            Print( ": the kernel is trivial.\n" );
        else
            Print( ": kernel has generators: " );
            Print( genker, "\n" );
            Print( ": boundary homomorphism maps generators of kernel to:  \n" );
            Print( imb, "\n" );
            Print( ": kernel embedding maps generators of kernel to: \n" );
            Print( imk, "\n" );
        fi;
    fi;
    # if ( IsCat1Algebra( C1A ) and HasXModAlgebraOfCat1Algebra( C1A ) ) then
    #     Print( ": associated crossed module is ", 
    #            XModAlgebraOfCat1Algebra( C1A ), "\n" );
    # fi;
end );

############################################################################
##
#M  Name                                              for a pre-cat1-alegbra
##
InstallMethod( Name, "method for a pre-cat1-algebra", true, 
    [ IsPreCat1Algebra ], 0,
function( C1A )

    local  nsrc, nrng, name, mor;

    if HasName( Source( C1A ) ) then
        nsrc := Name( Source( C1A ) );
    else
        nsrc := "..";
    fi;
    if HasName( Range( C1A ) ) then
        nrng := Name( Range( C1A ) );
    else
        nrng := "..";
    fi;
    name := Concatenation( "[", nsrc, " => ", nrng, "]" );
    SetName( C1A, name );
    return name;
end );

############################################################################
##
#F  PreCat1Algebra( <t>, <h>, <e> )  pre-cat1-algebra from tail, head, embed
#F  PreCat1Algebra( <t>, <h> )       pre-cat1-algebra from tail, head, endos
##
InstallGlobalFunction( PreCat1Algebra, function( arg )

    local  nargs, C1A;

    nargs := Length( arg );
    # two endomorphisms
    if ( ( nargs=2 ) and IsEndoMapping( arg[1] )
                     and IsEndoMapping( arg[2] ) ) then
        return PreCat1AlgebraByEndomorphisms( arg[1], arg[2] );
    # two homomorphisms and an embedding
    elif ( ( nargs=3 ) and
           ForAll( arg, a -> IsAlgebraHomomorphism( a ) ) ) then
        return PreCat1AlgebraByTailHeadEmbedding( arg[1], arg[2], arg[3] );
    fi;
    # alternatives not allowed
    Error( "standard usage: PreCat1Algebra( tail, head [,embedding] );" );
end );

############################################################################
##
#M  IsCat1Algebra             check that the second cat1-algebra axiom holds
##
InstallMethod( IsCat1Algebra, "generic method for crossed modules",
    true, [ Is2dAlgebra ], 0,
function( C1A )

    local Csrc, Crng, h, t, e, f, kerC, kert, kerh, genkert, genkerh, 
          uzGt, uzGh, i, j, h1, t1, z1, z2;

    if not ( IsPreCat1AlgebraObj( C1A ) and IsPreCat1Algebra( C1A ) ) then
        return false;
    fi;
    Csrc := Source( C1A );
    Crng := Range( C1A );
    h := HeadMap( C1A );
    t := TailMap( C1A );
    e := RangeEmbedding( C1A );
    kerC := Kernel( C1A );
    f := KernelEmbedding( C1A );
    kert := Kernel( t );
    kerh := Kernel( h );
    if not ( Size( kert ) = 1 or Size( kerh ) = 1 ) then
        genkert := GeneratorsOfAlgebra(kert);
        genkerh := GeneratorsOfAlgebra(kerh);
        uzGt := Length(genkert);
        uzGh := Length(genkerh);
        for i in [1..uzGt] do
            t1 := genkert[i];
            for j in [1..uzGh] do
                h1 := genkerh[j];
                z1 := t1*h1;
                z2 := Zero(Csrc);
                if ( z1 <> z2 ) then                
                    return false;
                fi;
            od;
        od;
    fi;
    ##kerth := CommutatorSubgroup( kert, kerh );
    ##if not ( Size( kerth ) = 1 ) then
    ##    Print("condition  [kert,kerh] = 1  is not satisfied \n");
    ##    return false;
    ##fi;
    if not ( ( Source( f ) = kerC ) and ( Range( f ) = Csrc ) ) then
        Print( "Warning: KernelEmbedding( C1A ) incorrectly defined?\n" );
    fi;
    return true;
end );

############################################################################
##
#M  IsIdentityCat1Algebra
##
InstallMethod( IsIdentityCat1Algebra, "test a cat1-algebra", true, 
    [ IsCat1Algebra ], 0,
function( C1A )
    return ( ( TailMap( C1A ) = IdentityMapping( Source( C1A ) ) ) and
             ( TailMap( C1A ) = IdentityMapping( Source( C1A ) ) ) );
end );

############################################################################
##
#F  Cat1Algebra( <GF(n)>,<size>, <gpnum>, <num> )   
##                                   cat1-algebra from data in CAT1_ALG_LIST
#F  Cat1Algebra( <t>, <h>, <e> )     cat1-algebra from tail, head, embed
#F  Cat1Algebra( <t>, <h> )          cat1-algebra from tail, head endos
##
InstallGlobalFunction( Cat1Algebra, 
function( arg )

    local  nargs, C1A, ok, usage1, usage2;

    nargs := Length( arg );
    usage1 := "standard usage: Cat1Algebra( tail, head [,embed] )";
    usage2 := "or: Cat1Algebra( GF(num), size, gpnum, num )";
    
    if ( ( nargs < 1 ) or ( nargs > 4 ) ) then        
        Print( usage1, "\n");
        Print( usage2, "\n");
        return fail;
    elif not IsInt( arg[1] ) then
        if ( nargs = 1 ) and IsPreXModAlgebra( arg[1] )  then
            C1A := Cat1AlgebraOfXModAlgebra( arg[1] );
        elif ( nargs = 2 ) then   
            C1A := PreCat1Algebra( arg[1], arg[2] );
        elif ( nargs = 3 ) then
            C1A := PreCat1Algebra( arg[1], arg[2], arg[3] );
        elif ( nargs = 4 ) then
            Print( usage1, "\n");
            Print( usage2, "\n");
            return fail;
        fi;
        ok := IsCat1Algebra( C1A );
        if ok then
            return C1A;
        else
            Error( "Code : Cat1Algebra from XModAlgebra" );
            return fail;
        fi;
    else   
        return Cat1AlgebraSelect( arg[1], arg[2], arg[3], arg[4] );        
    fi;
end );

############################################################################
##
#F  Cat1AlgebraSelect( <size>, <gpnum>, <num> )   
##                                       cat1-algebra from data in CAT1_LIST
##
InstallOtherMethod( Cat1AlgebraSelect, 
    "construct a cat1-algebra using data file", true, [ IsInt ], 0,
function( gf )
    return Cat1AlgebraSelect( gf, 0, 0, 0 );
end );

InstallOtherMethod( Cat1AlgebraSelect, 
    "construct a cat1-algebra using data file", true, [ IsInt, IsInt ], 0,
function( gf, size )
    return Cat1AlgebraSelect( gf, size, 0, 0 );
end );

InstallOtherMethod( Cat1AlgebraSelect, 
    "construct a cat1-algebra using data file", true, 
    [ IsInt, IsInt, IsInt ], 0,
function( gf, size, gpnum )
    return Cat1AlgebraSelect( gf, size, gpnum, 0 );
end );

InstallMethod( Cat1AlgebraSelect, 
    "construct a cat1-group-algebra using data file", 
    true, [ IsInt, IsInt, IsInt, IsInt ], 0,
function( gf, size, gpnum, num )

    local  ok, type, norm, usage, usage2, sizes, maxsize, maxgsize, len,
           start, iso, count, pos, pos2, names, A, gA, B, H, emb, gB, 
           usage_list1, usage_list2, usage_list3, i, j, k, l, ncat1, 
           G, genG, M, L, genR, R, t, kert, e, h, imt, imh, C1A, XC, elA;

    maxsize := CAT1ALG_LIST_MAX_SIZE;   
    usage := "Usage: Cat1Algebra( GFnum, gpsize, gpnum, num );";
    
    # if ( CAT1ALG_LIST_LOADED = false ) then    
        ReadPackage( "xmodalg", "lib/cat1algdata.g" );
    # fi;
     
    usage_list1 := Set(CAT1ALG_LIST, i -> i[1]);
    if not gf in usage_list1 then
      Print( "|--------------------------------------------------------| \n" );
      if ( gf <> 0 ) then
        Print( "| ",gf," is invalid value for the Galois Field (GFnum) \t | \n");
      fi;
      Print( "| Available values for GFnum in the data : \t \t | \n");
      Print( "|--------------------------------------------------------| \n" ); 
      Print( " ",usage_list1," \n");
      Print( usage, "\n" );
      return fail;
    fi;
    usage_list2 := Set(Filtered(CAT1ALG_LIST, i -> i[1]=gf), i -> i[2]);
    if not size in usage_list2 then
      Print( "|--------------------------------------------------------| \n" );
      if ( size <> 0 ) then
        Print( "| ",size," is invalid value for size of group (gpsize)  \t | \n") ;
      fi;
      Print( "| Available values for gpsize with GF(",gf,") in the data: \t | \n");
      Print( "|--------------------------------------------------------| \n" ); 
      Print( usage, "\n" );
      return usage_list2;
    fi;
    usage_list3 := Set( Filtered( Filtered( CAT1ALG_LIST, i -> i[1] = gf), 
                        i -> i[2] = size ), i -> i[3] );
    if not gpnum in usage_list3 then
      Print( "|--------------------------------------------------------| \n" );
      if ( gpnum <> 0 ) then
        Print( "| ",gpnum," is invalid value for groups of order ",size, "\t \t | \n");
      fi;
      Print( "| Available values for gpnum for groups of size ",size," : \t | \n");
      Print( "|--------------------------------------------------------| \n" );
      Print( usage, "\n" );
      return usage_list3;
    fi;
    maxgsize := CAT1ALG_LIST_GROUP_SIZES[gf+1]-CAT1ALG_LIST_GROUP_SIZES[gf];
    iso := CAT1ALG_LIST_CLASS_SIZES;
    count := 1;
    start := [ 1 ];
    for j in iso do
        count := count + j;
        Add( start, count );
    od;           
    sizes := size+CAT1ALG_LIST_GROUP_SIZES[gf]; 
    pos := start[ sizes ];
    pos2 := start[ sizes + 1 ] - 1;
    #if ( sizes < maxgsize ) then
    #    pos2 := start[ sizes + 1 ] - 1;
    #else
    #    pos2 := Length( CAT1ALG_LIST );
    #fi;
    names := List( [ pos..pos2], n -> CAT1ALG_LIST[n][5] );  
    if ( ( gpnum < 1 )  or (gpnum > iso[sizes] )) then        
        Print( " " ,gpnum, " is a invalid gpnum number.\n" ); 
        Print( " where 0 < gpnum <= ", iso[sizes], 
               " for gpsize " ,size, ".\n" );
        Print( usage, "\n" );
        return names;
    fi;
    if ( IsAbelian(SmallGroup(size,gpnum)) = false ) then        
        Print( StructureDescription(SmallGroup(size,gpnum)), 
               " is a non Abelian group.\n" ); 
        Print( usage, "\n" );
        return fail;
    fi;
    j := pos + gpnum - 1;
    M := CAT1ALG_LIST[j];
    G  := Group(M[4]);
    #G  := Group(M[4], ( ));    
    ncat1 := Length( M[6] ) + 1;
    genG := GeneratorsOfGroup( G );
    A := GroupRing(GF(gf),G);
    #A := GroupRing(GF(gf),SmallGroup(size,gpnum));
    gA := GeneratorsOfAlgebra(A); 
    SetName( A, M[5] );   
    if not ( ( num >= 1 ) and ( num <= ncat1 ) ) then
      Print( "There are ", ncat1, " cat1-structures for the group algebra ");
      Print( A, ".\n" ); 
      Print( " Range Alg     \tTail       \t\tHead      \n" ); 
      Print( "|--------------------------------------------------------| \n" );      
      Print( "| ", A, "  \tidentity map \t\tidentity map   \t |\n" ); 
      for i in [2..ncat1] do
          len := Length( M[6][i-1][4] );
          Print( "| ",M[6][i-1][3]," \t",M[6][i-1][4] );
          if ( len<14 ) then Print( "\t" ); fi;
          Print( " \t",M[6][i-1][5], "\t | \n" );
      od;              
      Print( "|--------------------------------------------------------| \n" ); 
      Print( usage, "\n" ); 
      Print( "Algebra has generators ", gA, "\n" );
      return ncat1;
    fi;
    if ( num = 1 ) then
        L := [ genG, Name(A), Name(A), gA, gA ];
        B := A;
        SetName( B, L[3] );
        imt := L[4];
        imh := L[5];
    else
        L := M[6][num-1];
        if ( L[3] = "-----" ) then
            elA := Elements(A);;
            imt := [];
            imh := [];
            for k in [1..Length(gA)] do
                Add( imt, elA[L[4][k]] );
            od;
            for k in [1..Length(gA)] do
                Add( imh, elA[L[5][k]] );
            od;
            t :=  AlgebraHomomorphismByImages( A, A, gA, imt );
            h := AlgebraHomomorphismByImages( A, A, gA, imh );
            return PreCat1AlgebraByEndomorphisms( t, h );
        fi;
        genR := L[1];
        R := Subgroup( G, genR );
        emb := Embedding(G,A);
        H := ImagesSet(emb,R);
        B := Algebra(GF(gf),GeneratorsOfGroup(H));
        gB := GeneratorsOfAlgebra(B);
        SetName( B, L[3] );
        imt := [];
        imh := [];
        for k in L[4] do
            Add( imt, gB[k] );
        od;
        for l in L[5] do
            Add( imh, gB[l] );
        od;
    fi;  
    t := AlgebraHomomorphismByImages( A, B, gA, imt );
    h := AlgebraHomomorphismByImages( A, B, gA, imh );
    SetName( Image( t ), L[3] );
    SetName( Image( h ), L[3] );
    SetIsEndoMapping( t, true );
    SetIsEndoMapping( h, true );
    # e := InclusionMappingAlgebra(A,B);
    kert := Kernel( t );
    SetName( kert, L[2] );
    return PreCat1AlgebraByEndomorphisms( t, h );
end );

############################################################################
##
#M  PreCat1AlgebraByTailHeadEmbedding
##
InstallMethod( PreCat1AlgebraByTailHeadEmbedding,
    "cat1-algebra from tail, head and embedding", true, 
    [ IsAlgebraHomomorphism, IsAlgebraHomomorphism, IsAlgebraHomomorphism ],
    0,
function( t, h, e )

    local  genG, R, genR, imh, imt, ime, eR, hres, tres, eres,
           kert, kergen, bdy, imbdy, f, C1A, ok, G, PC;

    G := Source( t );
    genG := GeneratorsOfAlgebra( G );
    if IsSurjective( t ) then
        R := Range( t );
    else
        R := Image( t );
    fi;
    eR := Image( e );
    genR := GeneratorsOfAlgebra( R );
    if not ( ( Source( h ) = G )
             and ( Image( h ) = R ) and ( Source( e ) = R )
             and IsInjective( e ) and IsSubset( G, eR ) )  then
        return fail;
    fi;
    imh := List( genG, x -> Image( h, x ) );
    imt := List( genG, x -> Image( t, x ) );
    ime := List( genR, x -> Image( e, x ) );
    kert := Kernel ( t );
    f := InclusionMappingAlgebra( G, kert );
    hres := AlgebraHomomorphismByImages( G, R, genG, imh );
    tres := AlgebraHomomorphismByImages( G, R, genG, imt );
    eres := AlgebraHomomorphismByImages( R, G, genR, ime );
    kergen := GeneratorsOfAlgebra( kert );
    imbdy := List( kergen, x -> Image( h, x) );
    bdy := AlgebraHomomorphismByImagesNC( kert, R, kergen, imbdy );
    PC := PreCat1AlgebraObj( tres, hres, eres );
    SetBoundary( PC, bdy );
    SetKernelEmbedding( PC, f );
    return PC;
end );

############################################################################
##
#M  PreCat1AlgebraByEndomorphisms( <et>, <eh> )
##
InstallMethod( PreCat1AlgebraByEndomorphisms,
    "cat1-algebra from tail and head endomorphisms", true, 
    [ IsAlgebraHomomorphism, IsAlgebraHomomorphism ], 0,
function( et, eh )

    local  G, gG, R, t, h, e, A, ok;

    if not ( IsEndoMapping( et ) and IsEndoMapping( eh ) ) then
        Info( InfoXModAlg, 1, "et, eh must both be group endomorphisms" );
        return fail;
    fi;
    if not ( Source( et ) = Source( eh ) ) then
        Info( InfoXModAlg, 1, "et and eh must have same source" );
        return fail;
    fi;
    G := Source( et );
    if not ( Image( et ) = Image( eh ) ) then
        Info( InfoXModAlg, 1, "et and eh must have same image" );
        return fail;
    fi;
    R := Image( et );
    gG := GeneratorsOfAlgebra( G );
    t := AlgebraHomomorphismByImages( G, R, gG, 
             List( gG, g->Image( et, g ) ) );
    h := AlgebraHomomorphismByImages( G, R, gG, 
             List( gG, g->Image( eh, g ) ) );
    e := InclusionMappingAlgebra( G, R ); 
    A := PreCat1AlgebraByTailHeadEmbedding( t, h, e ); 
    if ( A = fail ) then 
        return fail; 
    fi; 
    SetIsPreCat1Algebra( A, true ); 
    ok := IsCat1Algebra( A ); 
    return A; 
end );

############################################################################
##
#M  Source( C1A ) . . . . . . . . . . . . . . . . . . . . for a cat1-algebra
##
InstallOtherMethod( Source, "method for a pre-cat1-algebra", true,
    [ IsPreCat1Algebra ], 0,
    C1A -> Source( TailMap( C1A ) ) );

############################################################################
##
#M  Range( C1A ) . . . . . . . . . . . . . . . . . . . .  for a cat1-algebra
##
InstallOtherMethod( Range, "method for a pre-cat1-algebra", true,
    [ IsPreCat1Algebra ], 0,
    C1A -> Range( TailMap( C1A ) ) );

############################################################################
##
#M  Kernel( C1A ) . . . . . . . . . . . . . . . . . . for a pre-cat1-algebra
##
InstallOtherMethod( Kernel, "method for a pre-cat1-algebra", true, 
    [ IsPreCat1Algebra ], 0,
    C1A -> Kernel( TailMap( C1A ) ) );

############################################################################
##
#M  Boundary( C1A ) . . . . . . . . . . . . . . . . . . . for a cat1-algebra
##
InstallOtherMethod( Boundary, "method for a pre-cat1-algebra", true, 
    [ IsPreCat1Algebra ], 0,
function( PC1A )
    local t, K, R;
    t := HeadMap( PC1A );
    K := Kernel( PC1A );
    R := Range( PC1A );
    return RestrictionMappingAlgebra( t, K, R );
end );

############################################################################
##
#M  KernelEmbedding( C1A ) . . .  . . . . . . . . . . . . for a cat1-algebra
##
InstallMethod( KernelEmbedding, "method for a pre-cat1-algebra", true, 
    [ IsPreCat1Algebra ], 0,
    C1A -> InclusionMappingAlgebra( Source( C1A ), Kernel( C1A ) ) );

############################################################################
##
#M  AllCat1Algebras
##
InstallMethod( AllCat1Algebras, "generic method for cat1-algebras",
    true, [ IsField, IsGroup ], 0,
function( F, G )

    local Eler,Iler,i,j,PreCat1_ler, Cat1_ler,A;

    A := GroupRing( F, G );
    PreCat1_ler := [];
    Iler := AllIdempotentAlgebraHomomorphisms( A, A );
    PreCat1_ler := [];
    for i in [1..Length(Iler)] do
        for j in [1..Length(Iler)] do
            if PreCat1AlgebraByEndomorphisms(Iler[i],Iler[j]) <> fail then
                Add(PreCat1_ler,
                    PreCat1AlgebraByEndomorphisms( Iler[i], Iler[j] ) );
                Print(PreCat1AlgebraByEndomorphisms( Iler[i], Iler[j] ) );
            else 
                continue; 
            fi;                
        od;    
    od; 
    Cat1_ler := Filtered( PreCat1_ler, IsCat1Algebra );    
    return Cat1_ler;
end );

############################################################################
##
#M  IsIsomorphicCat1Algebra
##
InstallMethod( IsIsomorphicCat1Algebra, "generic method for cat1-algebras",
    true, [ IsCat1Algebra, IsCat1Algebra ], 0,
function( C1A1, C1A2 )

    local sonuc,T1,G1,b2,a2,b1,a1,T2,G2,alpha1,phi1,m1_ler,m1,alp,ph;

    sonuc := true;
    T1 := Source(C1A1);
    G1 := Range(C1A1);
    T2 := Source(C1A2);
    G2 := Range(C1A2);
    if ( C1A1 = C1A2 ) then
        return true;
    fi;
    if ( ( Size(T1) <> Size(T2) ) or ( Size(G1) <> Size(G2) ) ) then
        return false;
    fi;
    if ( ( LeftActingDomain(T1) <> LeftActingDomain(T2) ) 
      or ( LeftActingDomain(G1) <> LeftActingDomain(G2) ) ) then
        return false;
    fi;
    if ( T1 = T2 ) then
        if ( "AllAutosOfAlgebras" in KnownAttributesOfObject(T1) ) then
            alpha1 := AllAutosOfAlgebras(T1);
        else
            alpha1 := AllBijectiveAlgebraHomomorphisms(T1,T1);
            SetAllAutosOfAlgebras(T1,alpha1);
        fi;
    else
        alpha1 := AllBijectiveAlgebraHomomorphisms(T1,T2);
    fi;
    phi1 := AllBijectiveAlgebraHomomorphisms(G1,G2);
    m1_ler := [];        
    for alp in alpha1 do
        for ph in phi1 do
            if ( IsPreCat1AlgebraMorphism(Make2dAlgebraMorphism( 
                     C1A1, C1A2, alp, ph ) ) ) then
                Add(m1_ler,PreCat1AlgebraMorphism(C1A1,C1A2,alp,ph));
                if ( IsCat1AlgebraMorphism( 
                         Make2dAlgebraMorphism(C1A1,C1A2,alp,ph) ) ) then
                    return true;
                fi;
            fi;
        od;
    od;    
    ### m1_ler : komutator çaprazlanmış modüllerin tüm izomorfizmleri
    m1_ler := Filtered( m1_ler, IsCat1AlgebraMorphism );        
    if Length(m1_ler) = 0 then 
        #Print("Hic m1 yok \n");
        sonuc := false;
        return sonuc;
    fi; 
    return sonuc;
end );

############################################################################
##
#M  IsomorphicCat1AlgebraFamily
##
InstallMethod( IsomorphicCat1AlgebraFamily, "generic method for cat1-algebras",
    true, [ IsCat1Algebra, IsList ], 0,
function( C1A1, C1A1_ler )

    local sonuc,sayi,C1A;

    sonuc := [];
    sayi := 0;
    for C1A in C1A1_ler do
       if IsIsomorphicCat1Algebra(C1A,C1A1) then
           # Print(XM," ~ ",XM1,"\n" );    
           Add( sonuc, Position(C1A1_ler,C1A) );
           # sayi := sayi + 1;
       fi; 
    od;
    # Print(sayi,"\n");
    return sonuc;
end );

############################################################################
##
#M  AllCat1AlgebrasUpToIsomorphism
##
InstallMethod( AllCat1AlgebrasUpToIsomorphism, 
    "generic method for cat1-algebras", true, [ IsList ], 0,
function( Cat1ler )

    local n,l,i,j,k,isolar,liste1,liste2;

    n := Length(Cat1ler);
    liste1 := [];
    liste2 := [];
    for i in [1..n] do
        if i in liste1 then
            continue;
        else
            isolar := IsomorphicCat1AlgebraFamily(Cat1ler[i],Cat1ler);
            Append( liste1, isolar );        
            Add( liste2, Cat1ler[i] );
        fi; 
    od;
    return liste2;
end );

##########################  conversion functions  ##########################  

############################################################################
##
#M  PreXModAlgebraOfPreCat1Algebra
##
InstallMethod( PreXModAlgebraOfPreCat1Algebra, true, [ IsPreCat1Algebra ], 0,
function( C1A )
 
    local  A, B, s, t, e, bdy, S, R, vecR, evecR, eR, M, act, PM;

    A := Source( C1A ); 
    B := Range( C1A );
    s := HeadMap( C1A );
    t := TailMap( C1A );
    e := RangeEmbedding( C1A ); 
    bdy := Boundary( C1A );
    S := Source( bdy );
    R := Range( bdy );
    vecR := BasisVectors( Basis( R ) ); 
    evecR := List( vecR, v -> ImageElm( e, v ) ); 
    eR := Subalgebra( A, evecR ); 
    M := MultiplierAlgebraOfIdealBySubalgebra( A, S, eR ); 
    act := MultiplierHomomorphism( M ); 
    SetIsAlgebraAction( act, true ); 
    SetAlgebraActionType( act, "multiplier" ); 
    PM := PreXModAlgebraByBoundaryAndAction( bdy, act );
    return PM; 
end );

############################################################################
##
#M  XModAlgebraOfCat1Algebra
##
InstallMethod( XModAlgebraOfCat1Algebra, "generic method for cat1-algebras",
    true, [ IsCat1Algebra ], 0,
function( C1 )

    local  X1; 

    X1 := PreXModAlgebraOfPreCat1Algebra( C1 );
    if not IsXModAlgebra( X1 ) then
        Info( InfoXModAlg, 1, "X1 is only a pre-xmod-algebra" ); 
        return fail;        
    fi;
    SetCat1AlgebraOfXModAlgebra( X1, C1 );
    return X1;
end );

############################################################################
##
#M  PreCat1AlgebraOfPreXModAlgebra . .  pre-xmod-algebra -> pre-cat1-algebra
##
InstallMethod( PreCat1AlgebraOfPreXModAlgebra,
    "convert a pre-xmod-algebra to a pre-cat1-algebra record", true, 
    [ IsPreXModAlgebra ], 0,
function( XM )

    local  S, R, act, bdy, P, info, vecP, dimP, dimR, vecR, zR, dimS, vecS,
           zS, j, imgs, t, h, e, C;

    S := Source( XM );
    R := Range( XM );
    act := XModAlgebraAction( XM );
    bdy := Boundary( XM ); 
    P := SemidirectProductOfAlgebras( R, act, S ); 
    info := SemidirectProductOfAlgebrasInfo( P );
    vecP := BasisVectors( Basis( P ) ); 
    dimP := Length( vecP ); 
    dimR := Dimension( R ); 
    zR := Zero( R ); 
    dimS := Dimension( S ); 
    zS := Zero( S ); 
    vecR := BasisVectors( Basis( R ) ); 
    vecS := BasisVectors( Basis( S ) ); 
    imgs := ListWithIdenticalEntries( dimP, 0 ); 
    for j in [1..dimR] do 
        imgs[j] := vecR[j]; 
    od; 
    for j in [dimR+1..dimP] do 
        imgs[j] := Image( bdy, vecS[j-dimR] ); 
    od; 
    h := AlgebraHomomorphismByImages( P, R, vecP, imgs ); 
    t := Projection( P, 1 ); 
    e := Embedding( P, 1 );
    C := PreCat1AlgebraObj( t, h, e );
    return C; 
end ); 

############################################################################
##
#M  Cat1AlgebraOfXModAlgebra
##
InstallMethod( Cat1AlgebraOfXModAlgebra, 
    "generic method for crossed modules", true, [ IsXModAlgebra ], 0,
function( X1 )

    local C1; 

    C1 := PreCat1AlgebraOfPreXModAlgebra( X1 );
    if not IsCat1Algebra( C1 ) then
        Info( InfoXModAlg, 1, "C1 is only a pre-cat1-algebra" ); 
        return fail;        
    fi;    
    SetXModAlgebraOfCat1Algebra( C1, X1 );
    return C1;
end );
