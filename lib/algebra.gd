#############################################################################
##
#W  algebra.gd                 The XMODALG package            Zekeriya Arvasi
#W                                                             & Alper Odabas
#Y  Copyright (C) 2014-2021, Zekeriya Arvasi & Alper Odabas,  
##

DeclareInfoClass( "InfoXModAlg" );

############################  algebra operations  ################### 

DeclareGlobalFunction( "MultiplierAlgebra" );

DeclareProperty( "IsMultiplierAlgebra", IsList );

#############################  algebra mappings  #################### 

DeclareOperation( "InclusionMappingAlgebra", [ IsAlgebra, IsAlgebra ] );
DeclareOperation( "RestrictionMappingAlgebra", 
   [ IsAlgebraHomomorphism, IsAlgebra, IsAlgebra ] );

DeclareOperation( "AlgebraHomomorphismByFunction",
    [ IsAlgebra, IsAlgebra, IsFunction ] );
    
DeclareOperation( "MultiplierHomomorphism",
    [ IsAlgebra ] );
    
DeclareOperation( "ModuleHomomorphism",
    [ IsAlgebra, IsRing ] ); 

##############################  algebra actions  #################### 

DeclareGlobalFunction( "ElementsLeftActing" );

DeclareProperty( "IsAlgebraAction", IsMapping );

DeclareGlobalFunction( "AlgebraAction" );
DeclareOperation( "AlgebraAction1",
    [ IsAlgebra, IsList, IsAlgebra ] );
DeclareAttribute( "LeftElementOfCartesianProduct", IsAlgebraAction );
DeclareAttribute( "AlgebraActionType", IsAlgebraAction );
DeclareAttribute( "HasZeroModuleProduct", IsAlgebraAction );

DeclareOperation( "AlgebraAction2",[ IsAlgebra ] );
DeclareOperation( "AlgebraAction3",[ IsAlgebraHomomorphism ] );
DeclareOperation( "AlgebraAction4",[ IsAlgebra, IsRing ] );
DeclareOperation( "AlgebraAction5",[ IsAlgebra, IsAlgebra ] );

##################################################################### 
