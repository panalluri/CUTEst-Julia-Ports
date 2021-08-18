using ForwardDiff
using LinearAlgebra
using SparseArrays

x = Vector{Float64}(undef, 4)
fill!(x, 2)
A = spzeros(length(x),length(x))

function f(x)
    sum = sin(x[1])+x[2]
    sum = sum + x[1]^2 + exp(x[2])
    sum = sum + cos(x[3])
    sum= sum+exp(x[4])
    return sum
end

# function f(x::AbstractVector)
#     #println("Julia port of CUTEST's BEALE")
#     grad = zeros(size(x))
#     N=2
#     A=-1.5+x[1]*(1-x[2]^1)
#     B=-2.25+x[1]*(1-x[2]^2)
#     C=-2.625+x[1]*(1-x[2]^3)
#     sum=A^2+B^2+C^2
#     return sum #, grad
# end

for i = 1:length(x)
    for j=1:length(x)
    t1s = ForwardDiff.Dual{Nothing,Float64, 1}
    t2s = ForwardDiff.Dual{Nothing,t1s, 1}

    x = Vector{Float64}(undef, 4)
    fill!(x, 2)
    seed = zeros(length(x))
    seed[i]=1
    dx = ForwardDiff.Dual.(x, seed)
    y = f(dx)
    z = ForwardDiff.partials.(y)
    seed2 = zeros(length(x))
    seed2[j] = 1
    ddx = ForwardDiff.Dual.(dx, seed2)
    c = f(ddx)
    z = ForwardDiff.partials.(c)
    w = split(string(z),",")
    v = split(w[2],")")
    A[i,j] = Meta.parse(v[1])
    println(z)
    end
end

println(A)
B=ForwardDiff.hessian(f,x)