# module Wrapper

# export wrapfun
# #ALL GOOD
# using CUTEst
# using NLPModels

A = Dict{String,Function}()

A["ARGLINC"]=function arglinc(x::AbstractVector)
    println("Julia port of CUTEST's ARGLINC")
    N=200
    M=400
    sum = 2
    for i = 2:(M-1)
        sum1=-1
        for j = 2:(N-1)
            term = j*(i-1)*x[j]
            sum1 = sum1 + term
        end
        sum=sum+sum1^2
    end
    return sum
end

A["TOINTGSS"]=function tointgss(x::AbstractVector)
    println("Julia port of CUTEST's TOINTGSS")
    grad = zeros(size(x))
    N=5000
    sum=0
    coeff=10/(N-2)
    for i = 1:(N-2)
        U1=x[i]-x[i+1]
        U2=x[i+2]
        AU2SQ = coeff+U2^2
        TMEXPA = 2-exp(-U1^2/(0.1+U2^2))
        term = AU2SQ*TMEXPA
        sum = sum + term
    end
    return sum#, grad
end

A["SNAIL"]=function snail(x::AbstractVector)
    println("Julia port of CUTEST's SNAIL")
    grad = zeros(size(x))
    N=length(x)
    CLOW=1
    CUP=2
    term1 = (x[1]^2+x[2]^2)/(1+x[1]^2+x[2]^2)
    term2 = 1+0.5*(CUP+CLOW)*sqrt(x[1]^2+x[2]^2)
    term3 =sqrt(x[1]^2+x[2]^2)*0.5*(CUP-CLOW)*cos(sqrt(x[1]^2+x[2]^2)-atan(x[2],x[1]))
    sum = term1*(term2-term3)
    return sum#, grad
end

A["BEALE"]=function beale(x::AbstractVector)
    println("Julia port of CUTEST's BEALE")
    grad = zeros(size(x))
    N=2
    A=-1.5+x[1]*(1-x[2]^1)
    B=-2.25+x[1]*(1-x[2]^2)
    C=-2.625+x[1]*(1-x[2]^3)
    sum=A^2+B^2+C^2
    return sum #, grad
end

A["ECKERLE4LS"]=function eckerle4ls(x::AbstractVector)
    println("Julia port of CUTEST's ECKERLE4LS")
    grad = zeros(size(x))
    N=3
    M=35
    sum=0
    X=zeros(M)
    Y=zeros(M)
    X[1]=400.000000
    X[2]=405.000000
    X[3]=410.000000
    X[4]=415.000000
    X[5]=420.000000
    X[6]=425.000000
    X[7]=430.000000
    X[8]=435.000000
    X[9]=436.500000
    X[10]=438.000000
    X[11]=439.500000
    X[12]=441.000000
    X[13]=442.500000
    X[14]=444.000000
    X[15]=445.500000
    X[16]=447.000000
    X[17]=448.500000
    X[18]=450.000000
    X[19]=451.500000
    X[20]=453.000000
    X[21]=454.500000
    X[22]=456.000000
    X[23]=457.500000
    X[24]=459.000000
    X[25]=460.500000
    X[26]=462.000000
    X[27]=463.500000
    X[28]=465.000000
    X[29]=470.000000
    X[30]=475.000000
    X[31]=480.000000
    X[32]=485.000000
    X[33]=490.000000
    X[34]=495.000000
    X[35]=500.000000
          
    Y[1]=0.0001575
    Y[2]=0.0001699
    Y[3]=0.0002350
    Y[4]=0.0003102
    Y[5]=0.0004917
    Y[6]=0.0008710
    Y[7]=0.0017418
    Y[8]=0.0046400
    Y[9]=0.0065895
    Y[10]=0.0097302
    Y[11]=0.0149002
    Y[12]=0.0237310
    Y[13]=0.0401683
    Y[14]=0.0712559
    Y[15]=0.1264458
    Y[16]=0.2073413
    Y[17]=0.2902366
    Y[18]=0.3445623
    Y[19]=0.3698049
    Y[20]=0.3668534
    Y[21]=0.3106727
    Y[22]=0.2078154
    Y[23]=0.1164354
    Y[24]=0.0616764
    Y[25]=0.0337200
    Y[26]=0.0194023
    Y[27]=0.0117831
    Y[28]=0.0074357
    Y[29]=0.0022732
    Y[30]=0.0008800
    Y[31]=0.0004579
    Y[32]=0.0002345
    Y[33]=0.0001586
    Y[34]=0.0001143
    Y[35]=0.0000710
    for i = 1:M
        term1 = -Y[i]
        term2 = x[1]*exp(-0.5*(x[3]-X[i])^2/x[2]^2)/x[2]
        sum = sum+(term1+term2)^2
    end
    return sum#, grad
end

A["NCB20B"]=function ncb20b(x::AbstractVector)
    println("Julia port of CUTEST's NCB20B")
    grad = zeros(size(x))
    N=5000
    P=20
    CL=-4/P
    sum=0
    for i = 1:(N-P+1)
        coeff = (10/i)
        term1=0
        for j = i:(i+19)
            term1 = term1 + x[j]/(1+x[j]^2)
        end
        term1=term1^2
        termA=0
        for j = 1:P
            termA = termA + CL*x[i+j-1]
        end
        term2 = x[i]^4
        sum = sum + (coeff*term1+termA+100*term2+2)
    end
    for i = (N-P+2):N
        coeff = 1
        term1 = 2
        term2 = x[i]^4
        sum = sum + (coeff*term1+100*term2)
    end
    return sum#, grad
end

A["JENSMP"]=function jensmp(x::AbstractVector)
    println("Julia port of CUTEST's JENSMP")
    grad = zeros(size(x))
    M=10
    sum=0
    for i = 1:M
        term1 = -(2+2*i)
        term2 = exp(i*x[1])
        term3 = exp(i*x[2])
        sum = sum+(term1+term2+term3)^2
    end
    return sum#, grad
end

A["CHWIRUT2LS"]=function chwirut2ls(x::AbstractVector)
    println("Julia port of CUTEST's CHWIRUT2LS")
    grad = zeros(size(x))
    M=54
    N=3
    sum=0
    X=zeros(54)
    Y=zeros(54)
    X[1]=0.5  
    X[2]=1.0  
    X[3]=1.75 
    X[4]=3.75 
    X[5]=5.75 
    X[6]=0.875
    X[7]=2.25 
    X[8]=3.25 
    X[9]=5.25 
    X[10]=0.75 
    X[11]=1.75 
    X[12]=2.75 
    X[13]=4.75 
    X[14]=0.625
    X[15]=1.25 
    X[16]=2.25 
    X[17]=4.25 
    X[18]=0.5  
    X[19]=3.0  
    X[20]=0.75 
    X[21]=3.0  
    X[22]=1.5  
    X[23]=6.0  
    X[24]=3.0  
    X[25]=6.0  
    X[26]=1.5  
    X[27]=3.0  
    X[28]=0.5  
    X[29]=2.0  
    X[30]=4.0  
    X[31]=0.75 
    X[32]=2.0  
    X[33]=5.0  
    X[34]=0.75 
    X[35]=2.25 
    X[36]=3.75 
    X[37]=5.75 
    X[38]=3.0  
    X[39]=0.75 
    X[40]=2.5  
    X[41]=4.0  
    X[42]=0.75 
    X[43]=2.5  
    X[44]=4.0  
    X[45]=0.75 
    X[46]=2.5  
    X[47]=4.0  
    X[48]=0.5  
    X[49]=6.0  
    X[50]=3.0  
    X[51]=0.5  
    X[52]=2.75 
    X[53]=0.5  
    X[54]=1.75 

    Y[1]=92.9   
    Y[2]=57.1   
    Y[3]=31.05  
    Y[4]=11.5875
    Y[5]=8.025  
    Y[6]=63.6   
    Y[7]=21.4   
    Y[8]=14.25  
    Y[9]=8.475  
    Y[10]=63.8   
    Y[11]=26.8   
    Y[12]=16.4625
    Y[13]=7.125  
    Y[14]=67.3   
    Y[15]=41.0   
    Y[16]=21.15  
    Y[17]=8.175  
    Y[18]=81.50  
    Y[19]=13.12  
    Y[20]=59.9   
    Y[21]=14.62  
    Y[22]=32.9   
    Y[23]=5.44   
    Y[24]=12.56  
    Y[25]=5.44   
    Y[26]=32.0   
    Y[27]=13.95  
    Y[28]=75.8   
    Y[29]=20.0   
    Y[30]=10.42  
    Y[31]=59.5   
    Y[32]=21.67  
    Y[33]=8.55   
    Y[34]=62.0   
    Y[35]=20.2   
    Y[36]=7.76   
    Y[37]=3.75   
    Y[38]=11.81  
    Y[39]=54.7   
    Y[40]=23.7   
    Y[41]=11.55  
    Y[42]=61.3   
    Y[43]=17.7   
    Y[44]=8.74   
    Y[45]=59.2   
    Y[46]=16.3   
    Y[47]=8.62   
    Y[48]=81.0   
    Y[49]=4.87   
    Y[50]=14.62  
    Y[51]=81.7   
    Y[52]=17.17  
    Y[53]=81.3   
    Y[54]=28.9 
    for i = 1:(M)
        term1 = -Y[i]
        term2 = exp(-x[1]*X[i])
        term3 = x[2]+x[3]*X[i]
        sum = sum+(term1+term2/term3)^2
    end
    return sum#, grad
end

A["THURBERLS"]=function thurberls(x::AbstractVector)
    println("Julia port of CUTEST's THURBERLS")
    grad = zeros(size(x))
    M=37
    X=zeros(M)
    Y=zeros(M)
    X[1]=-3.067
    X[2]=-2.981
    X[3]=-2.921
    X[4]=-2.912
    X[5]=-2.840
    X[6]=-2.797
    X[7]=-2.702
    X[8]=-2.699
    X[9]=-2.633
    X[10]=-2.481
    X[11]=-2.363
    X[12]=-2.322
    X[13]=-1.501
    X[14]=-1.460
    X[15]=-1.274
    X[16]=-1.212
    X[17]=-1.100
    X[18]=-1.046
    X[19]=-0.915
    X[20]=-0.714
    X[21]=-0.566
    X[22]=-0.545
    X[23]=-0.400
    X[24]=-0.309
    X[25]=-0.109
    X[26]=-0.103
    X[27]=0.010
    X[28]=0.119
    X[29]=0.377
    X[30]=0.790
    X[31]=0.963
    X[32]=1.006
    X[33]=1.115
    X[34]=1.572
    X[35]=1.841
    X[36]=2.047
    X[37]=2.200

    Y[1]=  80.574
    Y[2]=  84.248
    Y[3]=  87.264
    Y[4]=  87.195
    Y[5]=  89.076
    Y[6]=  89.608
    Y[7]=  89.868
    Y[8]=  90.101
    Y[9]=  92.405
    Y[10]= 95.854
    Y[11]=100.696
    Y[12]=101.060
    Y[13]=401.672
    Y[14]=390.724
    Y[15]=567.534
    Y[16]=635.316
    Y[17]=733.054
    Y[18]=759.087
    Y[19]=894.206
    Y[20]=990.785
    Y[21]=1090.109
    Y[22]=1080.914
    Y[23]=1122.643
    Y[24]=1178.351
    Y[25]=1260.531
    Y[26]=1273.514
    Y[27]=1288.339
    Y[28]=1327.543
    Y[29]=1353.863
    Y[30]=1414.509
    Y[31]=1425.208
    Y[32]=1421.384
    Y[33]=1442.962
    Y[34]=1464.350
    Y[35]=1468.705
    Y[36]=1447.894
    Y[37]=1457.628
    N=7
    sum=0 
    for i = 1:M
        term1 = -Y[i]
        term2 = x[1]+x[2]*X[i]+x[3]*X[i]^2+x[4]*X[i]^3
        term3 = 1+x[5]*X[i]+x[6]*X[i]^2+x[7]*X[i]^3
        sum = sum +(term1+term2/term3)^2
    end
    return sum#, grad
end

A["NCB20"]=function ncb20(a::AbstractVector)
    println("Julia port of CUTEST's NCB20")
    #grad = zeros(size(a))
    N=5000
    P=20
    CL=-4/P
    COND = 10^4
    NY=10
    sum=0
    x=a[1:5000]
    y=a[5001:5010]
    for i = 1:(N-P)
        coeff = (10/i)
        term1 = 0
        for j = i:(i+19)
            term1 = term1 + x[j]/(1+x[j]^2)
        end
        term1=term1^2
        termA=0
        for j = 1:P
            termA = termA + CL*x[i+j-1]
        end
        term2 = x[i]^4
        sum = sum + (coeff*term1+termA+term2+2)
    end
    for i = (N-P+1):N
        coeff = 1
        term1 = 2
        term2 = x[i]^4
        sum = sum + (coeff*term1+term2)
    end
    for i = 1:NY
        term3 = x[i] * x[NY+i] * y[i] + 2.0 * y[i]^2
        sum=sum+term3*(1/COND)
    end
    sum=sum+2
    return sum#, grad
end

A["ARWHEAD"]=function arwhead(x::AbstractVector)
    println("Julia port of CUTEST's ARWHEAD")
    grad = zeros(size(x))
    N=5000
    sum = 0
    for i = 1:(N-1)
        term1 = -4*x[i]+3
        term2 = x[i]^2+x[N]^2
        sum = sum +term1+term2^2
    end
    return sum#, grad
end

A["CHNRSNBM"]=function chnrsnbm(x::AbstractVector)
    println("Julia port of CUTEST's CHNRSNBM")
    grad = zeros(size(x))
    N=50
    sum=0
    for i = 2:N
        term1 = x[i-1]-x[i]^2
        coeff = 16*(1.5+sin(i))^2
        term2 = x[i]-1
        sum = sum+coeff*(term1)^2+term2^2
    end
    return sum#, grad
end

A["BRKMCC"]=function brkmcc(x::AbstractVector)
    println("Julia port of CUTEST's BRKMCC")
    grad = zeros(size(x))
    N=length(x)
    sum=0
    term1 = x[1]-2
    term2 = x[2]-1
    term3 = 1-0.25*x[1]^2-x[2]^2
    term4 = x[1]-2*x[2]+1
    sum = term1^2+term2^2+(1/25)*1/term3+5*term4^2
    return sum#, grad
end

A["BIGGS6"]=function biggs6(x::AbstractVector)
    println("Julia port of CUTEST's BIGGS6")
    grad = zeros(size(x))
    N=6
    M=13
    sum=0
    for i = 1:M
        coeff = exp(-0.1*i)-5*exp(-1*i)+3*exp(-0.4*i)
        A= x[3]*exp(-0.1*i*x[1])
        B= x[4]*exp(-0.1*i*x[2])
        C= x[6]*exp(-0.1*i*x[5])
        sum = sum + (-coeff+A-B+C)^2
    end
    return sum #, grad
end

A["FLETBV3M"]=function fletbv3m(x::AbstractVector)
    println("Julia port of CUTEST's FLETBV3M")
    grad = zeros(size(x))
    N=5000
    OBJ = 10^8
    K=1
    H=1/(N+1)
    H2=H^2
    IH2 = (N+1)^2
    KDH2 = K/IH2
    P=1/OBJ

    term1 = x[1]
    sum=0.5*P*term1^2
    for i = 1:(N-1)
        term1 = x[i]-x[i+1]
        sum = sum+0.5*P*(term1)^2
    end
    term1 = P*x[N]
    sum =sum+0.5*P*term1^2
    for i = 1:(N)
        term2 = (-K/H2)*P*cos(x[i])
        sum = sum+(term2)
    end
    for i = 1:(N)
        term3 = (P*(1+2/H2))*100*sin(0.01*x[i])
        sum = sum+(term3)
    end
    return sum#, grad
end

A["EXPFIT"]=function expfit(x::AbstractVector)
    println("Julia port of CUTEST's EXPFIT")
    grad = zeros(size(x))
    P=10
    H=0.25
    sum=0
    for i = 1:P
        term1 = -i*H+x[1]*exp(x[2]*i*0.25)
        sum = sum+term1^2
    end
    return sum#, grad
end

A["VARDIM"]=function vardim(x::AbstractVector)
    println("Julia port of CUTEST's VARDIM")
    grad = zeros(size(x))
    N=200
    sum=0
    J=0.5*N*(N+1)
    for i = 1:(N)
        term1 = x[i]-1
        sum = sum+(term1)^2
    end
    sum1=0
    sum2 =0
    for i = 1:N
        sum1 = sum1+i*x[i]
        sum2 = sum2+i*x[i]
    end
    sum1 = sum1-J
    sum2=sum2-J
    sum = sum + sum1^2 + sum2^4
    return sum#, grad
end

A["ALLINITU"]=function allinitu(x::AbstractVector)
    println("Julia port of CUTEST's ALLINITU")
    grad = zeros(size(x))
    N=4
    sum=0 
        FT2 = x[3]-1
        FT3 = x[1]^2
        FT4 = x[2]^2+(x[3]+x[4])^2
        FT5 = x[4]-3+sin(x[3])^2+x[1]^2*x[2]^2
        FT6 = sin(x[3])^2
        FNT2 = x[4]-1
        FNT3 = x[2]^2
        FNT4 = x[3]^2+(x[4]+x[1])^2
        FNT5 = x[1]-4+sin(x[4])^2+x[2]^2*x[3]^2
        FNT6 = sin(x[4])^2
        sum = FT2+FT3+FT4+FT5+FT6+FNT2^2+FNT3^2+FNT4^2+FNT5^2+FNT6^2
    return sum#, grad
end

A["KOWOSB"]=function kowosb(x::AbstractVector)
    println("Julia port of CUTEST's KOWOSB")
    grad = zeros(size(x))
    M=11
    G=zeros(M)
    E=zeros(M)
    G[1]=0.1957
    G[2]=0.1947
    G[3]=0.1735
    G[4]=0.1600
    G[5]=0.0844
    G[6]=0.0627
    G[7]=0.0456
    G[8]=0.0342
    G[9]=0.0323
    G[10]=0.0235
    G[11]=0.0246
    E[1]=4.0
    E[2]=2.0
    E[3]=1.0
    E[4]=0.5
    E[5]=0.25
    E[6]=0.167
    E[7]=0.125
    E[8]=0.1
    E[9]=0.0833
    E[10]=0.0714
    E[11]=0.0624
    sum=0
    for i = 1:M
        term1 = -G[i]+x[1]*(E[i]^2+E[i]*x[2])/(E[i]^2+E[i]*x[3]+x[4])
        sum = sum+(term1)^2
    end
    return sum#, grad
end

A["MEYER3"]=function meyer3(x::AbstractVector)
    println("Julia port of CUTEST's MEYER3")
    grad = zeros(size(x))
    sum=0 
    G=zeros(16)
    G[1]=34780.0
    G[2]=28610.0
    G[3]=23650.0
    G[4]=19630.0
    G[5]=16370.0
    G[6]=13720.0
    G[7]=11540.0
    G[8]=9744.0
    G[9]=8261.0
    G[10]=7030.0
    G[11]=6005.0
    G[12]=5147.0
    G[13]=4427.0
    G[14]=3820.0
    G[15]=3307.0
    G[16]=2872.0
    x[1]=100*x[1]
    for i = 1:16
        term1 = -G[i]
        coeff=45+5*i
        term2 = x[1]*exp(0.0001*x[2]/(coeff+0.01*x[3]))
        sum = sum+(term1+term2)^2
    end
    return sum#, grad
end

A["TRIDIA"]=function tridia(x::AbstractVector)
    println("Julia port of CUTEST's TRIDIA")
    grad = zeros(size(x))
    alpha = 2
    beta=1
    N=5000
    gamma=1
    delta=1
    sum = (x[1]-1)^2
    for i = 2:N
        term1 = -x[i-1]+2*x[i]
        sum = sum +i*term1^2
    end
    return sum#, grad
end

A["SENSORS"]=function sensors(x::AbstractVector)
    println("Julia port of CUTEST's SENSORS")
    grad = zeros(size(x))
    N=100
    sum = 0
    for i = 1:N
        for j = 1:N
            term1 = sin(x[i])*sin(x[j])*sin(x[i]-x[j])
            sum = sum -term1^2
        end
    end
    return sum#, grad
end

A["INDEF"]=function indef(x::AbstractVector)
    println("Julia port of CUTEST's INDEF")
    grad = zeros(size(x))
    N=5000
    alpha=0.5
    sum = 0
    for i = 1:N
        term1 = x[i]
        sum = sum +term1
    end
    for i = 2:(N-1)
        term1 = 2*x[i]-x[N]-x[1]
        sum = sum +0.5*cos(term1)
    end
    return sum#, grad
end

A["RAT43LS"]=function rat43ls(x::AbstractVector)
    println("Julia port of CUTEST's RAT43LS")
    grad = zeros(size(x))
    M=15
    N=4
    X=zeros(M)
    Y=zeros(M)
    X[1]=1.0
    X[2]=2.0
    X[3]=3.0
    X[4]=4.0
    X[5]=5.0
    X[6]=6.0
    X[7]=7.0
    X[8]=8.0
    X[9]=9.0
    X[10]=10.0
    X[11]=11.0
    X[12]=12.0
    X[13]=13.0
    X[14]=14.0
    X[15]=15.0

    Y[1]=16.08
    Y[2]=33.83
    Y[3]=65.80
    Y[4]=97.20
    Y[5]=191.55
    Y[6]=326.20
    Y[7]=386.87
    Y[8]=520.53
    Y[9]=590.03
    Y[10]=651.92
    Y[11]=724.93
    Y[12]=699.56
    Y[13]=689.96
    Y[14]=637.56
    Y[15]=717.41

    sum = 0
    for i = 1:M
        term1 = -Y[i]
        EP1 = 1+ exp(x[2]-x[3]*X[i])
        term2 = x[1]/(EP1^(1/x[4]))
        sum = sum +(term1+term2)^2
    end
    return sum#, grad
end

A["CLUSTERLS"]=function clusterls(x::AbstractVector)
    println("Julia port of CUTEST's CLUSTERLS")
    grad = zeros(size(x))
    term1 = (x[1]-x[2]^2)*(x[1]-sin(x[2]))
    term2 = (cos(x[2])-x[1])*(x[2]-cos(x[1]))
    sum = term1^2+term2^2
    return sum#, grad
end

A["OSBORNEA"]=function osbornea(x::AbstractVector)
    println("Julia port of CUTEST's OSBORNEA")
    grad = zeros(size(x))
    M=33
    G=zeros(M)
    G[1]=0.844
    G[2]=0.908
    G[3]=0.932
    G[4]=0.936
    G[5]=0.925
    G[6]=0.908
    G[7]=0.881
    G[8]=0.850
    G[9]=0.818
    G[10]=0.784
    G[11]=0.751
    G[12]=0.718
    G[13]=0.685
    G[14]=0.658
    G[15]=0.628
    G[16]=0.603
    G[17]=0.580
    G[18]=0.558
    G[19]=0.538
    G[20]=0.522
    G[21]=0.506
    G[22]=0.490
    G[23]=0.478
    G[24]=0.467
    G[25]=0.457
    G[26]=0.448
    G[27]=0.438
    G[28]=0.431
    G[29]=0.424
    G[30]=0.420
    G[31]=0.414
    G[32]=0.411
    G[33]=0.406
    sum=0
    for i = 1:M
        T=-10*(i-1)
        term1 = x[1]-G[i]
        term2 = x[2]*exp(T*x[4])
        term3 = x[3]*exp(T*x[5])
        sum = sum + (term1+term2+term3)^2
    end
    return sum#, grad
end

A["STRTCHDV"]=function strtchdv(x::AbstractVector)
    println("Julia port of CUTEST's STRTCHDV")
    grad = zeros(size(x))
    N=10
    M=N-1
    sum=0
    for i = 1:M
        Y = x[i]^2+x[i+1]^2
        A = Y^0.125
        S = sin(50*Y^0.1)
        B = 1+S
        term = A*B
        sum = sum + (term)^2
    end
    return sum#, grad
end

A["HATFLDD"]=function hatfldd(x::AbstractVector)
    println("Julia port of CUTEST's HATFLDD")
    grad = zeros(size(x))
    N=length(x)
    T=zeros(10)
    Z=zeros(10)
    T[1]=0.2
    T[2]=0.3
    T[3]=0.4
    T[4]=0.5
    T[5]=0.6
    T[6]=0.7
    T[7]=0.75
    T[8]=0.8
    T[9]=0.85
    T[10]=0.9

    Z[1]=1.751
    Z[2]=1.561
    Z[3]=1.391
    Z[4]=1.239
    Z[5]=1.103
    Z[6]=0.981
    Z[7]=0.925
    Z[8]=0.8721
    Z[9]=0.8221
    Z[10]=0.7748

    sum=0
    for i = 1:10
        term1 = Z[i]
        term2 = -x[1]*exp(T[i]*x[2])
        term3 = exp(T[i]*x[3])
        sum = sum + (term1+term2+term3)^2
    end
    return sum#, grad
end

A["HATFLDE"]=function hatflde(x::AbstractVector)
    println("Julia port of CUTEST's HATFLDE")
    grad = zeros(size(x))
    NG=21
    T=zeros(NG)
    Z=zeros(NG)
    T[1]=0.3
    T[2]=0.35
    T[3]=0.4
    T[4]=0.45
    T[5]=0.5
    T[6]=0.55
    T[7]=0.6
    T[8]=0.65
    T[9]=0.7
    T[10]=0.75
    T[11]=0.8
    T[12]=0.85
    T[13]=0.9
    T[14]=0.95
    T[15]=1.0
    T[16]=1.05
    T[17]=1.1
    T[18]=1.15
    T[19]=1.2
    T[20]=1.25
    T[21]=1.3

    Z[1]=1.561
    Z[2]=1.473
    Z[3]=1.391
    Z[4]=1.313
    Z[5]=1.239
    Z[6]=1.169
    Z[7]=1.103
    Z[8]=1.04
    Z[9]=0.981
    Z[10]=0.925
    Z[11]=0.8721
    Z[12]=0.8221
    Z[13]=0.7748
    Z[14]=0.73
    Z[15]=0.6877
    Z[16]=0.6477
    Z[17]=0.6099
    Z[18]=0.5741
    Z[19]=0.5403
    Z[20]=0.5084
    Z[21]=0.4782
    sum=0
    for i = 1:NG
        term = Z[i]
        term1 = -x[1]*exp(T[i]*x[2])
        term2 = exp(x[3]*T[i])
        sum = sum + (term+term1+term2)^2
    end
    return sum#, grad
end

A["RAT42LS"]=function rat42ls(x::AbstractVector)
    println("Julia port of CUTEST's RAT42LS")
    grad = zeros(size(x))
    M=9
    N=3
    X=zeros(M)
    Y=zeros(M)
    X[1]= 9.0
    X[2]=14.0
    X[3]=21.0
    X[4]=28.0
    X[5]=42.0
    X[6]=57.0
    X[7]=63.0
    X[8]=70.0
    X[9]=79.0

    Y[1]= 8.93
    Y[2]=10.80
    Y[3]=18.59
    Y[4]=22.33
    Y[5]=39.35
    Y[6]=56.11
    Y[7]=61.73
    Y[8]=64.62
    Y[9]=67.08
    sum=0
    for i = 1:M
        term = -Y[i]
        term1 = x[1]/(1+exp(x[2]-x[3]*X[i]))
        sum = sum + (term+term1)^2
    end
    return sum#, grad
end

A["NONCVXUN"]=function noncvxun(x::AbstractVector)
    println("Julia port of CUTEST's NONCVXUN")
    grad = zeros(size(x))
    N=5000
    sum=0
    for i = 1:N
        term1 = (x[i]+x[mod(2*i-1,N)+1]+x[mod(3*i-1,N)+1])^2
        term2 = 4*cos(x[i]+x[mod(2*i-1,N)+1]+x[mod(3*i-1,N)+1])
        sum = sum + term1+term2
    end
    return sum#, grad
end

A["GROWTHLS"]=function growthls(x::AbstractVector)
    println("Julia port of CUTEST's GROWTHLS")
    grad = zeros(size(x))
    N=3
    sum=0
    u=x
    G=zeros(25)
    G[8]=8.0
    G[9]=8.4305
    G[10]=9.5294
    G[11]=10.4627
    G[12]=12.0  
    G[13]=13.0205
    G[14]=14.5949
    G[15]=16.1078
    G[16]=18.0596
    G[18]=20.4569
    G[20]=24.25
    G[25]=32.9863
        G8=-G[8]+u[1]*8^(u[2]+log(8)*u[3])
        G9=-G[9]+u[1]*9^(u[2]+log(9)*u[3])
        G10=-G[10]+u[1]*10^(u[2]+log(10)*u[3])
        G11=-G[11]+u[1]*11^(u[2]+log(11)*u[3])
        G12=-G[12]+u[1]*12^(u[2]+log(12)*u[3])
        G13=-G[13]+u[1]*13^(u[2]+log(13)*u[3])
        G14=-G[14]+u[1]*14^(u[2]+log(14)*u[3])
        G15=-G[15]+u[1]*15^(u[2]+log(15)*u[3])
        G16=-G[16]+u[1]*16^(u[2]+log(16)*u[3])
        G18=-G[18]+u[1]*18^(u[2]+log(18)*u[3])
        G20=-G[20]+u[1]*20^(u[2]+log(20)*u[3])
        G25=-G[25]+u[1]*25^(u[2]+log(25)*u[3])
        sum = G8^2+G9^2+G10^2+G11^+2+G12^2+G13^2+G14^2+G15^2+G16^2+G18^2+G20^2+G25^2
    return sum#, grad
end

A["MODBEALE"]=function modbeale(x::AbstractVector)
    println("Julia port of CUTEST's MODBEALE")
    grad = zeros(size(x))
    N=10000*2
    ALPHA=50
    ALPHINV=1/50
    sum=0
    for i = 1:(N/2-1)
        j=convert(Int64,2*i-1)
        BA = -1.5+(x[j]*(1-x[j+1]^1))
        BB = -2.25+(x[j]*(1-x[j+1]^2))
        BC = -2.625+(x[j]*(1-x[j+1]^3))
        L = 6*x[j+1]-x[j+2]
        sum = sum+50*L^2+BA^2+BB^2+BC^2
    end
    BA = -1.5+(x[N-1]*(1-x[N]^1))
    BB = -2.25+(x[N-1]*(1-x[N]^2))
    BC = -2.625+(x[N-1]*(1-x[N]^3))
    sum =sum+BA^2+BB^2+BC^2
    return sum#, grad
end

A["SPIN2LS"]=function spin2ls(a::AbstractVector)
    println("Julia port of CUTEST's SPIN2LS")
    sum=0
    N=50
    x=zeros(N)
    y=zeros(N)
    mu=a[1]
    om=a[2]
    x=a[3:(2+N)]
    y=a[(2+N+1):length(a)]
    for i = 1:N
        term1 = -mu*x[i]
        term2 = om*y[i]
        term3 = -mu*y[i]
        term4 = om*x[i]
        sum1 = term1+term2
        sum2 = term3+term4
        for j = 1:(i-1)
            termA = (y[i]-y[j])/((y[i]-y[j])^2+(x[i]-x[j])^2)
            sum1 = sum1 + termA
            termB = (x[i]-x[j])/((y[i]-y[j])^2+(x[i]-x[j])^2)
            sum2 = sum2 + termB
        end
        for j = (i+1):N
            termA = (y[i]-y[j])/((y[i]-y[j])^2+(x[i]-x[j])^2)
            sum1 = sum1 + termA
            termB = (x[i]-x[j])/((y[i]-y[j])^2+(x[i]-x[j])^2)
            sum2 = sum2 + termB
        end
        sum = sum+sum1^2+sum2^2
    end
    return sum
end

A["SBRYBND"]=function sbrybnd(x::AbstractVector)
    println("Julia port of CUTEST's SBRYBND")
    K=ones(3)
    K[1]=2
    K[2]=5
    K[3]=1
    sum=0
    M = 12/(length(x)-1)
    for i = 1:5
        sum1=0
        for j = 1:(i-1)
            term = -K[3]*exp(M*(j-1))*x[j]
            termA = -K[3]*x[j]^2*exp(M*(j-1))^2
            sum1 = sum1 + term + termA
        end
        term1 = -K[3]*exp(M*(i))*x[i+1]
        term2 = K[1]*exp(M*(i-1))*x[i]
        term3 = K[2]*x[i]^3*exp(M*(i-1))^3
        term4 = -K[3]*x[i+1]^2*exp(M*(i))^2
        sum1=sum1+term1+term2+term3+term4
        sum = sum + sum1^2
    end
    for i = 6:(length(x)-2)
        sum1=0
        for j = (i-5):(i-1)
            term = -K[3]*exp(M*(j-1))*x[j]
            termA = -K[3]*x[j]^3*exp(M*(j-1))^3
            sum1 = sum1 + term+termA
        end
        term1 = -K[3]*exp(M*(i))*x[i+1]
        term2 = K[1]*exp(M*(i-1))*x[i]
        term3 = K[2]*x[i]^2*exp(M*(i-1))^2
        term4 = -K[3]*x[i+1]^2*exp(M*(i))^2
        sum1=sum1+term1+term2+term3+term4
        sum = sum + sum1^2
    end
    for i = (length(x)-1):(length(x))
        sum1=0
        for j = (i-5):(i-1)
            term = -K[3]*exp(M*(j-1))*x[j]
            termA = -K[3]*x[j]^2*exp(M*(j-1))^2
            sum1 = sum1 + term+termA
        end
        term1 = K[1]*exp(M*(i-1))*x[i]
        termB = K[2]*x[i]^3*exp(M*(i-1))^3
        for j = (i+1):length(x)
            term = -K[3]*exp(M*(j-1))*x[j]
            termC = -K[3]*x[j]^2*exp(M*(j-1))^2
            sum1 = sum1 + term+termC
        end
        sum1=sum1+term1+termB
        sum = sum + sum1^2
    end
    return sum
end

A["GAUSS1LS"]=function gauss1ls(x::AbstractVector)
    println("Julia port of CUTEST's GAUSS1LS")
    N=8
    M=250
    X=zeros(250)
    Y=zeros(250)
    X[1]=1.0    
    X[2]=2.0    
    X[3]=3.0    
    X[4]=4.0    
    X[5]=5.0    
    X[6]=6.0    
    X[7]=7.0    
    X[8]=8.0    
    X[9]=9.0    
    X[10]=10.0 
    X[11]=11.0 
    X[12]=12.0 
    X[13]=13.0 
    X[14]=14.0 
    X[15]=15.0 
    X[16]=16.0 
    X[17]=17.0 
    X[18]=18.0 
    X[19]=19.0 
    X[20]=20.0 
    X[21]=21.0 
    X[22]=22.0 
    X[23]=23.0 
    X[24]=24.0 
    X[25]=25.0 
    X[26]=26.0 
    X[27]=27.0 
    X[28]=28.0 
    X[29]=29.0 
    X[30]=30.0 
    X[31]=31.0 
    X[32]=32.0 
    X[33]=33.0 
    X[34]=34.0 
    X[35]=35.0 
    X[36]=36.0 
    X[37]=37.0 
    X[38]=38.0 
    X[39]=39.0 
    X[40]=40.0 
    X[41]=41.0 
    X[42]=42.0 
    X[43]=43.0 
    X[44]=44.0 
    X[45]=45.0 
    X[46]=46.0 
    X[47]=47.0 
    X[48]=48.0 
    X[49]=49.0 
    X[50]=50.0 
    X[51]=51.0 
    X[52]=52.0 
    X[53]=53.0 
    X[54]=54.0 
    X[55]=55.0 
    X[56]=56.0 
    X[57]=57.0 
    X[58]=58.0 
    X[59]=59.0 
    X[60]=60.0 
    X[61]=61.0 
    X[62]=62.0 
    X[63]=63.0 
    X[64]=64.0 
    X[65]=65.0 
    X[66]=66.0 
    X[67]=67.0 
    X[68]=68.0 
    X[69]=69.0 
    X[70]=70.0 
    X[71]=71.0 
    X[72]=72.0 
    X[73]=73.0 
    X[74]=74.0 
    X[75]=75.0 
    X[76]=76.0 
    X[77]=77.0 
    X[78]=78.0 
    X[79]=79.0 
    X[80]=80.0 
    X[81]=81.0 
    X[82]=82.0 
    X[83]=83.0 
    X[84]=84.0 
    X[85]=85.0 
    X[86]=86.0 
    X[87]=87.0 
    X[88]=88.0 
    X[89]=89.0 
    X[90]=90.0 
    X[91]=91.0 
    X[92]=92.0 
    X[93]=93.0 
    X[94]=94.0 
    X[95]=95.0 
    X[96]=96.0 
    X[97]=97.0 
    X[98]=98.0 
    X[99]=99.0 
    X[100]=100.0
    X[101]=101.0
    X[102]=102.0
    X[103]=103.0
    X[104]=104.0
    X[105]=105.0
    X[106]=106.0
    X[107]=107.0
    X[108]=108.0
    X[109]=109.0
    X[110]=110.0
    X[111]=111.0
    X[112]=112.0
    X[113]=113.0
    X[114]=114.0
    X[115]=115.0
    X[116]=116.0
    X[117]=117.0
    X[118]=118.0
    X[119]=119.0
    X[120]=120.0
    X[121]=121.0
    X[122]=122.0
    X[123]=123.0
    X[124]=124.0
    X[125]=125.0
    X[126]=126.0
    X[127]=127.0
    X[128]=128.0
    X[129]=129.0
    X[130]=130.0
    X[131]=131.0
    X[132]=132.0
    X[133]=133.0
    X[134]=134.0
    X[135]=135.0
    X[136]=136.0
    X[137]=137.0
    X[138]=138.0
    X[139]=139.0
    X[140]=140.0
    X[141]=141.0
    X[142]=142.0
    X[143]=143.0
    X[144]=144.0
    X[145]=145.0
    X[146]=146.0
    X[147]=147.0
    X[148]=148.0
    X[149]=149.0
    X[150]=150.0
    X[151]=151.0
    X[152]=152.0
    X[153]=153.0
    X[154]=154.0
    X[155]=155.0
    X[156]=156.0
    X[157]=157.0
    X[158]=158.0
    X[159]=159.0
    X[160]=160.0
    X[161]=161.0
    X[162]=162.0
    X[163]=163.0
    X[164]=164.0
    X[165]=165.0
    X[166]=166.0
    X[167]=167.0
    X[168]=168.0
    X[169]=169.0
    X[170]=170.0
    X[171]=171.0
    X[172]=172.0
    X[173]=173.0
    X[174]=174.0
    X[175]=175.0
    X[176]=176.0
    X[177]=177.0
    X[178]=178.0
    X[179]=179.0
    X[180]=180.0
    X[181]=181.0
    X[182]=182.0
    X[183]=183.0
    X[184]=184.0
    X[185]=185.0
    X[186]=186.0
    X[187]=187.0
    X[188]=188.0
    X[189]=189.0
    X[190]=190.0
    X[191]=191.0
    X[192]=192.0
    X[193]=193.0
    X[194]=194.0
    X[195]=195.0
    X[196]=196.0
    X[197]=197.0
    X[198]=198.0
    X[199]=199.0
    X[200]=200.0
    X[201]=201.0
    X[202]=202.0
    X[203]=203.0
    X[204]=204.0
    X[205]=205.0
    X[206]=206.0
    X[207]=207.0
    X[208]=208.0
    X[209]=209.0
    X[210]=210.0
    X[211]=211.0
    X[212]=212.0
    X[213]=213.0
    X[214]=214.0
    X[215]=215.0
    X[216]=216.0
    X[217]=217.0
    X[218]=218.0
    X[219]=219.0
    X[220]=220.0
    X[221]=221.0
    X[222]=222.0
    X[223]=223.0
    X[224]=224.0
    X[225]=225.0
    X[226]=226.0
    X[227]=227.0
    X[228]=228.0
    X[229]=229.0
    X[230]=230.0
    X[231]=231.0
    X[232]=232.0
    X[233]=233.0
    X[234]=234.0
    X[235]=235.0
    X[236]=236.0
    X[237]=237.0
    X[238]=238.0
    X[239]=239.0
    X[240]=240.0
    X[241]=241.0
    X[242]=242.0
    X[243]=243.0
    X[244]=244.0
    X[245]=245.0
    X[246]=246.0
    X[247]=247.0
    X[248]=248.0
    X[249]=249.0
    X[250]=250.0

    Y[1]= 97.62227
    Y[2]= 97.80724
    Y[3]= 96.62247
    Y[4]= 92.59022
    Y[5]= 91.23869
    Y[6]= 95.32704
    Y[7]= 90.35040
    Y[8]= 89.46235
    Y[9]= 91.72520
    Y[10]=89.86916
    Y[11]=86.88076
    Y[12]=85.94360
    Y[13]=87.60686
    Y[14]=86.25839
    Y[15]=80.74976
    Y[16]=83.03551
    Y[17]=88.25837
    Y[18]=82.01316
    Y[19]=82.74098
    Y[20]=83.30034
    Y[21]=81.27850
    Y[22]=81.85506
    Y[23]=80.75195
    Y[24]=80.09573
    Y[25]=81.07633
    Y[26]=78.81542
    Y[27]=78.38596
    Y[28]=79.93386
    Y[29]=79.48474
    Y[30]=79.95942
    Y[31]=76.10691
    Y[32]=78.39830
    Y[33]=81.43060
    Y[34]=82.48867
    Y[35]=81.65462
    Y[36]=80.84323
    Y[37]=88.68663
    Y[38]=84.74438
    Y[39]=86.83934
    Y[40]=85.97739
    Y[41]=91.28509
    Y[42]=97.22411
    Y[43]=93.51733
    Y[44]=94.10159
    Y[45]=101.91760
    Y[46]=98.43134
    Y[47]=110.4214
    Y[48]=107.6628
    Y[49]=111.7288
    Y[50]=116.5115
    Y[51]=120.7609
    Y[52]=123.9553
    Y[53]=124.2437
    Y[54]=130.7996
    Y[55]=133.2960
    Y[56]=130.7788
    Y[57]=132.0565
    Y[58]=138.6584
    Y[59]=142.9252
    Y[60]=142.7215
    Y[61]=144.1249
    Y[62]=147.4377
    Y[63]=148.2647
    Y[64]=152.0519
    Y[65]=147.3863
    Y[66]=149.2074
    Y[67]=148.9537
    Y[68]=144.5876
    Y[69]=148.1226
    Y[70]=148.0144
    Y[71]=143.8893
    Y[72]=140.9088
    Y[73]=143.4434
    Y[74]=139.3938
    Y[75]=135.9878
    Y[76]=136.3927
    Y[77]=126.7262
    Y[78]=124.4487
    Y[79]=122.8647
    Y[80]=113.8557
    Y[81]=113.7037
    Y[82]=106.8407
    Y[83]=107.0034
    Y[84]=102.46290
    Y[85]=96.09296
    Y[86]=94.57555
    Y[87]=86.98824
    Y[88]=84.90154
    Y[89]=81.18023
    Y[90]=76.40117
    Y[91]=67.09200
    Y[92]=72.67155
    Y[93]=68.10848
    Y[94]=67.99088
    Y[95]=63.34094
    Y[96]=60.55253
    Y[97]=56.18687
    Y[98]=53.64482
    Y[99]=53.70307
    Y[100]=48.07893
    Y[101]=42.21258
    Y[102]=45.65181
    Y[103]=41.69728
    Y[104]=41.24946
    Y[105]=39.21349
    Y[106]=37.71696
    Y[107]=36.68395
    Y[108]=37.30393
    Y[109]=37.43277
    Y[110]=37.45012
    Y[111]=32.64648
    Y[112]=31.84347
    Y[113]=31.39951
    Y[114]=26.68912
    Y[115]=32.25323
    Y[116]=27.61008
    Y[117]=33.58649
    Y[118]=28.10714
    Y[119]=30.26428
    Y[120]=28.01648
    Y[121]=29.11021
    Y[122]=23.02099
    Y[123]=25.65091
    Y[124]=28.50295
    Y[125]=25.23701
    Y[126]=26.13828
    Y[127]=33.53260
    Y[128]=29.25195
    Y[129]=27.09847
    Y[130]=26.52999
    Y[131]=25.52401
    Y[132]=26.69218
    Y[133]=24.55269
    Y[134]=27.71763
    Y[135]=25.20297
    Y[136]=25.61483
    Y[137]=25.06893
    Y[138]=27.63930
    Y[139]=24.94851
    Y[140]=25.86806
    Y[141]=22.48183
    Y[142]=26.90045
    Y[143]=25.39919
    Y[144]=17.90614
    Y[145]=23.76039
    Y[146]=25.89689
    Y[147]=27.64231
    Y[148]=22.86101
    Y[149]=26.47003
    Y[150]=23.72888
    Y[151]=27.54334
    Y[152]=30.52683
    Y[153]=28.07261
    Y[154]=34.92815
    Y[155]=28.29194
    Y[156]=34.19161
    Y[157]=35.41207
    Y[158]=37.09336
    Y[159]=40.98330
    Y[160]=39.53923
    Y[161]=47.80123
    Y[162]=47.46305
    Y[163]=51.04166
    Y[164]=54.58065
    Y[165]=57.53001
    Y[166]=61.42089
    Y[167]=62.79032
    Y[168]=68.51455
    Y[169]=70.23053
    Y[170]=74.42776
    Y[171]=76.59911
    Y[172]=81.62053
    Y[173]=83.42208
    Y[174]=79.17451
    Y[175]=88.56985
    Y[176]=85.66525
    Y[177]=86.55502
    Y[178]=90.65907
    Y[179]=84.27290
    Y[180]=85.72220
    Y[181]=83.10702
    Y[182]=82.16884
    Y[183]=80.42568
    Y[184]=78.15692
    Y[185]=79.79691
    Y[186]=77.84378
    Y[187]=74.50327
    Y[188]=71.57289
    Y[189]=65.88031
    Y[190]=65.01385
    Y[191]=60.19582
    Y[192]=59.66726
    Y[193]=52.95478
    Y[194]=53.87792
    Y[195]=44.91274
    Y[196]=41.09909
    Y[197]=41.68018
    Y[198]=34.53379
    Y[199]=34.86419
    Y[200]=33.14787
    Y[201]=29.58864
    Y[202]=27.29462
    Y[203]=21.91439
    Y[204]=19.08159
    Y[205]=24.90290
    Y[206]=19.82341
    Y[207]=16.75551
    Y[208]=18.24558
    Y[209]=17.23549
    Y[210]=16.34934
    Y[211]=13.71285
    Y[212]=14.75676
    Y[213]=13.97169
    Y[214]=12.42867
    Y[215]=14.35519
    Y[216]=7.703309
    Y[217]=10.234410
    Y[218]=11.78315
    Y[219]=13.87768
    Y[220]=4.535700
    Y[221]=10.059280
    Y[222]=8.424824
    Y[223]=10.533120
    Y[224]=9.602255
    Y[225]=7.877514
    Y[226]=6.258121
    Y[227]=8.899865
    Y[228]=7.877754
    Y[229]=12.51191
    Y[230]=10.66205
    Y[231]=6.035400
    Y[232]=6.790655
    Y[233]=8.783535
    Y[234]=4.600288
    Y[235]=8.400915
    Y[236]=7.216561
    Y[237]=10.017410
    Y[238]=7.331278
    Y[239]=6.527863
    Y[240]=2.842001
    Y[241]=10.325070
    Y[242]=4.790995
    Y[243]=8.377101
    Y[244]=6.264445
    Y[245]=2.706213
    Y[246]=8.362329
    Y[247]=8.983658
    Y[248]=3.362571
    Y[249]=1.182746
    Y[250]=4.875359
    sum = 0
    for i = 1:M
        term1 = -Y[i]
        term2 = x[1]*exp(-x[2]*X[i])
        term3 = x[3]*exp(-((x[4]-X[i])/x[5])^2)
        term4 = x[6]*exp(-((x[7]-X[i])/x[8])^2)
        sum = sum+(term1+term2+term3+term4)^2
    end
    return sum
end

A["GAUSS2LS"]=function gauss2ls(x::AbstractVector)
    println("Julia port of CUTEST's GAUSS2LS")
    N=8
    M=250
    X=zeros(250)
    Y=zeros(250)
    X[1]=1.0  
    X[2]=2.0  
    X[3]=3.0  
    X[4]=4.0  
    X[5]=5.0  
    X[6]=6.0  
    X[7]=7.0  
    X[8]=8.0  
    X[9]=9.0  
    X[10]=10.0 
    X[11]=11.0 
    X[12]=12.0 
    X[13]=13.0 
    X[14]=14.0 
    X[15]=15.0 
    X[16]=16.0 
    X[17]=17.0 
    X[18]=18.0 
    X[19]=19.0 
    X[20]=20.0 
    X[21]=21.0 
    X[22]=22.0 
    X[23]=23.0 
    X[24]=24.0 
    X[25]=25.0 
    X[26]=26.0 
    X[27]=27.0 
    X[28]=28.0 
    X[29]=29.0 
    X[30]=30.0 
    X[31]=31.0 
    X[32]=32.0 
    X[33]=33.0 
    X[34]=34.0 
    X[35]=35.0 
    X[36]=36.0 
    X[37]=37.0 
    X[38]=38.0 
    X[39]=39.0 
    X[40]=40.0 
    X[41]=41.0 
    X[42]=42.0 
    X[43]=43.0 
    X[44]=44.0 
    X[45]=45.0 
    X[46]=46.0 
    X[47]=47.0 
    X[48]=48.0 
    X[49]=49.0 
    X[50]=50.0 
    X[51]=51.0 
    X[52]=52.0 
    X[53]=53.0 
    X[54]=54.0 
    X[55]=55.0 
    X[56]=56.0 
    X[57]=57.0 
    X[58]=58.0 
    X[59]=59.0 
    X[60]=60.0 
    X[61]=61.0 
    X[62]=62.0 
    X[63]=63.0 
    X[64]=64.0 
    X[65]=65.0 
    X[66]=66.0 
    X[67]=67.0 
    X[68]=68.0 
    X[69]=69.0 
    X[70]=70.0 
    X[71]=71.0 
    X[72]=72.0 
    X[73]=73.0 
    X[74]=74.0 
    X[75]=75.0 
    X[76]=76.0 
    X[77]=77.0 
    X[78]=78.0 
    X[79]=79.0 
    X[80]=80.0 
    X[81]=81.0 
    X[82]=82.0 
    X[83]=83.0 
    X[84]=84.0 
    X[85]=85.0 
    X[86]=86.0 
    X[87]=87.0 
    X[88]=88.0 
    X[89]=89.0 
    X[90]=90.0 
    X[91]=91.0 
    X[92]=92.0 
    X[93]=93.0 
    X[94]=94.0 
    X[95]=95.0 
    X[96]=96.0 
    X[97]=97.0 
    X[98]=98.0 
    X[99]=99.0 
    X[100]=100.0
    X[101]=101.0
    X[102]=102.0
    X[103]=103.0
    X[104]=104.0
    X[105]=105.0
    X[106]=106.0
    X[107]=107.0
    X[108]=108.0
    X[109]=109.0
    X[110]=110.0
    X[111]=111.0
    X[112]=112.0
    X[113]=113.0
    X[114]=114.0
    X[115]=115.0
    X[116]=116.0
    X[117]=117.0
    X[118]=118.0
    X[119]=119.0
    X[120]=120.0
    X[121]=121.0
    X[122]=122.0
    X[123]=123.0
    X[124]=124.0
    X[125]=125.0
    X[126]=126.0
    X[127]=127.0
    X[128]=128.0
    X[129]=129.0
    X[130]=130.0
    X[131]=131.0
    X[132]=132.0
    X[133]=133.0
    X[134]=134.0
    X[135]=135.0
    X[136]=136.0
    X[137]=137.0
    X[138]=138.0
    X[139]=139.0
    X[140]=140.0
    X[141]=141.0
    X[142]=142.0
    X[143]=143.0
    X[144]=144.0
    X[145]=145.0
    X[146]=146.0
    X[147]=147.0
    X[148]=148.0
    X[149]=149.0
    X[150]=150.0
    X[151]=151.0
    X[152]=152.0
    X[153]=153.0
    X[154]=154.0
    X[155]=155.0
    X[156]=156.0
    X[157]=157.0
    X[158]=158.0
    X[159]=159.0
    X[160]=160.0
    X[161]=161.0
    X[162]=162.0
    X[163]=163.0
    X[164]=164.0
    X[165]=165.0
    X[166]=166.0
    X[167]=167.0
    X[168]=168.0
    X[169]=169.0
    X[170]=170.0
    X[171]=171.0
    X[172]=172.0
    X[173]=173.0
    X[174]=174.0
    X[175]=175.0
    X[176]=176.0
    X[177]=177.0
    X[178]=178.0
    X[179]=179.0
    X[180]=180.0
    X[181]=181.0
    X[182]=182.0
    X[183]=183.0
    X[184]=184.0
    X[185]=185.0
    X[186]=186.0
    X[187]=187.0
    X[188]=188.0
    X[189]=189.0
    X[190]=190.0
    X[191]=191.0
    X[192]=192.0
    X[193]=193.0
    X[194]=194.0
    X[195]=195.0
    X[196]=196.0
    X[197]=197.0
    X[198]=198.0
    X[199]=199.0
    X[200]=200.0
    X[201]=201.0
    X[202]=202.0
    X[203]=203.0
    X[204]=204.0
    X[205]=205.0
    X[206]=206.0
    X[207]=207.0
    X[208]=208.0
    X[209]=209.0
    X[210]=210.0
    X[211]=211.0
    X[212]=212.0
    X[213]=213.0
    X[214]=214.0
    X[215]=215.0
    X[216]=216.0
    X[217]=217.0
    X[218]=218.0
    X[219]=219.0
    X[220]=220.0
    X[221]=221.0
    X[222]=222.0
    X[223]=223.0
    X[224]=224.0
    X[225]=225.0
    X[226]=226.0
    X[227]=227.0
    X[228]=228.0
    X[229]=229.0
    X[230]=230.0
    X[231]=231.0
    X[232]=232.0
    X[233]=233.0
    X[234]=234.0
    X[235]=235.0
    X[236]=236.0
    X[237]=237.0
    X[238]=238.0
    X[239]=239.0
    X[240]=240.0
    X[241]=241.0
    X[242]=242.0
    X[243]=243.0
    X[244]=244.0
    X[245]=245.0
    X[246]=246.0
    X[247]=247.0
    X[248]=248.0
    X[249]=249.0
    X[250]=250.0
  
    Y[1]= 97.58776
    Y[2]= 97.76344
    Y[3]= 96.56705
    Y[4]= 92.52037
    Y[5]= 91.15097
    Y[6]= 95.21728
    Y[7]= 90.21355
    Y[8]= 89.29235
    Y[9]= 91.51479
    Y[10]=89.60966
    Y[11]=86.56187
    Y[12]=85.55316
    Y[13]=87.13054
    Y[14]=85.67940
    Y[15]=80.04851
    Y[16]=82.18925
    Y[17]=87.24081
    Y[18]=80.79407
    Y[19]=81.28570
    Y[20]=81.56940
    Y[21]=79.22715
    Y[22]=79.43275
    Y[23]=77.90195
    Y[24]=76.75468
    Y[25]=77.17377
    Y[26]=74.27348
    Y[27]=73.11900
    Y[28]=73.84826
    Y[29]=72.47870
    Y[30]=71.92292
    Y[31]=66.92176
    Y[32]=67.93835
    Y[33]=69.56207
    Y[34]=69.07066
    Y[35]=66.53983
    Y[36]=63.87883
    Y[37]=69.71537
    Y[38]=63.60588
    Y[39]=63.37154
    Y[40]=60.01835
    Y[41]=62.67481
    Y[42]=65.80666
    Y[43]=59.14304
    Y[44]=56.62951
    Y[45]=61.21785
    Y[46]=54.38790
    Y[47]=62.93443
    Y[48]=56.65144
    Y[49]=57.13362
    Y[50]=58.29689
    Y[51]=58.91744
    Y[52]=58.50172
    Y[53]=55.22885
    Y[54]=58.30375
    Y[55]=57.43237
    Y[56]=51.69407
    Y[57]=49.93132
    Y[58]=53.70760
    Y[59]=55.39712
    Y[60]=52.89709
    Y[61]=52.31649
    Y[62]=53.98720
    Y[63]=53.54158
    Y[64]=56.45046
    Y[65]=51.32276
    Y[66]=53.11676
    Y[67]=53.28631
    Y[68]=49.80555
    Y[69]=54.69564
    Y[70]=56.41627
    Y[71]=54.59362
    Y[72]=54.38520
    Y[73]=60.15354
    Y[74]=59.78773
    Y[75]=60.49995
    Y[76]=65.43885
    Y[77]=60.70001
    Y[78]=63.71865
    Y[79]=67.77139
    Y[80]=64.70934
    Y[81]=70.78193
    Y[82]=70.38651
    Y[83]=77.22359
    Y[84]=79.52665
    Y[85]=80.13077
    Y[86]=85.67823
    Y[87]=85.20647
    Y[88]=90.24548
    Y[89]=93.61953
    Y[90]=95.86509
    Y[91]=93.46992
    Y[92]=105.8137
    Y[93]=107.8269
    Y[94]=114.0607
    Y[95]=115.5019
    Y[96]=118.5110
    Y[97]=119.6177
    Y[98]=122.1940
    Y[99]=126.9903
    Y[100]=125.7005
    Y[101]=123.7447
    Y[102]=130.6543
    Y[103]=129.7168
    Y[104]=131.8240
    Y[105]=131.8759
    Y[106]=131.9994
    Y[107]=132.1221
    Y[108]=133.4414
    Y[109]=133.8252
    Y[110]=133.6695
    Y[111]=128.2851
    Y[112]=126.5182
    Y[113]=124.7550
    Y[114]=118.4016
    Y[115]=122.0334
    Y[116]=115.2059
    Y[117]=118.7856
    Y[118]=110.7387
    Y[119]=110.2003
    Y[120]=105.17290
    Y[121]=103.44720
    Y[122]=94.54280
    Y[123]=94.40526
    Y[124]=94.57964
    Y[125]=88.76605
    Y[126]=87.28747
    Y[127]=92.50443
    Y[128]=86.27997
    Y[129]=82.44307
    Y[130]=80.47367
    Y[131]=78.36608
    Y[132]=78.74307
    Y[133]=76.12786
    Y[134]=79.13108
    Y[135]=76.76062
    Y[136]=77.60769
    Y[137]=77.76633
    Y[138]=81.28220
    Y[139]=79.74307
    Y[140]=81.97964
    Y[141]=80.02952
    Y[142]=85.95232
    Y[143]=85.96838
    Y[144]=79.94789
    Y[145]=87.17023
    Y[146]=90.50992
    Y[147]=93.23373
    Y[148]=89.14803
    Y[149]=93.11492
    Y[150]=90.34337
    Y[151]=93.69421
    Y[152]=95.74256
    Y[153]=91.85105
    Y[154]=96.74503
    Y[155]=87.60996
    Y[156]=90.47012
    Y[157]=88.11690
    Y[158]=85.70673
    Y[159]=85.01361
    Y[160]=78.53040
    Y[161]=81.34148
    Y[162]=75.19295
    Y[163]=72.66115
    Y[164]=69.85504
    Y[165]=66.29476
    Y[166]=63.58502
    Y[167]=58.33847
    Y[168]=57.50766
    Y[169]=52.80498
    Y[170]=50.79319
    Y[171]=47.03490
    Y[172]=46.47090
    Y[173]=43.09016
    Y[174]=34.11531
    Y[175]=39.28235
    Y[176]=32.68386
    Y[177]=30.44056
    Y[178]=31.98932
    Y[179]=23.63330
    Y[180]=23.69643
    Y[181]=20.26812
    Y[182]=19.07074
    Y[183]=17.59544
    Y[184]=16.08785
    Y[185]=18.94267
    Y[186]=18.61354
    Y[187]=17.25800
    Y[188]=16.62285
    Y[189]=13.48367
    Y[190]=15.37647
    Y[191]=13.47208
    Y[192]=15.96188
    Y[193]=12.32547
    Y[194]=16.33880
    Y[195]=10.438330
    Y[196]=9.628715
    Y[197]=13.12268
    Y[198]=8.772417
    Y[199]=11.76143
    Y[200]=12.55020
    Y[201]=11.33108
    Y[202]=11.20493
    Y[203]=7.816916
    Y[204]=6.800675
    Y[205]=14.26581
    Y[206]=10.66285
    Y[207]=8.911574
    Y[208]=11.56733
    Y[209]=11.58207
    Y[210]=11.59071
    Y[211]=9.730134
    Y[212]=11.44237
    Y[213]=11.22912
    Y[214]=10.172130
    Y[215]=12.50905
    Y[216]=6.201493
    Y[217]=9.019605
    Y[218]=10.80607
    Y[219]=13.09625
    Y[220]=3.914271
    Y[221]=9.567886
    Y[222]=8.038448
    Y[223]=10.231040
    Y[224]=9.367410
    Y[225]=7.695971
    Y[226]=6.118575
    Y[227]=8.793207
    Y[228]=7.796692
    Y[229]=12.45065
    Y[230]=10.61601
    Y[231]=6.001003
    Y[232]=6.765098
    Y[233]=8.764653
    Y[234]=4.586418
    Y[235]=8.390783
    Y[236]=7.209202
    Y[237]=10.012090
    Y[238]=7.327461
    Y[239]=6.525136
    Y[240]=2.840065
    Y[241]=10.323710
    Y[242]=4.790035
    Y[243]=8.376431
    Y[244]=6.263980
    Y[245]=2.705892
    Y[246]=8.362109
    Y[247]=8.983507
    Y[248]=3.362469
    Y[249]=1.182678
    Y[250]=4.875312
    sum = 0
    for i = 1:M
        term1 = -Y[i]
        term2 = x[1]*exp(-x[2]*X[i])
        term3 = x[3]*exp(-((x[4]-X[i])/x[5])^2)
        term4 = x[6]*exp(-((x[7]-X[i])/x[8])^2)
        sum = sum+(term1+term2+term3+term4)^2
    end
    return sum
end

A["GAUSS3LS"]=function gauss3ls(x::AbstractVector)
    println("Julia port of CUTEST's GAUSS3LS")
    N=8
    M=250
    X=zeros(250)
    Y=zeros(250)
    X[1]=1.0    
    X[2]=2.0    
    X[3]=3.0    
    X[4]=4.0    
    X[5]=5.0    
    X[6]=6.0    
    X[7]=7.0    
    X[8]=8.0    
    X[9]=9.0    
    X[10]=10.0 
    X[11]=11.0 
    X[12]=12.0 
    X[13]=13.0 
    X[14]=14.0 
    X[15]=15.0 
    X[16]=16.0 
    X[17]=17.0 
    X[18]=18.0 
    X[19]=19.0 
    X[20]=20.0 
    X[21]=21.0 
    X[22]=22.0 
    X[23]=23.0 
    X[24]=24.0 
    X[25]=25.0 
    X[26]=26.0 
    X[27]=27.0 
    X[28]=28.0 
    X[29]=29.0 
    X[30]=30.0 
    X[31]=31.0 
    X[32]=32.0 
    X[33]=33.0 
    X[34]=34.0 
    X[35]=35.0 
    X[36]=36.0 
    X[37]=37.0 
    X[38]=38.0 
    X[39]=39.0 
    X[40]=40.0 
    X[41]=41.0 
    X[42]=42.0 
    X[43]=43.0 
    X[44]=44.0 
    X[45]=45.0 
    X[46]=46.0 
    X[47]=47.0 
    X[48]=48.0 
    X[49]=49.0 
    X[50]=50.0 
    X[51]=51.0 
    X[52]=52.0 
    X[53]=53.0 
    X[54]=54.0 
    X[55]=55.0 
    X[56]=56.0 
    X[57]=57.0 
    X[58]=58.0 
    X[59]=59.0 
    X[60]=60.0 
    X[61]=61.0 
    X[62]=62.0 
    X[63]=63.0 
    X[64]=64.0 
    X[65]=65.0 
    X[66]=66.0 
    X[67]=67.0 
    X[68]=68.0 
    X[69]=69.0 
    X[70]=70.0 
    X[71]=71.0 
    X[72]=72.0 
    X[73]=73.0 
    X[74]=74.0 
    X[75]=75.0 
    X[76]=76.0 
    X[77]=77.0 
    X[78]=78.0 
    X[79]=79.0 
    X[80]=80.0 
    X[81]=81.0 
    X[82]=82.0 
    X[83]=83.0 
    X[84]=84.0 
    X[85]=85.0 
    X[86]=86.0 
    X[87]=87.0 
    X[88]=88.0 
    X[89]=89.0 
    X[90]=90.0 
    X[91]=91.0 
    X[92]=92.0 
    X[93]=93.0 
    X[94]=94.0 
    X[95]=95.0 
    X[96]=96.0 
    X[97]=97.0 
    X[98]=98.0 
    X[99]=99.0 
    X[100]=100.0
    X[101]=101.0
    X[102]=102.0
    X[103]=103.0
    X[104]=104.0
    X[105]=105.0
    X[106]=106.0
    X[107]=107.0
    X[108]=108.0
    X[109]=109.0
    X[110]=110.0
    X[111]=111.0
    X[112]=112.0
    X[113]=113.0
    X[114]=114.0
    X[115]=115.0
    X[116]=116.0
    X[117]=117.0
    X[118]=118.0
    X[119]=119.0
    X[120]=120.0
    X[121]=121.0
    X[122]=122.0
    X[123]=123.0
    X[124]=124.0
    X[125]=125.0
    X[126]=126.0
    X[127]=127.0
    X[128]=128.0
    X[129]=129.0
    X[130]=130.0
    X[131]=131.0
    X[132]=132.0
    X[133]=133.0
    X[134]=134.0
    X[135]=135.0
    X[136]=136.0
    X[137]=137.0
    X[138]=138.0
    X[139]=139.0
    X[140]=140.0
    X[141]=141.0
    X[142]=142.0
    X[143]=143.0
    X[144]=144.0
    X[145]=145.0
    X[146]=146.0
    X[147]=147.0
    X[148]=148.0
    X[149]=149.0
    X[150]=150.0
    X[151]=151.0
    X[152]=152.0
    X[153]=153.0
    X[154]=154.0
    X[155]=155.0
    X[156]=156.0
    X[157]=157.0
    X[158]=158.0
    X[159]=159.0
    X[160]=160.0
    X[161]=161.0
    X[162]=162.0
    X[163]=163.0
    X[164]=164.0
    X[165]=165.0
    X[166]=166.0
    X[167]=167.0
    X[168]=168.0
    X[169]=169.0
    X[170]=170.0
    X[171]=171.0
    X[172]=172.0
    X[173]=173.0
    X[174]=174.0
    X[175]=175.0
    X[176]=176.0
    X[177]=177.0
    X[178]=178.0
    X[179]=179.0
    X[180]=180.0
    X[181]=181.0
    X[182]=182.0
    X[183]=183.0
    X[184]=184.0
    X[185]=185.0
    X[186]=186.0
    X[187]=187.0
    X[188]=188.0
    X[189]=189.0
    X[190]=190.0
    X[191]=191.0
    X[192]=192.0
    X[193]=193.0
    X[194]=194.0
    X[195]=195.0
    X[196]=196.0
    X[197]=197.0
    X[198]=198.0
    X[199]=199.0
    X[200]=200.0
    X[201]=201.0
    X[202]=202.0
    X[203]=203.0
    X[204]=204.0
    X[205]=205.0
    X[206]=206.0
    X[207]=207.0
    X[208]=208.0
    X[209]=209.0
    X[210]=210.0
    X[211]=211.0
    X[212]=212.0
    X[213]=213.0
    X[214]=214.0
    X[215]=215.0
    X[216]=216.0
    X[217]=217.0
    X[218]=218.0
    X[219]=219.0
    X[220]=220.0
    X[221]=221.0
    X[222]=222.0
    X[223]=223.0
    X[224]=224.0
    X[225]=225.0
    X[226]=226.0
    X[227]=227.0
    X[228]=228.0
    X[229]=229.0
    X[230]=230.0
    X[231]=231.0
    X[232]=232.0
    X[233]=233.0
    X[234]=234.0
    X[235]=235.0
    X[236]=236.0
    X[237]=237.0
    X[238]=238.0
    X[239]=239.0
    X[240]=240.0
    X[241]=241.0
    X[242]=242.0
    X[243]=243.0
    X[244]=244.0
    X[245]=245.0
    X[246]=246.0
    X[247]=247.0
    X[248]=248.0
    X[249]=249.0
    X[250]=250.0

    Y[1]= 97.58776
    Y[2]= 97.76344
    Y[3]= 96.56705
    Y[4]= 92.52037
    Y[5]= 91.15097
    Y[6]= 95.21728
    Y[7]= 90.21355
    Y[8]= 89.29235
    Y[9]= 91.51479
    Y[10]=89.60965
    Y[11]=86.56187
    Y[12]=85.55315
    Y[13]=87.13053
    Y[14]=85.67938
    Y[15]=80.04849
    Y[16]=82.18922
    Y[17]=87.24078
    Y[18]=80.79401
    Y[19]=81.28564
    Y[20]=81.56932
    Y[21]=79.22703
    Y[22]=79.43259
    Y[23]=77.90174
    Y[24]=76.75438
    Y[25]=77.17338
    Y[26]=74.27296
    Y[27]=73.11830
    Y[28]=73.84732
    Y[29]=72.47746
    Y[30]=71.92128
    Y[31]=66.91962
    Y[32]=67.93554
    Y[33]=69.55841
    Y[34]=69.06592
    Y[35]=66.53371
    Y[36]=63.87094
    Y[37]=69.70526
    Y[38]=63.59295
    Y[39]=63.35509
    Y[40]=59.99747
    Y[41]=62.64843
    Y[42]=65.77345
    Y[43]=59.10141
    Y[44]=56.57750
    Y[45]=61.15313
    Y[46]=54.30767
    Y[47]=62.83535
    Y[48]=56.52957
    Y[49]=56.98427
    Y[50]=58.11459
    Y[51]=58.69576
    Y[52]=58.23322
    Y[53]=54.90490
    Y[54]=57.91442
    Y[55]=56.96629
    Y[56]=51.13831
    Y[57]=49.27123
    Y[58]=52.92668
    Y[59]=54.47693
    Y[60]=51.81710
    Y[61]=51.05401
    Y[62]=52.51731
    Y[63]=51.83710
    Y[64]=54.48196
    Y[65]=49.05859
    Y[66]=50.52315
    Y[67]=50.32755
    Y[68]=46.44419
    Y[69]=50.89281
    Y[70]=52.13203
    Y[71]=49.78741
    Y[72]=49.01637
    Y[73]=54.18198
    Y[74]=53.17456
    Y[75]=53.20827
    Y[76]=57.43459
    Y[77]=51.95282
    Y[78]=54.20282
    Y[79]=57.46687
    Y[80]=53.60268
    Y[81]=58.86728
    Y[82]=57.66652
    Y[83]=63.71034
    Y[84]=65.24244
    Y[85]=65.10878
    Y[86]=69.96313
    Y[87]=68.85475
    Y[88]=73.32574
    Y[89]=76.21241
    Y[90]=78.06311
    Y[91]=75.37701
    Y[92]=87.54449
    Y[93]=89.50588
    Y[94]=95.82098
    Y[95]=97.48390
    Y[96]=100.86070
    Y[97]=102.48510
    Y[98]=105.7311
    Y[99]=111.3489
    Y[100]=111.0305
    Y[101]=110.1920
    Y[102]=118.3581
    Y[103]=118.8086
    Y[104]=122.4249
    Y[105]=124.0953
    Y[106]=125.9337
    Y[107]=127.8533
    Y[108]=131.0361
    Y[109]=133.3343
    Y[110]=135.1278
    Y[111]=131.7113
    Y[112]=131.9151
    Y[113]=132.1107
    Y[114]=127.6898
    Y[115]=133.2148
    Y[116]=128.2296
    Y[117]=133.5902
    Y[118]=127.2539
    Y[119]=128.3482
    Y[120]=124.8694
    Y[121]=124.6031
    Y[122]=117.0648
    Y[123]=118.1966
    Y[124]=119.5408
    Y[125]=114.7946
    Y[126]=114.2780
    Y[127]=120.3484
    Y[128]=114.8647
    Y[129]=111.6514
    Y[130]=110.1826
    Y[131]=108.4461
    Y[132]=109.0571
    Y[133]=106.5308
    Y[134]=109.4691
    Y[135]=106.8709
    Y[136]=107.3192
    Y[137]=106.9000
    Y[138]=109.6526
    Y[139]=107.1602
    Y[140]=108.2509
    Y[141]=104.96310
    Y[142]=109.3601
    Y[143]=107.6696
    Y[144]=99.77286
    Y[145]=104.96440
    Y[146]=106.1376
    Y[147]=106.5816
    Y[148]=100.12860
    Y[149]=101.66910
    Y[150]=96.44254
    Y[151]=97.34169
    Y[152]=96.97412
    Y[153]=90.73460
    Y[154]=93.37949
    Y[155]=82.12331
    Y[156]=83.01657
    Y[157]=78.87360
    Y[158]=74.86971
    Y[159]=72.79341
    Y[160]=65.14744
    Y[161]=67.02127
    Y[162]=60.16136
    Y[163]=57.13996
    Y[164]=54.05769
    Y[165]=50.42265
    Y[166]=47.82430
    Y[167]=42.85748
    Y[168]=42.45495
    Y[169]=38.30808
    Y[170]=36.95794
    Y[171]=33.94543
    Y[172]=34.19017
    Y[173]=31.66097
    Y[174]=23.56172
    Y[175]=29.61143
    Y[176]=23.88765
    Y[177]=22.49812
    Y[178]=24.86901
    Y[179]=17.29481
    Y[180]=18.09291
    Y[181]=15.34813
    Y[182]=14.77997
    Y[183]=13.87832
    Y[184]=12.88891
    Y[185]=16.20763
    Y[186]=16.29024
    Y[187]=15.29712
    Y[188]=14.97839
    Y[189]=12.11330
    Y[190]=14.24168
    Y[191]=12.53824
    Y[192]=15.19818
    Y[193]=11.70478
    Y[194]=15.83745
    Y[195]=10.035850
    Y[196]=9.307574
    Y[197]=12.86800
    Y[198]=8.571671
    Y[199]=11.60415
    Y[200]=12.42772
    Y[201]=11.23627
    Y[202]=11.13198
    Y[203]=7.761117
    Y[204]=6.758250
    Y[205]=14.23375
    Y[206]=10.63876
    Y[207]=8.893581
    Y[208]=11.55398
    Y[209]=11.57221
    Y[210]=11.58347
    Y[211]=9.724857
    Y[212]=11.43854
    Y[213]=11.22636
    Y[214]=10.170150
    Y[215]=12.50765
    Y[216]=6.200494
    Y[217]=9.018902
    Y[218]=10.80557
    Y[219]=13.09591
    Y[220]=3.914033
    Y[221]=9.567723
    Y[222]=8.038338
    Y[223]=10.230960
    Y[224]=9.367358
    Y[225]=7.695937
    Y[226]=6.118552
    Y[227]=8.793192
    Y[228]=7.796682
    Y[229]=12.45064
    Y[230]=10.61601
    Y[231]=6.001000
    Y[232]=6.765096
    Y[233]=8.764652
    Y[234]=4.586417
    Y[235]=8.390782
    Y[236]=7.209201
    Y[237]=10.012090
    Y[238]=7.327461
    Y[239]=6.525136
    Y[240]=2.840065
    Y[241]=10.323710
    Y[242]=4.790035
    Y[243]=8.376431
    Y[244]=6.263980
    Y[245]=2.705892
    Y[246]=8.362109
    Y[247]=8.983507
    Y[248]=3.362469
    Y[249]=1.182678
    Y[250]=4.875312
    sum = 0
    for i = 1:M
        term1 = -Y[i]
        term2 = x[1]*exp(-x[2]*X[i])
        term3 = x[3]*exp(-((x[4]-X[i])/x[5])^2)
        term4 = x[6]*exp(-((x[7]-X[i])/x[8])^2)
        sum = sum+(term1+term2+term3+term4)^2
    end
    return sum
end

A["PALMER5D"]=function palmer5d(x::AbstractVector)
    println("Julia port of CUTEST's PALMER5D")
    M=23
    X=zeros(23)
    Y=zeros(23)
    X[12]=0.000000
    X[13]=1.570796
    X[14]=1.396263
    X[15]=1.308997
    X[16]=1.221730
    X[17]=1.125835
    X[18]=1.047198
    X[19]=0.872665
    X[20]=0.698132
    X[21]=0.523599
    X[22]=0.349066
    X[23]=0.174533

    Y[12]=83.57418
    Y[13]=81.007654
    Y[14]=18.983286
    Y[15]=8.051067
    Y[16]=2.044762
    Y[17]=0.000000
    Y[18]=1.170451
    Y[19]=10.479881
    Y[20]=25.785001
    Y[21]=44.126844
    Y[22]=62.822177
    Y[23]=77.719674
    sum = 0
    for i = 12:M
        term=x[1]+x[2]*X[i]^2+x[3]*X[i]^4+x[4]*X[i]^6-Y[i]
        sum = sum+term^2
    end
    return sum
end

A["PALMER1C"]=function palmer1c(x::AbstractVector)
    println("Julia port of CUTEST's PALMER1C")
    M=35
    X=zeros(35)
    Y=zeros(35)
    X[1]=-1.788963
    X[2]=-1.745329
    X[3]=-1.658063
    X[4]=-1.570796
    X[5]=-1.483530
    X[6]=-1.396263
    X[7]=-1.308997
    X[8]=-1.218612
    X[9]=-1.134464
    X[10]=-1.047198
    X[11]=-0.872665
    X[12]=-0.698132
    X[13]=-0.523599
    X[14]=-0.349066
    X[15]=-0.174533
    X[16]=0.0000000
    X[17]=1.788963
    X[18]=1.745329
    X[19]=1.658063
    X[20]=1.570796
    X[21]=1.483530
    X[22]=1.396263
    X[23]=1.308997
    X[24]=1.218612
    X[25]=1.134464
    X[26]=1.047198
    X[27]=0.872665
    X[28]=0.698132
    X[29]=0.523599
    X[30]=0.349066
    X[31]=0.174533
    X[32]=-1.8762289
    X[33]=-1.8325957
    X[34]=1.8762289
    X[35]=1.8325957

    Y[1]=78.596218
    Y[2]=65.77963
    Y[3]=43.96947
    Y[4]=27.038816
    Y[5]=14.6126
    Y[6]=6.2614
    Y[7]=1.538330
    Y[8]=0.000000
    Y[9]=1.188045
    Y[10]=4.6841
    Y[11]=16.9321
    Y[12]=33.6988
    Y[13]=52.3664
    Y[14]=70.1630
    Y[15]=83.4221
    Y[16]=88.3995
    Y[17]=78.596218
    Y[18]=65.77963
    Y[19]=43.96947
    Y[20]=27.038816
    Y[21]=14.6126
    Y[22]=6.2614
    Y[23]=1.538330
    Y[24]=0.000000
    Y[25]=1.188045
    Y[26]=4.6841
    Y[27]=16.9321
    Y[28]=33.6988
    Y[29]=52.3664
    Y[30]=70.1630
    Y[31]=83.4221
    Y[32]=108.18086
    Y[33]=92.733676
    Y[34]=108.18086
    Y[35]=92.733676
    sum = 0
    for i = 1:M
        term=x[1]+x[2]*X[i]^2+x[3]*X[i]^4+x[4]*X[i]^6+x[5]*X[i]^8+x[6]*X[i]^10+x[7]*X[i]^12+x[8]*X[i]^14-Y[i]
        sum = sum+term^2
    end
    return sum
end

A["PALMER2C"]=function palmer2c(x::AbstractVector)
    println("Julia port of CUTEST's PALMER2C")
    M=23
    X=zeros(M)
    Y=zeros(M)
    X[1]=-1.745329
    X[2]=-1.570796
    X[3]=-1.396263
    X[4]=-1.221730
    X[5]=-1.047198
    X[6]=-0.937187
    X[7]=-0.872665
    X[8]=-0.698132
    X[9]=-0.523599
    X[10]=-0.349066
    X[11]=-0.174533
    X[12]=0.0
    X[13]=0.174533
    X[14]=0.349066
    X[15]=0.523599
    X[16]=0.698132
    X[17]=0.872665
    X[18]=0.937187
    X[19]=1.047198
    X[20]=1.221730
    X[21]=1.396263
    X[22]=1.570796
    X[23]=1.745329

    Y[1]=72.676767
    Y[2]=40.149455
    Y[3]=18.8548
    Y[4]=6.4762
    Y[5]=0.8596
    Y[6]=0.00000
    Y[7]=0.2730
    Y[8]=3.2043
    Y[9]=8.1080
    Y[10]=13.4291
    Y[11]=17.7149
    Y[12]=19.4529
    Y[13]=17.7149
    Y[14]=13.4291
    Y[15]=8.1080
    Y[16]=3.2053
    Y[17]=0.2730
    Y[18]=0.00000
    Y[19]=0.8596
    Y[20]=6.4762
    Y[21]=18.8548
    Y[22]=40.149455
    Y[23]=72.676767
    sum = 0
    for i = 1:M
        term=x[1]+x[2]*X[i]^2+x[3]*X[i]^4+x[4]*X[i]^6+x[5]*X[i]^8+x[6]*X[i]^10+x[7]*X[i]^12+x[8]*X[i]^14-Y[i]
        sum = sum+term^2
    end
    return sum
end

A["PALMER8C"]=function palmer8c(x::AbstractVector)
    println("Julia port of CUTEST's PALMER8C")
    M=23
    X=zeros(M)
    Y=zeros(M)
    
    X[12]=0.000000
    X[13]=0.174533
    X[14]=0.314159
    X[15]=0.436332
    X[16]=0.514504
    X[17]=0.610865
    X[18]=0.785398
    X[19]=0.959931
    X[20]=1.134464
    X[21]=1.308997
    X[22]=1.483530
    X[23]=1.570796

    Y[12]= 4.757534
    Y[13]= 3.121416
    Y[14]= 1.207606
    Y[15]= 0.131916
    Y[16]= 0.000000
    Y[17]= 0.258514
    Y[18]= 3.380161
    Y[19]=10.762813
    Y[20]=23.745996
    Y[21]=44.471864
    Y[22]=76.541947
    Y[23]=97.874528
    
    sum = 0
    for i = 12:M
        term=x[1]+x[2]*X[i]^2+x[3]*X[i]^4+x[4]*X[i]^6+x[5]*X[i]^8+x[6]*X[i]^10+x[7]*X[i]^12+x[8]*X[i]^14-Y[i]
        sum = sum+term^2
    end
    return sum
end

A["PALMER1D"]=function palmer1d(x::AbstractVector)
    println("Julia port of CUTEST's PALMER1D")
    M=35
    X=zeros(M)
    Y=zeros(M)
    
    X[1]=-1.788963
    X[2]=-1.745329
    X[3]=-1.658063
    X[4]=-1.570796
    X[5]=-1.483530
    X[6]=-1.396263
    X[7]=-1.308997
    X[8]=-1.218612
    X[9]=-1.134464
    X[10]=-1.047198
    X[11]=-0.872665
    X[12]=-0.698132
    X[13]=-0.523599
    X[14]=-0.349066
    X[15]=-0.174533
    X[16]=0.0000000
    X[17]=1.788963
    X[18]=1.745329
    X[19]=1.658063
    X[20]=1.570796
    X[21]=1.483530
    X[22]=1.396263
    X[23]=1.308997
    X[24]=1.218612
    X[25]=1.134464
    X[26]=1.047198
    X[27]=0.872665
    X[28]=0.698132
    X[29]=0.523599
    X[30]=0.349066
    X[31]=0.174533
    X[32]=-1.8762289
    X[33]=-1.8325957
    X[34]=1.8762289
    X[35]=1.8325957

    Y[1]=78.596218
    Y[2]=65.77963
    Y[3]=43.96947
    Y[4]=27.038816
    Y[5]=14.6126
    Y[6]=6.2614
    Y[7]=1.538330
    Y[8]=0.000000
    Y[9]=1.188045
    Y[10]=4.6841
    Y[11]=16.9321
    Y[12]=33.6988
    Y[13]=52.3664
    Y[14]=70.1630
    Y[15]=83.4221
    Y[16]=88.3995
    Y[17]=78.596218
    Y[18]=65.77963
    Y[19]=43.96947
    Y[20]=27.038816
    Y[21]=14.6126
    Y[22]=6.2614
    Y[23]=1.538330
    Y[24]=0.000000
    Y[25]=1.188045
    Y[26]=4.6841
    Y[27]=16.9321
    Y[28]=33.6988
    Y[29]=52.3664
    Y[30]=70.1630
    Y[31]=83.4221
    Y[32]=108.18086
    Y[33]=92.733676
    Y[34]=108.18086
    Y[35]=92.733676
    
    sum = 0
    for i = 1:M
        term=x[1]+x[2]*X[i]^2+x[3]*X[i]^4+x[4]*X[i]^6+x[5]*X[i]^8+x[6]*X[i]^10+x[7]*X[i]^12-Y[i]
        sum = sum+term^2
    end
    return sum
end

A["PALMER6C"]=function palmer6c(x::AbstractVector)
    println("Julia port of CUTEST's PALMER6C")
    M=24
    X=zeros(M)
    Y=zeros(M)
    

    X[12]=0.000000    
    X[13]=1.570796    
    X[14]=1.396263    
    X[15]=1.221730    
    X[16]=1.047198    
    X[17]=0.872665    
    X[18]=0.785398    
    X[19]=0.732789    
    X[20]=0.698132    
    X[21]=0.610865    
    X[22]=0.523599    
    X[23]=0.349066    
    X[24]=0.174533

    Y[12]=10.678659
    Y[13]=75.414511
    Y[14]=41.513459
    Y[15]=20.104735
    Y[16]= 7.432436
    Y[17]= 1.298082
    Y[18]= 0.171300
    Y[19]= 0.000000
    Y[20]= 0.068203
    Y[21]= 0.774499
    Y[22]= 2.070002
    Y[23]= 5.574556
    Y[24]= 9.026378
    
    sum = 0
    for i = 12:M
        term=x[1]+x[2]*X[i]^2+x[3]*X[i]^4+x[4]*X[i]^6+x[5]*X[i]^8+x[6]*X[i]^10+x[7]*X[i]^12+x[8]*X[i]^14-Y[i]
        sum = sum+term^2
    end
    return sum
end

A["PALMER5C"]=function palmer5c(x::AbstractVector)
    println("Julia port of CUTEST's PALMER5C")
    M=23
    X=zeros(M)
    Y=zeros(M)
    
    X[12]=0.000000
    X[13]=1.570796
    X[14]=1.396263
    X[15]=1.308997
    X[16]=1.221730
    X[17]=1.125835
    X[18]=1.047198
    X[19]=0.872665
    X[20]=0.698132
    X[21]=0.523599
    X[22]=0.349066
    X[23]=0.174533

    Y[12]=83.57418
    Y[13]=81.007654
    Y[14]=18.983286
    Y[15]=8.051067
    Y[16]=2.044762
    Y[17]=0.000000
    Y[18]=1.170451
    Y[19]=10.479881
    Y[20]=25.785001
    Y[21]=44.126844
    Y[22]=62.822177
    Y[23]=77.719674
    
    sum = 0
    T=zeros(15)
    for i = 12:M
        T[1]=1
        T[2]=X[i]/X[13]
        for j = 2:14
            T[1+j]=2*T[2]*T[j]-T[j-1]
        end
        term1 = x[1]-Y[i]
        term2 = T[3]*x[2]
        term3 = T[5]*x[3]
        term4 = T[7]*x[4]
        term5 = T[9]*x[5]
        term6 = T[11]*x[6]
        sum = sum+(term1+term2+term3+term4+term5+term6)^2
    end
    return sum
end

A["PALMER7C"]=function palmer7c(x::AbstractVector)
    println("Julia port of CUTEST's PALMER7C")
    M=24
    X=zeros(M)
    Y=zeros(M)
    
    X[12]=0.000000
    X[13]=0.139626
    X[14]=0.261799
    X[15]=0.436332
    X[16]=0.565245
    X[17]=0.512942
    X[18]=0.610865
    X[19]=0.785398
    X[20]=0.959931
    X[21]=1.134464
    X[22]=1.308997
    X[23]=1.483530
    X[24]=1.658063

    Y[12]=  4.419446
    Y[13]=  3.564931
    Y[14]=  2.139067
    Y[15]=  0.404686
    Y[16]=  0.000000
    Y[17]=  0.035152
    Y[18]=  0.146813
    Y[19]=  2.718058
    Y[20]=  9.474417
    Y[21]= 26.132221
    Y[22]= 41.451561
    Y[23]= 72.283164
    Y[24]=117.630959
    
    sum = 0
    for i = 12:M
        term=x[1]+x[2]*X[i]^2+x[3]*X[i]^4+x[4]*X[i]^6+x[5]*X[i]^8+x[6]*X[i]^10+x[7]*X[i]^12+x[8]*X[i]^14-Y[i]
        sum = sum+term^2
    end
    return sum
end

A["GENHUMPS"]=function genhumps(x::AbstractVector)
    println("Julia port of CUTEST's GENHUMPS")
    N=5000
    Z=20
    sum = 0
    for i = 1:(N-1)
        term1 = (sin(Z*x[i])*sin(Z*x[i+1]))^2
        term2 = x[i]^2
        term3 = x[i+1]^2
        sum = sum+(term1+0.05*term2+0.05*term3)
    end
    return sum
end

A["TRIGON1"]=function trigon1(x::AbstractVector)
    println("Julia port of CUTEST's TRIGON1")
    N=10
    M=N
    sum = 0
    for i = 1:(N)
        sum1=0
        term1 = -(N+i)
        term2 = (i)*sin(x[i])
        term3 = (i+1)*cos(x[i])
        sum1=term1+term2+term3
        for j = 1:(i-1)
            sum1=sum1+cos(x[j])
        end
        for j = (i+1):(N)
            sum1=sum1+cos(x[j])
        end
        sum = sum+(sum1)^2
    end
    return sum
end

A["HAIRY"]=function hairy(x::AbstractVector)
    println("Julia port of CUTEST's HAIRY")
    H=30
    C=100
    sum = 0
    term1 = sin(7*x[1])^2*cos(7*x[2])^2
    term2 = sqrt((x[1]-x[2])^2+0.01)
    term3 = sqrt((x[1])^2+0.01)
    sum=H*term1+C*term2+C*term3
    return sum
end

A["MGH17LS"]=function mgh17ls(x::AbstractVector)
    println("Julia port of CUTEST's MGH17LS")
    M=33
    N=5
    X=zeros(M)
    Y=zeros(M)
    X[1]=0.0E+0
    X[2]=1.0E+1
    X[3]=2.0E+1
    X[4]=3.0E+1
    X[5]=4.0E+1
    X[6]=5.0E+1
    X[7]=6.0E+1
    X[8]=7.0E+1
    X[9]=8.0E+1
    X[10]=9.0E+1
    X[11]=1.0E+2
    X[12]=1.1E+2
    X[13]=1.2E+2
    X[14]=1.3E+2
    X[15]=1.4E+2
    X[16]=1.5E+2
    X[17]=1.6E+2
    X[18]=1.7E+2
    X[19]=1.8E+2
    X[20]=1.9E+2
    X[21]=2.0E+2
    X[22]=2.1E+2
    X[23]=2.2E+2
    X[24]=2.3E+2
    X[25]=2.4E+2
    X[26]=2.5E+2
    X[27]=2.6E+2
    X[28]=2.7E+2
    X[29]=2.8E+2
    X[30]=2.9E+2
    X[31]=3.0E+2
    X[32]=3.1E+2
    X[33]=3.2E+2

    Y[1]=8.44E-1
    Y[2]=9.08E-1
    Y[3]=9.32E-1
    Y[4]=9.36E-1
    Y[5]=9.25E-1
    Y[6]=9.08E-1
    Y[7]=8.81E-1
    Y[8]=8.50E-1
    Y[9]=8.18E-1
    Y[10]=7.84E-1
    Y[11]=7.51E-1
    Y[12]=7.18E-1
    Y[13]=6.85E-1
    Y[14]=6.58E-1
    Y[15]=6.28E-1
    Y[16]=6.03E-1
    Y[17]=5.80E-1
    Y[18]=5.58E-1
    Y[19]=5.38E-1
    Y[20]=5.22E-1
    Y[21]=5.06E-1
    Y[22]=4.90E-1
    Y[23]=4.78E-1
    Y[24]=4.67E-1
    Y[25]=4.57E-1
    Y[26]=4.48E-1
    Y[27]=4.38E-1
    Y[28]=4.31E-1
    Y[29]=4.24E-1
    Y[30]=4.20E-1
    Y[31]=4.14E-1
    Y[32]=4.11E-1
    Y[33]=4.06E-1
    sum = 0
    for i = 1:M
        term1 = x[1]-Y[i]
        term2 = x[2]*exp(-x[4]*X[i])
        term3 = x[3]*exp(-x[5]*X[i])
        sum=sum +(term1+term2+term3)^2
    end
    return sum
end

A["MGH09LS"]=function mgh09ls(x::AbstractVector)
    println("Julia port of CUTEST's MGH09LS")
    M=11
    N=4
    X=zeros(M)
    Y=zeros(M)
    X[1]=4.0E+0 
    X[2]=2.0E+0 
    X[3]=1.0E+0 
    X[4]=5.00E-1
    X[5]=2.50E-1
    X[6]=1.67E-1
    X[7]=1.25E-1
    X[8]=1.00E-1
    X[9]=8.33E-2
    X[10]=7.14E-2
    X[11]=6.25E-2

    Y[1]=1.957E-1
    Y[2]=1.947E-1
    Y[3]=1.735E-1
    Y[4]=1.60E-1 
    Y[5]=8.44E-2 
    Y[6]=6.27E-2 
    Y[7]=4.56E-2 
    Y[8]=3.42E-2 
    Y[9]=3.23E-2 
    Y[10]=2.35E-2 
    Y[11]=2.46E-2 
    sum = 0
    for i = 1:M
        term1 = -Y[i]
        term2 = (x[1]*(x[2]*X[i]+X[i]^2))/(x[4]+x[3]*X[i]+X[i]^2)
        sum=sum +(term1+term2)^2
    end
    return sum
end

A["LUKSAN12LS"]=function luksan12ls(x::AbstractVector)
    println("Julia port of CUTEST's LUKSAN12LS")
    grad = zeros(size(x))
    sum = 0
    S = 32
    i=1
    for j = 1:S
      term = -10*x[i+1]+10*x[i]^2
      term1 = x[i+2]-1
      term2 = (x[i+3]-1)^2
      term3 = (x[i+4]-1)^3
      term4 = -10+x[i]^2*x[i+3]+sin(x[i+3]-x[i+4])
      term5 = -20+x[i+1]+x[i+2]^4*x[i+3]^2
      sum = sum +term^2+ term1^2+term2^2+term3^2+term4^2+term5^2
      i=i+3
    end
    return sum#, grad
end

A["LUKSAN21LS"]=function luksan21ls(x::AbstractVector)
    println("Julia port of CUTEST's LUKSAN21LS")
    grad = zeros(size(x))
    N=100
    M=N 
    H=1/(N+1)
    term1=2*x[1]-x[2]+1+(0.5*H^2)*(x[1]+1*H+1)^3
    term2 = 2*x[N]-x[N-1]+1+(0.5*H^2)*(x[N]+N*H+1)^3
    sum=term1^2+term2^2
    for i = 2:(M-1)
      term = 2*x[i]-x[i-1]-x[i+1]+1
      term1 = (0.5*H^2)*(x[i]+i*H+1)^3
      sum = sum +(term+term1)^2
    end
    return sum#, grad
end

A["LUKSAN14LS"]=function luksan14ls(x::AbstractVector)
    println("Julia port of CUTEST's LUKSAN14LS")
    grad = zeros(size(x))
    sum = 0
    S = 32
    i=1
    for j = 1:S
      term = -10*x[i+1]+10*x[i]^2
      term1 = x[i+2]+x[i+1]-2
      term2 = x[i+3]-1
      term3 = x[i+4]-1
      term4 = x[i]+3*x[i+1]
      term5 = x[i+2]+x[i+3]-2*x[i+4]
      term6 = -10*x[i+4]+10*x[i+1]^2
      sum = sum +term^2+ term1^2+term2^2+term3^2+term4^2+term5^2+term6^2
      i=i+3
    end
    return sum#, grad
end

A["PRICE3"]=function price3(x::AbstractVector)
    println("Julia port of CUTEST's PRICE3")
    grad = zeros(size(x))
    M=2
    N=2
    term1 = -x[2]+x[1]^2
    term2 = -x[1]-0.6+6.4*(x[2]-0.5)^2
    sum = 100*term1^2+term2^2
    return sum#, grad
end

A["PRICE4"]=function price4(x::AbstractVector)
    println("Julia port of CUTEST's PRICE4")
    grad = zeros(size(x))
    M=2
    N=2
    term1 = 2*x[2]*x[1]^3-x[2]^3
    term2 = 6*x[1]+x[2]-x[2]^2
    sum = term1^2+term2^2
    return sum#, grad
end

A["S308"]=function s308(x::AbstractVector)
    println("Julia port of CUTEST's S308")
    grad = zeros(size(x))
    term1 = x[1]^2+x[1]*x[2]+x[2]^2
    term2 = sin(x[1])
    term3 = cos(x[2])
    sum = term1^2+term2^2+term3^2
    return sum#, grad
end

A["MISRA1ALS"]=function misra1als(x::AbstractVector)
    println("Julia port of CUTEST's MISRA1ALS")
    grad = zeros(size(x))
    X=zeros(14)
    Y=zeros(14)
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
    M=14
    sum=0
    for i = 1:M
        term = x[1]-Y[i]
        term1 = -x[1]*exp(-x[2]*X[i])
        sum = sum + (term+term1)^2
    end
    return sum#, grad
end

A["MISRA1DLS"]=function misra1dls(x::AbstractVector)
    println("Julia port of CUTEST's MISRA1DLS")
    grad = zeros(size(x))
    X=zeros(14)
    Y=zeros(14)
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
    M=14
    sum=0
    for i = 1:M
        term = -Y[i]
        term1 = x[1]*x[2]*X[i]/(1+x[2]*X[i])
        sum = sum + (term+term1)^2
    end
    return sum#, grad
end

A["MISRA1BLS"]=function misra1bls(x::AbstractVector)
    println("Julia port of CUTEST's MISRA1BLS")
    grad = zeros(size(x))
    X=zeros(14)
    Y=zeros(14)
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
    M=14
    sum=0
    for i = 1:M
        term = x[1]-Y[i]
        term1 = -x[1]/(1+0.5*x[2]*X[i])^2
        sum = sum + (term+term1)^2
    end
    return sum#, grad
end

A["DENSCHNF"]=function denschnf(x::AbstractVector)
    println("Julia port of CUTEST's DENSCHNF")
    grad = zeros(size(x))
    sum=0
    term = -8+2*(x[1]+x[2])^2+(x[1]-x[2])^2
    term1 = -9+5*x[1]^2+(x[2]-3)^2
    sum = sum + term^2+term1^2
    return sum#, grad
end

A["DENSCHNA"]=function denschna(x::AbstractVector)
    println("Julia port of CUTEST's DENSCHNA")
    grad = zeros(size(x))
    sum=0
    term1 = x[1]
    term2 = x[1]+x[2]
    term3 = -1+exp(x[2])
    sum = sum + term1^4+term2^2+term3^2
    return sum#, grad
end

A["DENSCHNC"]=function denschnc(x::AbstractVector)
    println("Julia port of CUTEST's DENSCHNC")
    grad = zeros(size(x))
    sum=0
    term1 = -2+x[1]^2+x[2]^2
    term2 = -2+exp(x[1]-1)+x[2]^3
    sum = sum + term1^2+term2^2
    return sum#, grad
end

A["DENSCHNB"]=function denschnb(x::AbstractVector)
    println("Julia port of CUTEST's DENSCHNB")
    grad = zeros(size(x))
    sum=0
    term1 = x[1]-2
    term2 = (x[1]-2)*x[2]
    term3 = x[2]+1
    sum = sum + term1^2+term2^2+term3^2
    return sum#, grad
end

A["DENSCHND"]=function denschnd(x::AbstractVector)
    println("Julia port of CUTEST's DENSCHND")
    grad = zeros(size(x))
    sum=0
    term1 = x[1]^2+x[2]^3-x[3]^4
    term2 = 2*(x[1]*x[2]*x[3])
    term3 = 2*x[1]*x[2]-3*x[3]*x[2]+x[1]*x[3]
    sum = sum + term1^2+term2^2+term3^2
    return sum#, grad
end

A["LSC2LS"]=function lsc2ls(x::AbstractVector)
    println("Julia port of CUTEST's LSC2LS")
    grad = zeros(size(x))
    sum=0
    X=zeros(6)
    Y=zeros(6)
    X[1]=36.0
    X[2]=36.0
    X[3]=19.0
    X[4]=18.0
    X[5]=33.0
    X[6]=26.0
    Y[1]=14.0
    Y[2]=10.0
    Y[3]=28.0
    Y[4]=31.0
    Y[5]=18.0
    Y[6]=26.0
    M=6
    N=3
    for i = 1:M
        term1 = -x[3]+ sqrt((x[1]-X[i])^2+(x[2]-Y[i])^2)
        sum = sum+term1^2
    end
    return sum#, grad
end

A["LSC1LS"]=function lsc1ls(x::AbstractVector)
    println("Julia port of CUTEST's LSC1LS")
    grad = zeros(size(x))
    sum=0
    X=zeros(6)
    Y=zeros(6)
    X[1]=9.0
    X[2]=35.0
    X[3]=-13.0
    X[4]=10.0
    X[5]=23.0
    X[6]=0.0
    Y[1]=34.0
    Y[2]=10.0
    Y[3]=6.0
    Y[4]=-14.0
    Y[5]=27.0
    Y[6]=-10.0
    M=6
    N=3
    for i = 1:M
        term1 = -x[3]+ sqrt((x[1]-X[i])^2+(x[2]-Y[i])^2)
        sum = sum+term1^2
    end
    return sum#, grad
end

A["HIMMELBH"]=function himmelbh(x::AbstractVector)
    println("Julia port of CUTEST's HIMMELBH")
    grad = zeros(size(x))
    term1 = -3*x[1]-2*x[2]+2
    term2 = x[1]^3+x[2]^2
    sum = term1+term2
    return sum#, grad
end

A["HIMMELBF"]=function himmelbf(x::AbstractVector)
    println("Julia port of CUTEST's HIMMELBF")
    grad = zeros(size(x))
    sum=0
    A=zeros(7)
    B=zeros(7)
    A[1]=0.0
    A[2]=0.000428
    A[3]=0.001000
    A[4]=0.001610
    A[5]=0.002090
    A[6]=0.003480
    A[7]=0.005250

    B[1]=7.391
    B[2]=11.18
    B[3]=16.44
    B[4]=16.20
    B[5]=22.20
    B[6]=24.02
    B[7]=31.32
    for i=1:7
        term1 = -1
        term2 = x[1]^2+A[i]*x[2]^2+A[i]^2*x[3]^2
        term3 = B[i]*(1+A[i]*x[4]^2)
        sum = sum + 10^4*(term1+term2/term3)^2
    end
    return sum#, grad
end

A["HIMMELBB"]=function himmelbb(x::AbstractVector)
    println("Julia port of CUTEST's HIMMELBB")
    grad = zeros(size(x))
    term1 = x[1]*x[2]
    term2 = (1-x[1])
    term3 = (1-x[2]-x[1]*term2^5)
    sum = (term1*term2*term3)^2
    return sum#, grad
end

A["HIMMELBCLS"]=function himmelbcls(x::AbstractVector)
    println("Julia port of CUTEST's HIMMELBCLS")
    grad = zeros(size(x))
    term1 = x[2]-11+x[1]^2
    term2 = x[1]-7+x[2]^2
    sum = term1^2+term2^2
    return sum#, grad
end

A["HIMMELBG"]=function himmelbg(x::AbstractVector)
    println("Julia port of CUTEST's HIMMELBG")
    grad = zeros(size(x))
    term1 = exp(-x[1]-x[2])
    term2 = 2*x[1]^2+3*x[2]^2
    sum = (term1*term2)
    return sum#, grad
end

A["MARATOSB"]=function maratosb(x::AbstractVector)
    println("Julia port of CUTEST's MARATOSB")
    grad = zeros(size(x))
    term1 = x[1]
    term2 = -1+x[1]^2+x[2]^2
    sum = term1 + 10^6*term2^2
    return sum#, grad
end

A["ZANGWIL2"]=function zangwil2(x::AbstractVector)
    println("Julia port of CUTEST's ZANGWIL2")
    grad = zeros(size(x))
    term1 = -56*x[1]-256*x[2]+991
    term2 = 16*x[1]^2+16*x[2]^2-8*x[1]*x[2]
    sum = (1/15)*(term1+term2)
    return sum#, grad
end

A["FREUROTH"]=function freuroth(x::AbstractVector)
    println("Julia port of CUTEST's FREUROTH")
    grad = zeros(size(x))
    N=length(x)
    sum=0
    for i = 1:(N-1)
        term1 = x[i]-2*x[i+1]-13
        term2 = (5-1*x[i+1])*x[i+1]^2
        term3 = x[1]-14*x[i+1]-29
        term4 = (1+1*x[i+1])*x[i+1]^2
        sum = sum + (term1+term2)^2+(term3+term4)^2
    end
    return sum#, grad
end

B=Dict("KOWOSB"=>4,"NONCVXUN"=>5000,"BIGGS6"=>6,"OSBORNEA"=>5,"TOINTGSS"=>5000,"ECKERLE4LS"=>3,"EXPFIT"=>2,"CLUSTERLS"=>2,"THURBERLS"=>7,"BRKMCC"=>2,"RAT42LS"=>3,"SNAIL"=>2,"RAT43LS"=>4,"HATFLDE"=>3,"ALLINITU"=>4,"ARWHEAD"=>5000,"NCB20"=>5010,"SENSORS"=>100,"INDEF"=>5000,"HATFLDD"=>3,"CHNRSNBM"=>50,"CHWIRUT2LS"=>3,"TRIDIA"=>5000,"MODBEALE"=>20000,"MEYER3"=>3,"LSC1LS"=>3,"GROWTHLS"=>3,"FLETBV3M"=>5000,"NCB20B"=>5000,"JENSMP"=>2,"STRTCHDV"=>10,"VARDIM"=>200,"BEALE"=>2,"STREG"=>4,"PENALTY3"=>200,"DJTL"=>2,"EIGENCLS"=>51*52,"CERI651CLS"=>7,"VIBRBEAM"=>30,"CERI651ALS"=>7,"DIAMON2DLS"=>66,"DEVGLA2NE"=>5,"CERI651DLS"=>7,"EIGENALS"=>50*51,"EIGENBLS"=>50*51,"MSQRTBLS"=>32^2,"LANCZOS2LS"=>6,"BENNETT5LS"=>3,"SPMSRTLS"=>1667^2,"HYDCAR6LS"=>29,"SPINLS"=>2602,"HEART8LS"=>8,"HEART6LS"=>6,"DIAMON3DLS"=>99,"CERI651BLS"=>7,"PENALTY2"=>200,"FMINSRF2"=>100^2,"FMINSURF"=>75^2,"COOLHANSLS"=>9,"VAREIGVL"=>4999,"CERI651ELS"=>7,"SSBRYBND"=>5000,"BRYBND"=>5000,"GBRAINLS"=>11*200,"MANCINO"=>100,"NONMSQRT"=>70^2,"BROYDNBDLS"=>5000,"BROYDN3DLS"=>5000,"BROYDN7D"=>5000,"NONCVXU2"=>5000,"NELSONLS"=>3,"YFITU"=>3,"COATINGNE"=>134,"YATP1CLS"=>350*352,"YATP2LS"=>350*352,"YATP2CLS"=>350*352,"HILBERTA"=>2,"YATP1LS"=>350*352,"HILBERTB"=>10,"WATSON"=>12,"DIXON3DQ"=>10000,"CHAINWOO"=>4000,"KIRBY2LS"=>5,"COATING"=>134,"ERRINRSM"=>50,"DEVGLA2"=>5,"HIMMELBB"=>2,"HIMMELBH"=>2,"ZANGWIL2"=>2,"LSC1LS"=>3,"GAUSS2LS"=>8,"PALMER6C"=>8,"LUKSAN14LS"=>98,"PRICE4"=>2,"MGH10SLS"=>16,"PALMER2C"=>8,"HAIRY"=>2,"MISRA1BLS"=>2,"GENHUMPS"=>5000,"DENSCHNC"=>2,"ARGLINA"=>200,"HIMMELBCLS"=>2,"DENSCHND"=>3,"MARATOSB"=>2,"LSC2LS"=>3,"SISSER"=>2,"PALMER1C"=>8,"CYCLOOCFLS"=>29996,"MISRA1DLS"=>2,"TRIGON1"=>10,"S308"=>2,"MISRA1ALS"=>2,"S308NE"=>2,"HIMMELBG"=>2,"LUKSAN21LS"=>100,"SPIN2LS"=>102,"PALMER5C"=>6,"SBRYBND"=>5000,"ARGLINC"=>200,"FREUROTH"=>5000,"PALMER8C"=>8,"MGH17LS"=>5,"LUKSAN22LS"=>100,"DENSCHNB"=>2,"DENSCHNF"=>2,"DENSCHNA"=>2,"PALMER1D"=>7,"GAUSS3LS"=>8,"HIMMELBF"=>4,"PRICE3"=>2,"MGH09LS"=>4,"PALMER7C"=>8,"PALMER5D"=>4,"GAUSS1LS"=>8,"LUKSAN12LS"=>98)
problemVector = collect(keys(A))
sumArray = ones(length(problemVector))
gradArray=zeros(length(problemVector))
z=rand(1:10,10^8)
println(problemVector)
println(length(problemVector))

for i =1:length(problemVector)
    prob=problemVector[i]
    y=B[prob]
    println(string(y)*prob)
    soln=(A[prob](ones(y)))
    println(soln)
end

# function unitTesting(problemVector,sumArray,gradArray,z)
#     sumArraySIF = ones(length(problemVector))
#     gradArraySIF = ones(length(problemVector))
#     for i = 1:length(problemVector)
#         problem = problemVector[i]
#         lens=B[problem]
#         x=z[1:lens]
#         x=ones(lens)
#         temp=A[problem](x)
#         sumArray[i]=temp
#         println("Working on: "*problem)
#         nlp = CUTEstModel(problem, verbose=false)
#         fx = obj(nlp, x)
#         #gx = grad(nlp, x)
#         finalize(nlp)
#         fx = convert(Float64,fx)
#         #gx = convert(Array{Float64},gx)
#         sumArraySIF[i] = fx
#         #gradArraySIF[i] = gx
#     end
#     for i = 1:length(problemVector)
#         if sumArray[i]-sumArraySIF[i] != 0
#             println("Issue with sum: " * problemVector[i])
#             println(sumArray[i])
#             println(sumArraySIF[i])
#             # println(x)
#         end
#         # if gradArray[i]-gradArraySIF[i] != 0
#         #     println("grad: " * problemVector[i])
#         #     # println(x)
#         # end
#     end
# end

# unitTesting(problemVector,sumArray,gradArray,z)

# end
