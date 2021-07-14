module Wrapper

export wrapfun

using CUTEst
using NLPModels

problemVector = ["OSCIGRAD","BOX3","OSCIPATH","BOX","BOXBODLS","BOXPOWER","ENGVAL2","ENGVAL1","ROSENBR","SROSENBR","ROSENBRTU","GENROSE","POWER","FLETCHCR","EXTROSNB","ROSZMAN1LS","DIXMAANI","LIARWHD","SCHMVETT","LUKSAN13LS","JUDGE","NONDIA","DIXMAANJ","DIXMAANC","DIXMAANL","DIXMAANK","DIXMAANG","DIXMAANF","DIXMAANE","DIXMAANP","DIXMAANH","DIXMAANB","DIXMAANN","DIXMAANA","DIXMAANO","DIXMAANM","DIXMAAND","SINVALNE","COSINE","SSCOSINE","SINEVAL","MUONSINELS","SCOSINE","SINQUAD","CLIFF","EG2","EXP2","CUBE","GAUSSIAN","HUMPS"]
sumArray=zeros(length(problemVector))
gradArray=zeros(length(problemVector))
len=zeros(length(problemVector))

function oscigrad(x::AbstractVector)
    println("Julia port of CUTEST's OSCIGRAD")
    #grad = zeros(size(x))
    sum = 0.5*x[1]-0.5-4*500*(x[2]-2*x[1]^2+1)*x[1]
    sum = sum^2
    for i = 2:(length(x)-1)
      term1 = -4*500*(x[i+1]-2*x[i]^2+1)*x[i]
      term2 = 2*500*(x[i]-2*x[i-1]^2+1)
      sum = sum + (term1 + term2)^2
    end
    term2 = 2*500*(x[length(x)]-2*x[length(x)-1]^2+1)
    sum = sum + term2^2
    return sum#, grad
end

function box3(x::AbstractVector)
    println("Julia port of CUTEST's BOX3")
    #grad = zeros(size(x))
    sum = 0
    for i = 1:10
      term = (exp(-0.1*i)-exp(-i))*x[3]+exp(-0.1*i*x[1])-exp(-0.1*i*x[2])
      sum = sum + (term)^2
    end
    return sum#, grad
end

function oscipath(x::AbstractVector)
    println("Julia port of CUTEST's OSCIPATH")
    #grad = zeros(size(x))
    sum = 0.25*(x[1]-1)^2
    for i = 2:(length(x))
      term1 = (x[i]-(2*x[i-1]^2-1))
      sum = sum + 500*(term1)^2
    end
    return sum#, grad
end

function box(x::AbstractVector)
    println("Julia port of CUTEST's BOX")
    #grad = zeros(size(x))
    sum = 0
    half=convert(Int64,0.5*length(x))
    for i = 1:(length(x))
      term1 = (x[i]+x[1])^2
      term2 = (x[i]+x[length(x)])^2
      term3 = (x[i]+x[half])^2
      term4 = x[i]^4
      term5 = -0.5*x[i]
      sum = sum + (term1) + term2+term3+term4+term5
    end
    return sum#, grad
end

function boxbodls(x::AbstractVector)
    println("Julia port of CUTEST's BOXBODLS")
    X=zeros(6)
    Y=zeros(6)
    X[1]=1.0
    X[2]=2.0
    X[3]=3.0
    X[4]=5.0
    X[5]=7.0
    X[6]=10.0
    Y[1]=109.0
    Y[2]=149.0
    Y[3]=149.0
    Y[4]=191.0
    Y[5]=213.0
    Y[6]=224.0
    #grad = zeros(size(x))
    sum = 0
    for i = 1:6
      term1 = x[1]-x[1]*exp(-x[2]*X[i])-Y[i]
      sum = sum + (term1)^2 
    end
    return sum#, grad
end

function boxpower(x::AbstractVector)
    println("Julia port of CUTEST's BOXPOWER")
    P=9
    #grad = zeros(size(x))
    sum = x[1]^2+x[length(x)]^(2*P+2)
    for i = 2:(length(x)-1)
      term1 = x[1]+x[length(x)]+x[i]
      sum = sum + (term1)^2
    end
    return sum#, grad
end

function engval2(x::AbstractVector)
    println("Julia port of CUTEST's ENGVAL2")
    #grad = zeros(size(x))
    term1 = x[1]^2+x[2]^2+x[3]^2-1
    term2 = x[1]^2+x[2]^2+(x[3]-2)^2-1
    term3 = x[1]+x[2]+x[3]-1
    term4 = x[1]+x[2]-x[3]+1
    term5 = x[1]^3+(5*x[3]-x[1]+1)^2+3*x[2]^2-36
    sum = term1^2+term2^2+term3^2+term4^2+term5^2
    return sum#, grad
end

function engval1(x::AbstractVector)
    println("Julia port of CUTEST's ENGVAL1")
    #grad = zeros(size(x))
    sum=0
    for i = 1:(length(x)-1)
        term1 = -4*x[i]+3
        term2 = x[i]^2+x[i+1]^2
        sum = sum + term1 + term2^2
    end
    return sum#, grad
end

function rosenbr(x::AbstractVector)
    println("Julia port of CUTEST's ROSENBR")
    #grad = zeros(size(x))
    term1= 100*(x[2]-x[1]^2)^2
    term2 = (x[1]-1)^2
    sum=term1+term2
    return sum#, grad
end

function srosenbr(x::AbstractVector)
    println("Julia port of CUTEST's SROSENBR")
    #grad = zeros(size(x))
    sum=0
    half=convert(Int64,0.5*length(x))
    for i = 1:half
        term1 = x[2*i-1]-1
        term2 = x[2*i]-x[2*i-1]^2
        sum = sum + term1^2 + 100*term2^2
    end
    return sum#, grad
end

function rosenbrtu(x::AbstractVector)
    println("Julia port of CUTEST's ROSENBRTU")
    #grad = zeros(size(x))
    term1=x[2]-x[1]^2
    term2=x[1]-1
    sum=100*term1^2/(1+term1^2)+term2^2/(1+term2^2)
    return sum#, grad
end

function genrose(x::AbstractVector)
    println("Julia port of CUTEST's GENROSE")
    grad = zeros(size(x))
    term = (1 - x[1])
    grad[1] = 2 * term
    sum = 1 - term^2
    term = (x[length(x)] - 1)
    grad[length(x)] = 2 * term
    sum = sum + term^2
    for i = 1:length(x)-1
      term = (x[i+1] - x[i]^2)
      sum = sum + 100*term^2 + (1 - x[i])^2
      grad[i] = grad[i] - 2 * (1-x[i]) - 400*x[i]*term
      grad[i+1] = grad[i+1] + 200*term
    end
    return sum#, grad
end

function power(x::AbstractVector)
    println("Julia port of CUTEST's POWER")
    grad = zeros(size(x))
    sum = 0
    for i = 1:length(x)
      term = i*x[i]^2
      sum = sum + term
    end
    for i = 1:length(x)
      grad[i] = 2*sum*2*i*x[i]
    end
    sum = sum^2
    return sum#, grad
end

function fletchcr(x::AbstractVector)
    println("Julia port of CUTEST's FLETCHCR")
    grad = zeros(size(x))
    sum = 0
    for i = 1:(length(x)-1)
      term1 = -x[i]^2 + x[i+1]
      term2 = -x[i]+1
      sum = sum + 100*term1^2 + term2^2
      grad[i] = grad[i] + 2*100*term1*-2*x[i] + 2*term2*-1
      grad[i+1] = grad[i+1] + 2*100*term1
    end
    return sum#, grad
end

function extrosnb(x::AbstractVector)
    println("Julia port of CUTEST's EXTROSNB")
    grad = zeros(size(x))
    term = (1 - x[1])
    sum = term^2
    grad[1] = -2*term
    for i = 1:length(x)-1
      term = (x[i+1] - x[i]^2)
      sum = sum + 100*term^2
      grad[i+1] = grad[i+1] + 200*term
      grad[i] = grad[i] - 400*x[i]*term
    end
    return sum#, grad
end

function roszman1ls(x::AbstractVector)
    println("Julia port of CUTEST's ROSZMAN1LS")
    #grad = zeros(size(x))
    sum = 0
    X=zeros(25)
    Y=zeros(25)
    X[1]=-4868.68
    X[2]=-4868.09
    X[3]=-4867.41
    X[4]=-3375.19
    X[5]=-3373.14
    X[6]=-3372.03
    X[7]=-2473.74
    X[8]=-2472.35
    X[9]=-2469.45
    X[10]=-1894.65
    X[11]=-1893.40
    X[12]=-1497.24
    X[13]=-1495.85
    X[14]=-1493.41
    X[15]=-1208.68
    X[16]=-1206.18
    X[17]=-1206.04
    X[18]=-997.92
    X[19]=-996.61
    X[20]=-996.31
    X[21]=-834.94
    X[22]=-834.66
    X[23]=-710.03
    X[24]=-530.16
    X[25]=-464.17

    Y[1]=0.252429
    Y[2]=0.252141
    Y[3]=0.251809
    Y[4]=0.297989
    Y[5]=0.296257
    Y[6]=0.295319
    Y[7]=0.339603
    Y[8]=0.337731
    Y[9]=0.333820
    Y[10]=0.389510
    Y[11]=0.386998
    Y[12]=0.438864
    Y[13]=0.434887
    Y[14]=0.427893
    Y[15]=0.471568
    Y[16]=0.461699
    Y[17]=0.461144
    Y[18]=0.513532
    Y[19]=0.506641
    Y[20]=0.505062
    Y[21]=0.535648
    Y[22]=0.533726
    Y[23]=0.568064
    Y[24]=0.612886
    Y[25]=0.624169

    for i = 1:25
      term1 = -1*atan(x[3]/(x[4]-X[i]))
      term2 = 4*atan(1)
      sum = sum+ (term1/term2 +x[1] -X[i]*x[2]-Y[i])^2
    end
    return sum#, grad
end

function dixmaani(x::AbstractVector)
    println("Julia port of CUTEST's DIXMAANI")
    grad = zeros(size(x))
    sum = 0
    M = convert(Int64,(length(x))/3)
    for i = 1:length(x)
      coeff = (i/length(x))^2
      sum = sum + coeff*x[i]^2
    end
    sum=sum+1
    for i = 1:(2*M)
        term1 = 0.125*(x[i]^2*x[i+M]^4)
        sum = sum + term1
    end
    for i = 1:M
        coeff2 = (i/length(x))^2
        term2 = 0.125*(x[i]*x[i+2*M])
        sum = sum + coeff2*term2
    end
    return sum#, grad
end

function liarwhd(x::AbstractVector)
    println("Julia port of CUTEST's LIARWHD")
    grad = zeros(size(x))
    sum = 0
    for i = 1:length(x)
      term1 = -x[1]+x[i]^2
      term2 = x[i]-1
      sum = sum + 4*term1^2 + term2^2
    end
    return sum#, grad
end

#THIS ONE IS WRONG!!
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

function luksan13ls(x::AbstractVector)
    println("Julia port of CUTEST's LUKSAN13LS")
    grad = zeros(size(x))
    sum = 0
    S = convert(Int64,(length(x)-2)/3)
    i=1
    for j = 1:S
      term = -10*x[i+1]+10*x[i]^2
      term1 = -10*x[i+2]+10*x[i+1]^2
      term2 = (x[i+2]-x[i+3])^2
      term3 = (x[i+3]-x[i+4])^2
      term4 = x[i]+x[i+2]-30+x[i]^2
      term5 = x[i+1]+x[i+3]-10-x[i+2]^2
      term6 = -10+x[i]*x[i+4]
      sum = sum +term^2+ term1^2+term2^2+term3^2+term4^2+term5^2+term6^2
      i=i+3
    end
    return sum#, grad
end

function judge(x::AbstractVector)
    println("Julia port of CUTEST's JUDGE")
    grad = zeros(size(x))
    A=zeros(20)
    B=zeros(20)
    Y=zeros(20)
    A[1]=0.286
	A[2]=0.973
	A[3]=0.384
	A[4]=0.276
	A[5]=0.973
	A[6]=0.543
	A[7]=0.957
	A[8]=0.948
	A[9]=0.543
	A[10]=0.797
	A[11]=0.936
	A[12]=0.889
	A[13]=0.006
	A[14]=0.828
	A[15]=0.399
	A[16]=0.617
	A[17]=0.939
	A[18]=0.784
	A[19]=0.072
	A[20]=0.889

	B[1]=0.645
	B[2]=0.585
	B[3]=0.310
	B[4]=0.058
	B[5]=0.455
	B[6]=0.779
	B[7]=0.259
	B[8]=0.202
	B[9]=0.028
	B[10]=0.099
	B[11]=0.142
	B[12]=0.296
	B[13]=0.175
	B[14]=0.180
	B[15]=0.842
	B[16]=0.039
	B[17]=0.103
	B[18]=0.620
	B[19]=0.158
	B[20]=0.704

	Y[1]=4.284
	Y[2]=4.149
	Y[3]=3.877
	Y[4]=0.533
	Y[5]=2.211
	Y[6]=2.389
	Y[7]=2.145
	Y[8]=3.231
	Y[9]=1.998
	Y[10]=1.379
	Y[11]=2.106
	Y[12]=1.428
	Y[13]=1.011
	Y[14]=2.179
	Y[15]=2.858
	Y[16]=1.388
	Y[17]=1.651
	Y[18]=1.593
	Y[19]=1.046
	Y[20]=2.152
    sum = 0
    for i = 1:20
      term1 = x[1]+A[i]*x[2]-Y[i]+B[i]*x[2]^2
      sum = sum + term1^2
    end
    return sum#, grad
end

function nondia(x::AbstractVector)
    println("Julia port of CUTEST's NONDIA")
    grad = zeros(size(x))
    term = (x[1]-1)
    sum = term^2
    gamma=2
    for i = 2:length(x)
      term1 = x[1]-x[i-1]^gamma
      sum = sum + 100*term1^2
    end
    return sum#, grad
end

function dixmaanj(x::AbstractVector)
    println("Julia port of CUTEST's DIXMAANJ")
    grad = zeros(size(x))
    sum = 0
    M = convert(Int64,length(x)/3)
    for i = 1:length(x)
      coeff = (i/length(x))^2
      sum = sum + coeff*x[i]^2
    end
    sum=sum+1
    for i = 1:(length(x)-1)
        term = x[i]^2*(x[i+1]+x[i+1]^2)^2
        sum = sum + 0.0625*term
      end
    for i = 1:(2*M)
        term1 = x[i]^2*x[i+M]^4
        sum = sum + 0.0625*term1
    end
    for i = 1:M
        coeff2 = (i/length(x))^2
        term2 = x[i]*x[i+2*M]
        sum = sum + 0.0625*coeff2*term2
    end
    return sum#, grad
end

function dixmaanc(x::AbstractVector)
    println("Julia port of CUTEST's DIXMAANC")
    grad = zeros(size(x))
    sum = 0
    M = convert(Int64,length(x)/3)
    for i = 1:length(x)
      coeff = 1
      sum = sum + coeff*x[i]^2
    end
    sum=sum+1
    for i = 1:(length(x)-1)
        term = x[i]^2*(x[i+1]+x[i+1]^2)^2
        sum = sum + 0.125*term
      end
    for i = 1:(2*M)
        term1 = x[i]^2*x[i+M]^4
        sum = sum + 0.125*term1
    end
    for i = 1:M
        coeff2 = 1
        term2 = x[i]*x[i+2*M]
        sum = sum + 0.125*coeff2*term2
    end
    return sum#, grad
end

function dixmaanl(x::AbstractVector)
    println("Julia port of CUTEST's DIXMAANL")
    grad = zeros(size(x))
    sum = 0
    M = convert(Int64,length(x)/3)
    for i = 1:length(x)
      coeff = (i/length(x))^2
      sum = sum + coeff*x[i]^2
    end
    sum=sum+1
    for i = 1:(length(x)-1)
        term = x[i]^2*(x[i+1]+x[i+1]^2)^2
        sum = sum + 0.26*term
      end
    for i = 1:(2*M)
        term1 = x[i]^2*x[i+M]^4
        sum = sum + 0.26*term1
    end
    for i = 1:M
        coeff2 = (i/length(x))^2
        term2 = x[i]*x[i+2*M]
        sum = sum + 0.26*coeff2*term2
    end
    return sum#, grad
end

function dixmaank(x::AbstractVector)
    println("Julia port of CUTEST's DIXMAANK")
    grad = zeros(size(x))
    sum = 0
    M = convert(Int64,length(x)/3)
    for i = 1:length(x)
      coeff = (i/length(x))^2
      sum = sum + coeff*x[i]^2
    end
    sum=sum+1
    for i = 1:(length(x)-1)
        term = x[i]^2*(x[i+1]+x[i+1]^2)^2
        sum = sum + 0.125*term
      end
    for i = 1:(2*M)
        term1 = x[i]^2*x[i+M]^4
        sum = sum + 0.125*term1
    end
    for i = 1:M
        coeff2 = (i/length(x))^2
        term2 = x[i]*x[i+2*M]
        sum = sum + 0.125*coeff2*term2
    end
    return sum#, grad
end

function dixmaang(x::AbstractVector)
    println("Julia port of CUTEST's DIXMAANG")
    grad = zeros(size(x))
    sum = 0
    M = convert(Int64,length(x)/3)
    for i = 1:length(x)
      coeff = (i/length(x))
      sum = sum + coeff*x[i]^2
    end
    sum=sum+1
    for i = 1:(length(x)-1)
        term = x[i]^2*(x[i+1]+x[i+1]^2)^2
        sum = sum + 0.125*term
      end
    for i = 1:(2*M)
        term1 = x[i]^2*x[i+M]^4
        sum = sum + 0.125*term1
    end
    for i = 1:M
        coeff2 = (i/length(x))
        term2 = x[i]*x[i+2*M]
        sum = sum + 0.125*coeff2*term2
    end
    return sum#, grad
end

function dixmaanf(x::AbstractVector)
    println("Julia port of CUTEST's DIXMAANF")
    grad = zeros(size(x))
    sum = 0
    M = convert(Int64,length(x)/3)
    for i = 1:length(x)
      coeff = (i/length(x))
      sum = sum + coeff*x[i]^2
    end
    sum=sum+1
    for i = 1:(length(x)-1)
        term = x[i]^2*(x[i+1]+x[i+1]^2)^2
        sum = sum + 0.0625*term
      end
    for i = 1:(2*M)
        term1 = x[i]^2*x[i+M]^4
        sum = sum + 0.0625*term1
    end
    for i = 1:M
        coeff2 = (i/length(x))
        term2 = x[i]*x[i+2*M]
        sum = sum + 0.0625*coeff2*term2
    end
    return sum#, grad
end

function dixmaane(x::AbstractVector)
    println("Julia port of CUTEST's DIXMAANE")
    grad = zeros(size(x))
    sum = 0
    M = convert(Int64,length(x)/3)
    for i = 1:length(x)
      coeff = (i/length(x))
      sum = sum + coeff*x[i]^2
    end
    sum=sum+1
    for i = 1:(2*M)
        term1 = x[i]^2*x[i+M]^4
        sum = sum + 0.125*term1
    end
    for i = 1:M
        coeff2 = (i/length(x))
        term2 = x[i]*x[i+2*M]
        sum = sum + 0.125*coeff2*term2
    end
    return sum#, grad
end

function dixmaanp(x::AbstractVector)
    println("Julia port of CUTEST's DIXMAANP")
    grad = zeros(size(x))
    sum = 0
    M = convert(Int64,length(x)/3)
    for i = 1:length(x)
      coeff = (i/length(x))^2
      sum = sum + coeff*x[i]^2
    end
    sum=sum+1
    for i = 1:(length(x)-1)
        term = x[i]^2*(x[i+1]+x[i+1]^2)^2
        coeff3 = (i/length(x))
        sum = sum + coeff3*0.26*term
      end
    for i = 1:(2*M)
        term1 = x[i]^2*x[i+M]^4
        coeff4 = (i/length(x))
        sum = sum + coeff4*0.26*term1
    end
    for i = 1:M
        coeff2 = (i/length(x))^2
        term2 = x[i]*x[i+2*M]
        sum = sum + 0.26*coeff2*term2
    end
    return sum#, grad
end

function dixmaanh(x::AbstractVector)
    println("Julia port of CUTEST's DIXMAANH")
    grad = zeros(size(x))
    sum = 0
    M = convert(Int64,length(x)/3)
    for i = 1:length(x)
      coeff = (i/length(x))
      sum = sum + coeff*x[i]^2
    end
    sum=sum+1
    for i = 1:(length(x)-1)
        term = x[i]^2*(x[i+1]+x[i+1]^2)^2
        sum = sum + 0.26*term
      end
    for i = 1:(2*M)
        term1 = x[i]^2*x[i+M]^4
        sum = sum + 0.26*term1
    end
    for i = 1:M
        coeff2 = (i/length(x))
        term2 = x[i]*x[i+2*M]
        sum = sum + 0.26*coeff2*term2
    end
    return sum#, grad
end

function dixmaanb(x::AbstractVector)
    println("Julia port of CUTEST's DIXMAANB")
    grad = zeros(size(x))
    sum = 0
    M = convert(Int64,length(x)/3)
    for i = 1:length(x)
      coeff = 1
      sum = sum + coeff*x[i]^2
    end
    sum=sum+1
    for i = 1:(length(x)-1)
        term = x[i]^2*(x[i+1]+x[i+1]^2)^2
        sum = sum + 0.0625*term
      end
    for i = 1:(2*M)
        term1 = x[i]^2*x[i+M]^4
        sum = sum + 0.0625*term1
    end
    for i = 1:M
        coeff2 = 1
        term2 = x[i]*x[i+2*M]
        sum = sum + 0.0625*coeff2*term2
    end
    return sum#, grad
end

function dixmaann(x::AbstractVector)
    println("Julia port of CUTEST's DIXMAANN")
    grad = zeros(size(x))
    sum = 0
    M = convert(Int64,length(x)/3)
    for i = 1:length(x)
      coeff = (i/length(x))^2
      sum = sum + coeff*x[i]^2
    end
    sum=sum+1
    for i = 1:(length(x)-1)
        coeff3 = (i/length(x))
        term = x[i]^2*(x[i+1]+x[i+1]^2)^2
        sum = sum + coeff3*0.0625*term
      end
    for i = 1:(2*M)
        coeff4 = (i/length(x))
        term1 = x[i]^2*x[i+M]^4
        sum = sum + coeff4*0.0625*term1
    end
    for i = 1:M
        coeff2 = (i/length(x))^2
        term2 = x[i]*x[i+2*M]
        sum = sum + 0.0625*coeff2*term2
    end
    return sum#, grad
end

function dixmaana(x::AbstractVector)
    println("Julia port of CUTEST's DIXMAANA")
    grad = zeros(size(x))
    sum = 0
    M = convert(Int64,length(x)/3)
    for i = 1:length(x)
      coeff = 1
      sum = sum + coeff*x[i]^2
    end
    sum=sum+1
    for i = 1:(2*M)
        term1 = x[i]^2*x[i+M]^4
        sum = sum + 0.125*term1
    end
    for i = 1:M
        coeff2 = 1
        term2 = x[i]*x[i+2*M]
        sum = sum + 0.125*coeff2*term2
    end
    return sum#, grad
end

function dixmaano(x::AbstractVector)
    println("Julia port of CUTEST's DIXMAANO")
    grad = zeros(size(x))
    sum = 0
    M = convert(Int64,length(x)/3)
    for i = 1:length(x)
      coeff = (i/length(x))^2
      sum = sum + coeff*x[i]^2
    end
    sum=sum+1
    for i = 1:(length(x)-1)
        coeff3 = (i/length(x))
        term = x[i]^2*(x[i+1]+x[i+1]^2)^2
        sum = sum + coeff3*0.125*term
      end
    for i = 1:(2*M)
        coeff4 = (i/length(x))
        term1 = x[i]^2*x[i+M]^4
        sum = sum + coeff4*0.125*term1
    end
    for i = 1:M
        coeff2 = (i/length(x))^2
        term2 = x[i]*x[i+2*M]
        sum = sum + 0.125*coeff2*term2
    end
    return sum#, grad
end

function dixmaanm(x::AbstractVector)
    println("Julia port of CUTEST's DIXMAANM")
    grad = zeros(size(x))
    sum = 0
    M = convert(Int64,length(x)/3)
    for i = 1:length(x)
      coeff = (i/length(x))^2
      sum = sum + coeff*x[i]^2
    end
    sum=sum+1
    for i = 1:(2*M)
        coeff3 = (i/length(x))
        term1 = x[i]^2*x[i+M]^4
        sum = sum + coeff3*0.125*term1
    end
    for i = 1:M
        coeff2 = (i/length(x))^2
        term2 = x[i]*x[i+2*M]
        sum = sum + 0.125*coeff2*term2
    end
    return sum#, grad
end

function dixmaand(x::AbstractVector)
    println("Julia port of CUTEST's DIXMAAND")
    grad = zeros(size(x))
    sum = 0
    M = convert(Int64,length(x)/3)
    for i = 1:length(x)
        coeff=1
        sum = sum + coeff*x[i]^2
    end
    sum=sum+1
    for i = 1:(length(x)-1)
        term = x[i]^2*(x[i+1]+x[i+1]^2)^2
        sum = sum + 0.26*term
      end
    for i = 1:(2*M)
        term1 = x[i]^2*x[i+M]^4
        sum = sum + 0.26*term1
    end
    for i = 1:M
        term2 = x[i]*x[i+2*M]
        coeff2=1
        sum = sum + 0.26*coeff2*term2
    end
    return sum#, grad
end

#SO WRONG
function sinvalne(x::AbstractVector)
    println("Julia port of CUTEST's SINVALNE")
    grad = zeros(size(x))
    term1=x[2]-sin(x[1])
    term2=0.5*x[1]
    sum=10*term1+term2
    return sum#, grad
end

function cosine(x::AbstractVector)
    println("Julia port of CUTEST's COSINE")
    grad = zeros(size(x))
    sum=0
    for i = 1:(length(x)-1)
        term = x[i]^2-0.5*x[i+1]
        sum = sum + cos(term)
    end
    return sum#, grad
end

function sscosine(x::AbstractVector)
    println("Julia port of CUTEST's SSCOSINE")
    grad = zeros(size(x))
    sum=0
    for i = 1:(length(x)-1)
        exp1 = 6*(i-1)/(length(x)-1)
        exp2 = 6*(i)/(length(x)-1)
        term1 = -0.5*exp(exp2)*x[i+1]
        term2 = (exp(exp1))^2*x[i]^2
        sum = sum + cos(term1+term2)
    end
    return sum#, grad
end

function sineval(x::AbstractVector)
    println("Julia port of CUTEST's SINEVAL")
    grad = zeros(size(x))
    term1=x[2]-sin(x[1])
    term2=x[2]
    sum=1000*term1^2+0.25*term2^2
    return sum#, grad
end

function muonsinels(x::AbstractVector)
    println("Julia port of CUTEST's MUONSINELS")
    X=zeros(512)
    Y=zeros(512)
    X[1]=0.0
    X[2]=0.0122718
    X[3]=0.0245437
    X[4]=0.0368155
    X[5]=0.0490874
    X[6]=0.0613592
    X[7]=0.0736311
    X[8]=0.0859029
    X[9]=0.0981748
    X[10]=0.110447
    X[11]=0.122718
    X[12]=0.13499
    X[13]=0.147262
    X[14]=0.159534
    X[15]=0.171806
    X[16]=0.184078
    X[17]=0.19635
    X[18]=0.208621
    X[19]=0.220893
    X[20]=0.233165
    X[21]=0.245437
    X[22]=0.257709
    X[23]=0.269981
    X[24]=0.282252
    X[25]=0.294524
    X[26]=0.306796
    X[27]=0.319068
    X[28]=0.33134
    X[29]=0.343612
    X[30]=0.355884
    X[31]=0.368155
    X[32]=0.380427
    X[33]=0.392699
    X[34]=0.404971
    X[35]=0.417243
    X[36]=0.429515
    X[37]=0.441786
    X[38]=0.454058
    X[39]=0.46633
    X[40]=0.478602
    X[41]=0.490874
    X[42]=0.503146
    X[43]=0.515418
    X[44]=0.527689
    X[45]=0.539961
    X[46]=0.552233
    X[47]=0.564505
    X[48]=0.576777
    X[49]=0.589049
    X[50]=0.60132
    X[51]=0.613592
    X[52]=0.625864
    X[53]=0.638136
    X[54]=0.650408
    X[55]=0.66268
    X[56]=0.674952
    X[57]=0.687223
    X[58]=0.699495
    X[59]=0.711767
    X[60]=0.724039
    X[61]=0.736311
    X[62]=0.748583
    X[63]=0.760854
    X[64]=0.773126
    X[65]=0.785398
    X[66]=0.79767
    X[67]=0.809942
    X[68]=0.822214
    X[69]=0.834486
    X[70]=0.846757
    X[71]=0.859029
    X[72]=0.871301
    X[73]=0.883573
    X[74]=0.895845
    X[75]=0.908117
    X[76]=0.920388
    X[77]=0.93266
    X[78]=0.944932
    X[79]=0.957204
    X[80]=0.969476
    X[81]=0.981748
    X[82]=0.99402
    X[83]=1.00629
    X[84]=1.01856
    X[85]=1.03084
    X[86]=1.04311
    X[87]=1.05538
    X[88]=1.06765
    X[89]=1.07992
    X[90]=1.09219
    X[91]=1.10447
    X[92]=1.11674
    X[93]=1.12901
    X[94]=1.14128
    X[95]=1.15355
    X[96]=1.16583
    X[97]=1.1781
    X[98]=1.19037
    X[99]=1.20264
    X[100]=1.21491
    X[101]=1.22718
    X[102]=1.23946
    X[103]=1.25173
    X[104]=1.264
    X[105]=1.27627
    X[106]=1.28854
    X[107]=1.30082
    X[108]=1.31309
    X[109]=1.32536
    X[110]=1.33763
    X[111]=1.3499
    X[112]=1.36217
    X[113]=1.37445
    X[114]=1.38672
    X[115]=1.39899
    X[116]=1.41126
    X[117]=1.42353
    X[118]=1.43581
    X[119]=1.44808
    X[120]=1.46035
    X[121]=1.47262
    X[122]=1.48489
    X[123]=1.49717
    X[124]=1.50944
    X[125]=1.52171
    X[126]=1.53398
    X[127]=1.54625
    X[128]=1.55852
    X[129]=1.5708
    X[130]=1.58307
    X[131]=1.59534
    X[132]=1.60761
    X[133]=1.61988
    X[134]=1.63216
    X[135]=1.64443
    X[136]=1.6567
    X[137]=1.66897
    X[138]=1.68124
    X[139]=1.69351
    X[140]=1.70579
    X[141]=1.71806
    X[142]=1.73033
    X[143]=1.7426
    X[144]=1.75487
    X[145]=1.76715
    X[146]=1.77942
    X[147]=1.79169
    X[148]=1.80396
    X[149]=1.81623
    X[150]=1.82851
    X[151]=1.84078
    X[152]=1.85305
    X[153]=1.86532
    X[154]=1.87759
    X[155]=1.88986
    X[156]=1.90214
    X[157]=1.91441
    X[158]=1.92668
    X[159]=1.93895
    X[160]=1.95122
    X[161]=1.9635
    X[162]=1.97577
    X[163]=1.98804
    X[164]=2.00031
    X[165]=2.01258
    X[166]=2.02485
    X[167]=2.03713
    X[168]=2.0494
    X[169]=2.06167
    X[170]=2.07394
    X[171]=2.08621
    X[172]=2.09849
    X[173]=2.11076
    X[174]=2.12303
    X[175]=2.1353
    X[176]=2.14757
    X[177]=2.15984
    X[178]=2.17212
    X[179]=2.18439
    X[180]=2.19666
    X[181]=2.20893
    X[182]=2.2212
    X[183]=2.23348
    X[184]=2.24575
    X[185]=2.25802
    X[186]=2.27029
    X[187]=2.28256
    X[188]=2.29484
    X[189]=2.30711
    X[190]=2.31938
    X[191]=2.33165
    X[192]=2.34392
    X[193]=2.35619
    X[194]=2.36847
    X[195]=2.38074
    X[196]=2.39301
    X[197]=2.40528
    X[198]=2.41755
    X[199]=2.42983
    X[200]=2.4421
    X[201]=2.45437
    X[202]=2.46664
    X[203]=2.47891
    X[204]=2.49118
    X[205]=2.50346
    X[206]=2.51573
    X[207]=2.528
    X[208]=2.54027
    X[209]=2.55254
    X[210]=2.56482
    X[211]=2.57709
    X[212]=2.58936
    X[213]=2.60163
    X[214]=2.6139
    X[215]=2.62618
    X[216]=2.63845
    X[217]=2.65072
    X[218]=2.66299
    X[219]=2.67526
    X[220]=2.68753
    X[221]=2.69981
    X[222]=2.71208
    X[223]=2.72435
    X[224]=2.73662
    X[225]=2.74889
    X[226]=2.76117
    X[227]=2.77344
    X[228]=2.78571
    X[229]=2.79798
    X[230]=2.81025
    X[231]=2.82252
    X[232]=2.8348
    X[233]=2.84707
    X[234]=2.85934
    X[235]=2.87161
    X[236]=2.88388
    X[237]=2.89616
    X[238]=2.90843
    X[239]=2.9207
    X[240]=2.93297
    X[241]=2.94524
    X[242]=2.95751
    X[243]=2.96979
    X[244]=2.98206
    X[245]=2.99433
    X[246]=3.0066
    X[247]=3.01887
    X[248]=3.03115
    X[249]=3.04342
    X[250]=3.05569
    X[251]=3.06796
    X[252]=3.08023
    X[253]=3.09251
    X[254]=3.10478
    X[255]=3.11705
    X[256]=3.12932
    X[257]=3.14159
    X[258]=3.15386
    X[259]=3.16614
    X[260]=3.17841
    X[261]=3.19068
    X[262]=3.20295
    X[263]=3.21522
    X[264]=3.2275
    X[265]=3.23977
    X[266]=3.25204
    X[267]=3.26431
    X[268]=3.27658
    X[269]=3.28885
    X[270]=3.30113
    X[271]=3.3134
    X[272]=3.32567
    X[273]=3.33794
    X[274]=3.35021
    X[275]=3.36249
    X[276]=3.37476
    X[277]=3.38703
    X[278]=3.3993
    X[279]=3.41157
    X[280]=3.42385
    X[281]=3.43612
    X[282]=3.44839
    X[283]=3.46066
    X[284]=3.47293
    X[285]=3.4852
    X[286]=3.49748
    X[287]=3.50975
    X[288]=3.52202
    X[289]=3.53429
    X[290]=3.54656
    X[291]=3.55884
    X[292]=3.57111
    X[293]=3.58338
    X[294]=3.59565
    X[295]=3.60792
    X[296]=3.62019
    X[297]=3.63247
    X[298]=3.64474
    X[299]=3.65701
    X[300]=3.66928
    X[301]=3.68155
    X[302]=3.69383
    X[303]=3.7061
    X[304]=3.71837
    X[305]=3.73064
    X[306]=3.74291
    X[307]=3.75518
    X[308]=3.76746
    X[309]=3.77973
    X[310]=3.792
    X[311]=3.80427
    X[312]=3.81654
    X[313]=3.82882
    X[314]=3.84109
    X[315]=3.85336
    X[316]=3.86563
    X[317]=3.8779
    X[318]=3.89018
    X[319]=3.90245
    X[320]=3.91472
    X[321]=3.92699
    X[322]=3.93926
    X[323]=3.95153
    X[324]=3.96381
    X[325]=3.97608
    X[326]=3.98835
    X[327]=4.00062
    X[328]=4.01289
    X[329]=4.02517
    X[330]=4.03744
    X[331]=4.04971
    X[332]=4.06198
    X[333]=4.07425
    X[334]=4.08652
    X[335]=4.0988
    X[336]=4.11107
    X[337]=4.12334
    X[338]=4.13561
    X[339]=4.14788
    X[340]=4.16016
    X[341]=4.17243
    X[342]=4.1847
    X[343]=4.19697
    X[344]=4.20924
    X[345]=4.22152
    X[346]=4.23379
    X[347]=4.24606
    X[348]=4.25833
    X[349]=4.2706
    X[350]=4.28287
    X[351]=4.29515
    X[352]=4.30742
    X[353]=4.31969
    X[354]=4.33196
    X[355]=4.34423
    X[356]=4.35651
    X[357]=4.36878
    X[358]=4.38105
    X[359]=4.39332
    X[360]=4.40559
    X[361]=4.41786
    X[362]=4.43014
    X[363]=4.44241
    X[364]=4.45468
    X[365]=4.46695
    X[366]=4.47922
    X[367]=4.4915
    X[368]=4.50377
    X[369]=4.51604
    X[370]=4.52831
    X[371]=4.54058
    X[372]=4.55285
    X[373]=4.56513
    X[374]=4.5774
    X[375]=4.58967
    X[376]=4.60194
    X[377]=4.61421
    X[378]=4.62649
    X[379]=4.63876
    X[380]=4.65103
    X[381]=4.6633
    X[382]=4.67557
    X[383]=4.68785
    X[384]=4.70012
    X[385]=4.71239
    X[386]=4.72466
    X[387]=4.73693
    X[388]=4.7492
    X[389]=4.76148
    X[390]=4.77375
    X[391]=4.78602
    X[392]=4.79829
    X[393]=4.81056
    X[394]=4.82284
    X[395]=4.83511
    X[396]=4.84738
    X[397]=4.85965
    X[398]=4.87192
    X[399]=4.88419
    X[400]=4.89647
    X[401]=4.90874
    X[402]=4.92101
    X[403]=4.93328
    X[404]=4.94555
    X[405]=4.95783
    X[406]=4.9701
    X[407]=4.98237
    X[408]=4.99464
    X[409]=5.00691
    X[410]=5.01919
    X[411]=5.03146
    X[412]=5.04373
    X[413]=5.056
    X[414]=5.06827
    X[415]=5.08054
    X[416]=5.09282
    X[417]=5.10509
    X[418]=5.11736
    X[419]=5.12963
    X[420]=5.1419
    X[421]=5.15418
    X[422]=5.16645
    X[423]=5.17872
    X[424]=5.19099
    X[425]=5.20326
    X[426]=5.21553
    X[427]=5.22781
    X[428]=5.24008
    X[429]=5.25235
    X[430]=5.26462
    X[431]=5.27689
    X[432]=5.28917
    X[433]=5.30144
    X[434]=5.31371
    X[435]=5.32598
    X[436]=5.33825
    X[437]=5.35052
    X[438]=5.3628
    X[439]=5.37507
    X[440]=5.38734
    X[441]=5.39961
    X[442]=5.41188
    X[443]=5.42416
    X[444]=5.43643
    X[445]=5.4487
    X[446]=5.46097
    X[447]=5.47324
    X[448]=5.48552
    X[449]=5.49779
    X[450]=5.51006
    X[451]=5.52233
    X[452]=5.5346
    X[453]=5.54687
    X[454]=5.55915
    X[455]=5.57142
    X[456]=5.58369
    X[457]=5.59596
    X[458]=5.60823
    X[459]=5.62051
    X[460]=5.63278
    X[461]=5.64505
    X[462]=5.65732
    X[463]=5.66959
    X[464]=5.68186
    X[465]=5.69414
    X[466]=5.70641
    X[467]=5.71868
    X[468]=5.73095
    X[469]=5.74322
    X[470]=5.7555
    X[471]=5.76777
    X[472]=5.78004
    X[473]=5.79231
    X[474]=5.80458
    X[475]=5.81686
    X[476]=5.82913
    X[477]=5.8414
    X[478]=5.85367
    X[479]=5.86594
    X[480]=5.87821
    X[481]=5.89049
    X[482]=5.90276
    X[483]=5.91503
    X[484]=5.9273
    X[485]=5.93957
    X[486]=5.95185
    X[487]=5.96412
    X[488]=5.97639
    X[489]=5.98866
    X[490]=6.00093
    X[491]=6.0132
    X[492]=6.02548
    X[493]=6.03775
    X[494]=6.05002
    X[495]=6.06229
    X[496]=6.07456
    X[497]=6.08684
    X[498]=6.09911
    X[499]=6.11138
    X[500]=6.12365
    X[501]=6.13592
    X[502]=6.14819
    X[503]=6.16047
    X[504]=6.17274
    X[505]=6.18501
    X[506]=6.19728
    X[507]=6.20955
    X[508]=6.22183
    X[509]=6.2341
    X[510]=6.24637
    X[511]=6.25864
    X[512]=6.27091

    Y[1]=0.0
    Y[2]=0.0735646
    Y[3]=0.14673
    Y[4]=0.219101
    Y[5]=0.290285
    Y[6]=0.359895
    Y[7]=0.427555
    Y[8]=0.492898
    Y[9]=0.55557
    Y[10]=0.615232
    Y[11]=0.671559
    Y[12]=0.724247
    Y[13]=0.77301
    Y[14]=0.817585
    Y[15]=0.857729
    Y[16]=0.893224
    Y[17]=0.92388
    Y[18]=0.949528
    Y[19]=0.970031
    Y[20]=0.985278
    Y[21]=0.995185
    Y[22]=0.999699
    Y[23]=0.998795
    Y[24]=0.99248
    Y[25]=0.980785
    Y[26]=0.963776
    Y[27]=0.941544
    Y[28]=0.91421
    Y[29]=0.881921
    Y[30]=0.844854
    Y[31]=0.803208
    Y[32]=0.757209
    Y[33]=0.707107
    Y[34]=0.653173
    Y[35]=0.595699
    Y[36]=0.534998
    Y[37]=0.471397
    Y[38]=0.405241
    Y[39]=0.33689
    Y[40]=0.266713
    Y[41]=0.19509
    Y[42]=0.122411
    Y[43]=0.0490677
    Y[44]=-0.0245412
    Y[45]=-0.0980171
    Y[46]=-0.170962
    Y[47]=-0.24298
    Y[48]=-0.313682
    Y[49]=-0.382683
    Y[50]=-0.449611
    Y[51]=-0.514103
    Y[52]=-0.575808
    Y[53]=-0.634393
    Y[54]=-0.689541
    Y[55]=-0.740951
    Y[56]=-0.788346
    Y[57]=-0.83147
    Y[58]=-0.870087
    Y[59]=-0.903989
    Y[60]=-0.932993
    Y[61]=-0.95694
    Y[62]=-0.975702
    Y[63]=-0.989177
    Y[64]=-0.99729
    Y[65]=-1.0
    Y[66]=-0.99729
    Y[67]=-0.989177
    Y[68]=-0.975702
    Y[69]=-0.95694
    Y[70]=-0.932993
    Y[71]=-0.903989
    Y[72]=-0.870087
    Y[73]=-0.83147
    Y[74]=-0.788346
    Y[75]=-0.740951
    Y[76]=-0.689541
    Y[77]=-0.634393
    Y[78]=-0.575808
    Y[79]=-0.514103
    Y[80]=-0.449611
    Y[81]=-0.382683
    Y[82]=-0.313682
    Y[83]=-0.24298
    Y[84]=-0.170962
    Y[85]=-0.0980171
    Y[86]=-0.0245412
    Y[87]=0.0490677
    Y[88]=0.122411
    Y[89]=0.19509
    Y[90]=0.266713
    Y[91]=0.33689
    Y[92]=0.405241
    Y[93]=0.471397
    Y[94]=0.534998
    Y[95]=0.595699
    Y[96]=0.653173
    Y[97]=0.707107
    Y[98]=0.757209
    Y[99]=0.803208
    Y[100]=0.844854
    Y[101]=0.881921
    Y[102]=0.91421
    Y[103]=0.941544
    Y[104]=0.963776
    Y[105]=0.980785
    Y[106]=0.99248
    Y[107]=0.998795
    Y[108]=0.999699
    Y[109]=0.995185
    Y[110]=0.985278
    Y[111]=0.970031
    Y[112]=0.949528
    Y[113]=0.92388
    Y[114]=0.893224
    Y[115]=0.857729
    Y[116]=0.817585
    Y[117]=0.77301
    Y[118]=0.724247
    Y[119]=0.671559
    Y[120]=0.615232
    Y[121]=0.55557
    Y[122]=0.492898
    Y[123]=0.427555
    Y[124]=0.359895
    Y[125]=0.290285
    Y[126]=0.219101
    Y[127]=0.14673
    Y[128]=0.0735646
    Y[129]=3.67394e-16
    Y[130]=-0.0735646
    Y[131]=-0.14673
    Y[132]=-0.219101
    Y[133]=-0.290285
    Y[134]=-0.359895
    Y[135]=-0.427555
    Y[136]=-0.492898
    Y[137]=-0.55557
    Y[138]=-0.615232
    Y[139]=-0.671559
    Y[140]=-0.724247
    Y[141]=-0.77301
    Y[142]=-0.817585
    Y[143]=-0.857729
    Y[144]=-0.893224
    Y[145]=-0.92388
    Y[146]=-0.949528
    Y[147]=-0.970031
    Y[148]=-0.985278
    Y[149]=-0.995185
    Y[150]=-0.999699
    Y[151]=-0.998795
    Y[152]=-0.99248
    Y[153]=-0.980785
    Y[154]=-0.963776
    Y[155]=-0.941544
    Y[156]=-0.91421
    Y[157]=-0.881921
    Y[158]=-0.844854
    Y[159]=-0.803208
    Y[160]=-0.757209
    Y[161]=-0.707107
    Y[162]=-0.653173
    Y[163]=-0.595699
    Y[164]=-0.534998
    Y[165]=-0.471397
    Y[166]=-0.405241
    Y[167]=-0.33689
    Y[168]=-0.266713
    Y[169]=-0.19509
    Y[170]=-0.122411
    Y[171]=-0.0490677
    Y[172]=0.0245412
    Y[173]=0.0980171
    Y[174]=0.170962
    Y[175]=0.24298
    Y[176]=0.313682
    Y[177]=0.382683
    Y[178]=0.449611
    Y[179]=0.514103
    Y[180]=0.575808
    Y[181]=0.634393
    Y[182]=0.689541
    Y[183]=0.740951
    Y[184]=0.788346
    Y[185]=0.83147
    Y[186]=0.870087
    Y[187]=0.903989
    Y[188]=0.932993
    Y[189]=0.95694
    Y[190]=0.975702
    Y[191]=0.989177
    Y[192]=0.99729
    Y[193]=1.0
    Y[194]=0.99729
    Y[195]=0.989177
    Y[196]=0.975702
    Y[197]=0.95694
    Y[198]=0.932993
    Y[199]=0.903989
    Y[200]=0.870087
    Y[201]=0.83147
    Y[202]=0.788346
    Y[203]=0.740951
    Y[204]=0.689541
    Y[205]=0.634393
    Y[206]=0.575808
    Y[207]=0.514103
    Y[208]=0.449611
    Y[209]=0.382683
    Y[210]=0.313682
    Y[211]=0.24298
    Y[212]=0.170962
    Y[213]=0.0980171
    Y[214]=0.0245412
    Y[215]=-0.0490677
    Y[216]=-0.122411
    Y[217]=-0.19509
    Y[218]=-0.266713
    Y[219]=-0.33689
    Y[220]=-0.405241
    Y[221]=-0.471397
    Y[222]=-0.534998
    Y[223]=-0.595699
    Y[224]=-0.653173
    Y[225]=-0.707107
    Y[226]=-0.757209
    Y[227]=-0.803208
    Y[228]=-0.844854
    Y[229]=-0.881921
    Y[230]=-0.91421
    Y[231]=-0.941544
    Y[232]=-0.963776
    Y[233]=-0.980785
    Y[234]=-0.99248
    Y[235]=-0.998795
    Y[236]=-0.999699
    Y[237]=-0.995185
    Y[238]=-0.985278
    Y[239]=-0.970031
    Y[240]=-0.949528
    Y[241]=-0.92388
    Y[242]=-0.893224
    Y[243]=-0.857729
    Y[244]=-0.817585
    Y[245]=-0.77301
    Y[246]=-0.724247
    Y[247]=-0.671559
    Y[248]=-0.615232
    Y[249]=-0.55557
    Y[250]=-0.492898
    Y[251]=-0.427555
    Y[252]=-0.359895
    Y[253]=-0.290285
    Y[254]=-0.219101
    Y[255]=-0.14673
    Y[256]=-0.0735646
    Y[257]=-7.34788e-16
    Y[258]=0.0735646
    Y[259]=0.14673
    Y[260]=0.219101
    Y[261]=0.290285
    Y[262]=0.359895
    Y[263]=0.427555
    Y[264]=0.492898
    Y[265]=0.55557
    Y[266]=0.615232
    Y[267]=0.671559
    Y[268]=0.724247
    Y[269]=0.77301
    Y[270]=0.817585
    Y[271]=0.857729
    Y[272]=0.893224
    Y[273]=0.92388
    Y[274]=0.949528
    Y[275]=0.970031
    Y[276]=0.985278
    Y[277]=0.995185
    Y[278]=0.999699
    Y[279]=0.998795
    Y[280]=0.99248
    Y[281]=0.980785
    Y[282]=0.963776
    Y[283]=0.941544
    Y[284]=0.91421
    Y[285]=0.881921
    Y[286]=0.844854
    Y[287]=0.803208
    Y[288]=0.757209
    Y[289]=0.707107
    Y[290]=0.653173
    Y[291]=0.595699
    Y[292]=0.534998
    Y[293]=0.471397
    Y[294]=0.405241
    Y[295]=0.33689
    Y[296]=0.266713
    Y[297]=0.19509
    Y[298]=0.122411
    Y[299]=0.0490677
    Y[300]=-0.0245412
    Y[301]=-0.0980171
    Y[302]=-0.170962
    Y[303]=-0.24298
    Y[304]=-0.313682
    Y[305]=-0.382683
    Y[306]=-0.449611
    Y[307]=-0.514103
    Y[308]=-0.575808
    Y[309]=-0.634393
    Y[310]=-0.689541
    Y[311]=-0.740951
    Y[312]=-0.788346
    Y[313]=-0.83147
    Y[314]=-0.870087
    Y[315]=-0.903989
    Y[316]=-0.932993
    Y[317]=-0.95694
    Y[318]=-0.975702
    Y[319]=-0.989177
    Y[320]=-0.99729
    Y[321]=-1.0
    Y[322]=-0.99729
    Y[323]=-0.989177
    Y[324]=-0.975702
    Y[325]=-0.95694
    Y[326]=-0.932993
    Y[327]=-0.903989
    Y[328]=-0.870087
    Y[329]=-0.83147
    Y[330]=-0.788346
    Y[331]=-0.740951
    Y[332]=-0.689541
    Y[333]=-0.634393
    Y[334]=-0.575808
    Y[335]=-0.514103
    Y[336]=-0.449611
    Y[337]=-0.382683
    Y[338]=-0.313682
    Y[339]=-0.24298
    Y[340]=-0.170962
    Y[341]=-0.0980171
    Y[342]=-0.0245412
    Y[343]=0.0490677
    Y[344]=0.122411
    Y[345]=0.19509
    Y[346]=0.266713
    Y[347]=0.33689
    Y[348]=0.405241
    Y[349]=0.471397
    Y[350]=0.534998
    Y[351]=0.595699
    Y[352]=0.653173
    Y[353]=0.707107
    Y[354]=0.757209
    Y[355]=0.803208
    Y[356]=0.844854
    Y[357]=0.881921
    Y[358]=0.91421
    Y[359]=0.941544
    Y[360]=0.963776
    Y[361]=0.980785
    Y[362]=0.99248
    Y[363]=0.998795
    Y[364]=0.999699
    Y[365]=0.995185
    Y[366]=0.985278
    Y[367]=0.970031
    Y[368]=0.949528
    Y[369]=0.92388
    Y[370]=0.893224
    Y[371]=0.857729
    Y[372]=0.817585
    Y[373]=0.77301
    Y[374]=0.724247
    Y[375]=0.671559
    Y[376]=0.615232
    Y[377]=0.55557
    Y[378]=0.492898
    Y[379]=0.427555
    Y[380]=0.359895
    Y[381]=0.290285
    Y[382]=0.219101
    Y[383]=0.14673
    Y[384]=0.0735646
    Y[385]=1.10218e-15
    Y[386]=-0.0735646
    Y[387]=-0.14673
    Y[388]=-0.219101
    Y[389]=-0.290285
    Y[390]=-0.359895
    Y[391]=-0.427555
    Y[392]=-0.492898
    Y[393]=-0.55557
    Y[394]=-0.615232
    Y[395]=-0.671559
    Y[396]=-0.724247
    Y[397]=-0.77301
    Y[398]=-0.817585
    Y[399]=-0.857729
    Y[400]=-0.893224
    Y[401]=-0.92388
    Y[402]=-0.949528
    Y[403]=-0.970031
    Y[404]=-0.985278
    Y[405]=-0.995185
    Y[406]=-0.999699
    Y[407]=-0.998795
    Y[408]=-0.99248
    Y[409]=-0.980785
    Y[410]=-0.963776
    Y[411]=-0.941544
    Y[412]=-0.91421
    Y[413]=-0.881921
    Y[414]=-0.844854
    Y[415]=-0.803208
    Y[416]=-0.757209
    Y[417]=-0.707107
    Y[418]=-0.653173
    Y[419]=-0.595699
    Y[420]=-0.534998
    Y[421]=-0.471397
    Y[422]=-0.405241
    Y[423]=-0.33689
    Y[424]=-0.266713
    Y[425]=-0.19509
    Y[426]=-0.122411
    Y[427]=-0.0490677
    Y[428]=0.0245412
    Y[429]=0.0980171
    Y[430]=0.170962
    Y[431]=0.24298
    Y[432]=0.313682
    Y[433]=0.382683
    Y[434]=0.449611
    Y[435]=0.514103
    Y[436]=0.575808
    Y[437]=0.634393
    Y[438]=0.689541
    Y[439]=0.740951
    Y[440]=0.788346
    Y[441]=0.83147
    Y[442]=0.870087
    Y[443]=0.903989
    Y[444]=0.932993
    Y[445]=0.95694
    Y[446]=0.975702
    Y[447]=0.989177
    Y[448]=0.99729
    Y[449]=1.0
    Y[450]=0.99729
    Y[451]=0.989177
    Y[452]=0.975702
    Y[453]=0.95694
    Y[454]=0.932993
    Y[455]=0.903989
    Y[456]=0.870087
    Y[457]=0.83147
    Y[458]=0.788346
    Y[459]=0.740951
    Y[460]=0.689541
    Y[461]=0.634393
    Y[462]=0.575808
    Y[463]=0.514103
    Y[464]=0.449611
    Y[465]=0.382683
    Y[466]=0.313682
    Y[467]=0.24298
    Y[468]=0.170962
    Y[469]=0.0980171
    Y[470]=0.0245412
    Y[471]=-0.0490677
    Y[472]=-0.122411
    Y[473]=-0.19509
    Y[474]=-0.266713
    Y[475]=-0.33689
    Y[476]=-0.405241
    Y[477]=-0.471397
    Y[478]=-0.534998
    Y[479]=-0.595699
    Y[480]=-0.653173
    Y[481]=-0.707107
    Y[482]=-0.757209
    Y[483]=-0.803208
    Y[484]=-0.844854
    Y[485]=-0.881921
    Y[486]=-0.91421
    Y[487]=-0.941544
    Y[488]=-0.963776
    Y[489]=-0.980785
    Y[490]=-0.99248
    Y[491]=-0.998795
    Y[492]=-0.999699
    Y[493]=-0.995185
    Y[494]=-0.985278
    Y[495]=-0.970031
    Y[496]=-0.949528
    Y[497]=-0.92388
    Y[498]=-0.893224
    Y[499]=-0.857729
    Y[500]=-0.817585
    Y[501]=-0.77301
    Y[502]=-0.724247
    Y[503]=-0.671559
    Y[504]=-0.615232
    Y[505]=-0.55557
    Y[506]=-0.492898
    Y[507]=-0.427555
    Y[508]=-0.359895
    Y[509]=-0.290285
    Y[510]=-0.219101
    Y[511]=-0.14673
    Y[512]=-0.0735646

    grad = zeros(size(x))
    sum=0
    for i = 1:512
        term1 = 10*sin(X[i]*x[1])
        sum = sum +(-10*Y[i] + term1)^2
    end
    return sum#, grad
end

#PROBLEM CHILD!
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

function sinquad(x::AbstractVector)
    println("Julia port of CUTEST's SINQUAD")
    grad = zeros(size(x))
    term1 = (x[1]-1)^4
    term2 = (x[length(x)]^2-x[1]^2)^2
    sum=term1+term2
    for i = 2:(length(x)-1)
        term1 = sin(x[i]-x[length(x)])
        term2 = -x[1]^2+x[i]^2
        sum = sum + (term1+term2)^2
    end
    return sum#, grad
end

function cliff(x::AbstractVector)
    println("Julia port of CUTEST's CLIFF")
    grad = zeros(size(x))
    term1=(0.01*x[1]-0.03)^2
    term2 = x[2]-x[1]
    term3 = exp(20*(x[1]-x[2]))
    sum=term1+term2+term3
    return sum#, grad
end

function eg2(x::AbstractVector)
    println("Julia port of CUTEST's EG2")
    grad = zeros(size(x))
    sum=0.5*sin(x[length(x)]^2)
    for i = 1:(length(x)-1)
        term1 = x[i]^2-1+x[1]        
        sum = sum + sin(term1)
    end
    return sum#, grad
end

function exp2(x::AbstractVector)
    println("Julia port of CUTEST's EXP2")
    grad = zeros(size(x))
    sum=0
    for i = 1:(10-1)
        term1 = -5*exp(-0.1*i*x[2]) + exp(-0.1*i*x[1])
        term2 = -1*(exp(-0.1*i)-5*exp(-i))
        sum = sum + (term1+term2)^2
    end
    return sum#, grad
end

function cube(x::AbstractVector)
    println("Julia port of CUTEST's CUBE")
    grad = zeros(size(x))
    sum=(x[1]-1)^2
    for i = 2:(length(x))
        term1 = x[i]^2-x[i-1]^3
        sum = sum + 100*(term1)^2
    end
    return sum#, grad
end

function gaussian(x::AbstractVector)
    println("Julia port of CUTEST's GAUSSIAN")
    grad = zeros(size(x))
    sum=0
    G=ones(15)
    G[1]=0.0009
    G[2]=0.0044
    G[3]=0.0175
    G[4]=0.0540
    G[5]=0.1295
    G[6]=0.2420
    G[7]=0.3521
    G[8]=0.3989
    G[9]=0.3521
    G[10]=0.2420
    G[11]=0.1295
    G[12]=0.0540
    G[13]=0.0175
    G[14]=0.0044
    G[15]=0.0009
    for i = 1:15
        exp1 = -0.5*x[2]*(0.5*(8-i)-x[3])^2
        term1 = -G[i] + x[1]*exp(exp1)
        sum = sum + term1^2
    end
    return sum#, grad
end

function humps(x::AbstractVector)
    println("Julia port of CUTEST's HUMPS")
    grad = zeros(size(x))
    sum=0
    term1 = sin(20*x[1])*sin(20*x[2])
    sum = sum + term1^2 + 0.05*x[1]^2 + 0.05*x[2]^2
    return sum#, grad
end

len[1]=100000
x=ones(100000)
sumArray[1] = oscigrad(x)
len[2]=3
x=ones(3)
sumArray[2] = box3(x)
len[3]=500
x=ones(500)
sumArray[3] = oscipath(x)
len[4]=10000
x=ones(10000)
sumArray[4] = box(x)
len[5]=2
x=ones(2)
sumArray[5] = boxbodls(x)
len[6]=20000
x=ones(20000)
sumArray[6] = boxpower(x)
len[7]=3
x=ones(3)
sumArray[7] = engval2(x)
len[8]=5000
x=ones(5000)
sumArray[8] = engval1(x)
len[9]=2
x=ones(2)
sumArray[9] = rosenbr(x)
len[10]=5000
x=ones(5000)
sumArray[10] = srosenbr(x)
len[11]=2
x=ones(2)
sumArray[11] = rosenbrtu(x)
len[12]=500
x=ones(500)
sumArray[12] = genrose(x)
len[13]=10000
x=ones(10000)
sumArray[13] = power(x)
len[14]=1000
x=ones(1000)
sumArray[14] = fletchcr(x)
len[15]=1000
x=ones(1000)
sumArray[15] = extrosnb(x)
len[16]=4
x=ones(4)
sumArray[16] = roszman1ls(x)
len[17]=3000
x=ones(3000)
sumArray[17] = dixmaani(x)
len[18]=5000
x=ones(5000)
sumArray[18] = liarwhd(x)
len[19]=5000
x=ones(5000)
sumArray[19] = schmvett(x)
len[20]=98
x=ones(98)
sumArray[20] = luksan13ls(x)
len[21]=2
x=ones(2)
sumArray[21] = judge(x)
len[22]=5000
x=ones(5000)
sumArray[22] = nondia(x)
len[23]=3000
x=ones(3000)
sumArray[23] = dixmaanj(x)
len[24]=3000
x=ones(3000)
sumArray[24] = dixmaanc(x)
len[25]=3000
x=ones(3000)
sumArray[25] = dixmaanl(x)
len[26]=3000
x=ones(3000)
sumArray[26] = dixmaank(x)
len[27]=3000
x=ones(3000)
sumArray[27] = dixmaang(x)
len[28]=3000
x=ones(3000)
sumArray[28] = dixmaanf(x)
len[29]=3000
x=ones(3000)
sumArray[29] = dixmaane(x)
len[30]=3000
x=ones(3000)
sumArray[30] = dixmaanp(x)
len[31]=3000
x=ones(3000)
sumArray[31] = dixmaanh(x)
len[32]=3000
x=ones(3000)
sumArray[32] = dixmaanb(x)
len[33]=3000
x=ones(3000)
sumArray[33] = dixmaann(x)
len[34]=3000
x=ones(3000)
sumArray[34] = dixmaana(x)
len[35]=3000
x=ones(3000)
sumArray[35] = dixmaano(x)
len[36]=3000
x=ones(3000)
sumArray[36] = dixmaanm(x)
len[37]=3000
x=ones(3000)
sumArray[37] = dixmaand(x)
len[38]=2
x=ones(2)
sumArray[38] = sinvalne(x)
len[39]=10000
x=ones(10000)
sumArray[39] = cosine(x)
len[40]=5000
x=ones(5000)
sumArray[40] = sscosine(x)
len[41]=2
x=ones(2)
sumArray[41] = sineval(x)
len[42]=1
x=ones(1)
sumArray[42] = muonsinels(x)
len[43]=5000
x=ones(5000)
sumArray[43] = scosine(x)
len[44]=5000
x=ones(5000)
sumArray[44] = sinquad(x)
len[45]=2
x=ones(2)
sumArray[45] = cliff(x)
len[46]=1000
x=ones(1000)
sumArray[46] = eg2(x)
len[47]=2
x=ones(2)
sumArray[47] = exp2(x)
len[48]=2
x=ones(2)
sumArray[48] = cube(x)
len[49]=3
x=ones(3)
sumArray[49] = gaussian(x)
len[50]=2
x=ones(2)
sumArray[50] = humps(x)

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

#unitTesting(problemVector,sumArray,gradArray,len)

# end