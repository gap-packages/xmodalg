#############################################################################
##
#W  util.gi                 The XMODALG package           Zekeriya Arvasi
#W                                                             & Alper Odabas
##  version 1.15, 09/01/2018 
##
#Y  Copyright (C) 2014-2018, Zekeriya Arvasi & Alper Odabas,  
##

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
### IsInjective çalýþmýyor NC ile üretilmiþ morfizmlerde
SetIsInjective(inc,true );
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
InstallMethod(RestrictedMapping,"create new GHBI",
  CollFamSourceEqFamElms,[IsAlgebraHomomorphism,IsAlgebra],0,
function(hom,U)
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
