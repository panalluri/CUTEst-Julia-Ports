using Diffractor

function powExp(x)
    sum = x^2
    return sum
end

function expanded(x)
    sum = x*x
    return sum
end

x=3.0
A=Diffractor.PrimeDerivativeBack(powExp)(x)
B=Diffractor.PrimeDerivativeBack(expanded)(x)
println(A)
println(B)
