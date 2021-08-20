using ForwardDiff
using LinearAlgebra
using SparseArrays
using CUTEst
using NLPModels

x = Vector{Float64}(undef, 4)
fill!(x, 2)
x = rand(1:10,1000)
x=convert(Array{Float64},x)
A = spzeros(length(x),length(x))

function f(x::AbstractVector)
    #println("Julia port of CUTEST's KSSLS")
    #grad = zeros(size(x))
    sum=0
    for i = 1:length(x)
        term1 = x[i]^2 - (length(x)-1) - 3*x[i]
        for j = 1:(i-1)
            term1 = term1 + x[j]
        end
        for j = (i+1):(length(x))
            term1 = term1 + x[j]
        end
        sum = sum + term1^2
    end
    return sum#, grad
end

for j = 1:length(x)
    for k=1:length(x)
        t1s = ForwardDiff.Dual{Nothing,Float64, 1}
        t2s = ForwardDiff.Dual{Nothing,t1s, 1}
        seed = zeros(length(x))
        seed[j]=1
        dx = ForwardDiff.Dual.(x, seed)
        y = f(dx)
        z = ForwardDiff.partials.(y)
        seed2 = zeros(length(x))
        seed2[k] = 1
        ddx = ForwardDiff.Dual.(dx, seed2)
        c = f(ddx)
        z = ForwardDiff.partials.(c)
        A[j,k] = z.values[1].partials.values[1]
    end
end

# nlp = CUTEstModel("KSSLS", verbose=false)
# hx = hess(nlp, x)
# finalize(nlp)

println(A)
# B=ForwardDiff.hessian(f,x)
# println(B)

