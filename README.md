# CUTEst-Julia-Ports

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.5142349.svg)](https://doi.org/10.5281/zenodo.5142349)

The CUTEst test set is a repository of optimization problems that require a Fortran compiler to run. 
The numerical expressions for these problems is stored in .SIF files, which appear to be an uncommon 
file format upon which that the CUTEst repository relies heavily.

The CUTEst Julia Ports repository holds Julia ports of most of the CUTEst unconstrained functions.
Currently, the Julia ports are only able to compute the sum value of an objective function. 
More work will be done in the near future to ensure that these ports are able to also compute the 
gradient and Hessian for the CUTEst unconstrained functions.

Of the functions currently in the main branch of the repository, the ones that are not working 
correctly have a comment above them in the script of the code. The functions working correctly 
do not have a comment above them in the script of the code. The main branch contains the final 
product of most of the codes, while other branches contain works in progress.

The documentation necessary to read an unconstrained problem from a SIF file is included in a PDF 
on the main branch. This documentation also works through an example of how to deconstruct a SIF 
file, as a further resource.

The file JuliaCUTEstModule is a module that can be used to determine the values of the objective 
functions of various problems. To call a CUTEst problem, use the command CUTEst("ProblemName"), 
for which the output is the problem name, if the problem is accounted for by the module. Moreover, 
the command obj("ProblemName",inputVector) outputs the value of the objective function for a 
given test problem and input vector. An example of how to use JuliaCUTEstModule in a separate 
script is included in the file JuliaCUTEstModuleExample.jl.
