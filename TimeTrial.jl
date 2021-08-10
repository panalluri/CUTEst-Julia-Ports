using BenchmarkTools
using ForwardDiff
using CUTEst
using NLPModels

function genrose(x::AbstractVector)
    #println("Julia port of CUTEST's GENROSE")
    term = (1 - x[1])
    sum = 1 - term^2
    term = (x[length(x)] - 1)
    sum = sum + term^2
    for i = 1:length(x)-1
      term = (x[i+1] - x[i]^2)
      sum = sum + 100*term^2 + (1 - x[i])^2
    end
    return sum#, grad
end

problem = "GENROSE"
xyz=rand(1:10,500)
x=convert(Array{Float64},xyz)
A = @btime genrose(x)
B = @btime ForwardDiff.gradient(genrose,x)
nlp = CUTEstModel(problem, verbose=false)
fx = @btime obj(nlp, x)
gx = @btime grad(nlp, x)
finalize(nlp)