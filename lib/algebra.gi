#############################################################################
##
#W  algebra.gi                 The XMODALG package            Zekeriya Arvasi
#W                                                             & Alper Odabas
#Y  Copyright (C) 2014-2025, Zekeriya Arvasi & Alper Odabas,  
##

############################  algebra operations  ########################### 

#############################################################################
##
#M  HasZeroAnnihilator
##
InstallMethod( HasZeroAnnihilator, 
    "generic method for a commutative algebra", true, 
    [ IsAlgebra and IsCommutative ], 0,
function( A )
    ## this method assumes that Ann(A)=0 is equivalent to A^2=A 
    local genA, num, a, b, i, j, L, B; 
    genA := GeneratorsOfAlgebra( A ); 
    num := Length( genA ); 
    L := [ ]; 
    for i in [1..num] do 
        a := genA[i]; 
        for j in [i..num] do 
            b := genA[j]; 
            Add( L, a*b ); 
        od; 
    od; 
    B := Subalgebra( A, L );
    return ( A = B ); 
end );

#############################################################################
##
#M  RegularAlgebraMultiplier
##
InstallMethod( RegularAlgebraMultiplier, 
    "generic method for a commutative algebra, an ideal, and an element",
    true, [ IsAlgebra, IsAlgebra, IsObject ], 0,
function( A, I, a )
    local vecI, imf, f; 
    if not IsCommutative( A ) then 
        Info( InfoXModAlg, 1, "A is not commutative" ); 
        return fail; 
    fi; 
    if not IsIdeal( A, I ) then 
        Info( InfoXModAlg, 1, "I is not an ideal in A" ); 
        return fail; 
    fi; 
    if not a in A then 
        Info( InfoXModAlg, 1, "a is not an element of A" ); 
        return fail; 
    fi; 
    vecI := BasisVectors( Basis( I ) ); 
    imf := List( vecI, v -> a*v ); 
    f := LeftModuleHomomorphismByImages( I, I, vecI, imf );
    return f; 
end );

#############################################################################
##
#M  IsAlgebraMultiplier
##
InstallMethod( IsAlgebraMultiplier, "generic method for a mapping", true, 
    [ IsMapping ], 0,
function( m )
    local A, vecA, len, i, a, j, b, c, ok; 
    A := Source( m ); 
    if not IsAlgebra( A ) and ( A = Range( m ) ) then 
        return false; 
    fi; 
    vecA := BasisVectors( Basis( A ) ); 
    len := Length( vecA ); 
    for i in [1..len] do 
        a := vecA[i]; 
        for j in [i..len] do 
            b := vecA[j]; 
            c := ImageElm( m, a*b ); 
            ok := ( c = a * ImageElm(m,b) ) and ( c = b * ImageElm(m,a) ); 
            if not ok then 
                return false; 
            fi; 
        od; 
    od; 
    return true; 
end );

#############################################################################
##
#M  MultiplierAlgebraOfIdealBySubalgebra( <A I B> )
## 
InstallMethod( MultiplierAlgebraOfIdealBySubalgebra, 
    "for an algebra, an ideal, and a subalgebra", true,  
    [ IsAlgebra, IsAlgebra, IsAlgebra ], 0,
function ( A, I, B )
    local domA, vecA, vecB, imhom, M, hom; 
    if not IsIdeal( A, I ) then 
        Info( InfoXModAlg, 1, "I is not an ideal in A" ); 
    fi; 
    vecB := BasisVectors( Basis( B ) ); 
    if not ForAll( vecB, b -> b in A ) then 
        Info( InfoXModAlg, 1, "B is not a subalgebra of A" ); 
        return fail; 
    fi; 
    domA := LeftActingDomain( A ); 
    imhom := List( vecB, b -> RegularAlgebraMultiplier( A, I, b ) ); 
    M := AlgebraByGenerators( domA, imhom ); 
    SetIsMultiplierAlgebra( M, true ); 
    if ( Dimension( M ) = 0 ) then 
        hom := ZeroMapping( B, M ); 
    else 
        hom := AlgebraHomomorphismByImages( B, M, vecB, imhom ); 
    fi; 
    SetMultiplierHomomorphism( M, hom ); 
    return M;
end ); 

#############################################################################
##
#M  MultiplierAlgebra( <A> )
## 
InstallMethod( MultiplierAlgebra, "generic method for an algebra", 
    true, [ IsAlgebra  ], 0,
function ( A )
    return MultiplierAlgebraOfIdealBySubalgebra( A, A, A ); 
end ); 

#############################################################################
##
#M  MultiplierAlgebraByGenerators 
## 
InstallMethod( MultiplierAlgebraByGenerators, 
    "generic method for an algebra and a list of multipliers", true, 
    [ IsAlgebra, IsList ], 0,
function ( A, L )
    local I, ok, domA, M;
    ok := ForAll( L, IsAlgebraMultiplier ); 
    if not ok then 
        Info( InfoXModAlg, 1, "L is not a list of multipliers" ); 
        return fail; 
    fi; 
    I := Source( L[1] ); 
    if not IsIdeal( A, I ) then 
        Info( InfoXModAlg, 1, "I is not an ideal in A" ); 
        return fail; 
    fi; 
    domA := LeftActingDomain( A ); 
    M := FLMLORByGenerators( domA, L ); 
    SetIsMultiplierAlgebra( M, true ); 
    return M;
end );

############################################################################
##
#M  AllAlgebraHomomorphisms
##
InstallMethod( AllAlgebraHomomorphisms, "generic method for two algebras",
    true, [ IsAlgebra, IsAlgebra ], 0,
function( G, H )

    local A,B,a,b,h,f,i,sonuc,mler,j,k,eH,l,L,g,H_G,genG;

    eH := Elements(H);
    if ( "IsGroupAlgebra" in KnownPropertiesOfObject(G) ) then
        H_G := UnderlyingGroup(G);
        L := MinimalGeneratingSet(H_G);
        genG := List( L, g -> g^Embedding(H_G,G) );
    else
        genG := GeneratorsOfAlgebra(G);
    fi;
    if (Length(genG) = 0) then
        genG := GeneratorsOfAlgebra(G);
    fi;
    mler := [];
    if Length(genG) = 1 then
        for i in [1..Size(H)] do
            f := AlgebraHomomorphismByImages(G,H,genG,[eH[i]]);
            if ((f <> fail) and  (not f in mler))  then 
                Add(mler,f);
            else 
                continue; 
            fi;            
        od;
    elif Length(genG) = 2 then
        for i in [1..Size(H)] do
            for j in [1..Size(H)] do
                f := AlgebraHomomorphismByImages(G,H,genG,[eH[i],eH[j]]);
                if ((f <> fail) and  (not f in mler))  then 
                    Add(mler,f);
                else 
                    continue; 
                fi; 
            od;
        od;
    elif Length(genG) = 3 then
        for i in [1..Size(H)] do
            for j in [1..Size(H)] do
                for k in [1..Size(H)] do
                    f := AlgebraHomomorphismByImages( G, H, genG,
                             [eH[i],eH[j],eH[k]]);
                    if ((f <> fail) and  (not f in mler))  then 
                        Add(mler,f);
                    else 
                        continue; 
                    fi; 
                od;
            od;
        od;
    elif Length(genG) = 4 then
        for i in [1..Size(H)] do
            for j in [1..Size(H)] do
                for k in [1..Size(H)] do
                    for l in [1..Size(H)] do
                        f := AlgebraHomomorphismByImages( G, H, genG, 
                                 [eH[i],eH[j],eH[k],eH[l]]);
                        if ((f <> fail) and  (not f in mler))  then 
                            Add(mler,f);
                        else 
                            continue; 
                       fi;    
                    od;
                od;
            od;
        od;
    else
        Print("not implemented yet");    
    fi;
    #Print(Length(mler));
    #Print("\n");
    return mler;
end );

############################################################################
##
#M  AllBijectiveAlgebraHomomorphisms
##
InstallMethod( AllBijectiveAlgebraHomomorphisms, 
    "generic method for two algebras", true, [ IsAlgebra, IsAlgebra ], 0,
function( G, H )

    local A,B,a,b,h,f,i,sonuc,mler,j,k,eH,l,L,g,H_G,genG;

    eH := Elements(H);
    if ( "IsGroupAlgebra" in KnownPropertiesOfObject(G) ) then
        H_G := UnderlyingGroup(G);
        L := MinimalGeneratingSet(H_G);
        genG := List( L, g -> g^Embedding(H_G,G) );
    else
        genG := GeneratorsOfAlgebra(G);
    fi;
    if  (Length(genG) = 0) then
        genG := GeneratorsOfAlgebra(G);
    fi;
    mler := [];
    if Length(genG) = 1 then 
        for i in [1..Size(H)] do
            f := AlgebraHomomorphismByImages(G,H,genG,[eH[i]]);
            if ((f <> fail) and  (not f in mler) and (IsBijective(f)))  then 
                Add(mler,f);
            else 
                continue; 
            fi;            
        od;
    elif Length(genG) = 2 then
        for i in [1..Size(H)] do
            for j in [1..Size(H)] do
                f := AlgebraHomomorphismByImages(G,H,genG,[eH[i],eH[j]]);
                if ((f <> fail) and (not f in mler) and (IsBijective(f))) then 
                    Add(mler,f);
                else 
                    continue; 
                fi;        
            od;
        od;
    elif Length(genG) = 3 then
        for i in [1..Size(H)] do
            for j in [1..Size(H)] do
                for k in [1..Size(H)] do
                    f := AlgebraHomomorphismByImages( G, H, genG, 
                             [eH[i],eH[j],eH[k]]);
                    if ((f <> fail) and (not f in mler) 
                                    and (IsBijective(f))) then 
                        Add(mler,f);
                    else 
                        continue; 
                    fi;    
                od;
            od;
        od;
    elif Length(genG) = 4 then
        for i in [1..Size(H)] do
            for j in [1..Size(H)] do
                for k in [1..Size(H)] do
                    for l in [1..Size(H)] do
                        f := AlgebraHomomorphismByImages( G, H, genG, 
                                 [eH[i],eH[j],eH[k],eH[l]]);
                        if ((f <> fail) and (not f in mler) 
                                        and (IsBijective(f))) then 
                            Add(mler,f);
                        else 
                            continue; 
                        fi;    
                    od;
                od;
            od;
        od;
    else
        Print("not implemented yet");    
    fi;
    #Print(Length(mler));
    #Print("\n");
    return mler;
end );

############################################################################
##
#M  AllIdempotentAlgebraHomomorphisms
##
InstallMethod( AllIdempotentAlgebraHomomorphisms, 
    "generic method for algebras", true, [ IsAlgebra, IsAlgebra ], 0,
function( G, H )

    local A,B,a,b,h,f,i,sonuc,mler,j,k,eH,l,L,g,H_G,genG;

    eH := Elements(H);
    H_G := UnderlyingGroup(G);
    L := MinimalGeneratingSet(H_G);
    genG := List( L, g -> g^Embedding(H_G,G) );
    if ( Length(genG) = 0 ) then
            genG := GeneratorsOfAlgebra(G);
    fi;
    mler := [];
    if Length(genG) = 1 then
        for i in [1..Size(H)] do
            f := AlgebraHomomorphismByImages(G,H,genG,[eH[i]]);
            if ((f <> fail) and  (not f in mler) and (f*f=f))  then 
                Add(mler,f);
            else 
                continue; 
            fi; 
        od;
    elif Length(genG) = 2 then
        for i in [1..Size(H)] do
            for j in [1..Size(H)] do
                f := AlgebraHomomorphismByImages(G,H,genG,[eH[i],eH[j]]);
                if ((f <> fail) and  (not f in mler) and (f*f=f))  then 
                    Add(mler,f);
                else 
                    continue; 
                fi;        
            od;
        od;
    elif Length(genG) = 3 then
        for i in [1..Size(H)] do
            for j in [1..Size(H)] do
                for k in [1..Size(H)] do
                    f := AlgebraHomomorphismByImages( G, H, genG, 
                             [eH[i],eH[j],eH[k]]);
                    if ((f <> fail) and  (not f in mler) and (f*f=f)) then 
                        Add(mler,f);
                    else 
                        continue; 
                    fi;    
                od;
            od;
        od;
    elif Length(genG) = 4 then
        for i in [1..Size(H)] do
            for j in [1..Size(H)] do
                for k in [1..Size(H)] do
                    for l in [1..Size(H)] do
                        f := AlgebraHomomorphismByImages( G, H, genG, 
                                 [eH[i],eH[j],eH[k],eH[l]]);
                        if ((f <> fail) and (not f in mler) and (f*f=f)) then 
                            Add(mler,f);
                        else 
                            continue; 
                        fi;    
                    od;
                od;
            od;
        od;
    else
        Print("not implemented yet");    
    fi;
    #Print(Length(mler));
    #Print("\n");
    return mler;
end );


#############################  algebra mappings  ############################ 

#############################################################################
##
#M  InclusionMappingAlgebra( <G>, <H> )
##
InstallMethod( InclusionMappingAlgebra, "generic method for subalgebra",
               IsIdenticalObj, [ IsAlgebra, IsAlgebra ], 0,
function( G, H )

    local  genH, inc, ok;
    if not IsSubset( G, H ) then
        Error( "usage: InclusionMappingAlgebra( G, H );  with  H <= G" );
    fi;
    genH := GeneratorsOfAlgebra( H );
    inc := AlgebraHomomorphismByImagesNC( H, G, genH, genH );
    ### IsInjective Áal˝˛m˝yor NC ile ¸retilmi˛ morfizmlerde
    SetIsInjective( inc, true );
    return inc;
end );

#############################################################################
##
#M  RestrictionMappingAlgebra( <hom>, <src>, <rng> )
##
InstallMethod( RestrictionMappingAlgebra, 
    "generic method for an algebra homomorphism", true,
    [ IsAlgebraHomomorphism, IsAlgebra, IsAlgebra ], 0,
function( hom, src, rng )

    local  res, gens, ims, r;

    if not IsSubset( Source( hom ), src ) then
        return fail;
    fi;
    if not IsSubset( Range( hom ), rng ) then
        return fail;
    fi;
    res := RestrictedMapping( hom, src );
    gens := GeneratorsOfAlgebra( src );
    ims := List( gens, g -> Image( res, g ) );
    for r in ims do
        if not ( r in rng ) then
            return fail;
        fi;
    od;
    return AlgebraHomomorphismByImages( src, rng, gens, ims );
end );

#############################################################################
##
#M  RestrictedMapping(<hom>,<U>)
##
InstallMethod(RestrictedMapping, "create new GHBI",
    CollFamSourceEqFamElms, [ IsAlgebraHomomorphism, IsAlgebra ], 0, 
function( hom, U ) 
    local rest,gens,imgs,imgp;

    if ForAll(GeneratorsOfAlgebra(Source(hom)),i->i in U) then
        return hom;   
    fi;
    gens:=GeneratorsOfAlgebra(U);
    imgs:=List( gens, i->ImageElm(hom,i) );

    if HasImagesSource(hom) then
        imgp:=ImagesSource(hom);
    else
        imgp:=Subalgebra(Range(hom),imgs);
    fi;
    rest:=AlgebraHomomorphismByImagesNC(U,imgp,gens,imgs);
    if HasIsInjective(hom) and IsInjective(hom) then
        SetIsInjective(rest,true);
    fi;
    if HasIsTotal(hom) and IsTotal(hom) then
        SetIsTotal(rest,true);
    fi;
    return rest;
end);

##############################  algebra actions  ############################ 

#############################################################################
##
#M  IsAlgebraAction( <hom> )
##
InstallMethod( IsAlgebraAction, "for an algebra homomorphism", true,
    [ IsAlgebraHomomorphism ], 0,
function ( hom )
    local A, C, genC, g1, g;
    C := Range( hom );
    ## check that C is an algebra of isomorphisms of A
    genC := GeneratorsOfAlgebra( C );
    g1 := genC[1];
    if not IsLeftModuleHomomorphism( g1 ) then
        Info( InfoXModAlg, 1, "g1 is not a left module homomorphism" );
        return false;
    fi;
    A := Source( g1 );
    for g in genC do
        if not ( Source( g ) = A ) and ( Range( g ) = A ) then
            Info( InfoXModAlg, 1, "source and/or range <> A" );
            return false;
        fi;
        if not IsBijective( g ) then
            Info( InfoXModAlg, 1, "a generator of C is not bijective" );
            return false;
        fi;
    od;
    return true;
end );

#############################################################################
##
#F  AlgebraAction( <args> ) 
##
InstallGlobalFunction( AlgebraAction, 
function( arg )

    local  nargs;

    nargs := Length( arg );
    # Algebra, Ideal, and Subalgebra
    if ( ( nargs = 3 ) and ForAll( arg, IsAlgebra ) ) then
        return AlgebraActionByMultipliers( arg[1], arg[2], arg[3] );
    # module and zero map
    elif ( ( nargs = 2 ) and IsAlgebra( arg[1] ) 
                         and IsLeftModule( arg[2] ) ) then
        return AlgebraActionByModule( arg[1],arg[2] );
    # action homomorphism and algebra acted on
    elif ( nargs = 2 ) and IsAlgebraHomomorphism( arg[1] )
                       and IsAlgebra( arg[2] ) then
        return AlgebraActionByHomomorphism( arg[1], arg[2] );
    # surjective homomorphism
    elif ( ( nargs = 1 ) and IsAlgebraHomomorphism( arg[1] )
                         and IsSurjective( arg[1] ) ) then
        return AlgebraActionBySurjection( arg[1] );
    fi;
    # alternatives not allowed
    Error( "usage: AlgebraAction( A, I, B );  or various options" );
end );

#############################################################################
##
#F  AlgebraActionByMultipliers( <A>, <I>, <B> )
##
InstallMethod( AlgebraActionByMultipliers, 
    "for an algebra, an ideal, and a subalgebra", true,  
    [ IsAlgebra, IsAlgebra, IsAlgebra ], 0,
function ( A, I, B )
    local M, act;
    M := MultiplierAlgebraOfIdealBySubalgebra( A, I, B ); 
    act := MultiplierHomomorphism( M );
    SetIsAlgebraAction( act, true );
    SetAlgebraActionType( act, "multiplier" );
    SetAlgebraActedOn( act, B );
    SetHasZeroModuleProduct( act, false );
    return act;
end );

#############################################################################
##
#F  AlgebraActionBySurjection( <hom> )
##
InstallMethod( AlgebraActionBySurjection, "for a surjective algebra hom", 
    true, [ IsAlgebraHomomorphism ], 0,
function ( hom )
    local A, basA, vecA, dom, B, basB, vecB, dimA, dimB, K, basK, vecK, 
          zA, a, k, maps, j, b, p, im, M, act; 
    if not IsSurjective( hom ) then 
        Error( "hom is not a surjective algebra homomorphism" ); 
    fi; 
    A := Source( hom ); 
    basA := Basis( A ); 
    vecA := BasisVectors( basA ); 
    dimA := Dimension( A ); 
    dom := LeftActingDomain( A ); 
    B := Range( hom ); 
    basB := Basis( B ); 
    vecB := BasisVectors( basB ); 
    dimB := Dimension( B ); 
    if not ( dom = LeftActingDomain( B ) ) then 
        Print( "A and B have different LeftActingDomains\n" );
        return fail; 
    fi; 
    ## check that the kernel is contained in the annihilator 
    zA := Zero( A ); 
    K := Kernel( hom ); 
    basK := Basis( K );
    vecK := BasisVectors( basK ); 
    for k in vecK do 
        for a in vecA do 
            if not ( k*a = zA ) then 
                Print( "kernel of hom is not in the annihilator of A\n" ); 
                return fail;  
            fi; 
        od; 
    od; 
    maps := ListWithIdenticalEntries( dimB, 0 );
    for j in [1..dimB] do 
        b := vecB[j]; 
        p := PreImagesRepresentativeNC( hom, b ); 
        im := List( vecA, a -> p*a );
        maps[j] := LeftModuleHomomorphismByImages( A, A, vecA, im );
    od;
    M := AlgebraByGenerators( dom, maps );
    act := LeftModuleGeneralMappingByImages( B, M, vecB, maps );
    SetIsAlgebraAction( act, true );
    SetAlgebraActionType( act, "surjection" );
    SetAlgebraActedOn( act, A );
    SetHasZeroModuleProduct( act, false );
    return act;
end );

#############################################################################
##
#M  SemidirectProductOfAlgebras( <A1>, <act>, <A2> )
##
InstallMethod( SemidirectProductOfAlgebras,
    "for two algebras and an action",
    [ IsAlgebra, IsAlgebraAction, IsAlgebra ],
    function( A1, act, A2 ) 
    local F,           # the common domain of scalars 
          z,           # the zero of F 
          n,           # dimension of the resulting algebra.
          n1,n2,       # dimensions of A1,A2 
          B,           # range of the action 
          vecB,        # basis vectors (endomorphisms of A1) for B 
          i,j,k,       # loop variables 
          r,s,u,v,     # basis vectors 
          T,           # table of structure constants of the product 
          bas1,bas2,   # bases of A1,A2 
          vec1,vec2,   # basis vectors of A1,A2 
          L1,L2,       # lists of zeroes 
          imr,imu,     # images of r,u under act 
          ru,rv,su,sv, # 4 terms in a typical product 
          L,           # the non-zero entries in these positions 
          sym,         # if both products are (anti)symmetric, then the 
                       # result will have the same property.
          P;           # the answer is the semidirect product algebra 

    ## we are assuming commutative algebras so T will be symmetric
    ## and we only need to calculate the upper triangle
    if not IsCommutative( A1 ) and IsCommutative( A2 ) then
        Error( "commutative algebras required" ); 
    fi;
    F := LeftActingDomain( A1 ); 
    z := Zero( F ); 
    if ( F <> LeftActingDomain( A2 ) ) then
        Error( "<A1> and <A2> must be written over the same field" );
    fi; 
    if not ( Source( act ) = A1 ) then 
        Error( "the source of act should be A1" ); 
    fi; 
    B := Range( act ); 
    vecB := BasisVectors( Basis( B ) ); 
    if not ForAll( vecB, v -> ( Source(v)=A2 ) and ( Range(v)=A2 ) ) then 
        Error( "image B of act is not an algebra of endomorphisms of A2" ); 
    fi; 
    n1 := Dimension( A1 );
    n2 := Dimension( A2 );
    n := n1 + n2; 
    if not IsPosInt( n ) then 
        Error( "require A1,A2 to be algebras of finite dimension" ); 
    fi; 
    bas1 := Basis( A1 ); 
    vec1 := BasisVectors( bas1 ); 
    bas2 := Basis( A2 ); 
    vec2 := BasisVectors( bas2 ); 
    L1 := ListWithIdenticalEntries( n1, z ); 
    L2 := ListWithIdenticalEntries( n2, z ); 
    # Initialize the s.c. table.
    T := EmptySCTable( n, Zero(F), "symmetric" );
    for i in [1..n1] do 
        r := vec1[i];
        for j in [i..n1] do 
            u := vec1[j]; 
            ru := Coefficients( bas1, r*u ); 
            L := [ ]; 
            for k in [1..n1] do 
                if ( ru[k] <> z ) then 
                    Append( L, [ ru[k], k ] ); 
                fi; 
            od;
            SetEntrySCTable( T, i, j, L ); 
        od;
    od;
    for i in [1..n1] do
        r := vec1[i]; 
        imr := ImageElm( act, r ); 
        for j in [1..n2] do 
            v := vec2[j]; 
            rv := Coefficients( bas2, ImageElm( imr, v ) ); 
            L := [ ]; 
            for k in [1..n2] do 
                if ( rv[k] <> z ) then 
                    Append( L, [ rv[k], k+n1 ] ); 
                fi; 
            od; 
            SetEntrySCTable( T, i, j+n1, L ); 
        od; 
    od; 
    for i in [1..n2] do 
        s := vec2[i]; 
        for j in [i..n2] do 
            v := vec2[j]; 
            sv := Coefficients( bas2, s*v ); 
            L := [ ]; 
            for k in [1..n2] do 
                if ( sv[k] <> z ) then 
                    Append( L, [ sv[k], k+n1 ] ); 
                fi; 
            od; 
            SetEntrySCTable( T, i+n1, j+n1, L ); 
        od; 
    od;
    P := AlgebraByStructureConstants( F, T );
    if HasName( A1 ) and HasName( A2 ) then
        SetName( P, Concatenation( Name( A1 ), " |X ", Name( A2 ) ) ); 
    fi;
    SetSemidirectProductOfAlgebrasInfo( P, rec( algebras := [ A1, A2 ], 
                                                action := act, 
                                                embeddings := [ ], 
                                                projections := [ ] ) ); 
    return P; 
end );

#############################################################################
##
#A  Embedding
##
InstallMethod( Embedding, "semidirect product of algebras and integer",
    [ IsAlgebra and HasSemidirectProductOfAlgebrasInfo, IsPosInt ], 
    function( P, i )
    local info, vecP, A1, dim1, A2, dim2, vec1, vec2, p1, imgs, hom;

    # check
    info := SemidirectProductOfAlgebrasInfo( P );
    if IsBound( info.embeddings[i] ) then 
        return info.embeddings[i];
    fi;
    vecP := BasisVectors( Basis( P ) ); 
    A1 := info.algebras[1]; 
    dim1 := Dimension( A1 ); 
    A2 := info.algebras[2]; 
    dim2 := Dimension( A2 ); 
    vec1 := BasisVectors( Basis( A1 ) ); 
    vec2 := BasisVectors( Basis( A2 ) ); 
    if ( i = 1 ) then 
        imgs := List( [1..dim1], i -> vecP[i] ); 
        hom := AlgebraHomomorphismByImages( A1, P, vec1, imgs );  
    elif ( i = 2 ) then 
        imgs := List( [1..dim2], i -> vecP[i+dim1] );  
        hom := AlgebraHomomorphismByImages( A2, P, vec2, imgs ); 
    else 
        Error( "only two embeddings possible" ); 
    fi; 
    ## SetIsInjective( hom, true );
    info.embeddings[i] := hom;
    return hom;
end );

#############################################################################
##
#A  Projection
##
InstallMethod( Projection, "semidirect product of algebras and integer",
    [ IsAlgebra and HasSemidirectProductOfAlgebrasInfo, IsPosInt ], 
function( P, i )
    local info, vecP, dimP, A1, dim1, z1, vec1, imgs, j, hom;
    if ( i <> 1 ) then 
        Error( "only the first projection is available" ); 
    fi; 
    # check
    info := SemidirectProductOfAlgebrasInfo( P );
    if IsBound( info.projections[1] ) then 
        return info.projections[1];
    fi;
    vecP := BasisVectors( Basis( P ) ); 
    dimP := Length( vecP ); 
    A1 := info.algebras[1]; 
    dim1 := Dimension( A1 ); 
    z1 := Zero( A1 ); 
    vec1 := BasisVectors( Basis( A1 ) );  
    imgs := ListWithIdenticalEntries( dimP, 0 );
    for j in [1..dim1] do 
        imgs[j] := vec1[j]; 
    od; 
    for j in [dim1+1..dimP] do 
        imgs[j] := z1; 
    od;
    hom := AlgebraHomomorphismByImages( P, A1, vecP, imgs );  
    ## SetIsSurjective( hom, true ); 
    info.projections[1] := hom;
    return hom;
end );

############################  direct sum operations  ####################### 

#############################################################################
##
#M  DirectSumOfAlgebrasWithInfo
##
InstallMethod( DirectSumOfAlgebrasWithInfo, "for two algebra",
    [ IsAlgebra, IsAlgebra ],
    function( A, B )
    local D, eA, eB, pA, pB, info;
    D := DirectSumOfAlgebras( A, B );
    if ( D <> fail ) then
        if HasName( A ) and HasName( B ) then 
            SetName( D, Concatenation( Name(A), "(+)", Name(B) ) );
        fi;
        info := rec( algebras := [ A, B ],
                     first := [ 1, 1 + Dimension( A ) ],
                     embeddings := [ ],
                     projections := [ ] );
        SetDirectSumOfAlgebrasInfo( D, info );
        eA := Embedding( D, 1 );
        eB := Embedding( D, 2 );
        pA := Projection( D, 1 );
        pB := Projection( D, 2 );
    fi;
    return D;
end);

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
