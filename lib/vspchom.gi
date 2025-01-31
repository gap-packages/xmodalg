##  This is a temporary file, created 11/5/21 
##  it contains a fix to the following operation method 
##  which was added to gapdev at that time. 
##  So this file needs to be ReRead when XModAlg is loaded until such time 
##  as the gapdev fix has become part of the standard distribution. 

#############################################################################
##
#F  MakeImagesInfoLinearGeneralMappingByImages( <map> )
##
##  Provide the information for computing images, that is, set up
##  the components `basispreimage', `imagesbasispreimage', `corelations'.
##
BindGlobal( "MakeImagesInfoLinearGeneralMappingByImages", function( map )
    local preimage,
          ech,
	  mapi,
          B;

    preimage:= PreImagesRange( map );
    mapi:= MappingGeneratorsImages( map );

    if   Dimension( preimage ) = 0 then

      # Set the entries explicitly.
      map!.basispreimage       := Basis( preimage );
      map!.corelations         := IdentityMat( Length( mapi[2] ),
                                      LeftActingDomain( preimage ) );
      map!.imagesbasispreimage := Immutable( [] );

    elif IsGaussianRowSpace( Source( map ) ) then
#T operation MakeImagesInfo( map, source )
#T to leave this to the method selection ?
#T or flag `IsFromGaussianSpace' ?

      # The images of the basis vectors are obtained on
      # forming the linear combinations of images of generators
      # given by `ech.coeffs'.

      ech:= SemiEchelonMatTransformation( mapi[1] );
      map!.basispreimage       := SemiEchelonBasisNC(
                                      preimage, ech.vectors );
      map!.corelations         := Immutable( ech.relations );
      map!.imagesbasispreimage := Immutable( ech.coeffs * mapi[2] );
#T problem if mapi[2] is a basis and if this does not store that it is a small list!

    else

      # Delegate the work to the associated row space.
      B:= Basis( preimage );
      ech:= SemiEchelonMatTransformation( List( mapi[1],
                     x -> Coefficients( B, x ) ) );
      map!.basispreimage       := BasisNC( preimage,
                                      List( ech.vectors,
                                        x -> LinearCombination( B, x ) ) );
      map!.corelations         := Immutable( ech.relations );
      map!.imagesbasispreimage := Immutable( List( ech.coeffs,
                                    x -> LinearCombination( mapi[2], x ) ) );

    fi;
end );
