using Enzyme
# using CUTEst
# using NLPModels
A = Dict{String,Function}()

function genrose(x::AbstractVector)
  println("Julia port of CUTEST's GENROSE")
  grad = zeros(size(x))
  term = (1 - x[1])
  grad[1] = 2 * term
  sum = 1 - term^2
  term = (x[size(x,1)] - 1)
  grad[size(x,1)] = 2 * term
  sum = sum + term^2
  for i = 1:length(x)-1
    term = (x[i+1] - x[i]^2)
    sum = sum + 100*term^2 + (1 - x[i])^2
    grad[i] = grad[i] - 2 * (1-x[i]) - 400*x[i]*term
    grad[i+1] = grad[i+1] + 200*term
  end
  return sum, grad
end

A["GENROSE"]=function genrose2(x::AbstractVector)
    println("Julia port of CUTEST's GENROSE")
    term = (1 - x[1])
    sum = 1 - term^2
    term = (x[size(x,1)] - 1)
    sum = sum + term^2
    for i = 1:length(x)-1
      term = (x[i+1] - x[i]^2)
      sum = sum + 100*term^2 + (1 - x[i])^2
    end
    return sum
end

B=Dict("GENROSE"=>500)
problemVector=collect(keys(A))
z=rand(1:10,10^8)

function unitTesting(problemVector,z)
    for i = 1:length(A)
        problem = problemVector[i]
        lens=B[problem]
        x=z[1:lens]
        temp=A[problem](x)
        sumPort=temp
        println("Working on: "*problem)
        # nlp = CUTEstModel(problem, verbose=false)
        # fx = obj(nlp, x)
        # gx = grad(nlp, x)
        # finalize(nlp)
        # sumCUTEst = convert(Float64,fx)
        # if sumPort-sumCUTEst != 0
        #     println("Issue with sum: " * problemVector[i])
        #     println(sumPort)
        #     println(sumCUTEst)
        # end
        # gradCUTEst = convert(Array{Float64},gx)
        gradPort = zero(x)
        Z = autodiff(A[problem],Active,Duplicated(x,gradPort))
        println(gradPort)
        # if gradPort-gradCUTEst != 0
        #     println("Issue with gradient: " * problemVector[i])
        #     println(gradPort)
        #     println(gradCUTEst)
        # end
    end
end

unitTesting(problemVector,z)

# x = ones(500)
# df_dx = zero(x)
# Z = autodiff(A["GENROSE"],Active,Duplicated(x,df_dx))
#A,C = genrose(x)

#println(A["GENROSE"](x))
# println(df_dx-C)