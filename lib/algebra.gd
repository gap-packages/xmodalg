#############################################################################
##
#W  algebra.gd                 The XMODALG package            Zekeriya Arvasi
#W                                                             & Alper Odabas
#Y  Copyright (C) 2014-2021, Zekeriya Arvasi & Alper Odabas,  
##

DeclareInfoClass( "InfoXModAlg" );

############################  algebra operations  ################### 

DeclareProperty( "HasZeroAnnihilator", IsAlgebra and IsCommutative ); 

DeclareOperation( "RegularAlgebraMultiplier", 
    [ IsAlgebra, IsAlgebra, IsObject ] ); 
DeclareProperty( "IsAlgebraMultiplier", IsMapping ); 

DeclareOperation( "MultiplierAlgebraOfIdealBySubalgebra", 
    [ IsAlgebra, IsAlgebra, IsAlgebra ] );
DeclareOperation( "MultiplierAlgebraByGenerators", [ IsAlgebra, IsList ] ); 
DeclareAttribute( "MultiplierAlgebra", IsAlgebra, "mutable" ); 
DeclareAttribute( "MultiplierHomomorphism", IsAlgebra, "mutable" );
DeclareProperty( "IsMultiplierAlgebra", IsList ); 

#############################  algebra mappings  #################### 

DeclareOperation( "InclusionMappingAlgebra", [ IsAlgebra, IsAlgebra ] );
DeclareOperation( "RestrictionMappingAlgebra", 
   [ IsAlgebraHomomorphism, IsAlgebra, IsAlgebra ] );

DeclareOperation( "AlgebraHomomorphismByFunction",
    [ IsAlgebra, IsAlgebra, IsFunction ] );
    
DeclareOperation( "ModuleHomomorphism",
    [ IsAlgebra, IsRing ] ); 

DeclareOperation( "AllAlgebraHomomorphisms", 
    [ IsAlgebra, IsAlgebra ] );
DeclareOperation( "AllBijectiveAlgebraHomomorphisms", 
    [ IsAlgebra, IsAlgebra ] );
DeclareOperation( "AllIdempotentAlgebraHomomorphisms", 
    [ IsAlgebra, IsAlgebra ] );

##############################  algebra actions  #################### 

DeclareGlobalFunction( "ElementsLeftActing" );

DeclareProperty( "IsAlgebraAction", IsMapping );

DeclareGlobalFunction( "AlgebraAction" );
DeclareAttribute( "LeftElementOfCartesianProduct", IsAlgebraAction );
DeclareAttribute( "AlgebraActionType", IsAlgebraAction );
DeclareAttribute( "HasZeroModuleProduct", IsAlgebraAction );

DeclareOperation( "AlgebraAction2", [ IsAlgebra ] );
DeclareOperation( "AlgebraActionBySurjection", [ IsAlgebraHomomorphism ] );
DeclareOperation( "AlgebraActionByModule", [ IsAlgebra, IsRing ] );
DeclareOperation( "AlgebraActionByMultipliers", 
    [ IsAlgebra, IsAlgebra, IsAlgebra ] );

DeclareOperation ( "SemidirectProductOfAlgebras", 
    [ IsAlgebra, IsAlgebraAction, IsAlgebra ] ); 
DeclareAttribute( "SemidirectProductOfAlgebrasInfo", IsAlgebra, "mutable" );

##################################################################### 
