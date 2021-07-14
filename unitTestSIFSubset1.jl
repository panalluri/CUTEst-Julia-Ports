module Wrapper

export wrapfun
#ALL GOOD EXCEPT COMMENTED
using CUTEst
using NLPModels

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
    x[2]=10^(-4)*x[2]
    x[3]=0.01*x[3]
    for i = 1:16
        term1 = -G[i]
        coeff=45+5*i
        term2 = x[1]*exp(x[2]/(coeff+x[3]))
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
        sum = sum +term1^2
    end
    for i = 2:(N-1)
        term1 = 2*x[i]-x[N]-x[1]
        sum = sum +0.5*cos(term1)
    end
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

A["INDEFM"]=function indefm(x::AbstractVector)
    println("Julia port of CUTEST's INDEFM")
    grad = zeros(size(x))
    N=100000
    sum=0
    for i = 1:N
        term1 = x[i]
        sum = sum + 100*sin(0.01*term1)
    end
    for i = 2:(N-1)
        term1 = 2*x[i]-x[N]-x[1]
        sum = sum + 0.5*cos(term1)
    end
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

#PROBLEM
A["OSBORNEB"]=function osborneb(x::AbstractVector)
    println("Julia port of CUTEST's OSBORNEB")
    grad = zeros(size(x))
    M=65
    N=11
    G=zeros(M)
    G[1]=1.366
    G[2]=1.191
    G[3]=1.112
    G[4]=1.013
    G[5]=0.991
    G[6]=0.885
    G[7]=0.831
    G[8]=0.847
    G[9]=0.786
    G[10]=0.725
    G[11]=0.746
    G[12]=0.679
    G[13]=0.608
    G[14]=0.655
    G[15]=0.616
    G[16]=0.606
    G[17]=0.602
    G[18]=0.626
    G[19]=0.651
    G[20]=0.724
    G[21]=0.649
    G[22]=0.649
    G[23]=0.694
    G[24]=0.644
    G[25]=0.624
    G[26]=0.661
    G[27]=0.612
    G[28]=0.558
    G[29]=0.533
    G[30]=0.495
    G[31]=0.500
    G[32]=0.423
    G[33]=0.395
    G[34]=0.375
    G[35]=0.372
    G[36]=0.391
    G[37]=0.396
    G[38]=0.405
    G[39]=0.428
    G[40]=0.429
    G[41]=0.523
    G[42]=0.562
    G[43]=0.607
    G[44]=0.653
    G[45]=0.672
    G[46]=0.708
    G[47]=0.633
    G[48]=0.668
    G[49]=0.645
    G[50]=0.632
    G[51]=0.591
    G[52]=0.559
    G[53]=0.597
    G[54]=0.625
    G[55]=0.739
    G[56]=0.710
    G[57]=0.729
    G[58]=0.720
    G[59]=0.636
    G[60]=0.581
    G[61]=0.428
    G[62]=0.292
    G[63]=0.162
    G[64]=0.098
    G[65]=0.054
    sum=0
    for i = 1:M
        T=0.1*(i-1)
        term1 = -G[i]
        term2 = x[1]*exp(-T*x[5])
        term3 = x[2]*exp(-x[6]*(T-x[9])^2)
        term4 = x[3]*exp(-x[7]*(T-x[10])^2)
        term5 = x[4]*exp(-x[8]*(T-x[11])^2)
        sum = sum + (term1+term2+term3+term4+term5)^2
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
        Y = x[1]^2+x[2]^2
        A = Y^0.125
        S = sin(50*Y^0.1)
        B = 1+S
        term = A*B
        sum = sum + (term)^2
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

#PROBELM
A["INTEQNELS"]=function inteqnels(x::AbstractVector)
    println("Julia port of CUTEST's INTEQNELS")
    grad = zeros(size(x))
    N=500
    H=1/(N+1)
    HFH = 0.5*H
    term1 = x[1]
    term2 = x[N+2]
    sum=term1^2+term2^2
    sum1 = 0
    for i = 2:(N+1)
        sum1=0
        term1 = x[i]
        for j = 1:i
            coeff = j*H*HFH*(1-i*H)
            term = (x[j]+(1+j*H))^3
            sum1 = sum1 + coeff*term
        end
        for j = (i+1):N
            coeff = i*HFH*(1-j*H)*H
            term = (x[j]+(1+j*H))^3
            sum1 = sum1 + coeff*term
        end
        sum = sum + (sum1+term1)^2
    end
    return sum#, grad
end

A["NONCVXUN"]=function noncvxun(x::AbstractVector)
    println("Julia port of CUTEST's NONCVXUN")
    grad = zeros(size(x))
    N=5000
    sum=0
    for i = 1:N
        term1 = (x[i]+2*x[1])^2
        term2 = 4*cos(x[i]+2*x[1])
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

problemVector = collect(keys(A))
sumArray = ones(length(problemVector))
gradArray=zeros(length(problemVector))
B=Dict("DMN15103LS"=>99, "OSBORNEB"=>11, "INTEQNELS"=>502, "TOINTQOR"=>50, "BEALE"=>2, "VARDIM"=>200, "STRTCHDV"=>10, "JENSMP"=>2, "ENSOLS"=>9, "NCB20B"=>5000, "CHNRSNBM"=>50, "FLETBV3M"=>5000, "GROWTHLS"=>3, "MEYER3"=>3, "MODBEALE"=>20000, "DMN15332LS"=>66, "TRIDIA"=>5000, "GULF"=>3, "CHWIRUT2LS"=>3, "DMN15333LS"=>99, "HATFLDD"=>3, "INDEF"=>5000, "SENSORS"=>100, "NCB20"=>5010, "ARWHEAD"=>5000, "ALLINITU"=>4, "HATFLDE"=>3, "RAT43LS"=>4, "SNAIL"=>2, "VESUVIOLS"=>8, "RAT42LS"=>3, "BRKMCC"=>2, "TOINTGOR"=>50, "THURBERLS"=>7, "TOINTPSP"=>50, "CLUSTERLS"=>2, "INDEFM"=>100000, "EXPFIT"=>2, "DMN37143LS"=>99, "ECKERLE4LS"=>3, "TOINTGSS"=>5000, "HAHN1LS"=>7, "DMN15102LS"=>66, "DMN37142LS"=>66, "OSBORNEA"=>5, "VESUVIOULS"=>8, "BIGGS6"=>6, "NONCVXUN"=>5000, "KOWOSB"=>4, "VESUVIALS"=>4)
z=rand(1:10,10^6)
println(problemVector)

for i =1:length(problemVector)
    prob=problemVector[i]
    y=B[prob]
    println(string(y)*prob)
    soln=(A[prob](ones(y)))
    println(soln)
end

function unitTesting(problemVector,sumArray,gradArray,z)
    sumArraySIF = ones(length(problemVector))
    gradArraySIF = ones(length(problemVector))
    for i = 1:length(problemVector)
        problem = problemVector[i]
        lens=B[problem]
        x=z[1:lens]
        x=ones(lens)
        temp=A[problem](x)
        sumArray[i]=temp
        println("Working on: "*problem)
        nlp = CUTEstModel(problem, verbose=false)
        fx = obj(nlp, x)
        #gx = grad(nlp, x)
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

unitTesting(problemVector,sumArray,gradArray,z)

end