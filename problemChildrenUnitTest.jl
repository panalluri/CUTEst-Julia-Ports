module Wrapper

export wrapfun

using CUTEst
using NLPModels

problemVector = ["SCHMVETT","SINVALNE","SCOSINE"]
sumArray=zeros(length(problemVector))
gradArray=zeros(length(problemVector))
len=zeros(length(problemVector))

function schmvett(x::AbstractVector)
    println("Julia port of CUTEST's SCHMVETT")
    grad = zeros(size(x))
    sum = 0
    for i = 1:(length(x)-2)
      term1 = x[i]-x[i+1]
      term2 = -1/(1+term1^2)
      term3 = 0.5*(pi*x[i+1]+x[i+2])
      term4 = -1*sin(term3)
      term5 = (x[i]+x[i+2])/x[i+1]
      term6 = -1*exp(-1*(term5-2)^2)
      sum = sum + term2+term4+term6
    end
    return sum#, grad
end

function sinvalne(x::AbstractVector)
    println("Julia port of CUTEST's SINVALNE")
    grad = zeros(size(x))
    term1=x[2]-sin(x[1])
    term2=0.5*x[1]
    sum=10*term1+term2
    return sum#, grad
end

function scosine(x::AbstractVector)
    println("Julia port of CUTEST's SCOSINE")
    grad = zeros(size(x))
    sum=0
    for i = 1:(length(x)-1)
        exp1 = 12*(i-1)/(length(x)-1)
        exp2 = (12*i)/(length(x)-1)
        term1 = -0.5*(exp(exp2))*x[i+1]
        term2 = (exp(exp1))^2*x[i]^2
        sum = sum + cos(term1+term2)
    end
    return sum#, grad
end

len[1]=5000
x=ones(5000)
sumArray[1] = schmvett(x)
len[2]=2
x=ones(2)
sumArray[2] = sinvalne(x)
len[3]=5000
x=ones(5000)
sumArray[3] = scosine(x)

function unitTesting(problemVector,sumArray,gradArray,len)
    sumArraySIF = ones(length(problemVector))
    gradArraySIF = ones(length(problemVector))
    for i = 1:length(problemVector)
        temp=convert(Int64,len[i])
        x=ones(temp)
        problem = problemVector[i]
        println("Working on: "*problem)
        nlp = CUTEstModel(problem, verbose=false)
        fx = obj(nlp, x)
        gx = grad(nlp, x)
        finalize(nlp)
        fx = convert(Float64,fx)
        #gx = convert(Array{Float64},gx)
        sumArraySIF[i] = fx
        #gradArraySIF[i] = gx
    end
    for i = 1:length(problemVector)
        if sumArray[i]-sumArraySIF[i] != 0
            println("Issue with sum: " * problemVector[i])
            println(sumArray[i])
            println(sumArraySIF[i])
            # println(x)
        end
        # if gradArray[i]-gradArraySIF[i] != 0
        #     println("grad: " * problemVector[i])
        #     # println(x)
        # end
    end
end

function unitTesting(problemVector,sumArray,gradArray,len)

end