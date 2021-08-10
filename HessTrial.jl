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
xyz=rand(1:10,10)
x=convert(Array{Float64},xyz)
nlp = CUTEstModel(problem, verbose=false)
hx = hess(nlp, x)
finalize(nlp)
hessCUTEst = convert(Array{Float64},hx)
hessPort = ForwardDiff.hessian(genrose,x)
hErr=0
lens=500
for i = 1:lens
    for j = 1:lens
        if abs(hessPort[i,j]-hessCUTEst[i,j]) >= 10^(-3)
            println(string(hessPort[i,j]))
            println(string(hessCUTEst[i,j]))
            println("i"*string(i)*" j"*string(j))
        end
    end
end