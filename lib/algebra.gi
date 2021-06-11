#############################################################################
##
#W  algebra.gi                 The XMODALG package            Zekeriya Arvasi
#W                                                             & Alper Odabas
#Y  Copyright (C) 2014-2021, Zekeriya Arvasi & Alper Odabas,  
##

############################  algebra operations  ########################### 

#############################################################################
##
#M  IsMultiplierAlgebra
##
InstallMethod( IsMultiplierAlgebra, "generic method for 2-dim algebra objects",
    true, [ IsList ], 0,
function( obj )
    return ( ForAll( obj, IsMapping ) );
end );

#############################################################################
##
#F  MultiplierAlgebra( <R> )
##
#T  expect this to return an algebra? 
## 
InstallGlobalFunction( MultiplierAlgebra, 
function ( R )
    local   uzR, elR,MR,r,f,i;
    if not (IsAlgebra(R)=true) then
        return false;
    fi; 
    uzR := Size(R);
    elR := Elements(R);
    MR := [];
    for i in [1..uzR] do 
        r := elR[i];
        f := GroupHomomorphismByFunction( R, R, x->r*x );
        #if ( (f in MR) = false ) then
           Add(MR,f);
        #fi;
    od;
    SetIsMultiplierAlgebra(MR,true);
    # return the mapping
    return MR;
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
#F  AlgebraHomomorphismByFunction( <D>, <E>, <fun> )
##
InstallMethod( AlgebraHomomorphismByFunction, "for 2 algebras and a function", 
    true, [ IsAlgebra, IsAlgebra, IsFunction ], 0,
function ( A,B,C )
    local act,arg,narg,usage,error,fun;        # mapping <map>, result
    act := rec( fun := C );
    ObjectifyWithAttributes( act, 
        NewType(GeneralMappingsFamily( ElementsFamily(FamilyObj(A)),
            ElementsFamily(FamilyObj(B)) ),
        IsSPMappingByFunctionRep and IsSingleValued
            and IsTotal and IsAlgebraHomomorphism ),
        Source, A,
        Range, B );
    # return the mapping
    return act;
end );

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
    # Algebra and Ideal
    if ( ( nargs = 3 ) and IsAlgebra( arg[1] )
                       and IsAlgebra( arg[3] ) ) then
        return AlgebraAction1( arg[1], arg[2], arg[3] );
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
        return AlgebraAction4( arg[1],arg[2] );   
    fi;
    # alternatives not allowed
    Error( "usage: XModAlgebra( bdy, act );  or  XModAlgebra( G, N );" );
end );

#############################################################################
##
#F  AlgebraAction1( <D>, <E>, <fun> )
##
InstallMethod( AlgebraAction1, "for,for,for", true,
    [ IsAlgebra, IsList, IsAlgebra ], 0,
function ( A, B, C )
    local act,arg,narg,usage,error;        # mapping <map>, result
    narg := 3;
    usage := "\n Usage: input two propositions; \n";
    error := "\n Error: input positive value; \n";
    if ((narg < 3) or (narg >= 4)) then
        Print(usage);
        return false;
    fi;
    act := rec( fun:= x->x[1]*x[2]);
    ObjectifyWithAttributes( act, 
        NewType(GeneralMappingsFamily( ElementsFamily(FamilyObj(B) ),
        ElementsFamily( FamilyObj(C)) ),
        IsSPMappingByFunctionRep and IsSingleValued
            and IsTotal and IsGroupHomomorphism ),
        LeftElementOfCartesianProduct, A,
        AlgebraActionType, "Type1",
        Source, B,
        Range, C,
        HasZeroModuleProduct, false,
        IsAlgebraAction, true);
    # return the mapping
    return act;
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
        p := PreImagesRepresentative( hom, b ); 
        im := List( vecA, a -> p*a );
        maps[j] := LeftModuleHomomorphismByImages( A, A, vecA, im );
    od;
    M := Algebra( dom, maps );
    act := LeftModuleGeneralMappingByImages( B, M, vecB, maps );
    SetIsAlgebraAction( act, true );
    SetAlgebraActionType( act, "Type3" );
    SetHasZeroModuleProduct( act, false );
    return act;
end );

#############################################################################
##
#F  AlgebraAction4( <D>, <E>, <fun> )
##
InstallMethod( AlgebraAction4, "for,for,for", true, [ IsAlgebra, IsRing ], 0,
function ( M,R )
    local   act,RM;        # mapping <map>, result
    RM := Cartesian(R,M);
    act := rec( fun:= x->x[1]*x[2]);
    ObjectifyWithAttributes( act, 
        NewType( GeneralMappingsFamily( ElementsFamily(FamilyObj(RM) ),
            ElementsFamily( FamilyObj(M) ) ),
        IsSPMappingByFunctionRep and IsSingleValued
            and IsTotal and IsGroupHomomorphism ),
        LeftElementOfCartesianProduct, R,
        AlgebraActionType, "Type4",
        Source, RM,
        Range, M,
        HasZeroModuleProduct, true,
        IsAlgebraAction, true );
    # return the mapping
    return act;
end );

#############################################################################
##
#F  AlgebraActionByMultiplication( <A>, <I> )
##
InstallMethod( AlgebraActionByMultiplication, "for an algebra and an ideal", 
    true, [ IsAlgebra, IsAlgebra ], 0,
function ( A, I )
    local basA, basI, vecA, genA, dimA, maps, j, im, M, act, eA;
    genA := GeneratorsOfAlgebra( A );
    basA := Basis( A );
    vecA := BasisVectors( basA );
    dimA := Dimension( A );
    basI := Basis( I );
    maps := ListWithIdenticalEntries( dimA, 0 );
    if ( dimA > 0  ) then
        for j in [1..dimA] do
            im := List( basI, b -> vecA[j]*b );
            maps[j] := LeftModuleHomomorphismByImages( I, I, basI, im );
        od;
        M := Algebra( LeftActingDomain(A), maps );
        act := LeftModuleGeneralMappingByImages( A, M, vecA, maps );
    else
        maps := [ IdentityMapping(I) ];
        M := Algebra( LeftActingDomain( A ), maps );
        eA := Elements(A);
        act := LeftModuleGeneralMappingByImages( A, M, [eA[1]], 
                   GeneratorsOfAlgebra( M ) );
    fi;    
    SetIsAlgebraAction( act, true );
    SetAlgebraActionType( act, "Type5" );
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
