#############################################################################
##
#W  algebra.gi                 The XMODALG package            Zekeriya Arvasi
#W                                                             & Alper Odabas
#Y  Copyright (C) 2014-2022, Zekeriya Arvasi & Alper Odabas,  
##

############################  algebra operations  ########################### 

#############################################################################
##
#M  HasZeroAnnihilator
##
InstallMethod( HasZeroAnnihilator, "generic method for a commutative algebra",
    true, [ IsAlgebra and IsCommutative ], 0,
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
#F  MultiplierAlgebraOfIdealBySubalgebra( <A I B> )
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
    M := FLMLORByGenerators( domA, imhom ); 
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
#F  MultiplierAlgebra( <A> )
## 
InstallMethod( MultiplierAlgebra, "generic method for an algebra", 
    true, [ IsAlgebra  ], 0,
function ( A )
    return MultiplierAlgebraOfIdealBySubalgebra( A, A, A ); 
end ); 

#############################################################################
##
#F  MultiplierAlgebraByGenerators 
## 
InstallMethod( MultiplierAlgebraByGenerators, 
    "generic method for an algebra and a list of multipliers", true, 
    [ IsAlgebra, IsList ], 0,
function ( A, L )
    local I, ok, domA, M;
    ok := ForAll( L, m -> IsAlgebraMultiplier( m ) ); 
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

##############################################################################
##
#M  AllAlgebraHomomorphisms
##
InstallMethod( AllAlgebraHomomorphisms, "generic method for algebras",
    true, [ IsAlgebra, IsAlgebra ], 0,
function( G, H )

    local A,B,a,b,h,f,i,sonuc,mler,j,k,eH,l,L,g,H_G,genG;

    eH := Elements(H);
    if ( "IsGroupAlgebra" in KnownPropertiesOfObject(G) ) then
        H_G := UnderlyingGroup(G);
        L := MinimalGeneratingSet(H_G);
        genG := List( L , g -> g^Embedding(H_G,G) );
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

##############################################################################
##
#M  AllBijectiveAlgebraHomomorphisms
##
InstallMethod( AllBijectiveAlgebraHomomorphisms, "generic method for algebras",
    true, [ IsAlgebra, IsAlgebra ], 0,
function( G, H )

    local A,B,a,b,h,f,i,sonuc,mler,j,k,eH,l,L,g,H_G,genG;

    eH := Elements(H);
    if ( "IsGroupAlgebra" in KnownPropertiesOfObject(G) ) then
        H_G := UnderlyingGroup(G);
        L := MinimalGeneratingSet(H_G);
        genG := List( L , g -> g^Embedding(H_G,G) );
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

##############################################################################
##
#M  AllIdempotentAlgebraHomomorphisms
##
InstallMethod( AllIdempotentAlgebraHomomorphisms, "generic method for algebras",
    true, [ IsAlgebra, IsAlgebra ], 0,
function( G, H )

local A,B,a,b,h,f,i,sonuc,mler,j,k,eH,l,L,g,H_G,genG;

    eH := Elements(H);
    H_G := UnderlyingGroup(G);
    L := MinimalGeneratingSet(H_G);
    genG := List( L , g -> g^Embedding(H_G,G) );
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
                        if ((f <> fail) and  (not f in mler) and (f*f=f)) then 
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
InstallMethod( RestrictionMappingAlgebra, "generic method for group hom",
    true, [ IsAlgebraHomomorphism, IsAlgebra, IsAlgebra ], 0,
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
        if not (r in rng ) then
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
  imgs:=List(gens,i->ImageElm(hom,i));

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

#############################################################################
##
#O  AlgebraHomomorphismByFunction( <D>, <E>, <fun> )
##
InstallMethod( AlgebraHomomorphismByFunction, 
    "(XModAlg) for two algebras and a function",
    [ IsAlgebra, IsAlgebra, IsFunction ],
function( S, R, f )
    return Objectify( TypeOfDefaultGeneralMapping( S, R, 
	IsSPMappingByFunctionRep and IsAlgebraHomomorphism), 
        rec( fun := f ) );
end);

#############################################################################
##
#F  MultiplierHomomorphism( <D>, <E>, <fun> )
##
InstallMethod( MultiplierHomomorphism, "for,for,for", true, [ IsAlgebra ], 0,
function ( A )

    local mu, B; # mapping <map>, result
    B := MultiplierAlgebra(A);
    mu := AlgebraHomomorphismByFunction( A, B, 
              r -> AlgebraHomomorphismByFunction(A,A,x->r*x) );
    SetSource(mu,A);
    SetRange(mu,B);
    # return the mapping
    return mu;
end );

#############################################################################
##
#F  ModuleHomomorphism( <D>, <E>, <fun> )
##
InstallMethod( ModuleHomomorphism, "for,for,for", true, [IsAlgebra,IsRing], 0,
function ( M,R )

    local   mu,B;        # mapping <map>, result
     
    mu := AlgebraHomomorphismByFunction(M,R,r->Zero(R));  
    SetSource(mu,M);
    SetRange(mu,R);
    # return the mapping
    return mu;
end );

##############################  algebra actions  ############################ 

#############################################################################
##
#F  ElementsLeftActing( <fun> )
##
InstallGlobalFunction( ElementsLeftActing, 
function (ac)
    local AB,B,list,uzAB,uzA,uzB,k,i,elB;       
    AB := Source(ac);
    B := Range(ac);
    elB := Elements(B);
    list := [];
    uzAB := Length(AB);
    uzB := Length(elB);
    uzA := uzAB/uzB;
    k := 1;
    for i in [1..uzA] do
        Add(list,AB[k][1]);
        k := k+uzB;
    od;
    return Set(list);
end );

#############################################################################
##
#F  IsAlgebraAction( <fun> )
##
InstallMethod( IsAlgebraAction, "for,for,for", true, [ IsMapping ], 0,
function ( ac )
    local AB,A,B,uzB,uzA,j,i,k; 
    # mapping <map>, result
    AB := Source(ac);
    B := Elements(Range(ac));
    A := Elements(LeftElementOfCartesianProduct(ac));
    uzB := Length(B);
    uzA := Length(A);
    for j in [1..uzB] do
        if One(LeftElementOfCartesianProduct(ac))*B[j]<>B[j] then
            return false;
        fi;
        for k in [1..uzA] do
            for i in [1..uzA] do 
                if (((A[k]*A[i])*B[j])<>(A[k]*(A[i]*B[j]))) then
                    return false;
                fi;
            od;
       od;
    od;
    return true;
end );

#############################################################################
##
#F  AlgebraAction( <bdy>, <act> ) crossed module from given boundary & action
##
InstallGlobalFunction( AlgebraAction, 
function( arg )

    local  nargs;

    nargs := Length( arg );
    # Algebra, Ideal, and Subalgebra
    if ( ( nargs = 3 ) and ForAll( arg, a -> IsAlgebra(a) ) ) then
        return AlgebraActionByMultipliers( arg[1], arg[2], arg[3] );
    # Multiplier Action
    elif ( ( nargs = 1 ) and IsAlgebra( arg[1] ) ) then
        return AlgebraAction2( arg[1] );
    # surjective homomorphism
    elif ( ( nargs = 1 ) and IsAlgebraHomomorphism( arg[1] )
                         and IsSurjective( arg[1] ) ) then
        return AlgebraActionBySurjection( arg[1] );
    # module and zero map
    elif ( ( nargs = 2 ) and IsAlgebra( arg[1] ) 
                         and IsRing( arg[2] ) ) then
        return AlgebraActionByModule( arg[1],arg[2] );   
    fi;
    # alternatives not allowed
    Error( "usage: AlgebraAcrion( A, I, B );  or various options" );
end );

#############################################################################
##
#F  AlgebraAction2( <D>, <E>, <fun> )
##
InstallMethod( AlgebraAction2, "for,for,for", true, [ IsAlgebra ], 0,
function ( A )
    local act,MA,MAA;        # mapping <map>, result
    MA := MultiplierAlgebra(A);
    MAA := Cartesian(MA,A);
    act := rec( fun:= x->Image(x[1],x[2]) );
    ObjectifyWithAttributes( act, 
        NewType( GeneralMappingsFamily( ElementsFamily(FamilyObj(MAA) ), 
            ElementsFamily( FamilyObj(A) ) ),
        IsSPMappingByFunctionRep and IsSingleValued
            and IsTotal and IsGroupHomomorphism ),
        LeftElementOfCartesianProduct, MA,
        AlgebraActionType, "Type2",
        Source, MAA,
        Range, A,
        HasZeroModuleProduct, false,
        IsAlgebraAction, true );
    # return the mapping
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
        Error( "A and B have different LeftActingDomains" ); 
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
    M := FLMLORByGenerators( dom, maps );
    act := LeftModuleGeneralMappingByImages( B, M, vecB, maps );
    SetIsAlgebraAction( act, true );
    SetAlgebraActionType( act, "surjection" );
    SetHasZeroModuleProduct( act, false );
    return act;
end );

#############################################################################
##
#F  AlgebraActionByModule( <D>, <E>, <fun> )
##
InstallMethod( AlgebraActionByModule, "for,for,for", true, 
    [ IsAlgebra, IsRing ], 0,
function( M, R )
    local   act,RM;        # mapping <map>, result
    RM := Cartesian(R,M);
    act := rec( fun:= x->x[1]*x[2]);
    ObjectifyWithAttributes( act, 
        NewType( GeneralMappingsFamily( ElementsFamily(FamilyObj(RM) ),
            ElementsFamily( FamilyObj(M) ) ),
        IsSPMappingByFunctionRep and IsSingleValued
            and IsTotal and IsGroupHomomorphism ),
        LeftElementOfCartesianProduct, R,
        AlgebraActionType, "module",
        Source, RM,
        Range, M,
        HasZeroModuleProduct, true,
        IsAlgebraAction, true );
    # return the mapping
    return act;
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
          sym,         # if both products are (anti)symmetric, then the result
                       # will have the same property.
          P;           # the answer is the semidirect product algebra 

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
        imr := ImageElm( act, r ); 
        for j in [1..n1] do 
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
        for j in [1..n1] do 
            u := vec1[j]; 
            imu := ImageElm( act, u ); 
            su := Coefficients( bas2, ImageElm( imu, s ) ); 
            L := [ ]; 
            for k in [1..n2] do 
                if ( su[k] <> z ) then 
                    Append( L, [ su[k], k+n1 ] ); 
                fi; 
            od; 
            SetEntrySCTable( T, i+n1, j, L ); 
        od; 
        for j in [1..n2] do 
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
    SetSemidirectProductOfAlgebrasInfo( P, rec( algebras := [ A1, A2 ], 
                                                action := act, 
                                                embeddings := [ ], 
                                                projections := [ ] ) ); 
    return P; 
end );


#############################################################################
##
#A Embedding
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
    local info, vecP, dimP, A1, dim1, z1, A2, dim2, z2, vec1, vec2, 
          imgs, j, hom;
    # check
    info := SemidirectProductOfAlgebrasInfo( P );
    if IsBound( info.projections[i] ) then 
        return info.projections[i];
    fi;
    vecP := BasisVectors( Basis( P ) ); 
    dimP := Length( vecP ); 
    A1 := info.algebras[1]; 
    dim1 := Dimension( A1 ); 
    z1 := Zero( A1 ); 
    A2 := info.algebras[2]; 
    dim2 := Dimension( A2 ); 
    z2 := Zero( A2 ); 
    vec1 := BasisVectors( Basis( A1 ) ); 
    vec2 := BasisVectors( Basis( A2 ) ); 
    imgs := ListWithIdenticalEntries( dimP, 0 ); 
    if ( i = 1 ) then 
        for j in [1..dim1] do 
            imgs[j] := vec1[j]; 
        od; 
        for j in [dim1+1..dimP] do 
            imgs[j] := z1; 
        od; 
        hom := AlgebraHomomorphismByImages( P, A1, vecP, imgs ); 
    elif ( i = 2 ) then 
        return fail; 
    else 
        Error( "only the first projection is available" ); 
    fi; 
    ## SetIsSurjective( hom, true ); 
    info.projections[i] := hom;
    return hom;
end );
