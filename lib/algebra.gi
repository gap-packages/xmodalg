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
        return AlgebraAction3( arg[1] );
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
function ( A,B,C )
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
#F  AlgebraAction3( <f> )
##
InstallMethod( AlgebraAction3, "for,for,for", true, [IsAlgebraHomomorphism], 0,
function ( f )
    local act,g,BA,A,B;        # mapping <map>, result
    A := Source(f);
    B := Range(f);
    BA := Cartesian(B,A);
    g := InverseGeneralMapping(f);
    ### act := rec( fun:= x->PreImage(g,x[1])*x[2]); 
    act := rec( fun:= x->ImagesRepresentative(g,x[1])*x[2]);
    ObjectifyWithAttributes( act, 
        NewType(GeneralMappingsFamily( ElementsFamily( FamilyObj(BA) ),
            ElementsFamily( FamilyObj(A) ) ),
        IsSPMappingByFunctionRep and IsSingleValued
            and IsTotal and IsGroupHomomorphism ),
        LeftElementOfCartesianProduct, B,
        AlgebraActionType, "Type3",
        Source, BA,
        Range, A,
        HasZeroModuleProduct, false,
        IsAlgebraAction, true );
    # return the mapping
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
#F  AlgebraAction5( <A>, <I> )
##
InstallMethod( AlgebraAction5, "for,for", true, [ IsAlgebra, IsAlgebra ], 0,
function ( A,I )
    local basA,basI,vecA,genA,dimA,maps,j,im,M,act,eA;
    genA := GeneratorsOfAlgebra(A);
    basA := Basis(A);
    vecA := BasisVectors(basA);
    dimA := Dimension(A);
    basI := Basis(I);
    maps := ListWithIdenticalEntries(dimA,0);
    if ( dimA > 0  ) then
        for j in [1..dimA] do
            im := List(basI, b -> vecA[j]*b);
            maps[j] := LeftModuleHomomorphismByImages(I,I,basI,im);
        od;
        M := Algebra( LeftActingDomain(A),maps);
        act := LeftModuleGeneralMappingByImages(A,M,vecA,maps);
    else
        maps := [ IdentityMapping(I) ];
        M := Algebra( LeftActingDomain(A),maps);
        eA := Elements(A);
        act := LeftModuleGeneralMappingByImages( A, M, [eA[1]], 
                   GeneratorsOfAlgebra( M ) );
    fi;    
    SetIsAlgebraAction( act, true );
    SetAlgebraActionType( act, "Type5" );
    SetHasZeroModuleProduct( act, false );
    return act;
end );

