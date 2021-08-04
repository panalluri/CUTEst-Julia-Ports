using Diffractor
# using CUTEst
# using NLPModels

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

function genrose2(x::AbstractVector)
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
problem="GENROSE"
z=rand(1:10,10^8)
z=convert(Array{Float64},z)

function unitTesting(problem,z)
    lens=B[problem]
    x=z[1:lens]
    f,g = genrose(x)
    println("grad:"*string(g))
    temp=genrose2(x)
    sumPort=temp
    gradPort = Diffractor.PrimeDerivativeBack(genrose2)(x)
    println(gradPort)
    for i = 1:length(x)
      if gradPort[i] != g[i]
        println("Error in grad element "*string(i)*"! Diffractor: "*string(gradPort[i])*", genrose func: "*string(g[i]))
      end
    end
end

unitTesting(problem,z)
