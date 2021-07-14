module Wrapper

export wrapfun

using CUTEst
using NLPModels

problemVector = ["LOGHAIRY","QUARTC","TQUARTIC","NONDQUAR","QING","SSI","KSSLS","POWELLSG","POWELLBSLS","POWELLSQLS","WAYSEA2","WAYSEA1","PENALTY1","DQRTIC","BDQRTIC","DQDRTIC","WOODS","DANWOODLS","DANIWOODLS","ARGTRIGLS","CURLY10","CURLY20","CURLY30","SCURLY30","SCURLY20","SCURLY10","BROWNAL","BROWNBS","BROWNDEN","HELIX","MEXHAT","POWERSUM","SPARSQUR","ELATVIDU","LANCZOS3LS","TRIGON2","DENSCHNE","MISRA1CLS","PALMER4C","CRAGGLVY","PALMER3C","LANCZOS1LS","CHNROSNB","EDENSCH","RECIPELS","EGGCRATE","CHWIRUT1LS","MGH10LS","HATFLDGLS","BARD","ERRINROS","HATFLDFLS","MOREBV","ARGLINB","HATFLDFL","DEVGLA1"]
sumArray=zeros(length(problemVector))
gradArray=zeros(length(problemVector))
len=zeros(length(problemVector))

function loghairy(x::AbstractVector)
    println("Julia port of CUTEST's LOGHAIRY")
    #grad = zeros(size(x))
    term1 = 30*sin(7*x[1])^2*cos(7*x[1])^2
    term2 = (x[1]-x[2])^2 + 0.01
    term3 = 0.01+x[1]^2
    sum = 0.01*(100+ term1 + 100*sqrt(term2) + 100*sqrt(term3))
    sum=log(sum)
    return sum#, grad
end

function quartc(x::AbstractVector)
    println("Julia port of CUTEST's QUARTC")
    #grad = zeros(size(x))
    sum = 0
    for i = 1:length(x)
      term = (x[i]-i)
      sum = sum + (term)^4
    end
    return sum#, grad
end

function tquartic(x::AbstractVector)
    println("Julia port of CUTEST's TQUARTIC")
    #grad = zeros(size(x))
    sum = (x[1]-1)^2
    for i = 2:(length(x))
      term1 = (x[i]^2-x[i]^2)^2
      sum = sum + term1
    end
    return sum#, grad
end

function nondquar(x::AbstractVector)
    println("Julia port of CUTEST's NONDQUAR")
    #grad = zeros(size(x))
    sum = (x[1]-x[2])^2 + (x[length(x)-1]-x[length(x)])^2
    half=convert(Int64,0.5*length(x))
    for i = 1:(length(x)-2)
      term1 = x[i] + x[i+1] + x[length(x)]
      sum = sum + (term1)^4
    end
    return sum#, grad
end

function qing(x::AbstractVector)
    println("Julia port of CUTEST's QING")
    #grad = zeros(size(x))
    sum = 0
    for i = 1:length(x)
      term1 = x[i]^2-i
      sum = sum + (term1)^2 
    end
    return sum#, grad
end

function ssi(x::AbstractVector)
    println("Julia port of CUTEST's SSI")
    term1 = x[1]^2*x[3]-4
    term2 = x[2]^2+x[3]
    #grad = zeros(size(x))
    sum = 0.5*term1^2 + 0.5*term2^2
    return sum#, grad
end

function kssls(x::AbstractVector)
    println("Julia port of CUTEST's KSSLS")
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

function powellsg(x::AbstractVector)
    println("Julia port of CUTEST's POWELLSG")
    #grad = zeros(size(x))
    sum=0
    for i = 1:4:(length(x))
        term1 = x[i] + 10*x[i+1]
        term2 = x[i+2]-x[i+3]
        term3 = x[i+1]-2*x[i+2]
        term4 = x[i]-x[i+3]
        sum = sum + term1^2 + 5*term2^2 + term3^4 + 10*term4^4
    end
    return sum#, grad
end

function powellbsls(x::AbstractVector)
    println("Julia port of CUTEST's POWELLBSLS")
    #grad = zeros(size(x))
    sum=0
    for i = 1:(length(x)-1)
        term1 = 10^4*x[i]*x[i+1]-1
        term2 = -1.0001+exp(-x[i+1])+exp(-x[i])
        sum = sum + term1^2 + term2^2
    end
    return sum#, grad
end

function powellsqls(x::AbstractVector)
    println("Julia port of CUTEST's POWELLSQLS")
    #grad = zeros(size(x))
    term1= x[1]^4
    term2 = 2*x[2]^2 + 10*x[1]/(x[1]+0.1)
    sum=term1+term2^2
    return sum#, grad
end

function waysea2(x::AbstractVector)
    println("Julia port of CUTEST's WAYSEA2")
    #grad = zeros(size(x))
    sum=(x[2]-1)^2
    term=0
    for i = 1:length(x)
        term= term - 4*x[i]^2
    end
    term = term + 2.5*x[1]+13*x[2]-9.340125
    sum = sum + term^2
    return sum#, grad
end

function waysea1(x::AbstractVector)
    println("Julia port of CUTEST's WAYSEA1")
    grad = zeros(size(x))
    term1 = x[2]^4+x[1]^6-17
    term2 = 2*x[1]+x[2]-4
    sum = term1^2 + term2^2
    return sum#, grad
end

function penalty1(x::AbstractVector)
    println("Julia port of CUTEST's PENALTY1")
    grad = zeros(size(x))
    sum = 0
    for i = 1:length(x)
      term = x[i]-1
      sum = sum + 10^(-5)*term^2
    end
    sum1 = -0.25
    for i = 1:length(x)
      sum1 = sum1 + x[i]^2
    end
    sum= sum+sum1^2
    return sum#, grad
end

function dqrtic(x::AbstractVector)
    println("Julia port of CUTEST's DQRTIC")
    grad = zeros(size(x))
    sum = 0
    for i = 1:(length(x))
      term1 = i*x[i]-i
      sum=sum+term1^4
    end
    return sum#, grad
end

function bdqrtic(x::AbstractVector)
    println("Julia port of CUTEST's BDQRTIC")
    grad = zeros(size(x))
    sum=0
    for i = 1:(length(x)-4)
      term1 = 3-4*x[i]
      term2 = x[i]^2+2*x[i+1]^2+3*x[i+2]^2+4*x[i+3]^2+5*x[length(x)]^2
      sum = sum + term1^2 + term2^2
    end
    return sum#, grad
end

function dqdrtic(x::AbstractVector)
    println("Julia port of CUTEST's DQDRTIC")
    grad = zeros(size(x))
    sum=0
    for i = 1:(length(x)-2)
      sum = sum + 100*x[i+1]^2 + 100*x[i+2]^2 + x[i]^2
    end
    return sum#, grad
end

#ENTIRELY DYSFUNCTIONAL
function woods(x::AbstractVector)
    println("Julia port of CUTEST's WOODS")
    #grad = zeros(size(x))
    sum = 0
    M = convert(Int64,length(x)/4)
    for i = 1:M
      term1 = x[4*i-2]-x[4*i-3]^2
      term2 = 1-x[4*i-3]
      term3 = x[4*i]-x[4*i-1]^2
      term4 = -x[4*i-1]+1
      term5 = x[4*i-2]+x[4*i]-2
      term6 = x[4*i-2]-x[4*i]
      sum = sum+ 100*term1^2+term2^2+90*term3^2+term4^2+10*term5^2+0.1*term6^2
    end
    sum=sum+1
    return sum#, grad
end

function danwoodls(x::AbstractVector)
    println("Julia port of CUTEST's DANWOODLS")
    grad = zeros(size(x))
    sum = 0
    X=zeros(6)
    Y=zeros(6)
    X[1]=1.309
    X[2]=1.471
    X[3]=1.490
    X[4]=1.565
    X[5]=1.611
    X[6]=1.680

    Y[1]=2.138
    Y[2]=3.421
    Y[3]=3.597
    Y[4]=4.340
    Y[5]=4.882
    Y[6]=5.660
    for i = 1:6
      term1 = (x[1]*X[i])^(x[2])-Y[i]
      sum=sum+term1^2
    end
    return sum#, grad
end

function daniwoodls(x::AbstractVector)
    println("Julia port of CUTEST's DANIWOODLS")
    grad = zeros(size(x))
    sum = 0
    X=zeros(6)
    Y=zeros(6)
    X[1]=1.309
    X[2]=1.471
    X[3]=1.490
    X[4]=1.565
    X[5]=1.611
    X[6]=1.680

    Y[1]=2.138
    Y[2]=3.421
    Y[3]=3.597
    Y[4]=4.340
    Y[5]=4.882
    Y[6]=5.660
    for i = 1:6
        term1 = x[1]*(X[i])^(x[2])-Y[i]
        sum=sum+term1^2
    end
    return sum#, grad
end

function argtrigls(x::AbstractVector)
    println("Julia port of CUTEST's ARGTRIGLS")
    grad = zeros(size(x))
    sum = 0
    sum1=0
    for i = 1:(length(x))
      term1 = -1*(length(x)+i)
      term2 = i*(sin(x[i])+cos(x[i]))
      sum1 = sum1 + term1+term2
      for j = 1:length(x)
        sum1 = sum1 + cos(x[j])
      end
      sum = sum+ sum1^2
      sum1=0
    end
    return sum#, grad
end

function curly10(x::AbstractVector)
    println("Julia port of CUTEST's CURLY10")
    grad = zeros(size(x))
    sum = 0
    for i = 1:(length(x)-10)
        sum1=0
        for j = i:(i+10)
            sum1=sum1+x[j]
        end
        sum=sum+sum1*(sum1*(sum1^2-20)-0.1)
    end
    for i = (length(x)-9):(length(x))
        sum1=0
        for j = i:length(x)
            sum1=sum1+x[j]
        end
        sum=sum+sum1*(sum1*(sum1^2-20)-0.1)
    end
    return sum#, grad
end

function curly20(x::AbstractVector)
    println("Julia port of CUTEST's CURLY20")
    grad = zeros(size(x))
    sum = 0
    for i = 1:(length(x)-20)
        sum1=0
        for j = i:(i+20)
            sum1=sum1+x[j]
        end
        sum=sum+sum1*(sum1*(sum1^2-20)-0.1)
    end
    for i = (length(x)-19):(length(x))
        sum1=0
        for j = i:length(x)
            sum1=sum1+x[j]
        end
        sum=sum+sum1*(sum1*(sum1^2-20)-0.1)
    end
    return sum#, grad
end

function curly30(x::AbstractVector)
    println("Julia port of CUTEST's CURLY30")
    grad = zeros(size(x))
    sum = 0
    for i = 1:(length(x)-30)
        sum1=0
        for j = i:(i+30)
            sum1=sum1+x[j]
        end
        sum=sum+sum1*(sum1*(sum1^2-20)-0.1)
    end
    for i = (length(x)-29):(length(x))
        sum1=0
        for j = i:length(x)
            sum1=sum1+x[j]
        end
        sum=sum+sum1*(sum1*(sum1^2-20)-0.1)
    end
    return sum#, grad
end

function scurly30(x::AbstractVector)
    println("Julia port of CUTEST's SCURLY30")
    grad = zeros(size(x))
    sum = 0
    for i = 1:(length(x)-30)
        sum1=0
        for j = i:(i+30)
            coeff = 12*(j-1)/(length(x)-1)
            sum1=sum1+exp(coeff)*x[j]
        end
        sum=sum+sum1*(sum1*(sum1^2-20)-0.1)
    end
    for i = (length(x)-29):(length(x))
        sum1=0
        for j = i:length(x)
            coeff = 12*(j-1)/(length(x)-1)
            sum1=sum1+exp(coeff)*x[j]
        end
        sum=sum+sum1*(sum1*(sum1^2-20)-0.1)
    end
    return sum#, grad
end

function scurly20(x::AbstractVector)
    println("Julia port of CUTEST's SCURLY20")
    grad = zeros(size(x))
    sum = 0
    for i = 1:(length(x)-20)
        sum1=0
        for j = i:(i+20)
            coeff = 12*(j-1)/(length(x)-1)
            sum1=sum1+exp(coeff)*x[j]
        end
        sum=sum+sum1*(sum1*(sum1^2-20)-0.1)
    end
    for i = (length(x)-19):(length(x))
        sum1=0
        for j = i:length(x)
            coeff = 12*(j-1)/(length(x)-1)
            sum1=sum1+exp(coeff)*x[j]
        end
        sum=sum+sum1*(sum1*(sum1^2-20)-0.1)
    end
    return sum#, grad
end

function scurly10(x::AbstractVector)
    println("Julia port of CUTEST's SCURLY10")
    grad = zeros(size(x))
    sum = 0
    for i = 1:(length(x)-10)
        sum1=0
        for j = i:(i+10)
            coeff = 12*(j-1)/(length(x)-1)
            sum1=sum1+exp(coeff)*x[j]
        end
        sum=sum+sum1*(sum1*(sum1^2-20)-0.1)
    end
    for i = (length(x)-9):(length(x))
        sum1=0
        for j = i:length(x)
            coeff = 12*(j-1)/(length(x)-1)
            sum1=sum1+exp(coeff)*x[j]
        end
        sum=sum+sum1*(sum1*(sum1^2-20)-0.1)
    end
    return sum#, grad
end

function brownal(x::AbstractVector)
    println("Julia port of CUTEST's BROWNAL")
    grad = zeros(size(x))
    sum = 0
    for i = 1:(length(x)-1)
      sum1=0
      term1 = 2*x[i]-(length(x)-1)
      sum1=sum1+term1
      for j = 1:(i-1)
        sum1=sum1+x[j]
      end
      for j = (i+1):length(x)
        sum1=sum1+x[j]
      end
      sum = sum+sum1^2
    end
    sum=sum+(x[1]*x[2]*x[3]*x[4]*x[5]*x[6]*x[7]*x[8]*x[9]*x[10]-1)^2
    return sum#, grad
end

function brownbs(x::AbstractVector)
    println("Julia port of CUTEST's BROWNBS")
    grad = zeros(size(x))
    sum=0
    for i = 1:(length(x)-1)
      term1 = -10^6 + x[i]
      term2 = -2*10^(-6)+x[i+1]
      term3 = -2+x[i]*x[i+1]
      sum = sum + term1^2 + term2^2+term3^2
    end
    return sum#, grad
end

function brownden(x::AbstractVector)
    println("Julia port of CUTEST's BROWNDEN")
    grad = zeros(size(x))
    sum = 0
    for i = 1:20
        term1 = x[1]+0.2*i*x[2]-exp(0.2*i)
        term2 = x[3]+sin(0.2*i)*x[4]-cos(0.2*i)
        sum = sum + (term1^2 + term2^2)^2
    end
    return sum#, grad
end

function helix(x::AbstractVector)
    println("Julia port of CUTEST's HELIX")
    grad = zeros(size(x))
    sum = 0
    term1 = x[3] + 1.5915494/(x[1]^2+x[2]^2)*x[2]-1.5915494*atan(x[2],x[1])
    term2 = sqrt(x[1]^2+x[2]^2)-1
    sum = sum + 100*term1^2 + 100*term2^2 + x[3]^2
    return sum#, grad
end

function mexhat(x::AbstractVector)
    println("Julia port of CUTEST's MEXHAT")
    grad = zeros(size(x))
    term1 = -0.02+10^4*(x[2]-x[1]^2)^2 + (x[1]-1)^2
    term2 = -1*(x[1]-1)^2-(x[1]-1)^2
    sum = 10^5*term1^2 + term2
    return sum#, grad
end

function powersum(x::AbstractVector)
    println("Julia port of CUTEST's POWERSUM")
    grad = zeros(size(x))
    sum = 0
    A=zeros(4)
    A[1]=1
    A[2]=2
    A[3]=3
    A[4]=2
    for i = 1:length(x)
      term1=0
      term2=0
      for j = 1:4
        term1=term1+exp(i*log(A[j]))
      end
      for j = 1:length(x)
        term2 = term2+x[j]^i
      end
      sum=sum+(-term1+term2)^2
    end
    return sum#, grad
end

function sparsqur(x::AbstractVector)
    println("Julia port of CUTEST's SPARSQUR")
    grad = zeros(size(x))
    sum = 0
    for i = 1:length(x)
      coeff = 0.5*i
      term = 0.5*x[i]^2+5*0.5*x[1]^2
      sum = sum + coeff*term^2
    end
    return sum#, grad
end

function elatvidu(x::AbstractVector)
    println("Julia port of CUTEST's ELATVIDU")
    grad = zeros(size(x))
    sum = 0
    term1 = x[2]-10+x[1]^2
    term2 = x[1]-7+x[2]^2
    term3 = x[1]^2+x[2]^3-1
    sum = sum + term1^2+term2^2+term3^2
    return sum#, grad
end

function lanczos3ls(x::AbstractVector)
    println("Julia port of CUTEST's LANCZOS3LS")
    grad = zeros(size(x))
    sum = 0
    X=zeros(24)
    Y=zeros(24)
    X[1]=0.00E+0
    X[2]=5.00E-2
    X[3]=1.00E-1
    X[4]=1.50E-1
    X[5]=2.00E-1
    X[6]=2.50E-1
    X[7]=3.00E-1
    X[8]=3.50E-1
    X[9]=4.00E-1
    X[10]=4.50E-1
    X[11]=5.00E-1
    X[12]=5.50E-1
    X[13]=6.00E-1
    X[14]=6.50E-1
    X[15]=7.00E-1
    X[16]=7.50E-1
    X[17]=8.00E-1
    X[18]=8.50E-1
    X[19]=9.00E-1
    X[20]=9.50E-1
    X[21]=1.00E+0
    X[22]=1.05E+0
    X[23]=1.10E+0
    X[24]=1.15E+0

    Y[1]=2.5134
    Y[2]=2.0443
    Y[3]=1.6684
    Y[4]=1.3664
    Y[5]=1.1232
    Y[6]=0.9269
    Y[7]=0.7679
    Y[8]=0.6389
    Y[9]=0.5338
    Y[10]=0.4479
    Y[11]=0.3776
    Y[12]=0.3197
    Y[13]=0.2720
    Y[14]=0.2325
    Y[15]=0.1997
    Y[16]=0.1723
    Y[17]=0.1493
    Y[18]=0.1301
    Y[19]=0.1138
    Y[20]=0.1000
    Y[21]=0.0883
    Y[22]=0.0783
    Y[23]=0.0698
    Y[24]=0.0624
    for i = 1:24
        term1 = x[1]*exp(-x[2]*X[i])
        term2= x[3]*exp(-x[4]*X[i])
        term3= x[5]*exp(-x[6]*X[i])
        sum = sum + (term1+term2+term3-Y[i])^2
    end
    return sum#, grad
end

function trigon2(x::AbstractVector)
    println("Julia port of CUTEST's TRIGON2")
    grad = zeros(size(x))
    sum = 1
    for i = 1:length(x)
      term1 = sqrt(8)*sin(7*(x[i]-0.9)^2)
      term2 = sqrt(6)*sin(14*(x[i]-0.9)^2)
      term3 = x[i] - 0.9
      sum = sum + (term1+term2)^2+term3^2
    end
    return sum#, grad
end

function denschne(x::AbstractVector)
    println("Julia port of CUTEST's DENSCHNE")
    grad = zeros(size(x))
    sum = x[1]^2+(x[2]+x[2]^2)^2+(exp(x[3])-1)^2
    return sum#, grad
end

function misra1cls(x::AbstractVector)
    println("Julia port of CUTEST's MISRA1CLS")
    grad = zeros(size(x))
    X=zeros(14)
    Y=zeros(14)
    sum = 0
    X[1]= 77.6
    X[2]=114.9
    X[3]=141.1
    X[4]=190.8
    X[5]=239.9
    X[6]=289.0
    X[7]=332.8
    X[8]=378.4
    X[9]=434.8
    X[10]=477.3
    X[11]=536.8
    X[12]=593.1
    X[13]=689.1
    X[14]=760.0

    Y[1]=10.07
    Y[2]=14.73
    Y[3]=17.94
    Y[4]=23.93
    Y[5]=29.61
    Y[6]=35.18
    Y[7]=40.02
    Y[8]=44.82
    Y[9]=50.76
    Y[10]=55.05
    Y[11]=61.01
    Y[12]=66.40
    Y[13]=75.47
    Y[14]=81.78
    for i = 1:14
      term1 = x[1]-Y[i]-x[1]/(sqrt(1+2*x[2]*X[i]))
      sum = sum + term1^2
    end
    return sum#, grad
end

function palmer4c(x::AbstractVector)
    println("Julia port of CUTEST's PALMER4C")
    grad = zeros(size(x))
    X=zeros(23)
    Y=zeros(23)
    X[1]= -1.658063
    X[2]= -1.570796
    X[3]= -1.396263
    X[4]= -1.221730
    X[5]= -1.047198
    X[6]= -0.872665
    X[7]= -0.741119
    X[8]= -0.698132
    X[9]= -0.523599
    X[10]=-0.349066
    X[11]=-0.174533
    X[12]=0.0
    X[13]=0.174533
    X[14]=0.349066
    X[15]=0.523599
    X[16]=0.698132
    X[17]=0.741119
    X[18]=0.872665
    X[19]=1.047198
    X[20]=1.221730
    X[21]=1.396263
    X[22]=1.570796
    X[23]=1.658063

    Y[1]=67.27625
    Y[2]=52.8537
    Y[3]=30.2718
    Y[4]=14.9888
    Y[5]=5.5675
    Y[6]=0.92603
    Y[7]=0.0
    Y[8]=0.085108
    Y[9]=1.867422
    Y[10]=5.014768
    Y[11]=8.263520
    Y[12]=9.8046208
    Y[13]=8.263520
    Y[14]=5.014768
    Y[15]=1.867422
    Y[16]=0.085108
    Y[17]=0.0
    Y[18]=0.92603
    Y[19]=5.5675
    Y[20]=14.9888
    Y[21]=30.2718
    Y[22]=52.8537
    Y[23]=67.27625
    sum = 0
    for i = 1:23
        term = x[1]+x[2]*X[i]^2+x[3]*X[i]^4+x[4]*X[i]^6+x[5]*X[i]^8+x[6]*X[i]^10+x[7]*X[i]^12+x[8]*X[i]^14-Y[i]
        sum = sum + term^2
    end
    return sum#, grad
end

function cragglvy(x::AbstractVector)
    println("Julia port of CUTEST's CRAGGLVY")
    grad = zeros(size(x))
    sum = 0
    M = convert(Int64,0.5*(length(x)-2))
    for i = 1:M
      term1 = exp(x[2*i-1])-x[2*i]
      term2 = x[2*i]-x[2*i-1]
      term3 = x[2*i+1]-x[2*i+2]+tan(x[2*i+1]-x[2*i+2])
      term4= x[2*i-1]
      term5 = x[2*i+2]-1
      sum = sum + term1^4+100*term2^6+term3^4+term4^8+term5^2
    end
    return sum#, grad
end

function palmer3c(x::AbstractVector)
    println("Julia port of CUTEST's PALMER3C")
    grad = zeros(size(x))
    X=zeros(23)
    Y=zeros(23)
    
    X[1]=-1.658063
    X[2]=-1.570796
    X[3]=-1.396263
    X[4]=-1.221730
    X[5]=-1.047198
    X[6]=-0.872665
    X[7]=-0.766531
    X[8]=-0.698132
    X[9]=-0.523599
    X[10]=-0.349066
    X[11]=-0.174533
    X[12]=0.0
    X[13]=0.174533
    X[14]=0.349066
    X[15]=0.523599
    X[16]=0.698132
    X[17]=0.766531
    X[18]=0.872665
    X[19]=1.047198
    X[20]=1.221730
    X[21]=1.396263
    X[22]=1.570796
    X[23]=1.658063

    Y[1]=64.87939
    Y[2]=50.46046
    Y[3]=28.2034
    Y[4]=13.4575
    Y[5]=4.6547
    Y[6]=0.59447
    Y[7]=0.0000
    Y[8]=0.2177
    Y[9]=2.3029
    Y[10]=5.5191
    Y[11]=8.5519
    Y[12]=9.8919
    Y[13]=8.5519
    Y[14]=5.5191
    Y[15]=2.3029
    Y[16]=0.2177
    Y[17]=0.0000
    Y[18]=0.59447
    Y[19]=4.6547
    Y[20]=13.4575
    Y[21]=28.2034
    Y[22]=50.46046
    Y[23]=64.87939

    sum = 0
    for i = 1:23
      term = x[1]+x[2]*X[i]^2+x[3]*X[i]^4+x[4]*X[i]^6+x[5]*X[i]^8+x[6]*X[i]^10+x[7]*X[i]^12+x[8]*X[i]^14-Y[i]
      sum = sum + term^2
    end
    return sum#, grad
end

function lanczos1ls(x::AbstractVector)
    println("Julia port of CUTEST's LANCZOS1LS")
    grad = zeros(size(x))
    sum = 0
    X=zeros(24)
    X[1]=0.00E+0
    X[2]=5.00E-2
    X[3]=1.00E-1
    X[4]=1.50E-1
    X[5]=2.00E-1
    X[6]=2.50E-1
    X[7]=3.00E-1
    X[8]=3.50E-1
    X[9]=4.00E-1
    X[10]=4.50E-1
    X[11]=5.00E-1
    X[12]=5.50E-1
    X[13]=6.00E-1
    X[14]=6.50E-1
    X[15]=7.00E-1
    X[16]=7.50E-1
    X[17]=8.00E-1
    X[18]=8.50E-1
    X[19]=9.00E-1
    X[20]=9.50E-1
    X[21]=1.00E+0
    X[22]=1.05E+0
    X[23]=1.10E+0
    X[24]=1.15E+0
    for i = 1:24
      term1 = x[1]*exp(-x[2]*X[i]) + x[3]*exp(-x[4]*X[i])+ x[5]*exp(-x[6]*X[i])
      term2 = 0.0951*exp(-X[i]) + 0.8607*exp(-1*3*X[i]) + 1.5576*exp(-5*X[i])
      sum = sum + (term1-term2)^2
    end
    return sum#, grad
end

function chnrosnb(x::AbstractVector)
    println("Julia port of CUTEST's CHNROSNB")
    grad = zeros(size(x))
    sum = 0
    ALPH=zeros(50)
    ALPH[1]=1.25
    ALPH[2]=1.40
    ALPH[3]=2.40
    ALPH[4]=1.40
    ALPH[5]=1.75
    ALPH[6]=1.20
    ALPH[7]=2.25
    ALPH[8]=1.20
    ALPH[9]=1.00
    ALPH[10]=1.10
    ALPH[11]=1.50
    ALPH[12]=1.60
    ALPH[13]=1.25
    ALPH[14]=1.25
    ALPH[15]=1.20
    ALPH[16]=1.20
    ALPH[17]=1.40
    ALPH[18]=0.50
    ALPH[19]=0.50
    ALPH[20]=1.25
    ALPH[21]=1.80
    ALPH[22]=0.75
    ALPH[23]=1.25
    ALPH[24]=1.40
    ALPH[25]=1.60
    ALPH[26]=2.00
    ALPH[27]=1.00
    ALPH[28]=1.60
    ALPH[29]=1.25
    ALPH[30]=2.75
    ALPH[31]=1.25
    ALPH[32]=1.25
    ALPH[33]=1.25
    ALPH[34]=3.00
    ALPH[35]=1.50
    ALPH[36]=2.00
    ALPH[37]=1.25
    ALPH[38]=1.40
    ALPH[39]=1.80
    ALPH[40]=1.50
    ALPH[41]=2.20
    ALPH[42]=1.40
    ALPH[43]=1.50
    ALPH[44]=1.25
    ALPH[45]=2.00
    ALPH[46]=1.50
    ALPH[47]=1.25
    ALPH[48]=1.40
    ALPH[49]=0.60
    ALPH[50]=1.50
    for i = 2:length(x)
        term1= x[i-1]-x[i]^2
        term2 = x[i]-1
        sum = sum + 16*ALPH[i]^2*term1^2 + term2^2
    end
    return sum#, grad
end

function edensch(x::AbstractVector)
    println("Julia port of CUTEST's EDENSCH")
    grad = zeros(size(x))
    sum=16
    for i = 1:(length(x)-1)
        term1=x[i]-2
        term2=-2*x[i+1]+x[i]*x[i+1]
        term3 = x[i+1]+1
        sum=sum+term1^4+term2^2+term3^2
    end
    return sum#, grad
end

function recipels(x::AbstractVector)
    println("Julia port of CUTEST's RECIPELS")
    grad = zeros(size(x))
    term1 = (x[1]-5)
    term2 = x[2]^2
    term3 = x[3]/(x[2]-x[1])
    sum=term1^2+term2^2+term3^2
    return sum#, grad
end

function eggcrate(x::AbstractVector)
    println("Julia port of CUTEST's EGGCRATE")
    grad = zeros(size(x))
    term1 = 5*sin(x[1])
    term2 = 5*sin(x[2])
    sum=x[1]^2+x[2]^2+term1^2+term2^2
    return sum#, grad
end

function chwirut1ls(x::AbstractVector)
    println("Julia port of CUTEST's CHWIRUT1LS")
    X=zeros(214)
    Y=zeros(214)
    X[1]=0.5         
    X[2]=0.625     
    X[3]=0.75        
    X[4]=0.875     
    X[5]=1.0         
    X[6]=1.25        
    X[7]=1.75        
    X[8]=2.25        
    X[9]=1.75        
    X[10]=2.25        
    X[11]=2.75        
    X[12]=3.25        
    X[13]=3.75        
    X[14]=4.25        
    X[15]=4.75        
    X[16]=5.25        
    X[17]=5.75        
    X[18]=0.5         
    X[19]=0.625     
    X[20]=0.75        
    X[21]=0.875     
    X[22]=1.0         
    X[23]=1.25        
    X[24]=1.75        
    X[25]=2.25        
    X[26]=1.75        
    X[27]=2.25        
    X[28]=2.75        
    X[29]=3.25        
    X[30]=3.75        
    X[31]=4.25        
    X[32]=4.75        
    X[33]=5.25        
    X[34]=5.75        
    X[35]=0.5         
    X[36]=0.625     
    X[37]=0.75        
    X[38]=0.875     
    X[39]=1.0         
    X[40]=1.25        
    X[41]=1.75        
    X[42]=2.25        
    X[43]=1.75        
    X[44]=2.25        
    X[45]=2.75        
    X[46]=3.25        
    X[47]=3.75        
    X[48]=4.25        
    X[49]=4.75        
    X[50]=5.25        
    X[51]=5.75        
    X[52]=0.5         
    X[53]=0.625     
    X[54]=0.75        
    X[55]=0.875     
    X[56]=1.0         
    X[57]=1.25        
    X[58]=1.75        
    X[59]=2.25        
    X[60]=1.75        
    X[61]=2.25        
    X[62]=2.75        
    X[63]=3.25        
    X[64]=3.75        
    X[65]=4.25        
    X[66]=4.75        
    X[67]=5.25        
    X[68]=5.75        
    X[69]=0.5         
    X[70]=0.75        
    X[71]=1.5         
    X[72]=3.0         
    X[73]=3.0         
    X[74]=3.0         
    X[75]=6.0         
    X[76]=0.5         
    X[77]=0.75        
    X[78]=1.5         
    X[79]=3.0         
    X[80]=3.0         
    X[81]=3.0         
    X[82]=6.0         
    X[83]=0.5         
    X[84]=0.75        
    X[85]=1.5         
    X[86]=3.0         
    X[87]=3.0         
    X[88]=3.0         
    X[89]=6.0         
    X[90]=0.5         
    X[91]=0.75        
    X[92]=1.5         
    X[93]=3.0         
    X[94]=6.0         
    X[95]=3.0         
    X[96]=3.0         
    X[97]=6.0         
    X[98]=0.5         
    X[99]=0.75        
    X[100]=1.0         
    X[101]=1.5         
    X[102]=2.0         
    X[103]=2.0         
    X[104]=2.5         
    X[105]=3.0         
    X[106]=4.0         
    X[107]=5.0         
    X[108]=6.0         
    X[109]=0.5         
    X[110]=0.75        
    X[111]=1.0         
    X[112]=1.5         
    X[113]=2.0         
    X[114]=2.0         
    X[115]=2.5         
    X[116]=3.0         
    X[117]=4.0         
    X[118]=5.0         
    X[119]=6.0         
    X[120]=0.5         
    X[121]=0.75        
    X[122]=1.0         
    X[123]=1.5         
    X[124]=2.0         
    X[125]=2.0         
    X[126]=2.5         
    X[127]=3.0         
    X[128]=4.0         
    X[129]=5.0         
    X[130]=6.0         
    X[131]=0.5         
    X[132]=0.625     
    X[133]=0.75        
    X[134]=0.875     
    X[135]=1.0         
    X[136]=1.25        
    X[137]=2.25        
    X[138]=2.25        
    X[139]=2.75        
    X[140]=3.25        
    X[141]=3.75        
    X[142]=4.25        
    X[143]=4.75        
    X[144]=5.25        
    X[145]=5.75        
    X[146]=3.0         
    X[147]=3.0         
    X[148]=3.0         
    X[149]=3.0         
    X[150]=3.0         
    X[151]=3.0         
    X[152]=0.5         
    X[153]=0.75        
    X[154]=1.0         
    X[155]=1.5         
    X[156]=2.0         
    X[157]=2.5         
    X[158]=2.0         
    X[159]=2.5         
    X[160]=3.0         
    X[161]=4.0         
    X[162]=5.0         
    X[163]=6.0         
    X[164]=0.5         
    X[165]=0.75        
    X[166]=1.0         
    X[167]=1.5         
    X[168]=2.0         
    X[169]=2.5         
    X[170]=2.0         
    X[171]=2.5         
    X[172]=3.0         
    X[173]=4.0         
    X[174]=5.0         
    X[175]=6.0         
    X[176]=0.5         
    X[177]=0.75        
    X[178]=1.0         
    X[179]=1.5         
    X[180]=2.0         
    X[181]=2.5         
    X[182]=2.0         
    X[183]=2.5         
    X[184]=3.0         
    X[185]=4.0         
    X[186]=5.0         
    X[187]=6.0         
    X[188]=3.0         
    X[189]=0.5         
    X[190]=0.75        
    X[191]=1.5         
    X[192]=3.0         
    X[193]=6.0         
    X[194]=3.0         
    X[195]=6.0         
    X[196]=3.0         
    X[197]=3.0         
    X[198]=3.0         
    X[199]=1.75        
    X[200]=1.75        
    X[201]=0.5         
    X[202]=0.75        
    X[203]=1.75        
    X[204]=1.75        
    X[205]=2.75        
    X[206]=3.75        
    X[207]=1.75        
    X[208]=1.75        
    X[209]=0.5         
    X[210]=0.75        
    X[211]=2.75        
    X[212]=3.75        
    X[213]=1.75        
    X[214]=1.75

    Y[1]=92.9        
    Y[2]=78.7        
    Y[3]=64.2        
    Y[4]=64.9        
    Y[5]=57.1        
    Y[6]=43.3        
    Y[7]=31.1        
    Y[8]=23.6        
    Y[9]=31.05     
    Y[10]=23.7750 
    Y[11]=17.7375 
    Y[12]=13.8        
    Y[13]=11.5875 
    Y[14]=9.4125    
    Y[15]=7.7250    
    Y[16]=7.35        
    Y[17]=8.0250    
    Y[18]=90.6        
    Y[19]=76.9        
    Y[20]=71.6        
    Y[21]=63.6        
    Y[22]=54.0        
    Y[23]=39.2        
    Y[24]=29.3        
    Y[25]=21.4        
    Y[26]=29.1750 
    Y[27]=22.1250 
    Y[28]=17.5125 
    Y[29]=14.25     
    Y[30]=9.45     
    Y[31]=9.15     
    Y[32]=7.9125 
    Y[33]=8.4750 
    Y[34]=6.1125 
    Y[35]=80.0        
    Y[36]=79.0        
    Y[37]=63.8        
    Y[38]=57.2        
    Y[39]=53.2        
    Y[40]=42.5        
    Y[41]=26.8        
    Y[42]=20.4        
    Y[43]=26.85     
    Y[44]=21.0        
    Y[45]=16.4625 
    Y[46]=12.5250 
    Y[47]=10.5375 
    Y[48]=8.5875 
    Y[49]=7.1250 
    Y[50]=6.1125 
    Y[51]=5.9625 
    Y[52]=74.1        
    Y[53]=67.3        
    Y[54]=60.8        
    Y[55]=55.5        
    Y[56]=50.3        
    Y[57]=41.0        
    Y[58]=29.4        
    Y[59]=20.4        
    Y[60]=29.3625 
    Y[61]=21.15     
    Y[62]=16.7625 
    Y[63]=13.2        
    Y[64]=10.8750 
    Y[65]=8.1750 
    Y[66]=7.35     
    Y[67]=5.9625 
    Y[68]=5.6250 
    Y[69]=81.5        
    Y[70]=62.4        
    Y[71]=32.5        
    Y[72]=12.41     
    Y[73]=13.12     
    Y[74]=15.56     
    Y[75]=5.63     
    Y[76]=78.0        
    Y[77]=59.9        
    Y[78]=33.2        
    Y[79]=13.84     
    Y[80]=12.75     
    Y[81]=14.62     
    Y[82]=3.94     
    Y[83]=76.8        
    Y[84]=61.0        
    Y[85]=32.9        
    Y[86]=13.87     
    Y[87]=11.81     
    Y[88]=13.31     
    Y[89]=5.44     
    Y[90]=78.0        
    Y[91]=63.5        
    Y[92]=33.8        
    Y[93]=12.56     
    Y[94]=5.63     
    Y[95]=12.75     
    Y[96]=13.12     
    Y[97]=5.44     
    Y[98]=76.8        
    Y[99]=60.0        
    Y[100]=47.8        
    Y[101]=32.0        
    Y[102]=22.2        
    Y[103]=22.57     
    Y[104]=18.82     
    Y[105]=13.95     
    Y[106]=11.25     
    Y[107]=9.0        
    Y[108]=6.67     
    Y[109]=75.8        
    Y[110]=62.0        
    Y[111]=48.8        
    Y[112]=35.2        
    Y[113]=20.0        
    Y[114]=20.32     
    Y[115]=19.31     
    Y[116]=12.75     
    Y[117]=10.42     
    Y[118]=7.31     
    Y[119]=7.42     
    Y[120]=70.5        
    Y[121]=59.5        
    Y[122]=48.5        
    Y[123]=35.8        
    Y[124]=21.0        
    Y[125]=21.67     
    Y[126]=21.0        
    Y[127]=15.64     
    Y[128]=8.17     
    Y[129]=8.55     
    Y[130]=10.12     
    Y[131]=78.0        
    Y[132]=66.0        
    Y[133]=62.0        
    Y[134]=58.0        
    Y[135]=47.7        
    Y[136]=37.8        
    Y[137]=20.2        
    Y[138]=21.07     
    Y[139]=13.87     
    Y[140]=9.67     
    Y[141]=7.76     
    Y[142]=5.44     
    Y[143]=4.87     
    Y[144]=4.01     
    Y[145]=3.75     
    Y[146]=24.19     
    Y[147]=25.76     
    Y[148]=18.07     
    Y[149]=11.81     
    Y[150]=12.07     
    Y[151]=16.12     
    Y[152]=70.8        
    Y[153]=54.7        
    Y[154]=48.0        
    Y[155]=39.8        
    Y[156]=29.8        
    Y[157]=23.7        
    Y[158]=29.62     
    Y[159]=23.81     
    Y[160]=17.7        
    Y[161]=11.55     
    Y[162]=12.07     
    Y[163]=8.74     
    Y[164]=80.7        
    Y[165]=61.3        
    Y[166]=47.5        
    Y[167]=29.0        
    Y[168]=24.0        
    Y[169]=17.7        
    Y[170]=24.56     
    Y[171]=18.67     
    Y[172]=16.24     
    Y[173]=8.74     
    Y[174]=7.87     
    Y[175]=8.51     
    Y[176]=66.7        
    Y[177]=59.2        
    Y[178]=40.8        
    Y[179]=30.7        
    Y[180]=25.7        
    Y[181]=16.3        
    Y[182]=25.99     
    Y[183]=16.95     
    Y[184]=13.35     
    Y[185]=8.62     
    Y[186]=7.2        
    Y[187]=6.64     
    Y[188]=13.69     
    Y[189]=81.0        
    Y[190]=64.5        
    Y[191]=35.5        
    Y[192]=13.31     
    Y[193]=4.87     
    Y[194]=12.94     
    Y[195]=5.06     
    Y[196]=15.19     
    Y[197]=14.62     
    Y[198]=15.64     
    Y[199]=25.5        
    Y[200]=25.95     
    Y[201]=81.7        
    Y[202]=61.6        
    Y[203]=29.8        
    Y[204]=29.81     
    Y[205]=17.17     
    Y[206]=10.39     
    Y[207]=28.4        
    Y[208]=28.69     
    Y[209]=81.3        
    Y[210]=60.9        
    Y[211]=16.65     
    Y[212]=10.05     
    Y[213]=28.9        
    Y[214]=28.95
    sum=0
    grad = zeros(size(x))
    for i= 1:214
        term1=-Y[i]
        term2=exp(-X[i]*x[1])
        term3 = x[2]+x[3]*X[i]
        sum=sum+ (term1+term2/term3)^2
    end
    return sum#, grad
end

function mgh10ls(x::AbstractVector)
    println("Julia port of CUTEST's MGH10LS")
    X=zeros(16)
    Y=zeros(16)
    
    X[1]=5.00E+01
    X[2]=5.50E+01
    X[3]=6.00E+01
    X[4]=6.50E+01
    X[5]=7.00E+01
    X[6]=7.50E+01
    X[7]=8.00E+01
    X[8]=8.50E+01
    X[9]=9.00E+01
    X[10]=9.50E+01
    X[11]=1.00E+02
    X[12]=1.05E+02
    X[13]=1.10E+02
    X[14]=1.15E+02
    X[15]=1.20E+02
    X[16]=1.25E+02

    Y[1]=3.478E+04
    Y[2]=2.861E+04
    Y[3]=2.365E+04
    Y[4]=1.963E+04
    Y[5]=1.637E+04
    Y[6]=1.372E+04
    Y[7]=1.154E+04
    Y[8]=9.744E+03
    Y[9]=8.261E+03
    Y[10]=7.030E+03
    Y[11]=6.005E+03
    Y[12]=5.147E+03
    Y[13]=4.427E+03
    Y[14]=3.820E+03
    Y[15]=3.307E+03
    Y[16]=2.872E+03

    grad = zeros(size(x))
    sum=0
    for i = 1:16
        term1 = exp(x[2]/(x[3]*X[i]))
        sum = sum + (-Y[i] + x[1]*term1)^2
    end
    return sum#, grad
end

function hatfldgls(x::AbstractVector)
    println("Julia port of CUTEST's HATFLDGLS")
    grad = zeros(size(x))
    term1 = -x[1]*x[2]+x[1]-x[13]+1
    term2 = x[length(x)]-x[13]+1+x[length(x)-1]*x[length(x)]
    sum= term1^2+term2^2
    for i = 2:(length(x)-1)
        term1 = x[i]-x[13]+1+x[i]*(x[i-1]-x[i+1])
        sum = sum + term1^2
    end
    return sum#, grad
end

function bard(x::AbstractVector)
    println("Julia port of CUTEST's BARD")
    grad = zeros(size(x))
    sum=0
    G=zeros(15)
    G[1]=0.14
    G[2]=0.18
    G[3]=0.22
    G[4]=0.25
    G[5]=0.29
    G[6]=0.32
    G[7]=0.35
    G[8]=0.39
    G[9]=0.37
    G[10]=0.58
    G[11]=0.73
    G[12]=0.96
    G[13]=1.34
    G[14]=2.10
    G[15]=4.39
    for i = 1:8
        term1 = i/((16-i)*x[2]+i*x[3])
        sum = sum + (x[1]-G[i]+term1)^2
    end
    for i = 9:15
        term1 = i/((16-i)*x[2]+(16-i)*x[3])
        sum = sum + (x[1]-G[i]+term1)^2
    end
    return sum#, grad
end

function errinros(x::AbstractVector)
    println("Julia port of CUTEST's ERRINROS")
    grad = zeros(size(x))
    sum=0
    ALPH=zeros(50)
    ALPH[1]=1.25
    ALPH[2]=1.40
    ALPH[3]=2.40
    ALPH[4]=1.40
    ALPH[5]=1.75
    ALPH[6]=1.20
    ALPH[7]=2.25
    ALPH[8]=1.20
    ALPH[9]=1.00
    ALPH[10]=1.10
    ALPH[11]=1.50
    ALPH[12]=1.60
    ALPH[13]=1.25
    ALPH[14]=1.25
    ALPH[15]=1.20
    ALPH[16]=1.20
    ALPH[17]=1.40
    ALPH[18]=0.50
    ALPH[19]=0.50
    ALPH[20]=1.25
    ALPH[21]=1.80
    ALPH[22]=0.75
    ALPH[23]=1.25
    ALPH[24]=1.40
    ALPH[25]=1.60
    ALPH[26]=2.00
    ALPH[27]=1.00
    ALPH[28]=1.60
    ALPH[29]=1.25
    ALPH[30]=2.75
    ALPH[31]=1.25
    ALPH[32]=1.25
    ALPH[33]=1.25
    ALPH[34]=3.00
    ALPH[35]=1.50
    ALPH[36]=2.00
    ALPH[37]=1.25
    ALPH[38]=1.40
    ALPH[39]=1.80
    ALPH[40]=1.50
    ALPH[41]=2.20
    ALPH[42]=1.40
    ALPH[43]=1.50
    ALPH[44]=1.25
    ALPH[45]=2.00
    ALPH[46]=1.50
    ALPH[47]=1.25
    ALPH[48]=1.40
    ALPH[49]=0.60
    ALPH[50]=1.50
    for i =2:length(x)
        term1=x[i-1]-16*ALPH[i]^2*x[i]^2
        term2 = x[i]-1
        sum=sum+term1^2+term2^2
    end
    return sum#, grad
end

function hatfldfls(x::AbstractVector)
    println("Julia port of CUTEST's HATFLDFLS")
    grad = zeros(size(x))
    term1 = x[1]-0.032+x[2]*exp(1*x[3])
    term2 = x[1]-0.056+x[2]*exp(2*x[3])
    term3 = x[1]-0.099+x[2]*exp(3*x[3])
    sum=term1^2+term2^2+term3^2
    return sum#, grad
end

function morebv(x::AbstractVector)
    println("Julia port of CUTEST's MOREBV")
    grad = zeros(size(x))
    sum=0
    M=1/(length(x)+1)
    N=length(x)*M
    term1= -x[2]+2*x[1]+0.5*M^2*(x[1]+M+1)^3
    term2 = -x[length(x)-1]+2*x[length(x)]+0.5*M^2*(x[length(x)]+N+1)^3
    sum=term1^2+term2^2
    for i = 2:(length(x)-1)
        term1 = -x[i-1]-x[i+1]+2*x[i]
        term2 = 0.5*M^2*(x[i]+i*M+1)^3
        sum = sum + (term1+term2)^2
    end
    return sum#, grad
end

function arglinb(x::AbstractVector)
    println("Julia port of CUTEST's ARGLINB")
    grad = zeros(size(x))
    sum=0
    for i = 1:20
        term1 = -1
        sum1=0
        for j = 1:10
            term2=i*j*x[j]
            sum1=sum1+term2
        end
        sum = sum + (term1+sum1)^2
    end
    return sum#, grad
end

function hatfldfl(x::AbstractVector)
    println("Julia port of CUTEST's HATFLDFL")
    grad = zeros(size(x))
    sum=0
    term1 = x[1]+x[2]*x[3]-0.032
    term2 = x[1]+x[2]*x[3]^2-0.056
    term3 = x[1]+x[2]*x[3]^3-0.099
    sum=term1^2+term2^2+term3^2
    return sum#, grad
end

function devgla1(x::AbstractVector)
    println("Julia port of CUTEST's DEVGLA1")
    grad = zeros(size(x))
    sum=0
    for i = 1:24
        term1 = x[1]*x[2]^(0.1*(i-1))
        term2 = sin(0.1*(i-1)*x[3]+x[4])
        term3 = 60.137*exp(0.1*(i-1)*log(1.371))
        term4 = sin(3.112*0.1*(i-1)+1.761)
        sum=sum+(term1*term2-term3*term4-Y[i])^2
    end
    return sum#, grad
end

len[1]=2
x=ones(2)
sumArray[1] = loghairy(x)
len[2]=5000
x=ones(5000)
sumArray[2] = quartc(x)
len[3]=5000
x=ones(5000)
sumArray[3] = tquartic(x)
len[4]=5000
x=ones(5000)
sumArray[4] = nondquar(x)
len[5]=100
x=ones(100)
sumArray[5] = qing(x)
len[6]=3
x=ones(3)
sumArray[6] = ssi(x)
len[7]=1000
x=ones(1000)
sumArray[7] = kssls(x)
len[8]=5000
x=ones(5000)
sumArray[8] = powellsg(x)
len[9]=2
x=ones(2)
sumArray[9] = powellbsls(x)
len[10]=2
x=ones(2)
sumArray[10] = powellsqls(x)
len[11]=2
x=ones(2)
sumArray[11] = waysea2(x)
len[12]=2
x=ones(2)
sumArray[12] = waysea1(x)
len[13]=1000
x=ones(1000)
sumArray[13] = penalty1(x)
len[14]=5000
x=ones(5000)
sumArray[14] = dqrtic(x)
len[15]=5000
x=ones(5000)
sumArray[15] = bdqrtic(x)
len[16]=5000
x=ones(5000)
sumArray[16] = dqdrtic(x)
len[17]=4000
x=ones(4000)
sumArray[17] = woods(x)
len[18]=2
x=ones(2)
sumArray[18] = danwoodls(x)
len[19]=2
x=ones(2)
sumArray[19] = daniwoodls(x)
len[20]=200
x=ones(200)
sumArray[20] = argtrigls(x)
len[21]=10000
x=ones(10000)
sumArray[21] = curly10(x)
len[22]=10000
x=ones(10000)
sumArray[22] = curly20(x)
len[23]=10000
x=ones(10000)
sumArray[23] = curly30(x)
len[24]=10000
x=ones(10000)
sumArray[24] = scurly30(x)
len[25]=10000
x=ones(10000)
sumArray[25] = scurly20(x)
len[26]=10000
x=ones(10000)
sumArray[26] = scurly10(x)
len[27]=200
x=ones(200)
sumArray[27] = brownal(x)
len[28]=2
x=ones(2)
sumArray[28] = brownbs(x)
len[29]=4
x=ones(4)
sumArray[29] = brownden(x)
len[30]=3
x=ones(3)
sumArray[30] = helix(x)
len[31]=2
x=ones(2)
sumArray[31] = mexhat(x)
len[32]=4
x=ones(4)
sumArray[32] = powersum(x)
len[33]=10000
x=ones(10000)
sumArray[33] = sparsqur(x)
len[34]=2
x=ones(2)
sumArray[34] = elatvidu(x)
len[35]=6
x=ones(6)
sumArray[35] = lanczos3ls(x)
len[36]=10
x=ones(10)
sumArray[36] = trigon2(x)
len[37]=3
x=ones(3)
sumArray[37] = denschne(x)
len[38]=2
x=ones(2)
sumArray[38] = misra1cls(x)
len[39]=8
x=ones(8)
sumArray[39] = palmer4c(x)
len[40]=5000
x=ones(5000)
sumArray[40] = cragglvy(x)
len[41]=8
x=ones(8)
sumArray[41] = palmer3c(x)
len[42]=6
x=ones(6)
sumArray[42] = lanczos1ls(x)
len[43]=50
x=ones(50)
sumArray[43] = chnrosnb(x)
len[44]=2000
x=ones(2000)
sumArray[44] = edensch(x)
len[45]=3
x=ones(3)
sumArray[45] = recipels(x)
len[46]=2
x=ones(2)
sumArray[46] = eggcrate(x)
len[47]=3
x=ones(3)
sumArray[47] = chwirut1ls(x)
len[48]=3
x=ones(3)
sumArray[48] = mgh10ls(x)
len[49]=25
x=ones(25)
sumArray[49] = hatfldgls(x)
len[50]=3
x=ones(3)
sumArray[50] = bard(x)
len[51]=50
x=ones(50)
sumArray[51] = errinros(x)
len[52]=3
x=ones(3)
sumArray[52] = hatfldfls(x)
len[53]=5000
x=ones(5000)
sumArray[53] = morebv(x)
len[54]=200
x=ones(200)
sumArray[54] = arglinb(x)
len[55]=3
x=ones(3)
sumArray[55] = hatfldfl(x)
len[56]=4
x=ones(4)
sumArray[56] = devgla1(x)

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

unitTesting(problemVector,sumArray,gradArray,len)

end