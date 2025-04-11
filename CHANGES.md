# CHANGES to the 'XModAlg' package

## 1.27 -> 1.32 (11/04/25) 
 * (31/01/25) added Nizar Shammu's thesis to the list of references;
              removed all operations involving direct sums of crossed modules
              of algebras because the theoretical basis needs checking;
 
## 1.26 -> 1.27 (26/10/24) 
 * (21/10/24) removed references to "Type2" and "XModAlgebraConst"
              tests now use local variables and are mirrored in /examples
              xmod.tst now agrees with sections 4.1.7-4.1.10 in the manual
              changed names of variables in tests to avoid duplications

## 1.25 -> 1.26 (09/07/24) 
 * (08/07/24) renamed the actions and algebras in the tests/examples as 
              act1, act2, ,,, act6  and added direct sum operations
              AlgebraActionOnDirectSum and DirectSumAlgebraActions
 * (17/05/24) added operations for a module as an algebra,
              revised XModAlgebraByModule
 * (26/06/24) added AlgebraActionByHomomorphism,
              changed the example of XModAlgebraByBoundaryAndAction

## 1.23 -> 1.25 (17/05/24) 
 * (17/05/24) just 5 PRs since 1.23 came out - mostly CI changes

## 1.22 -> 1.23 (03/12/22) 
 * (03/12/22) changed AlgebraHomomorphismByFunction to agree with FR version 
              and prior to the function being moved to the main GAP library 

## 1.18 -> 1.22 (29/04/22) 
 * (27/04/22) required version 2.87 of XMod which uses Size2d in place of
              Size, and so replaced Size by Size2d for 2d-algebras 
 * (15/07/21) revised PreXModAlgebraOfPreCat1Algebra 
 * (14/07/21) revised IsPreXModAlgebra and IsXModAlgebra 
              renamed AlgebraAction4 as AlgebraActionByModule 
 * (09/07/21) added section on Multipliers and MultiplierAlgebras 
 * (09/06/21) renamed AlgebraAction3 as AlgebraActionBySurjection 
              renamed XModAlgebraByCentralExtension XModAlgebraBySurjection 
              revised these operations and added examples
 * (25/05/21) renamed AlgebraAction1 as AlgebraActionByMultipliers 
              added operation SemidirectProductofAlgebras 
              added chapter Commutative algebras and their actions to manual
 * (12/05/21) added algebra attribute AugmentationXMod 
 * (11/05/21) added lib/vspchom.gi as a temporary fix 

## 1.17 -> 1.18 (16/11/20) 
 * (07/08/20) fixed problem with Cat1AlgebraOfXModAlgebra 
              introduced ImagesSource2DimensionalMapping
 * (09/10/18) Conversion files: use "Of", not "By".  Delete SDproduct. 
 * (23/09/18) PreCat1Obj replaced by PreCat1AlgebraByTailHeadEmbedding 
 * (22/09/18) split off convert.xml and convert.tst from cat1.xml and cat1.tst 

## 1.16 -> 1.17 (30/08/18)
 * (29/08/18) added method for ImagesSource at end of alg2map.gi 
 * (28/08/18) update examples to avoid travis failures 

## 1.15 -> 1.16
 * (29/01/18) changed package releases to https://gap-packages.github.io/xmodalg

## 1.14 -> 1.15
 * (09/01/18) correction the release archive

## 1.13 -> 1.14 
 * (02/12/17) adjust test files to work correctly after LoadAllPackages(); 
 * (30/11/17) now requires XMod 2.64 
 * (01/11/17) now requires Laguna 3.7.0 
 * (05/10/17) moved testall.g to testing.g and added new testall.g 
 * (05/10/17) converted manual.bib to bib.xml 
 * (05/10/17) converted README and CHANGES to MarkDown files 

## 1.12 -> 1.13 
 * (30/09/17) created Github repository for 'XModAlg' 

## initial release 
 * Version 1.12 was prepared for the 4.* release at November 2015.




