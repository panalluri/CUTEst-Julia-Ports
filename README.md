# CUTEst-Julia-Ports
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
