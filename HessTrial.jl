using ForwardDiff
# using CUTEst
# using NLPModels

# function power(x::AbstractVector)
#     #println("Julia port of CUTEST's POWER")
#     sum = 0
#     for i = 1:length(x)
#       term = i*x[i]^2
#       sum = sum + term
#     end
#     sum = sum^2
#     return sum#, grad
# end

#problem = "BIGGS6"
#xyz=rand(1:10,6)
xyz = ones(10000)
x=convert(Array{Float64},xyz)
# nlp = CUTEstModel(problem, verbose=false)
# hx = hess(nlp, x)
# finalize(nlp)
# hessCUTEst = convert(Array{Float64},hx)
hessPort = ForwardDiff.hessian(power,x)
lens=500
for i = 2:(length(x)-1)
    println(hessPort[i,(i-1):(i+1)])
end
# for i = 1:lens
#     for j = 1:lens
#         if abs(hessPort[i,j]-hessCUTEst[i,j]) >= 10^(-3)
#             println(string(hessPort[i,j]))
#             println(string(hessCUTEst[i,j]))
#             println("i"*string(i)*" j"*string(j))
#         end
#     end
# end