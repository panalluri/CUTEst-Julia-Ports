xyz=rand(1:10,2)
x=convert(Array{Float64},xyz)
precision=100 #integer

problem = "BEALE"
a=JuliaCUTEstModule.CUTEstModel(problem) #check if problem is in module
b=JuliaCUTEstModule.vecLen(problem) #outputs length of input vector for problem

#compute obj func and grad values, given problem and input vector
function wrapfun(x,problem,precision)
    setprecision(precision)
    bx = convert(Array{BigFloat},x)
    if JuliaCUTEstModule.CUTEstModel(problem) == problem
        f = JuliaCUTEstModule.obj(problem,x)
        g = JuliaCUTEstModule.grad(problem,x)
        h = JuliaCUTEstModule.hess(problem,x)
    end
    return convert(Float64,f),convert(Array{Float64},g),convert(Matrix{Float64},h)
end

#time obj func and grad run times, given prob and input vec
function wrapfun2(x,problem,precision)
    setprecision(precision)
    bx = convert(Array{BigFloat},x)
    if JuliaCUTEstModule.CUTEstModel(problem) == problem
        JuliaCUTEstModule.tobj(problem,x)
        JuliaCUTEstModule.tgrad(problem,x)
        JuliaCUTEstModule.thess(problem,x)
    end
end

A = wrapfun(x,problem,precision)
println(A)
wrapfun2(x,problem,precision)