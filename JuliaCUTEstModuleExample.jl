xyz=rand(1:10,500)
x=convert(Array{Float64},xyz)
precision=52 #integer

problem = "GENROSE"
a=JuliaCUTEstModule.CUTEstModel(problem) #check if problem is in module
b=JuliaCUTEstModule.vecLen(problem) #outputs length of input vector for problem

#compute obj func value, given problem and input vector
function wrapfun(x,problem,precision)
    setprecision(precision)
    bx = convert(Array{BigFloat},x)
    if JuliaCUTEstModule.CUTEstModel(problem) == problem
        f = JuliaCUTEstModule.obj(problem,x)
    end
    return convert(Float64,f)#,convert(Array{Float64},g)
end

A = wrapfun(x,problem,precision)
println(A)