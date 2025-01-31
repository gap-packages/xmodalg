############################################################################
##
#W  alg2map.gi                 The XMODALG package           Zekeriya Arvasi
#W                                                            & Alper Odabas
#Y  Copyright (C) 2014-2025, Zekeriya Arvasi & Alper Odabas,  
##

############################################################################
##
#M  Make2dAlgebraMorphism( <src>, <rng>, <shom>, <rhom> )  . . 2d-object map 
##
InstallMethod( Make2dAlgebraMorphism,
    "for 2d-object, 2d-object, homomorphism, homomorphism", true,
    [ Is2dAlgebraObject, Is2dAlgebraObject, IsAlgebraHomomorphism, IsAlgebraHomomorphism ], 0,
function( src, rng, shom, rhom )

    local  filter, fam, mor, ok;

    fam := FamilyObj( [ src, rng, shom, rhom ] );
    filter := Is2dAlgebraMorphismRep;
    ok := ( ( Source( src ) = Source( shom ) ) and
            (  Range( src ) = Source( rhom ) ) and
            ( Source( rng ) = Range( shom ) ) and
            (  Range( rng ) = Range( rhom ) ) );
    if not ok then
        Info( InfoXModAlg, 2, "sources and ranges do not match" );
        return fail;
    fi;
    mor := rec();
    ObjectifyWithAttributes( mor, 
      NewType( fam, filter ),
      Source, src,
      Range, rng,
      IsEmpty, true,
      SourceHom, shom,
      RangeHom, rhom );
    return mor;
end );

############################################################################
##
#M  IsPreXModAlgebraMorphism          check diagram of algebra homs commutes
##
InstallMethod( IsPreXModAlgebraMorphism,
    "generic method for pre-crossed module homomorphisms",
    true, [ Is2dAlgebraMorphism ], 0,
function( mor )

    local PM, Pact, Pbdy, Prng, Psrc, QM, Qact, Qbdy, Qrng, Qsrc, basPrng, 
          vecPrng, dimPrng, basPsrc, maps, i, j, im, im2, basQrng, vecQrng, 
          dimQrng, basQsrc, maps2, morsrc, morrng, x2, x1, y2, z2, y1, z1, 
          gensrc, genrng, cx1, gx1, gcx1, actx1, actgx1;

    PM := Source( mor );
    QM := Range( mor );
    if not ( IsPreXModAlgebra( PM ) and IsPreXModAlgebra( QM ) ) then
        return false;
    fi;
    Psrc := Source( PM );
    Prng := Range( PM );
    Pbdy := Boundary( PM );
    Pact := XModAlgebraAction( PM );
    Qsrc := Source( QM );
    Qrng := Range( QM );
    Qbdy := Boundary( QM );
    Qact := XModAlgebraAction( QM );
    morsrc := SourceHom( mor );
    morrng := RangeHom( mor );
    gensrc := GeneratorsOfAlgebra( Psrc );
    genrng := GeneratorsOfAlgebra( Prng );
    Info( InfoXModAlg, 3, "Checking that the diagram commutes :- \n",
        "    boundary( morsrc( x ) ) = morrng( boundary( x ) )" );
    for x2 in gensrc do
        y1 := ( x2 ^ morsrc ) ^ Qbdy;
        z1 := ( x2 ^ Pbdy ) ^ morrng;
        if not ( y1 = z1 ) then
            Info( InfoXModAlg, 3, "Square does not commute! \n",
                "when x2= ", x2, " Qbdy( morsrc(x2) )= ", y1, "\n",
                "              and morrng( Pbdy(x2) )= ", z1 );
            return false;
        fi;
    od;
    # now check that the actions commute:
    Info( InfoXModAlg, 3,
          "Checking:  morsrc(x2^x1) = morsrc(x2)^(morrng(x1))" );
    if ( IsLeftModuleGeneralMapping(Pact) = true ) then
        basPrng := Basis(Prng);
        vecPrng := BasisVectors(basPrng);
        dimPrng := Dimension(Prng);
        basPsrc := Basis(Psrc);
        maps := ListWithIdenticalEntries(dimPrng,0);
        for j in [1..dimPrng] do
            im := List(basPsrc, b -> vecPrng[j]*b);
            maps[j] := LeftModuleHomomorphismByImages(Psrc,Psrc,basPsrc,im);
        od;
        basQrng := Basis(Qrng);
        vecQrng := BasisVectors(basQrng);
        dimQrng := Dimension(Qrng);
        basQsrc := Basis(Qsrc);
        maps2 := ListWithIdenticalEntries(dimQrng,0);
        for j in [1..dimQrng] do
           im2 := List(basQsrc, b -> vecQrng[j]*b);
           maps2[j] := LeftModuleHomomorphismByImages(Qsrc,Qsrc,basQsrc,im2);
        od;
        for x2 in gensrc do
            for x1 in genrng do
                cx1 := Coefficients(basPrng,x1);
                actx1 := Sum(List([1..dimPrng], i -> cx1[i]*maps[i]));
                gx1 := x1 ^ morrng;
                gcx1 := Coefficients(basQrng,gx1);
                actgx1 := Sum(List([1..dimQrng], i -> gcx1[i]*maps2[i]));
                y2 := (x2^actx1)^morsrc; 
                z2 := (x2^morsrc)^actgx1;
                if not ( y2 = z2 ) then
                    Info( InfoXModAlg, 2, "Actions do not commute! \n",
                          "When  x2 = ", x2, "  and  x1 = ", x1, "\n",
                          "           morsrc(x2^x1) = ", y2, "\n",
                          "and morsrc(x2)^(morrng(x1) = ", z2 );
                    return false;
                fi;
            od;
        od;      
    else
        for x2 in gensrc do
            for x1 in genrng do
                y2 := ( [ x1 , x2 ] ^ Pact) ^ morsrc; 
                z2 := [ x1 ^ morrng , x2 ^ morsrc ] ^ Qact ;
                if not ( y2 = z2 ) then
                    Info( InfoXModAlg, 2, "Actions do not commute! \n",
                          "When  x2 = ", x2, "  and  x1 = ", x1, "\n",
                          "           morsrc(x2^x1) = ", y2, "\n",
                          "and morsrc(x2)^(morrng(x1) = ", z2 );
                    return false;
                fi;
            od;
        od;
    fi;
    return true;
end );

############################################################################
##
#F  Display( <mor> ) . . .  print details of a (pre-)crossed module morphism
##
InstallMethod( Display, "display a morphism of pre-crossed modules", true,
    [ IsPreXModAlgebraMorphism ], 0,
    function( mor )

    local morsrc, morrng, gensrc, genrng, imsrc, imrng, P, Q, name, ok;    
    name := Name( mor );
    P := Source( mor );
    Q := Range( mor );
    morsrc := SourceHom( mor );
    gensrc := GeneratorsOfAlgebra( Source( P ) );
    morrng := RangeHom( mor );
    genrng := GeneratorsOfAlgebra( Range( P ) );
    if IsXModAlgebraMorphism( mor ) then
        Print( "\nMorphism of crossed modules :- \n" );
    else
        Print( "\nMorphism of pre-crossed modules :- \n" );
    fi;
## temporary fix (21/03/18)
##    Print( ": Source = ", P, " with generating sets:\n  " );
##    Print( gensrc, "\n  ", genrng, "\n" );
    Print( ": Source = " ); 
    ViewObj( P );
    Print( "\n" ); 
    if ( Q = P ) then
        Print( ": Range = Source\n" );
    else
##        Print( ":  Range = ", Q, " with generating sets:\n  " ); 
    Print( ":  Range = " ); 
    ViewObj( Q );
    Print( "\n" );
## temporary removal (21/03/18)
##        Print( GeneratorsOfAlgebra( Source( Q ) ), "\n" );
##        Print( "  ", GeneratorsOfAlgebra( Range( Q ) ), "\n" );
    fi;
    imsrc := List( gensrc, s -> Image( morsrc, s ) ); 
    Print( ": Source Homomorphism maps source generators to:\n" );
    Print( "  ", imsrc, "\n" );
    imrng := List( genrng, r -> Image( morrng, r ) ); 
    Print( ": Range Homomorphism maps range generators to:\n" );
    Print( "  ", imrng, "\n" );
    Print( "\n" );
end ); 

############################################################################
##
#M  IsXModAlgebraMorphism
##
InstallMethod( IsXModAlgebraMorphism,
    "generic method for pre-crossed module morphisms", true,
    [ IsPreXModAlgebraMorphism ], 0,
function( mor )
    return ( IsXModAlgebra( Source( mor ) ) 
           and IsXModAlgebra(  Range( mor ) ) );
end );

InstallMethod( IsXModAlgebraMorphism, "generic method for 2d-mappings", true,
    [ Is2dAlgebraMorphism ], 0,
function( mor )
    local  ispre;
    ispre := IsPreXModAlgebraMorphism( mor );
    if not ispre then
        return false;
    else
        return IsXModAlgebra( Source(mor) and IsXModAlgebra( Range(mor) ) );
    fi;
end );

############################################################################
##
#M  IdentityMapping( <obj> )
##
InstallOtherMethod( IdentityMapping, "for 2d-algebra object", true,
    [ Is2dAlgebraObject ], 0,
function( obj )

    local  shom, rhom;

    shom := IdentityMapping( Source( obj ) );
    rhom := IdentityMapping( Range( obj ) );
    if IsPreXModAlgebraObj( obj ) then
#### xmodu ekleyince tekrar duzenle########
        return PreXModAlgebraMorphismByHoms( obj, obj, shom, rhom );
####    return fail;
    elif IsPreCat1AlgebraObj( obj ) then
        return PreCat1AlgebraMorphismByHoms( obj, obj, shom, rhom );
    else
        return fail;
    fi;
end );

############################################################################
##
#F  PreXModAlgebraMorphism( <src>,<rng>,<srchom>,<rnghom> ) 
##
##  (need to extend to other sets of parameters)
##
InstallGlobalFunction( PreXModAlgebraMorphism, function( arg )

    local  nargs;
    nargs := Length( arg );

    # two pre-xmods and two homomorphisms
    if ( ( nargs = 4 ) and IsPreXModAlgebra( arg[1] ) 
                       and IsPreXModAlgebra( arg[2])
                       and IsAlgebraHomomorphism( arg[3] )
                       and IsAlgebraHomomorphism( arg[4] ) ) then
        return PreXModAlgebraMorphismByHoms(arg[1],arg[2],arg[3],arg[4]);
    fi;
    # alternatives not allowed
    Info( InfoXModAlg, 2, 
          "usage: PreXModAlgebraMorphism( src, rng, srchom, rnghom );" );
    return fail;
end );

##############################################################################
##
#F  XModAlgebraMorphism( <src>, <rng>, <srchom>, <rnghom> ) 
##
##  (need to extend to other sets of parameters)
##
InstallGlobalFunction( XModAlgebraMorphism, function( arg )

    local  nargs;
    nargs := Length( arg );

    # two xmods and two homomorphisms
    if ( ( nargs = 4 ) and IsXModAlgebra( arg[1] ) 
                       and IsXModAlgebra( arg[2])
                       and IsAlgebraHomomorphism( arg[3] )
                       and IsAlgebraHomomorphism( arg[4] ) ) then
        return XModAlgebraMorphismByHoms(arg[1],arg[2],arg[3],arg[4]);
    fi;
    # alternatives not allowed
    Info( InfoXModAlg, 2, 
          "usage: XModAlgebraMorphism( src, rng, srchom, rnghom );" );
    return fail;
end );

############################################################################
##
#M  XModMorphismByHoms( <Xs>, <Xr>, <hsrc>, <hrng> )  . . make xmod morphism
##
InstallMethod( XModAlgebraMorphismByHoms, "for 2 xmods and 2 homomorphisms",
    true, [ IsXModAlgebra, IsXModAlgebra, 
            IsAlgebraHomomorphism, IsAlgebraHomomorphism ], 0,
function( src, rng, srchom, rnghom )

    local  mor, ok;
    mor := PreXModAlgebraMorphismByHoms( src, rng, srchom, rnghom );
    if ( mor = fail ) then
        return fail;
    fi;
    ok := IsXModAlgebraMorphism( mor ) and Is2DimensionalMapping( mor );
    if not ok then
        return fail;
    fi;
    return mor;
end );

############################################################################
##
#M  PreXModAlgebraMorphismByHoms( <P>, <Q>, <hsrc>, <hrng> ) . . make prexmod morphism
##
InstallMethod( PreXModAlgebraMorphismByHoms,
    "for pre-xmod, pre-xmod, homomorphism, homomorphism,", true,
    [ IsPreXModAlgebra, IsPreXModAlgebra, IsAlgebraHomomorphism,
      IsAlgebraHomomorphism ], 0,
function( src, rng, srchom, rnghom )

    local  filter, fam, mor, ok, nsrc, nrng, name;

    if not ( IsAlgebraHomomorphism(srchom) 
             and IsAlgebraHomomorphism(rnghom) ) then
        Info( InfoXModAlg,2, "source, range mappings must be algebra homs" );
        return fail;
    fi;
    mor := Make2dAlgebraMorphism( src, rng, srchom, rnghom );
    if not IsPreXModAlgebraMorphism( mor ) then
        Info( InfoXModAlg, 2, "not a morphism of pre-crossed modules.\n" );
        return fail;
    fi;
    if ( HasName( Source(src) ) and HasName( Range(src) ) ) then
        nsrc := Name( src );
    else
        nsrc := "[..]";
    fi;
    if ( HasName( Source(rng) ) and HasName( Range(rng) ) ) then
        nrng := Name( rng );
    else
        nrng := "[..]";
    fi;
    name := Concatenation( "[", nsrc, " => ", nrng, "]" );
    SetName( mor, name );
    ok := IsXModAlgebraMorphism( mor );
    #### ok := IsSourceMorphism( mor );
    return mor;
end );

############################################################################
##
#F  PreCat1AlgebraMorphism( <src>,<rng>,<srchom>,<rnghom> )
##
##  (need to extend to other sets of parameters)
##
InstallGlobalFunction( PreCat1AlgebraMorphism, function( arg )

    local  nargs;
    nargs := Length( arg );

    # two pre-cat1s and two homomorphisms
    if ( ( nargs = 4 ) and IsPreCat1Algebra( arg[1] ) 
                       and IsPreCat1Algebra( arg[2])
                       and IsAlgebraHomomorphism( arg[3] )
                       and IsAlgebraHomomorphism( arg[4] ) ) then
        return PreCat1AlgebraMorphismByHoms(arg[1],arg[2],arg[3],arg[4]);
    fi;
    # alternatives not allowed
    Info( InfoXModAlg, 2, 
          "usage: PreCat1AlgebraMorphism( src, rng, srchom, rnghom );" );
    return fail;
end );

############################################################################
##
#F  Cat1AlgebraMorphism( <src>, <rng>, <srchom>, <rnghom> ) 
##
##  (need to extend to other sets of parameters)
##
InstallGlobalFunction( Cat1AlgebraMorphism, function( arg )

    local  nargs;
    nargs := Length( arg );

    # two cat1s and two homomorphisms
    if ( ( nargs = 4 ) and IsCat1Algebra( arg[1] ) 
                       and IsCat1Algebra( arg[2])
                       and IsAlgebraHomomorphism( arg[3] )
                       and IsAlgebraHomomorphism( arg[4] ) ) then
        return Cat1AlgebraMorphismByHoms(arg[1],arg[2],arg[3],arg[4]);
    fi;
    # alternatives not allowed
    Info( InfoXModAlg, 2, 
          "usage: Cat1AlgebraMorphism( src, rng, srchom, rnghom );" );
    return fail;
end );

############################################################################
##
#M  IsPreCat1AlgebraMorphism . . check that the diagram of group homs commutes
##
InstallMethod( IsPreCat1AlgebraMorphism,
    "generic method for mappings of 2d-objects", true, 
    [ Is2dAlgebraMorphism ], 0,
function( mor )

    local  PCG, Prng, Psrc, Pt, Ph, Pe, QCG, Qrng, Qsrc, Qt, Qh, Qe,
           morsrc, morrng, x2, x1, y2, z2, y1, z1, gensrc, genrng;

    PCG := Source( mor );
    QCG := Range( mor );
    if not ( IsPreCat1Algebra( PCG ) and IsPreCat1Algebra( QCG ) ) then
        return false;
    fi;
    Psrc := Source( PCG );
    Prng := Range( PCG );
    Pt := TailMap( PCG );
    Ph := HeadMap( PCG );
    Pe := RangeEmbedding( PCG );
    Qsrc := Source( QCG );
    Qrng := Range( QCG );
    Qt := TailMap( QCG );
    Qh := HeadMap( QCG );
    Qe := RangeEmbedding( QCG );
    morsrc := SourceHom( mor );
    morrng := RangeHom( mor );
    # now check that the homomorphisms commute
    gensrc := GeneratorsOfAlgebra( Psrc );
    genrng := GeneratorsOfAlgebra( Prng );
    Info( InfoXModAlg, 3,
          "Checking that the diagrams commute :- \n",
          "    tail/head( morsrc( x ) ) = morrng( tail/head( x ) )" );
    for x2 in gensrc do
        y1 := ( x2 ^ morsrc ) ^ Qt;
        z1 := ( x2 ^ Pt ) ^ morrng;
        y2 := ( x2 ^ morsrc ) ^ Qh;
        z2 := ( x2 ^ Ph ) ^ morrng;
        if not ( ( y1 = z1 ) and ( y2 = z2 ) ) then
            Info( InfoXModAlg, 3, "Square does not commute! \n",
                  "when x2= ", x2, " Qt( morsrc(x2) )= ", y1, "\n",
                  "              and morrng( Pt(x2) )= ", z1, "\n",
                  "              and Qh( morsrc(x2) )= ", y2, "\n",
                  "              and morrng( Ph(x2) )= ", z2 );
            return false;
        fi;
    od;
    for x2 in genrng do
        y1 := ( x2 ^ morrng ) ^ Qe;
        z1 := ( x2 ^ Pe ) ^ morsrc;
        if not ( y1 = z1 ) then
            Info( InfoXModAlg, 3, "Square does not commute! \n",
                  "when x2= ", x2, " Qe( morrng(x2) )= ", y1, "\n",
                  "              and morsrc( Pe(x2) )= ", z1 );
            return false;
        fi;
    od;
    return true;
end );

############################################################################
##
#F  Display( <mor> ) . . . . print details of a (pre-)cat1-algebra morphism
##
InstallMethod( Display, "display a morphism of pre-cat1 algebras", true,
    [ IsPreCat1AlgebraMorphism ], 0,
function( mor )

    local  morsrc, morrng, gensrc, genrng, P, Q, name, ok;

    if not HasName( mor ) then
        # name := PreCat1AlgebraMorphismName( mor );
        SetName( mor, "[..=>..]=>[..=>..]" );
    fi;
    name := Name( mor );
    P := Source( mor );
    Q := Range( mor );
    morsrc := SourceHom( mor );
    gensrc := GeneratorsOfAlgebra( Source( P ) );
    morrng := RangeHom( mor );
    genrng := GeneratorsOfAlgebra( Range( P ) );
    if IsCat1AlgebraMorphism( mor ) then
        Print( "\nMorphism of cat1-algebras :- \n" );
    else
        Print( "\nMorphism of pre-cat1 algebras :- \n" );
    fi;
    Print( ": Source = ", P, " with generating sets:\n  " );
    Print( gensrc, "\n  ", genrng, "\n" );
    if ( Q = P ) then
        Print( ": Range = Source\n" );
    else
        Print( ":  Range = ", Q, " with generating sets:\n  " );
        Print( GeneratorsOfAlgebra( Source( Q ) ), "\n" );
        Print( "  ", GeneratorsOfAlgebra( Range( Q ) ), "\n" );
    fi;
    Print( ": Source Homomorphism maps source generators to:\n" );
    Print( "  ", List( gensrc, s -> Image( morsrc, s ) ), "\n" );
    Print( ": Range Homomorphism maps range generators to:\n" );
    Print( "  ", List( genrng, r -> Image( morrng, r ) ), "\n" );
    Print( "\n" );
end ); 

############################################################################
##
#M  Name                                                      for a pre-xmod
##
InstallMethod( Name, "method for a 2d-mapping", true, [ Is2dAlgebraMorphism ], 0,
function( mor )

    local  nsrc, nrng, name;

    if HasName( Source( mor ) ) then
        nsrc := Name( Source( mor ) );
    else
        nsrc := "[...]";
    fi;
    if HasName( Range( mor ) ) then
        nrng := Name( Range( mor ) );
    else
        nrng := "[...]";
    fi;
    name := Concatenation( "[", nsrc, " => ", nrng, "]" );
    SetName( mor, name );
    return name;
end );

############################################################# ###############
##
#M  IsCat1AlgebraMorphism
##
InstallMethod( IsCat1AlgebraMorphism, "generic method for cat1-algebra homomorphisms",
    true, [ IsPreCat1AlgebraMorphism ], 0,
function( mor )
    return ( IsCat1Algebra( Source( mor ) ) and IsCat1Algebra(  Range( mor ) ) );
end );

InstallMethod( IsCat1AlgebraMorphism, "generic method for 2d-mappings", true,
    [ Is2dAlgebraMorphism ], 0,
function( mor )
    local  ispre;
    ispre := IsPreCat1AlgebraMorphism( mor );
    if not ispre then
        return false;
    else
        return ( IsCat1Algebra( Source( mor ) ) 
                 and IsCat1Algebra(  Range( mor ) ) );
    fi;
end );

############################################################################
##
#M  PreCat1AlgebraMorphismByHoms( <P>, <Q>, <hsrc>, <hrng> ) . make pre-cat1-alg morphism
##
InstallMethod( PreCat1AlgebraMorphismByHoms,
    "for pre-cat1-algebra, pre-cat1-algebra, homomorphism, homomorphism,",
    true, [ IsPreCat1Algebra, IsPreCat1Algebra, 
            IsAlgebraHomomorphism, IsAlgebraHomomorphism ], 0,
function( src, rng, srchom, rnghom )

    local  filter, fam, mor, ok, nsrc, nrng, name;

    if not ( IsAlgebraHomomorphism(srchom) 
             and IsAlgebraHomomorphism(rnghom) ) then
        Info( InfoXModAlg, 2, 
              "source and range mappings must be algebra homs" );
        return fail;
    fi;
    mor := Make2dAlgebraMorphism( src, rng, srchom, rnghom );
    if not IsPreCat1AlgebraMorphism( mor ) then
        Info( InfoXModAlg, 2, "not a morphism of pre-cat1 algebras.\n" );
        return fail;
    fi;
    if ( HasName( Source(src) ) and HasName( Range(src) ) ) then
        nsrc := Name( src );
    else
        nsrc := "[..]";
    fi;
    if ( HasName( Source(rng) ) and HasName( Range(rng) ) ) then
        nrng := Name( rng );
    else
        nrng := "[..]";
    fi;
    name := Concatenation( "[", nsrc, " => ", nrng, "]" );
    SetName( mor, name );
    ok := IsCat1AlgebraMorphism( mor );
    return mor;
end );

############################################################################
##
#M  Cat1AlgebraMorphismByHoms( <Cs>, <Cr>, <hsrc>, <hrng> ) 
##
InstallMethod( Cat1AlgebraMorphismByHoms, "for 2 cat1s and 2 homomorphisms", true,
    [ IsCat1Algebra, IsCat1Algebra, IsAlgebraHomomorphism, IsAlgebraHomomorphism ], 0,
function( src, rng, srchom, rnghom )

    local  mor, ok;
    mor := PreCat1AlgebraMorphismByHoms( src, rng, srchom, rnghom );
    ok := IsCat1AlgebraMorphism( mor );
    if not ok then
        return fail;
    fi;
    return mor;
end );

############################################################################
##
#M  ViewObj( <mor> ) . . . . . . . . . view a (pre-)crossed module morphism
##
InstallMethod( ViewObj, "method for a morphism of pre-crossed modules", true,
    [ IsPreXModAlgebraMorphism ], 0,
function( mor )
    if HasName( mor ) then
        Print( Name( mor ), "\n" );
    else
        Print( "[", Source( mor ), " => ", Range( mor ), "]" );
    fi;
end );

############################################################################
##
#M  PrintObj( <mor> ) . . . . . . . . .  print a (pre-)crossed module morphism
##
InstallMethod( PrintObj, "method for a morphism of pre-crossed modules",
    true, [ IsPreXModAlgebraMorphism ], 0,
function( mor )
    if HasName( mor ) then
        Print( Name( mor ), "\n" );
    else
        Print( "[", Source( mor ), " => ", Range( mor ), "]" );
    fi;
end );

############################################################################
##
#M  ViewObj( <PCG> ) . . . . . . . . . . . . . . . view a (pre-)cat1-algebra
##
InstallMethod( ViewObj, "method for a morphism of pre-cat1 algebras", true,
    [ IsPreCat1AlgebraMorphism ], 0,
function( mor )
    if HasName( mor ) then
        Print( Name( mor ), "\n" );
    else
        Print( "[", Source( mor ), " => ", Range( mor ), "]" );
    fi;
end );

############################################################################
##
#M  PrintObj( <PCG> ) . . . . . . . . . . . . .  print a (pre-)cat1-algebra
##
InstallMethod( PrintObj, "method for a morphism of pre-cat1 algebras", true,
    [ IsPreCat1AlgebraMorphism ], 0,
function( mor )
    if HasName( mor ) then
        Print( Name( mor ), "\n" );
    else
        Print( "[", Source( mor ), " => ", Range( mor ), "]" );
    fi;
end );

############################################################################
##
#M  Kernel . . . . . . of morphisms of pre-crossed modules of algebras 
#M         . . . . . . and pre-cat1-groups of algebras
##
InstallOtherMethod( Kernel, "generic method for 2d-mappings",
     true, [ Is2DimensionalMapping and Is2dAlgebraMorphism ], 0,
function( map )

    local  kerS, kerR, K;
    if HasKernel2DimensionalMapping( map ) then
        return Kernel2DimensionalMapping( map );
    fi;
    kerS := Kernel( SourceHom( map ) ); 
    kerR := Kernel( RangeHom( map ) ); 
    K := Sub2dAlgebra( Source( map ), kerS, kerR );
    SetKernel2DimensionalMapping( map, K );
    return K;
end );

############################################################################
##
#M  IsInjective( map ) . . . . . . . . . . . . .  . . .  for a 2dAlg-mapping
##
InstallOtherMethod( IsInjective,
    "method for a 2dAlg-mapping", true, [ Is2dAlgebraMorphism ], 0,
    map -> (     IsInjective( SourceHom( map ) )
             and IsInjective( RangeHom( map ) ) )  );

############################################################################
##
#M  IsSurjective( map ) . . . . . . . . . . . . . . . . for a 2dAlg-mapping
##
InstallOtherMethod( IsSurjective,
    "method for a 2dAlg-mapping", true, [ Is2dAlgebraMorphism ], 0,
    map -> (     IsSurjective( SourceHom( map ) )
             and IsSurjective( RangeHom( map ) ) )  );

############################################################################
##
#M  IsSingleValued( map ) . . . . . . . . . . . . . . . for a 2dAlg-mapping
##
InstallOtherMethod( IsSingleValued,
    "method for a 2dAlg-mapping", true, [ Is2dAlgebraMorphism ], 0,
    map -> (     IsSingleValued( SourceHom( map ) )
             and IsSingleValued( RangeHom( map ) ) )  );

############################################################################
##
#M  IsTotal( map ) . . . . . . . . . . . . . . . . . .  for a 2dAlg-mapping
##
InstallOtherMethod( IsTotal,
    "method for a 2dAlg-mapping", true, [ Is2dAlgebraMorphism ], 0,
    map -> (     IsTotal( SourceHom( map ) )
             and IsTotal( RangeHom( map ) ) )  );

############################################################################
##
#M  IsBijective( map ) . . . . . . . . . . . . . . . .  for a 2dAlg-mapping
##
InstallOtherMethod( IsBijective,
    "method for a 2d-mapping", true, [ Is2dAlgebraMorphism ], 0,
    map -> (     IsBijective( SourceHom( map ) )
             and IsBijective( RangeHom( map ) ) )  );

############################################################################
##
#M  ImagesSource2DimensionalMapping( <mor> ) .  for pre-xmod/cat1 alg morphs
##
InstallOtherMethod( ImagesSource2DimensionalMapping, 
    "image of pre-xmod/cat1 algebra morphism", true, 
    [ Is2DimensionalMapping and Is2dAlgebraMorphism ], 0, 
function( mor )
    
    local Shom, Rhom, imS, imR, sub;

    if not Is2dAlgebraMorphism( mor ) then 
        Error( "general method not yet implemented" ); 
    fi; 
    Shom := SourceHom( mor );
    Rhom := RangeHom( mor );
    imS := ImagesSource( Shom );
    imR := ImagesSource( Rhom );
    sub := Sub2dAlgebra( Range( mor ), imS, imR );
    return sub;
end );

