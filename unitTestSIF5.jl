# module Wrapper

# export wrapfun

# using CUTEst
# using NLPModels
using SpecialFunctions

A = Dict{String,Function}()
B=Dict("STREG"=>4,"PENALTY3"=>200,"DJTL"=>2,"EIGENCLS"=>51*52,"CERI651CLS"=>7,"VIBRBEAM"=>30,"CERI651ALS"=>7,"DIAMON2DLS"=>66,"DEVGLA2NE"=>5,"CERI651DLS"=>7,"EIGENALS"=>50*51,"EIGENBLS"=>50*51,"MSQRTBLS"=>32^2,"LANCZOS2LS"=>6,"BENNETT5LS"=>3,"SPMSRTLS"=>1667^2,"HYDCAR6LS"=>29,"SPINLS"=>2602,"HEART8LS"=>8,"HEART6LS"=>6,"DIAMON3DLS"=>99,"CERI651BLS"=>7,"PENALTY2"=>200,"FMINSRF2"=>100^2,"FMINSURF"=>75^2,"COOLHANSLS"=>9,"VAREIGVL"=>4999,"CERI651ELS"=>7,"SSBRYBND"=>5000,"BRYBND"=>5000,"GBRAINLS"=>11*200,"MANCINO"=>100,"NONMSQRT"=>70^2,"BROYDNBDLS"=>5000,"BROYDN3DLS"=>5000,"BROYDN7D"=>5000,"NONCVXU2"=>5000,"NELSONLS"=>3,"YFITU"=>3,"COATINGNE"=>134,"YATP1CLS"=>350*352,"YATP2LS"=>350*352,"YATP2CLS"=>350*352,"HILBERTA"=>2,"YATP1LS"=>350*352,"HILBERTB"=>10,"WATSON"=>12,"DIXON3DQ"=>10000,"CHAINWOO"=>4000,"KIRBY2LS"=>5,"COATING"=>134,"ERRINRSM"=>50,"DEVGLA2"=>5)

A["DIXON3DQ"]=function dixon3dq(x::AbstractVector)
    println("Julia port of CUTEST's DIXON3DQ")
    grad = zeros(size(x))
    N=10000
    term1 = x[1]-1
    term2 = x[N]-1
    sum =term1^2+term2^2
    for i = 2:(N-1)
        term1 = x[i]-x[i+1]
        sum=sum+term1^2
    end
    return sum #, grad
end

A["CHAINWOO"]=function chainwoo(x::AbstractVector)
    println("Julia port of CUTEST's CHAINWOO")
    grad = zeros(size(x))
    NS=1999
    N=2*NS+2
    sum=1
    j=4
    for i = 1:NS
        A=x[j-2]+x[j-3]^2
        B=-x[j-3]+1
        C=x[j]+x[j-1]^2
        D=-x[j-1]+1
        E=x[j-2]+x[j]-2
        F=x[j-2]-x[j]
        sum=sum+100*A^2+B^2+90*C^2+D^2+10*E^2+0.1*F^2
        j=j+2
    end
    return sum #, grad
end

A["KIRBY2LS"]=function kirby2ls(x::AbstractVector)
    println("Julia port of CUTEST's KIRBY2LS")
    grad = zeros(size(x))
    M=151
    N=5
    sum=0
    X=zeros(M)
    Y=zeros(M)
    X[1]=9.65  
    X[2]=10.74 
    X[3]=11.81 
    X[4]=12.88 
    X[5]=14.06 
    X[6]=15.28 
    X[7]=16.63 
    X[8]=18.19 
    X[9]=19.88 
    X[10]=21.84 
    X[11]=24.0  
    X[12]=26.25 
    X[13]=28.86 
    X[14]=31.85 
    X[15]=35.79 
    X[16]=40.18 
    X[17]=44.74 
    X[18]=49.53 
    X[19]=53.94 
    X[20]=58.29 
    X[21]=62.63 
    X[22]=67.03 
    X[23]=71.25 
    X[24]=75.22 
    X[25]=79.33 
    X[26]=83.56 
    X[27]=87.75 
    X[28]=91.93 
    X[29]=96.1  
    X[30]=100.28
    X[31]=104.46
    X[32]=108.66
    X[33]=112.71
    X[34]=116.88
    X[35]=121.33
    X[36]=125.79
    X[37]=125.79
    X[38]=128.74
    X[39]=130.27
    X[40]=133.33
    X[41]=134.79
    X[42]=137.93
    X[43]=139.33
    X[44]=142.46
    X[45]=143.9 
    X[46]=146.91
    X[47]=148.51
    X[48]=151.41
    X[49]=153.17
    X[50]=155.97
    X[51]=157.76
    X[52]=160.56
    X[53]=162.30
    X[54]=165.21
    X[55]=166.9 
    X[56]=169.92
    X[57]=170.32
    X[58]=171.54
    X[59]=173.79
    X[60]=174.57
    X[61]=176.25
    X[62]=177.34
    X[63]=179.19
    X[64]=181.02
    X[65]=182.08
    X[66]=183.88
    X[67]=185.75
    X[68]=186.80
    X[69]=188.63
    X[70]=190.45
    X[71]=191.48
    X[72]=193.35
    X[73]=195.22
    X[74]=196.23
    X[75]=198.05
    X[76]=199.97
    X[77]=201.06
    X[78]=202.83
    X[79]=204.69
    X[80]=205.86
    X[81]=207.58
    X[82]=209.50
    X[83]=210.65
    X[84]=212.33
    X[85]=215.43
    X[86]=217.16
    X[87]=220.21
    X[88]=221.98
    X[89]=225.06
    X[90]=226.79
    X[91]=229.92
    X[92]=231.69
    X[93]=234.77
    X[94]=236.6 
    X[95]=239.63
    X[96]=241.50
    X[97]=244.48
    X[98]=246.40
    X[99]=249.35
    X[100]=251.32
    X[101]=254.22
    X[102]=256.24
    X[103]=259.11
    X[104]=261.18
    X[105]=264.02
    X[106]=266.13
    X[107]=268.94
    X[108]=271.09
    X[109]=273.87
    X[110]=276.08
    X[111]=278.83
    X[112]=281.08
    X[113]=283.81
    X[114]=286.11
    X[115]=288.81
    X[116]=291.08
    X[117]=293.75
    X[118]=295.99
    X[119]=298.64
    X[120]=300.84
    X[121]=302.02
    X[122]=303.48
    X[123]=305.65
    X[124]=308.27
    X[125]=310.41
    X[126]=313.01
    X[127]=315.12
    X[128]=317.71
    X[129]=319.79
    X[130]=322.36
    X[131]=324.42
    X[132]=326.98
    X[133]=329.01
    X[134]=331.56
    X[135]=333.56
    X[136]=336.1 
    X[137]=338.08
    X[138]=340.6
    X[139]=342.57
    X[140]=345.08
    X[141]=347.02
    X[142]=349.52
    X[143]=351.44
    X[144]=353.93
    X[145]=355.83
    X[146]=358.32
    X[147]=360.2 
    X[148]=362.67
    X[149]=364.53
    X[150]=367.0 
    X[151]=371.3

    Y[1]=0.0082 
    Y[2]=0.0112 
    Y[3]=0.0149 
    Y[4]=0.0198 
    Y[5]=0.0248 
    Y[6]=0.0324 
    Y[7]=0.042  
    Y[8]=0.0549 
    Y[9]=0.0719 
    Y[10]=0.0963 
    Y[11]=0.1291 
    Y[12]=0.171  
    Y[13]=0.2314 
    Y[14]=0.3227 
    Y[15]=0.4809 
    Y[16]=0.7084 
    Y[17]=1.022  
    Y[18]=1.458  
    Y[19]=1.952  
    Y[20]=2.541  
    Y[21]=3.223  
    Y[22]=3.999  
    Y[23]=4.852  
    Y[24]=5.732  
    Y[25]=6.727  
    Y[26]=7.835  
    Y[27]=9.025  
    Y[28]=10.267 
    Y[29]=11.578 
    Y[30]=12.944 
    Y[31]=14.377 
    Y[32]=15.856 
    Y[33]=17.331 
    Y[34]=18.885 
    Y[35]=20.575 
    Y[36]=22.32  
    Y[37]=22.303 
    Y[38]=23.46  
    Y[39]=24.06  
    Y[40]=25.272 
    Y[41]=25.853 
    Y[42]=27.11  
    Y[43]=27.658 
    Y[44]=28.924 
    Y[45]=29.511 
    Y[46]=30.71  
    Y[47]=31.35  
    Y[48]=32.52  
    Y[49]=33.23  
    Y[50]=34.33  
    Y[51]=35.06  
    Y[52]=36.17  
    Y[53]=36.84  
    Y[54]=38.01  
    Y[55]=38.67  
    Y[56]=39.87  
    Y[57]=40.03  
    Y[58]=40.5   
    Y[59]=41.37  
    Y[60]=41.67  
    Y[61]=42.31  
    Y[62]=42.73  
    Y[63]=43.46  
    Y[64]=44.14  
    Y[65]=44.55  
    Y[66]=45.22  
    Y[67]=45.92  
    Y[68]=46.3   
    Y[69]=47.0   
    Y[70]=47.68  
    Y[71]=48.06  
    Y[72]=48.74  
    Y[73]=49.41  
    Y[74]=49.76  
    Y[75]=50.43  
    Y[76]=51.11  
    Y[77]=51.5   
    Y[78]=52.12  
    Y[79]=52.76  
    Y[80]=53.18  
    Y[81]=53.78  
    Y[82]=54.46  
    Y[83]=54.83  
    Y[84]=55.4   
    Y[85]=56.43  
    Y[86]=57.03  
    Y[87]=58.0   
    Y[88]=58.61  
    Y[89]=59.58  
    Y[90]=60.11  
    Y[91]=61.1   
    Y[92]=61.65  
    Y[93]=62.59  
    Y[94]=63.12  
    Y[95]=64.03  
    Y[96]=64.62  
    Y[97]=65.49  
    Y[98]=66.03  
    Y[99]=66.89  
    Y[100]=67.42  
    Y[101]=68.23  
    Y[102]=68.77  
    Y[103]=69.59  
    Y[104]=70.11  
    Y[105]=70.86  
    Y[106]=71.43  
    Y[107]=72.16  
    Y[108]=72.7   
    Y[109]=73.4   
    Y[110]=73.93  
    Y[111]=74.6   
    Y[112]=75.16  
    Y[113]=75.82  
    Y[114]=76.34  
    Y[115]=76.98  
    Y[116]=77.48  
    Y[117]=78.08  
    Y[118]=78.6   
    Y[119]=79.17  
    Y[120]=79.62  
    Y[121]=79.88  
    Y[122]=80.19  
    Y[123]=80.66  
    Y[124]=81.22  
    Y[125]=81.66  
    Y[126]=82.16  
    Y[127]=82.59  
    Y[128]=83.14  
    Y[129]=83.5   
    Y[130]=84.0   
    Y[131]=84.4   
    Y[132]=84.89  
    Y[133]=85.26  
    Y[134]=85.74  
    Y[135]=86.07  
    Y[136]=86.54  
    Y[137]=86.89  
    Y[138]=87.32  
    Y[139]=87.65  
    Y[140]=88.1   
    Y[141]=88.43  
    Y[142]=88.83  
    Y[143]=89.12  
    Y[144]=89.54  
    Y[145]=89.85  
    Y[146]=90.25  
    Y[147]=90.55  
    Y[148]=90.93  
    Y[149]=91.2   
    Y[150]=91.55  
    Y[151]=92.2   
    for i = 1:M
        term1 = -Y[i]
        term2 = (x[1] + x[2] * X[i] + x[3] * X[i]^2)/(1+ x[4] * X[i] + x[5] * X[i]^2)
        sum=sum+(term1+term2)^2
    end
    return sum #, grad
end

#problems
A["COATING"]=function coating(x::AbstractVector)
    println("Julia port of CUTEST's COATING")
    grad = zeros(size(x))
    M=252
    N=134
    sum=0
    SCALE1=4.08
    SCALE2=0.417
    ETA1=zeros(63)
    ETA2=zeros(63)
    Y=zeros(126)
    
    ETA1[1]= 0.7140
    ETA1[2]= 0.7169
    ETA1[3]= 0.7232
    ETA1[4]= 0.7151
    ETA1[5]= 0.6848
    ETA1[6]= 0.7070
    ETA1[7]= 0.7177
    ETA1[8]= 0.7073
    ETA1[9]= 0.6734
    ETA1[10]=0.7174
    ETA1[11]=0.7125
    ETA1[12]=0.6947
    ETA1[13]=0.7121
    ETA1[14]=0.7166
    ETA1[15]=0.6894
    ETA1[16]=0.6897
    ETA1[17]=0.7024
    ETA1[18]=0.7026
    ETA1[19]=0.6800
    ETA1[20]=0.6957
    ETA1[21]=0.6987
    ETA1[22]=0.7111
    ETA1[23]=0.7097
    ETA1[24]=0.6809
    ETA1[25]=0.7139
    ETA1[26]=0.7046
    ETA1[27]=0.6950
    ETA1[28]=0.7032
    ETA1[29]=0.7019
    ETA1[30]=0.6975
    ETA1[31]=0.6955
    ETA1[32]=0.7056
    ETA1[33]=0.6965
    ETA1[34]=0.6848
    ETA1[35]=0.6995
    ETA1[36]=0.6105
    ETA1[37]=0.6027
    ETA1[38]=0.6084
    ETA1[39]=0.6081
    ETA1[40]=0.6057
    ETA1[41]=0.6116
    ETA1[42]=0.6052
    ETA1[43]=0.6136
    ETA1[44]=0.6032
    ETA1[45]=0.6081
    ETA1[46]=0.6092
    ETA1[47]=0.6122
    ETA1[48]=0.6157
    ETA1[49]=0.6191
    ETA1[50]=0.6169
    ETA1[51]=0.5483
    ETA1[52]=0.5371
    ETA1[53]=0.5576
    ETA1[54]=0.5521
    ETA1[55]=0.5495
    ETA1[56]=0.5499
    ETA1[57]=0.4937
    ETA1[58]=0.5092
    ETA1[59]=0.5433
    ETA1[60]=0.5018
    ETA1[61]=0.5363
    ETA1[62]=0.4977
    ETA1[63]=0.5296

    ETA2[1]= 5.145
    ETA2[2]= 5.241
    ETA2[3]= 5.389
    ETA2[4]= 5.211
    ETA2[5]= 5.154
    ETA2[6]= 5.105
    ETA2[7]= 5.191
    ETA2[8]= 5.013
    ETA2[9]= 5.582
    ETA2[10]=5.208
    ETA2[11]=5.142
    ETA2[12]=5.284
    ETA2[13]=5.262
    ETA2[14]=6.838
    ETA2[15]=6.215
    ETA2[16]=6.817
    ETA2[17]=6.889
    ETA2[18]=6.732
    ETA2[19]=6.717
    ETA2[20]=6.468
    ETA2[21]=6.776
    ETA2[22]=6.574
    ETA2[23]=6.465
    ETA2[24]=6.090
    ETA2[25]=6.350
    ETA2[26]=4.255
    ETA2[27]=4.154
    ETA2[28]=4.211
    ETA2[29]=4.287
    ETA2[30]=4.104
    ETA2[31]=4.007
    ETA2[32]=4.261
    ETA2[33]=4.150
    ETA2[34]=4.040
    ETA2[35]=4.155
    ETA2[36]=5.086
    ETA2[37]=5.021
    ETA2[38]=5.040
    ETA2[39]=5.247
    ETA2[40]=5.125
    ETA2[41]=5.136
    ETA2[42]=4.949
    ETA2[43]=5.253
    ETA2[44]=5.154
    ETA2[45]=5.227
    ETA2[46]=5.120
    ETA2[47]=5.291
    ETA2[48]=5.294
    ETA2[49]=5.304
    ETA2[50]=5.209
    ETA2[51]=5.384
    ETA2[52]=5.490
    ETA2[53]=5.563
    ETA2[54]=5.532
    ETA2[55]=5.372
    ETA2[56]=5.423
    ETA2[57]=7.237
    ETA2[58]=6.944
    ETA2[59]=6.957
    ETA2[60]=7.138
    ETA2[61]=7.009
    ETA2[62]=7.074
    ETA2[63]=7.046

    Y[1]=  9.3636
    Y[2]=  9.3512
    Y[3]=  9.4891
    Y[4]=  9.1888
    Y[5]=  9.3161
    Y[6]=  9.2585
    Y[7]=  9.2913
    Y[8]=  9.3914
    Y[9]=  9.4524
    Y[10]= 9.4995
    Y[11]= 9.4179
    Y[12]= 9.468
    Y[13]= 9.4799
    Y[14]= 11.2917
    Y[15]= 11.5062
    Y[16]= 11.4579
    Y[17]= 11.3977
    Y[18]= 11.3688
    Y[19]= 11.3897
    Y[20]= 11.3104
    Y[21]= 11.3882
    Y[22]= 11.3629
    Y[23]= 11.3149
    Y[24]= 11.2474
    Y[25]= 11.2507
    Y[26]= 8.1678
    Y[27]= 8.1017
    Y[28]= 8.3506
    Y[29]= 8.3651
    Y[30]= 8.2994
    Y[31]= 8.1514
    Y[32]= 8.2229
    Y[33]= 8.1027
    Y[34]= 8.3785
    Y[35]= 8.4118
    Y[36]= 8.0955
    Y[37]= 8.0613
    Y[38]= 8.0979
    Y[39]= 8.1364
    Y[40]= 8.1700
    Y[41]= 8.1684
    Y[42]= 8.0885
    Y[43]= 8.1839
    Y[44]= 8.1478
    Y[45]= 8.1827
    Y[46]= 8.029
    Y[47]= 8.1000
    Y[48]= 8.2579
    Y[49]= 8.2248
    Y[50]= 8.2540
    Y[51]= 6.8518
    Y[52]= 6.8547
    Y[53]= 6.8831
    Y[54]= 6.9137
    Y[55]= 6.8984
    Y[56]= 6.8888
    Y[57]= 8.5189
    Y[58]= 8.5308
    Y[59]= 8.5184
    Y[60]= 8.5222
    Y[61]= 8.5705
    Y[62]= 8.5353
    Y[63]= 8.5213
    Y[64]= 8.3158
    Y[65]= 8.1995
    Y[66]= 8.2283
    Y[67]= 8.1857
    Y[68]= 8.2738
    Y[69]= 8.2131
    Y[70]= 8.2613
    Y[71]= 8.2315
    Y[72]= 8.2078
    Y[73]= 8.2996
    Y[74]= 8.3026
    Y[75]= 8.0995
    Y[76]= 8.2990
    Y[77]= 9.6753
    Y[78]= 9.6687
    Y[79]= 9.5704
    Y[80]= 9.5435
    Y[81]= 9.6780
    Y[82]= 9.7668
    Y[83]= 9.7827
    Y[84]= 9.7844
    Y[85]= 9.7011
    Y[86]= 9.8006
    Y[87]= 9.7610
    Y[88]= 9.7813
    Y[89]= 7.3073
    Y[90]= 7.2572
    Y[91]= 7.4686
    Y[92]= 7.3659
    Y[93]= 7.3587
    Y[94]= 7.3132
    Y[95]= 7.3542
    Y[96]= 7.2339
    Y[97]= 7.4375
    Y[98]= 7.4022
    Y[99]= 10.7914
    Y[100]=10.6554
    Y[101]=10.7359
    Y[102]=10.7583
    Y[103]=10.7735
    Y[104]=10.7907
    Y[105]=10.6465
    Y[106]=10.6994
    Y[107]=10.7756
    Y[108]=10.7402
    Y[109]=10.6800
    Y[110]=10.7000
    Y[111]=10.8160
    Y[112]=10.6921
    Y[113]=10.8677
    Y[114]=12.3495
    Y[115]=12.4424
    Y[116]=12.4303
    Y[117]=12.5086
    Y[118]=12.4513
    Y[119]=12.4625
    Y[120]=16.2290
    Y[121]=16.2781
    Y[122]=16.2082
    Y[123]=16.2715
    Y[124]=16.2464
    Y[125]=16.1626
    Y[126]=16.1568
    M4=convert(Int64,M/4)
    M2=convert(Int64,M/2)
    for ind = 1:(M4)
        i=convert(Int64,ind)
        term1 = x[1]+ETA1[i]*x[2]+ETA2[i]*x[3]+ETA2[i]*ETA1[i]*x[4]-Y[i]
        term11 = term1+x[2]*x[i+8]+x[3]*x[i+M4+8]+ETA2[i]*x[4]*x[i+8]+ETA1[i]*x[4]*x[i+M4+8]+x[4]*x[i+8]*x[i+M4+8]
        term2 = x[5]+ETA1[i]*x[6]+ETA2[i]*x[7]+ETA2[i]*ETA1[i]*x[8]-Y[i+M4]
        term22 = term2+x[6]*x[i+8]+x[7]*x[i+M4+8]+ETA2[i]*x[8]*x[i+8]+ETA1[i]*x[8]*x[i+M4+8]+x[8]*x[i+8]*x[i+M4+8]
        term3 = SCALE1*x[i+8]
        term4 = SCALE2*x[i+M4+8]
        sum=sum+term11^2+term22^2+term3^3+term4^2
    end
    return sum #, grad
end

A["ERRINRSM"]=function errinrsm(x::AbstractVector)
    println("Julia port of CUTEST's ERRINRSM")
    grad = zeros(size(x))
    N=50
    sum=0
    for i = 2:N
        coeff = 16*(sin(i)+1.5)^2
        term1 = x[i-1]-coeff*x[i]^2
        term2 = x[i]-1
        sum=sum+term1^2+term2^2
    end
    return sum #, grad
end

A["DEVGLA2"]=function devgla2(x::AbstractVector)
    println("Julia port of CUTEST's DEVGLA2")
    grad = zeros(size(x))
    N=5
    M=16
    sum=0
    for i = 1:M
        T = 0.1*(i-1)
        LNA=log(1.27)
        AT = exp(T*LNA)
        TP=T*3.012
        TP2=T*2.13
        STP2=sin(TP2)
        TPA=TP+STP2
        HPTA=tanh(TPA)
        EC=exp(0.507)
        ECT=EC*T
        CECT=cos(ECT)
        P=AT*HPTA
        PP=P*CECT
        Y=PP*53.81
        term1 = -Y+(x[1] * x[2]^T * tanh(x[3]*T+sin(x[4]*T)) * cos(T*exp(x[5])))
        sum=sum+term1^2
    end
    return sum #, grad
end

A["WATSON"]=function watson(x::AbstractVector)
    println("Julia port of CUTEST's WATSON")
    grad = zeros(size(x))
    N=12
    M=31
    sum=0
    for i = 1:29
        CE=zeros(12)
        LNTI=log(i/29)
        sum1=0
        CE[1]=exp(LNTI*(1-1))
        for j = 2:N
            CE[j]=exp(LNTI*(j-1))
            AE=(j-2)*LNTI
            C0 = exp(AE)
            C=C0*(j-1)
            term1 = C*x[j]
            sum1 = sum1 + term1
        end
        U = CE[1] * x[1] + CE[2] * x[2] + CE[3] *x[3] + CE[4] *x[4]+ CE[5] *x[5] + CE[6] *x[6] + CE[7] *x[7] + CE[8] *x[8]+ CE[9] *x[9] + CE[10] *x[10] + CE[11] *x[11]+ CE[12] *x[12]
        sum1 = sum1-U*U
        sum1=sum1-1
        sum=sum+sum1^2
    end
    term1 = x[1]
    term2 = x[2]-1-x[1]^2
    sum=sum+ term1^2+term2^2
    return sum #, grad
end

A["HILBERTA"]=function hilberta(x::AbstractVector)
    println("Julia port of CUTEST's HILBERTA")
    grad = zeros(size(x))
    N=2
    D=0
    sum=0
    for i = 1:N
        for j = 1:(i-1)
            term1 = (1/(i+j-1))*x[i]*x[j]
            sum = sum + term1
        end
        term = 0.5/(2*i-1)*x[i]^2
        sum=sum+term
    end
    return sum #, grad
end

A["HILBERTB"]=function hilbertb(x::AbstractVector)
    println("Julia port of CUTEST's HILBERTB")
    grad = zeros(size(x))
    N=10
    D=5
    sum=0
    for i = 1:N
        for j = 1:(i-1)
            term1 = (1/(i+j-1))*x[i]*x[j]
            sum = sum + term1
        end
        term = (0.5/(2*i-1)+D)*x[i]^2
        sum=sum+term
    end
    return sum #, grad
end

A["YATP1LS"]=function yatp1ls(x::AbstractVector)
    println("Julia port of CUTEST's YATP1LS")
    grad = zeros(size(x))
    N=350
    A=10
    sum=0
    a=x
    x=zeros(N,N)
    for i = 1:N
        x[i,1:N] = a[1+(i-1)*N:N*i]
    end
    y=zeros(N)
    z=zeros(N)
    y=a[(N*N+1):2:length(a)]
    z=a[(N*N+2):2:length(a)]
    for i = 1:N
        term1 = -1
        term2 = -1
        for j = 1:N
            term3 = x[i,j]^3-A*x[i,j]^2-x[i,j]*(y[i]+z[i])*cos(x[i,j])+sin(x[i,j])*(y[i]+z[i])
            term1 = term1+sin(x[i,j])/x[i,j]
            term2 = term2+sin(x[i,j])/x[i,j]
            sum = sum + term3^2
        end
        sum=sum+term1^2+term2^2
    end
    return sum #, grad
end

A["YATP2CLS"]=function yatp2cls(x::AbstractVector)
    println("Julia port of CUTEST's YATP2CLS")
    grad = zeros(size(x))
    N=350
    A=1
    sum=0
    a=x
    x=zeros(N,N)
    for i = 1:N
        x[i,1:N] = a[1+(i-1)*N:N*i]
    end
    y=zeros(N)
    z=zeros(N)
    y=a[(N*N+1):2:length(a)]
    z=a[(N*N+2):2:length(a)]
    for i = 1:N
        term1 = -1
        term2 = -1
        term3=0
        for j = 1:N
            term3 = x[i,j]-y[i]-z[j]-A-(y[i]+z[i])*cos(x[i,j])
            term1=term1+x[i,j]
            term2=term2+x[i,j]
            term1 = term1+sin(x[i,j])
            term2 = term2+sin(x[i,j])
            sum = sum + term3^2
        end
        sum=sum+term1^2+term2^2
    end
    return sum #, grad
end

A["YATP2LS"]=function yatp2ls(x::AbstractVector)
    println("Julia port of CUTEST's YATP2LS")
    grad = zeros(size(x))
    N=350
    A=1
    sum=0
    a=x
    x=zeros(N,N)
    for i = 1:N
        x[i,1:N] = a[1+(i-1)*N:N*i]
    end
    y=zeros(N)
    z=zeros(N)
    y=a[(N*N+1):2:length(a)]
    z=a[(N*N+2):2:length(a)]
    for i = 1:N
        term1 = -1
        term2 = -1
        term3=0
        for j = 1:N
            term3 = x[i,j]-y[i]-z[j]-A-(y[i]+z[i])*cos(x[i,j])
            term1=term1+x[i,j]
            term2=term2+x[i,j]
            term1 = term1+sin(x[i,j])
            term2 = term2+sin(x[i,j])
            sum = sum + term3^2
        end
        sum=sum+term1^2+term2^2
    end
    return sum #, grad
end

A["YATP1CLS"]=function yatp1cls(x::AbstractVector)
    println("Julia port of CUTEST's YATP1CLS")
    grad = zeros(size(x))
    N=350
    A=10
    sum=0
    a=x
    x=zeros(N,N)
    for i = 1:N
        x[i,1:N] = a[1+(i-1)*N:N*i]
    end
    y=zeros(N)
    z=zeros(N)
    y=a[(N*N+1):2:length(a)]
    z=a[(N*N+2):2:length(a)]
    for i = 1:N
        term1 = -1
        term2 = -1
        for j = 1:N
            term3 = x[i,j]^3-A*x[i,j]^2-x[i,j]*(y[i]+z[i])*cos(x[i,j])+sin(x[i,j])*(y[i]+z[i])
            term1 = term1+sin(x[i,j])/x[i,j]
            term2 = term2+sin(x[i,j])/x[i,j]
            sum = sum + term3^2
        end
        sum=sum+term1^2+term2^2
    end
    return sum #, grad
end

#issues
A["COATINGNE"]=function coatingne(x::AbstractVector)
    println("Julia port of CUTEST's COATINGNE")
    grad = zeros(size(x))
    M=252
    N=134
    sum=0
    SCALE1=4.08
    SCALE2=0.417
    ETA1=zeros(63)
    ETA2=zeros(63)
    Y=zeros(126)
    
    ETA1[1]= 0.7140
    ETA1[2]= 0.7169
    ETA1[3]= 0.7232
    ETA1[4]= 0.7151
    ETA1[5]= 0.6848
    ETA1[6]= 0.7070
    ETA1[7]= 0.7177
    ETA1[8]= 0.7073
    ETA1[9]= 0.6734
    ETA1[10]=0.7174
    ETA1[11]=0.7125
    ETA1[12]=0.6947
    ETA1[13]=0.7121
    ETA1[14]=0.7166
    ETA1[15]=0.6894
    ETA1[16]=0.6897
    ETA1[17]=0.7024
    ETA1[18]=0.7026
    ETA1[19]=0.6800
    ETA1[20]=0.6957
    ETA1[21]=0.6987
    ETA1[22]=0.7111
    ETA1[23]=0.7097
    ETA1[24]=0.6809
    ETA1[25]=0.7139
    ETA1[26]=0.7046
    ETA1[27]=0.6950
    ETA1[28]=0.7032
    ETA1[29]=0.7019
    ETA1[30]=0.6975
    ETA1[31]=0.6955
    ETA1[32]=0.7056
    ETA1[33]=0.6965
    ETA1[34]=0.6848
    ETA1[35]=0.6995
    ETA1[36]=0.6105
    ETA1[37]=0.6027
    ETA1[38]=0.6084
    ETA1[39]=0.6081
    ETA1[40]=0.6057
    ETA1[41]=0.6116
    ETA1[42]=0.6052
    ETA1[43]=0.6136
    ETA1[44]=0.6032
    ETA1[45]=0.6081
    ETA1[46]=0.6092
    ETA1[47]=0.6122
    ETA1[48]=0.6157
    ETA1[49]=0.6191
    ETA1[50]=0.6169
    ETA1[51]=0.5483
    ETA1[52]=0.5371
    ETA1[53]=0.5576
    ETA1[54]=0.5521
    ETA1[55]=0.5495
    ETA1[56]=0.5499
    ETA1[57]=0.4937
    ETA1[58]=0.5092
    ETA1[59]=0.5433
    ETA1[60]=0.5018
    ETA1[61]=0.5363
    ETA1[62]=0.4977
    ETA1[63]=0.5296

    ETA2[1]= 5.145
    ETA2[2]= 5.241
    ETA2[3]= 5.389
    ETA2[4]= 5.211
    ETA2[5]= 5.154
    ETA2[6]= 5.105
    ETA2[7]= 5.191
    ETA2[8]= 5.013
    ETA2[9]= 5.582
    ETA2[10]=5.208
    ETA2[11]=5.142
    ETA2[12]=5.284
    ETA2[13]=5.262
    ETA2[14]=6.838
    ETA2[15]=6.215
    ETA2[16]=6.817
    ETA2[17]=6.889
    ETA2[18]=6.732
    ETA2[19]=6.717
    ETA2[20]=6.468
    ETA2[21]=6.776
    ETA2[22]=6.574
    ETA2[23]=6.465
    ETA2[24]=6.090
    ETA2[25]=6.350
    ETA2[26]=4.255
    ETA2[27]=4.154
    ETA2[28]=4.211
    ETA2[29]=4.287
    ETA2[30]=4.104
    ETA2[31]=4.007
    ETA2[32]=4.261
    ETA2[33]=4.150
    ETA2[34]=4.040
    ETA2[35]=4.155
    ETA2[36]=5.086
    ETA2[37]=5.021
    ETA2[38]=5.040
    ETA2[39]=5.247
    ETA2[40]=5.125
    ETA2[41]=5.136
    ETA2[42]=4.949
    ETA2[43]=5.253
    ETA2[44]=5.154
    ETA2[45]=5.227
    ETA2[46]=5.120
    ETA2[47]=5.291
    ETA2[48]=5.294
    ETA2[49]=5.304
    ETA2[50]=5.209
    ETA2[51]=5.384
    ETA2[52]=5.490
    ETA2[53]=5.563
    ETA2[54]=5.532
    ETA2[55]=5.372
    ETA2[56]=5.423
    ETA2[57]=7.237
    ETA2[58]=6.944
    ETA2[59]=6.957
    ETA2[60]=7.138
    ETA2[61]=7.009
    ETA2[62]=7.074
    ETA2[63]=7.046

    Y[1]=  9.3636
    Y[2]=  9.3512
    Y[3]=  9.4891
    Y[4]=  9.1888
    Y[5]=  9.3161
    Y[6]=  9.2585
    Y[7]=  9.2913
    Y[8]=  9.3914
    Y[9]=  9.4524
    Y[10]= 9.4995
    Y[11]= 9.4179
    Y[12]= 9.468
    Y[13]= 9.4799
    Y[14]= 11.2917
    Y[15]= 11.5062
    Y[16]= 11.4579
    Y[17]= 11.3977
    Y[18]= 11.3688
    Y[19]= 11.3897
    Y[20]= 11.3104
    Y[21]= 11.3882
    Y[22]= 11.3629
    Y[23]= 11.3149
    Y[24]= 11.2474
    Y[25]= 11.2507
    Y[26]= 8.1678
    Y[27]= 8.1017
    Y[28]= 8.3506
    Y[29]= 8.3651
    Y[30]= 8.2994
    Y[31]= 8.1514
    Y[32]= 8.2229
    Y[33]= 8.1027
    Y[34]= 8.3785
    Y[35]= 8.4118
    Y[36]= 8.0955
    Y[37]= 8.0613
    Y[38]= 8.0979
    Y[39]= 8.1364
    Y[40]= 8.1700
    Y[41]= 8.1684
    Y[42]= 8.0885
    Y[43]= 8.1839
    Y[44]= 8.1478
    Y[45]= 8.1827
    Y[46]= 8.029
    Y[47]= 8.1000
    Y[48]= 8.2579
    Y[49]= 8.2248
    Y[50]= 8.2540
    Y[51]= 6.8518
    Y[52]= 6.8547
    Y[53]= 6.8831
    Y[54]= 6.9137
    Y[55]= 6.8984
    Y[56]= 6.8888
    Y[57]= 8.5189
    Y[58]= 8.5308
    Y[59]= 8.5184
    Y[60]= 8.5222
    Y[61]= 8.5705
    Y[62]= 8.5353
    Y[63]= 8.5213
    Y[64]= 8.3158
    Y[65]= 8.1995
    Y[66]= 8.2283
    Y[67]= 8.1857
    Y[68]= 8.2738
    Y[69]= 8.2131
    Y[70]= 8.2613
    Y[71]= 8.2315
    Y[72]= 8.2078
    Y[73]= 8.2996
    Y[74]= 8.3026
    Y[75]= 8.0995
    Y[76]= 8.2990
    Y[77]= 9.6753
    Y[78]= 9.6687
    Y[79]= 9.5704
    Y[80]= 9.5435
    Y[81]= 9.6780
    Y[82]= 9.7668
    Y[83]= 9.7827
    Y[84]= 9.7844
    Y[85]= 9.7011
    Y[86]= 9.8006
    Y[87]= 9.7610
    Y[88]= 9.7813
    Y[89]= 7.3073
    Y[90]= 7.2572
    Y[91]= 7.4686
    Y[92]= 7.3659
    Y[93]= 7.3587
    Y[94]= 7.3132
    Y[95]= 7.3542
    Y[96]= 7.2339
    Y[97]= 7.4375
    Y[98]= 7.4022
    Y[99]= 10.7914
    Y[100]=10.6554
    Y[101]=10.7359
    Y[102]=10.7583
    Y[103]=10.7735
    Y[104]=10.7907
    Y[105]=10.6465
    Y[106]=10.6994
    Y[107]=10.7756
    Y[108]=10.7402
    Y[109]=10.6800
    Y[110]=10.7000
    Y[111]=10.8160
    Y[112]=10.6921
    Y[113]=10.8677
    Y[114]=12.3495
    Y[115]=12.4424
    Y[116]=12.4303
    Y[117]=12.5086
    Y[118]=12.4513
    Y[119]=12.4625
    Y[120]=16.2290
    Y[121]=16.2781
    Y[122]=16.2082
    Y[123]=16.2715
    Y[124]=16.2464
    Y[125]=16.1626
    Y[126]=16.1568
    MD2=convert(Int64,M/2)
    F=zeros(M)
    M4=convert(Int64,M/4)
    for ind = 1:(M/4)
        i=convert(Int64,ind)
        F[i] = x[1]+ETA1[i]*x[2]+ETA2[i]*x[3]+ETA2[i]*ETA1[i]*x[4]
        F[i+M4] = x[5]+ETA1[i]*x[6]+ETA2[i]*x[7]+ETA2[i]*ETA1[i]*x[8]
        F[i+MD2] = SCALE1*x[i+8]
        F[i+3*M4] = SCALE2*x[i+M4+8]
    end
    for i = 1:MD2
        F[i]=F[i]-Y[i]
    end
    for i=1:M4
        F[i]= F[i]+x[2]*x[i+8]+x[3]*x[i+M4+8]+ETA2[i]*x[4]*x[i+8]+ETA1[i]*x[4]*x[i+M4+8]+x[4]*x[i+8]*x[i+M4+8]
        F[i+M4]= F[i]+x[6]*x[i+8]+x[7]*x[i+M4+8]+ETA2[i]*x[8]*x[i+8]+ETA1[i]*x[8]*x[i+M4+8]+x[8]*x[i+8]*x[i+M4+8]
    end
    sum=0
    for i=1:M
        sum=sum+F[i]
    end
    return sum #, grad
end

A["YFITU"]=function yfitu(x::AbstractVector)
    println("Julia port of CUTEST's YFITU")
    grad = zeros(size(x))
    p=16
    y=zeros(p+1)
    sum=0
    y[1]=21.158931
    y[2]=17.591719
    y[3]=14.046854
    y[4]=10.519732
    y[5]=7.0058392
    y[6]=3.5007293
    y[7]=0.0000000
    y[8]=-3.5007293
    y[9]=-7.0058392
    y[10]=-10.519732
    y[11]=-14.046854
    y[12]=-17.591719
    y[13]=-21.158931
    y[14]=-24.753206
    y[15]=-28.379405
    y[16]=-32.042552
    y[17]=-35.747869
    for i = 1:(p+1)
        term1 = -y[i]+x[3]*tan(x[1]*(1-i/p)+x[2]*i/p)
        sum=sum+term1^2
    end
    return sum #, grad
end

A["NELSONLS"]=function nelsonls(x::AbstractVector)
    println("Julia port of CUTEST's NELSONLS")
    grad = zeros(size(x))
    M=128
    Y=zeros(128)
    X1=zeros(128)
    X2=zeros(128)
    X1[1]=1.0 
    X1[2]=1.0 
    X1[3]=1.0 
    X1[4]=1.0 
    X1[5]=1.0 
    X1[6]=1.0 
    X1[7]=1.0 
    X1[8]=1.0 
    X1[9]=1.0 
    X1[10]=1.0 
    X1[11]=1.0 
    X1[12]=1.0 
    X1[13]=1.0 
    X1[14]=1.0 
    X1[15]=1.0 
    X1[16]=1.0 
    X1[17]=2.0 
    X1[18]=2.0 
    X1[19]=2.0 
    X1[20]=2.0 
    X1[21]=2.0 
    X1[22]=2.0 
    X1[23]=2.0 
    X1[24]=2.0 
    X1[25]=2.0 
    X1[26]=2.0 
    X1[27]=2.0 
    X1[28]=2.0 
    X1[29]=2.0 
    X1[30]=2.0 
    X1[31]=2.0 
    X1[32]=2.0 
    X1[33]=4.0 
    X1[34]=4.0 
    X1[35]=4.0 
    X1[36]=4.0 
    X1[37]=4.0 
    X1[38]=4.0 
    X1[39]=4.0 
    X1[40]=4.0 
    X1[41]=4.0 
    X1[42]=4.0 
    X1[43]=4.0 
    X1[44]=4.0 
    X1[45]=4.0 
    X1[46]=4.0 
    X1[47]=4.0 
    X1[48]=4.0 
    X1[49]=8.0 
    X1[50]=8.0 
    X1[51]=8.0 
    X1[52]=8.0 
    X1[53]=8.0 
    X1[54]=8.0 
    X1[55]=8.0 
    X1[56]=8.0 
    X1[57]=8.0 
    X1[58]=8.0 
    X1[59]=8.0 
    X1[60]=8.0 
    X1[61]=8.0 
    X1[62]=8.0 
    X1[63]=8.0 
    X1[64]=8.0 
    X1[65]=16.0
    X1[66]=16.0
    X1[67]=16.0
    X1[68]=16.0
    X1[69]=16.0
    X1[70]=16.0
    X1[71]=16.0
    X1[72]=16.0
    X1[73]=16.0
    X1[74]=16.0
    X1[75]=16.0
    X1[76]=16.0
    X1[77]=16.0
    X1[78]=16.0
    X1[79]=16.0
    X1[80]=16.0
    X1[81]=32.0
    X1[82]=32.0
    X1[83]=32.0
    X1[84]=32.0
    X1[85]=32.0
    X1[86]=32.0
    X1[87]=32.0
    X1[88]=32.0
    X1[89]=32.0
    X1[90]=32.0
    X1[91]=32.0
    X1[92]=32.0
    X1[93]=32.0
    X1[94]=32.0
    X1[95]=32.0
    X1[96]=32.0
    X1[97]=48.0
    X1[98]=48.0
    X1[99]=48.0
    X1[100]=48.0
    X1[101]=48.0
    X1[102]=48.0
    X1[103]=48.0
    X1[104]=48.0
    X1[105]=48.0
    X1[106]=48.0
    X1[107]=48.0
    X1[108]=48.0
    X1[109]=48.0
    X1[110]=48.0
    X1[111]=48.0
    X1[112]=48.0
    X1[113]=64.0
    X1[114]=64.0
    X1[115]=64.0
    X1[116]=64.0
    X1[117]=64.0
    X1[118]=64.0
    X1[119]=64.0
    X1[120]=64.0
    X1[121]=64.0
    X1[122]=64.0
    X1[123]=64.0
    X1[124]=64.0
    X1[125]=64.0
    X1[126]=64.0
    X1[127]=64.0
    X1[128]=64.0

    X2[1]=180.0
    X2[2]=180.0
    X2[3]=180.0
    X2[4]=180.0
    X2[5]=225.0
    X2[6]=225.0
    X2[7]=225.0
    X2[8]=225.0
    X2[9]=250.0
    X2[10]=250.0
    X2[11]=250.0
    X2[12]=250.0
    X2[13]=275.0
    X2[14]=275.0
    X2[15]=275.0
    X2[16]=275.0
    X2[17]=180.0
    X2[18]=180.0
    X2[19]=180.0
    X2[20]=180.0
    X2[21]=225.0
    X2[22]=225.0
    X2[23]=225.0
    X2[24]=225.0
    X2[25]=250.0
    X2[26]=250.0
    X2[27]=250.0
    X2[28]=250.0
    X2[29]=275.0
    X2[30]=275.0
    X2[31]=275.0
    X2[32]=275.0
    X2[33]=180.0
    X2[34]=180.0
    X2[35]=180.0
    X2[36]=180.0
    X2[37]=225.0
    X2[38]=225.0
    X2[39]=225.0
    X2[40]=225.0
    X2[41]=250.0
    X2[42]=250.0
    X2[43]=250.0
    X2[44]=250.0
    X2[45]=275.0
    X2[46]=275.0
    X2[47]=275.0
    X2[48]=275.0
    X2[49]=180.0
    X2[50]=180.0
    X2[51]=180.0
    X2[52]=180.0
    X2[53]=225.0
    X2[54]=225.0
    X2[55]=225.0
    X2[56]=225.0
    X2[57]=250.0
    X2[58]=250.0
    X2[59]=250.0
    X2[60]=250.0
    X2[61]=275.0
    X2[62]=275.0
    X2[63]=275.0
    X2[64]=275.0
    X2[65]=180.0
    X2[66]=180.0
    X2[67]=180.0
    X2[68]=180.0
    X2[69]=225.0
    X2[70]=225.0
    X2[71]=225.0
    X2[72]=225.0
    X2[73]=250.0
    X2[74]=250.0
    X2[75]=250.0
    X2[76]=250.0
    X2[77]=275.0
    X2[78]=275.0
    X2[79]=275.0
    X2[80]=275.0
    X2[81]=180.0
    X2[82]=180.0
    X2[83]=180.0
    X2[84]=180.0
    X2[85]=225.0
    X2[86]=225.0
    X2[87]=225.0
    X2[88]=225.0
    X2[89]=250.0
    X2[90]=250.0
    X2[91]=250.0
    X2[92]=250.0
    X2[93]=275.0
    X2[94]=275.0
    X2[95]=275.0
    X2[96]=275.0
    X2[97]=180.0
    X2[98]=180.0
    X2[99]=180.0
    X2[100]=180.0
    X2[101]=225.0
    X2[102]=225.0
    X2[103]=225.0
    X2[104]=225.0
    X2[105]=250.0
    X2[106]=250.0
    X2[107]=250.0
    X2[108]=250.0
    X2[109]=275.0
    X2[110]=275.0
    X2[111]=275.0
    X2[112]=275.0
    X2[113]=180.0
    X2[114]=180.0
    X2[115]=180.0
    X2[116]=180.0
    X2[117]=225.0
    X2[118]=225.0
    X2[119]=225.0
    X2[120]=225.0
    X2[121]=250.0
    X2[122]=250.0
    X2[123]=250.0
    X2[124]=250.0
    X2[125]=275.0
    X2[126]=275.0
    X2[127]=275.0
    X2[128]=275.0

    Y[1]= 15.00
    Y[2]= 17.00
    Y[3]= 15.50
    Y[4]= 16.50
    Y[5]= 15.50
    Y[6]= 15.00
    Y[7]= 16.00
    Y[8]= 14.50
    Y[9]= 15.00
    Y[10]=14.50
    Y[11]=12.50
    Y[12]=11.00
    Y[13]=14.00
    Y[14]=13.00
    Y[15]=14.00
    Y[16]=11.50
    Y[17]=14.00
    Y[18]=16.00
    Y[19]=13.00
    Y[20]=13.50
    Y[21]=13.00
    Y[22]=13.50
    Y[23]=12.50
    Y[24]=12.50
    Y[25]=12.50
    Y[26]=12.00
    Y[27]=11.50
    Y[28]=12.00
    Y[29]=13.00
    Y[30]=11.50
    Y[31]=13.00
    Y[32]=12.50
    Y[33]=13.50
    Y[34]=17.50
    Y[35]=17.50
    Y[36]=13.50
    Y[37]=12.50
    Y[38]=12.50
    Y[39]=15.00
    Y[40]=13.00
    Y[41]=12.00
    Y[42]=13.00
    Y[43]=12.00
    Y[44]=13.50
    Y[45]=10.00
    Y[46]=11.50
    Y[47]=11.00
    Y[48]= 9.50
    Y[49]=15.00
    Y[50]=15.00
    Y[51]=15.50
    Y[52]=16.00
    Y[53]=13.00
    Y[54]=10.50
    Y[55]=13.50
    Y[56]=14.00
    Y[57]=12.50
    Y[58]=12.00
    Y[59]=11.50
    Y[60]=11.50
    Y[61]= 6.50
    Y[62]= 5.50
    Y[63]= 6.00
    Y[64]= 6.00
    Y[65]=18.50
    Y[66]=17.00
    Y[67]=15.30
    Y[68]=16.00
    Y[69]=13.00
    Y[70]=14.00
    Y[71]=12.50
    Y[72]=11.00
    Y[73]=12.00
    Y[74]=12.00
    Y[75]=11.50
    Y[76]=12.00
    Y[77]= 6.00
    Y[78]= 6.00
    Y[79]= 5.00
    Y[80]= 5.50
    Y[81]=12.50
    Y[82]=13.00
    Y[83]=16.00
    Y[84]=12.00
    Y[85]=11.00
    Y[86]= 9.50
    Y[87]=11.00
    Y[88]=11.00
    Y[89]=11.00
    Y[90]=10.00
    Y[91]=10.50
    Y[92]=10.50
    Y[93]= 2.70
    Y[94]= 2.70
    Y[95]= 2.50
    Y[96]= 2.40
    Y[97]=13.00
    Y[98]=13.50
    Y[99]=16.50
    Y[100]=13.60
    Y[101]=11.50
    Y[102]=10.50
    Y[103]=13.50
    Y[104]=12.00
    Y[105]=7.00
    Y[106]=6.90
    Y[107]=8.80
    Y[108]=7.90
    Y[109]=1.20
    Y[110]=1.50
    Y[111]=1.00
    Y[112]=1.50
    Y[113]=13.00
    Y[114]=12.50
    Y[115]=16.50
    Y[116]=16.00
    Y[117]=11.00
    Y[118]=11.50
    Y[119]=10.50
    Y[120]=10.00
    Y[121]=7.27
    Y[122]=7.50
    Y[123]=6.70
    Y[124]=7.60
    Y[125]=1.50
    Y[126]=1.00
    Y[127]=1.20
    Y[128]=1.20
    sum=0
    for i = 1:M
        term1 = x[1]-log(Y[i])-x[2]*X1[i]*exp(-x[3]*X2[i])
        sum=sum+term1^2
    end
    return sum #, grad
end

A["NONCVXU2"]=function noncvxu2(x::AbstractVector)
    println("Julia port of CUTEST's NONCVXU2")
    grad = zeros(size(x))
    N=5000
    sum=0
    for i = 1:N
        term1 = (x[i]+2*x[1])^2
        term2 = 4*cos(x[i]+2*x[1])
        sum=sum+term1+term2
    end
    return sum #, grad
end

A["BROYDN7D"]=function broydn7d(x::AbstractVector)
    println("Julia port of CUTEST's BROYDN7D")
    grad = zeros(size(x))
    N=5000
    sum=0
    term1 = -2*x[2]+1+(-2*x[1]+3)*x[1]
    sum=sum+abs(term1)^(7/3)
    for i = 2:(N-1)
        term2 = -x[i-1]-2*x[i+1]+1+(-2*x[i]+3)*x[i]
        sum=sum+abs(term2)^(7/3)
    end
    term3 = -x[N-1]+1+(-2*x[N]+3)*x[N]
    sum=sum+abs(term3)^(7/3)
    ND2=convert(Int64,N/2)
    for i = 1:(ND2)
        term4 = x[i]+x[i+ND2]
        sum=sum+abs(term4)^(7/3)
    end
    return sum #, grad
end

A["BROYDN3DLS"]=function broydn3dls(x::AbstractVector)
    println("Julia port of CUTEST's BROYDN3DLS")
    grad = zeros(size(x))
    N=5000
    K1=2
    K2=1
    sum=0
    term1 = -2*x[2]+1+(-2*x[1]+3)*x[1]
    sum=sum+(term1)^2
    for i = 2:(N-1)
        term2 = -x[i-1]-2*x[i+1]+1+(-2*x[i]+3)*x[i]
        sum=sum+(term2)^2
    end
    term3 = -x[N-1]+1+(-2*x[N]+3)*x[N]
    sum=sum+(term3)^2
    return sum #, grad
end

A["BROYDNBDLS"]=function broydnbdls(x::AbstractVector)
    println("Julia port of CUTEST's BROYDNBDLS")
    grad = zeros(size(x))
    N=5000
    K1=2
    K2=5
    K3=1
    LB=5
    UB=1
    sum=0
    for i = 1:LB
        sum1=K1*x[i]+K2*x[i]^3
        for j = 1:(i-1)
            term1 = -K3*x[j]+-K3*x[j]^2
            sum1=sum1+term1
        end
        for j = (i+1):(i+UB)
            term1 = -K3*x[j]+-K3*x[j]^2
            sum1=sum1+term1
        end
        sum=sum+sum1^2
    end
    for i = (LB+1):(N-UB-1)
        sum1=K1*x[i]+K2*x[i]^2
        for j = (i-LB):(i-1)
            term1 = -K3*x[j]+-K3*x[j]^3
            sum1=sum1+term1
        end
        for j = (i+1):(i+UB)
            term1 = -K3*x[j]+-K3*x[j]^2
            sum1=sum1+term1
        end
        sum=sum+sum1^2
    end
    for i = (N-UB):N
        sum1=K1*x[i]+K2*x[i]^3
        for j = (i-LB):(i-1)
            term1 = -K3*x[j]+-K3*x[j]^2
            sum1=sum1+term1
        end
        for j = (i+1):N
            term1 = -K3*x[j]+-K3*x[j]^2
            sum1=sum1+term1
        end
        sum=sum+sum1^2
    end
    return sum #, grad
end

A["NONMSQRT"]=function nonmsqrt(x::AbstractVector)
    println("Julia port of CUTEST's NONMSQRT")
    grad = zeros(size(x))
    P=70
    N=P^2
    K=0
    sum=0
    a=x
    x=zeros(P,P)
    for i = 1:P
        x[i,1:P] = a[1+(i-1)*P:P*i]
    end
    B=zeros(P,P)
    k=0
    for i=1:P
        for j=1:P
            k=k+1
            B[i,j]=sin(k^2)
        end
    end
    B[3,1]=0
    A=zeros(P,P)
    for i =1:P
        for j=1:P
            for t =1:P
                A[i,j] = A[i,j]+B[i,t]*B[t,j]
            end
        end
    end
    for i =1:P
        for j=1:P
            term1 = -A[i,j]
            for k =1:P
                term1 = term1+x[i,k]*x[i,j]
            end
            sum=sum+term1^2
        end
    end
    return sum #, grad
end

A["MANCINO"]=function mancino(x::AbstractVector)
    println("Julia port of CUTEST's MANCINO")
    grad = zeros(size(x))
    N=100
    sum=0
    a=5
    b=14
    g=3
    BETAN=b*N
    BETAN2=b^2*N^2
    A=-1/(-(a+1)^2*(N-1)^2+BETAN2)*b*N
    for i =1:N
        term1 = BETAN*x[i]
        coeff=1
        for j =1:g
            coeff=coeff*(i-N/2)
        end
        term1=term1-coeff
        for j =1:(i-1)
            VIJ = sqrt(x[i]^2+i/j)
            SUMAL = sin(log(VIJ))^a+cos(log(VIJ))^a
            term1 = term1+VIJ*SUMAL
        end
        for j =(i+1):N
            VIJ = sqrt(x[i]^2+i/j)
            SUMAL = sin(log(VIJ))^a+cos(log(VIJ))^a
            term1 = term1+VIJ*SUMAL
        end
        sum = sum+term1^2
    end
    return sum #, grad
end

A["BRYBND"]=function brybnd(x::AbstractVector)
    println("Julia port of CUTEST's BRYBND")
    grad = zeros(size(x))
    N=5000
    K1=2
    K2=5
    K3=1
    LB=5
    UB=1
    sum=0
    for i = 1:LB
        sum1=K1*x[i]+K2*x[i]^3
        for j = 1:(i-1)
            term1 = -K3*x[j]+-K3*x[j]^2
            sum1=sum1+term1
        end
        for j = (i+1):(i+UB)
            term1 = -K3*x[j]+-K3*x[j]^2
            sum1=sum1+term1
        end
        sum=sum+sum1^2
    end
    for i = (LB+1):(N-UB-1)
        sum1=K1*x[i]+K2*x[i]^2
        for j = (i-LB):(i-1)
            term1 = -K3*x[j]+-K3*x[j]^3
            sum1=sum1+term1
        end
        for j = (i+1):(i+UB)
            term1 = -K3*x[j]+-K3*x[j]^2
            sum1=sum1+term1
        end
        sum=sum+sum1^2
    end
    for i = (N-UB):N
        sum1=K1*x[i]+K2*x[i]^3
        for j = (i-LB):(i-1)
            term1 = -K3*x[j]+-K3*x[j]^2
            sum1=sum1+term1
        end
        for j = (i+1):N
            term1 = -K3*x[j]+-K3*x[j]^2
            sum1=sum1+term1
        end
        sum=sum+sum1^2
    end
    return sum #, grad
end

A["SSBRYBND"]=function ssbrybnd(x::AbstractVector)
    println("Julia port of CUTEST's SSBRYBND")
    grad = zeros(size(x))
    N=5000
    K1=2
    K2=5
    K3=1
    SCAL=6
    LB=5
    UB=1
    sum=0
    for i = 1:LB
        coeff = exp(6*(i-1)/(N-1))
        sum1=K1*coeff*x[i]+K1*coeff^3*x[i]^3
        for j = 1:(i-1)
            coeff = exp(6*(j-1)/(N-1))
            term1 = -K3*coeff*x[j]-K3*coeff^2*x[j]^2
            sum1=sum1+term1
        end
        for j = (i+1):(i+UB)
            coeff = exp(6*(j-1)/(N-1))
            term1 = -K3*coeff*x[j]+-K3*coeff^2*x[j]^2
            sum1=sum1+term1
        end
        sum=sum+sum1^2
    end
    for i = (LB+1):(N-UB-1)
        coeff = exp(6*(i-1)/(N-1))
        sum1=K1*coeff*x[i]+K2*coeff^2*x[i]^2
        for j = (i-LB):(i-1)
            coeff = exp(6*(j-1)/(N-1))
            term1 = -K3*coeff*x[j]+-K3*coeff^3*x[j]^3
            sum1=sum1+term1
        end
        for j = (i+1):(i+UB)
            coeff = exp(6*(j-1)/(N-1))
            term1 = -K3*coeff*x[j]+-K3*coeff^2*x[j]^2
            sum1=sum1+term1
        end
        sum=sum+sum1^2
    end
    for i = (N-UB):N
        coeff = exp(6*(i-1)/(N-1))
        sum1=K1*coeff*x[i]+K2*coeff^3*x[i]^3
        for j = (i-LB):(i-1)
            coeff = exp(6*(j-1)/(N-1))
            term1 = -K3*coeff*x[j]+-K3*coeff^2*x[j]^2
            sum1=sum1+term1
        end
        for j = (i+1):N
            coeff = exp(6*(j-1)/(N-1))
            term1 = -K3*coeff*x[j]+-K3*coeff^2*x[j]^2
            sum1=sum1+term1
        end
        sum=sum+sum1^2
    end
    return sum #, grad
end

A["CERI651ELS"]=function ceri651els(x::AbstractVector)
    println("Julia port of CUTEST's CERI651ELS")
    grad = zeros(size(x))
    MPOT=10186
    M=64
    ML=4077
    MU=4140
    N=7
    X=zeros(MU)
    Y=zeros(MU)
    E=zeros(MU)
    
    X[4077]=13558.04688
    X[4078]=13560.76563
    X[4079]=13563.48438
    X[4080]=13566.20313
    X[4081]=13568.92188
    X[4082]=13571.64063
    X[4083]=13574.35938
    X[4084]=13577.07813
    X[4085]=13579.79688
    X[4086]=13582.51563
    X[4087]=13585.23438
    X[4088]=13587.95313
    X[4089]=13590.67188
    X[4090]=13593.39063
    X[4091]=13596.10938
    X[4092]=13598.82813
    X[4093]=13601.54688
    X[4094]=13604.26563
    X[4095]=13606.98438
    X[4096]=13609.70313
    X[4097]=13612.42188
    X[4098]=13615.14063
    X[4099]=13617.85938
    X[4100]=13620.57813
    X[4101]=13623.29688
    X[4102]=13626.01563
    X[4103]=13628.73438
    X[4104]=13631.45313
    X[4105]=13634.17188
    X[4106]=13636.89063
    X[4107]=13639.60938
    X[4108]=13642.32813
    X[4109]=13645.04688
    X[4110]=13647.76563
    X[4111]=13650.48438
    X[4112]=13653.20313
    X[4113]=13655.92188
    X[4114]=13658.64063
    X[4115]=13661.35938
    X[4116]=13664.07813
    X[4117]=13666.79688
    X[4118]=13669.51563
    X[4119]=13672.23438
    X[4120]=13674.96875
    X[4121]=13677.71875
    X[4122]=13680.46875
    X[4123]=13683.21875
    X[4124]=13685.96875
    X[4125]=13688.71875
    X[4126]=13691.46875
    X[4127]=13694.21875
    X[4128]=13696.96875
    X[4129]=13699.71875
    X[4130]=13702.46875
    X[4131]=13705.21875
    X[4132]=13707.96875
    X[4133]=13710.71875
    X[4134]=13713.46875
    X[4135]=13716.21875
    X[4136]=13718.96875
    X[4137]=13721.71875
    X[4138]=13724.46875
    X[4139]=13727.21875
    X[4140]=13729.96875

    Y[4077]=  0.00000000
    Y[4078]=  1.96083316
    Y[4079]=  0.98041658
    Y[4080]=  0.00000000
    Y[4081]=  0.00000000
    Y[4082]=  0.00000000
    Y[4083]=  0.00000000
    Y[4084]=  0.00000000
    Y[4085]=  0.00000000
    Y[4086]=  0.00000000
    Y[4087]=  0.00000000
    Y[4088]=  0.00000000
    Y[4089]=  0.00000000
    Y[4090]=  0.00000000
    Y[4091]=  0.00000000
    Y[4092]=  0.00000000
    Y[4093]=  0.00000000
    Y[4094]=  0.00000000
    Y[4095]=  0.98041658
    Y[4096]=  0.00000000
    Y[4097]=  0.00000000
    Y[4098]=  0.98041658
    Y[4099]=  0.98041658
    Y[4100]=  1.96083316
    Y[4101]=  1.96083316
    Y[4102]=  4.90208290
    Y[4103]=  0.98041658
    Y[4104]=  1.96083316
    Y[4105]=  0.00000000
    Y[4106]=  1.96083316
    Y[4107]=  0.98041658
    Y[4108]=  5.88249948
    Y[4109]=  0.98041658
    Y[4110]=  1.96083316
    Y[4111]=  0.00000000
    Y[4112]=  0.98041658
    Y[4113]=  0.00000000
    Y[4114]=  0.00000000
    Y[4115]=  0.98041658
    Y[4116]=  0.00000000
    Y[4117]=  1.96083316
    Y[4118]=  0.98041658
    Y[4119]=  0.00000000
    Y[4120]=  0.98041658
    Y[4121]=  0.98041658
    Y[4122]=  0.98041658
    Y[4123]=  0.00000000
    Y[4124]=  0.00000000
    Y[4125]=  0.98041658
    Y[4126]=  0.00000000
    Y[4127]=  0.00000000
    Y[4128]=  0.98041658
    Y[4129]=  0.00000000
    Y[4130]=  0.00000000
    Y[4131]=  0.00000000
    Y[4132]=  0.98041658
    Y[4133]=  0.98041658
    Y[4134]=  0.98041658
    Y[4135]=  0.00000000
    Y[4136]=  0.98041658
    Y[4137]=  0.00000000
    Y[4138]=  1.96083316
    Y[4139]=  0.00000000
    Y[4140]=  0.00000000

    E[4077]=1.00000000
    E[4078]=1.41421356
    E[4079]=1.00000000
    E[4080]=1.00000000
    E[4081]=1.00000000
    E[4082]=1.00000000
    E[4083]=1.00000000
    E[4084]=1.00000000
    E[4085]=1.00000000
    E[4086]=1.00000000
    E[4087]=1.00000000
    E[4088]=1.00000000
    E[4089]=1.00000000
    E[4090]=1.00000000
    E[4091]=1.00000000
    E[4092]=1.00000000
    E[4093]=1.00000000
    E[4094]=1.00000000
    E[4095]=1.00000000
    E[4096]=1.00000000
    E[4097]=1.00000000
    E[4098]=1.00000000
    E[4099]=1.00000000
    E[4100]=1.41421356
    E[4101]=1.41421356
    E[4102]=2.23606798
    E[4103]=1.00000000
    E[4104]=1.41421356
    E[4105]=1.00000000
    E[4106]=1.41421356
    E[4107]=1.00000000
    E[4108]=2.44948974
    E[4109]=1.00000000
    E[4110]=1.41421356
    E[4111]=1.00000000
    E[4112]=1.00000000
    E[4113]=1.00000000
    E[4114]=1.00000000
    E[4115]=1.00000000
    E[4116]=1.00000000
    E[4117]=1.41421356
    E[4118]=1.00000000
    E[4119]=1.00000000
    E[4120]=1.00000000
    E[4121]=1.00000000
    E[4122]=1.00000000
    E[4123]=1.00000000
    E[4124]=1.00000000
    E[4125]=1.00000000
    E[4126]=1.00000000
    E[4127]=1.00000000
    E[4128]=1.00000000
    E[4129]=1.00000000
    E[4130]=1.00000000
    E[4131]=1.00000000
    E[4132]=1.00000000
    E[4133]=1.00000000
    E[4134]=1.00000000
    E[4135]=1.00000000
    E[4136]=1.00000000
    E[4137]=1.00000000
    E[4138]=1.41421356
    E[4139]=1.00000000
    E[4140]=1.00000000
    sum=0
    C=x[1]
    L=x[2]
    A=x[3]
    B=x[4]
    I=x[5]
    S=x[6]
    X0=x[7]
    TORPI=sqrt( 1.0 / atan( 1.0 ) )
    ROOTP5=sqrt( 0.5 )
    for i = ML:MU
        term1 = X[i]/E[i]*L+1/E[i]*C-Y[i]/E[i]
        QA=erfc(ROOTP5*(A*S+(X[i]-X0)/S))
        QB=erfc(ROOTP5*(B*S+(X[i]-X0)/S))
        T=QA+QB
        P=i*0.5*A*B/(A+B)
        R=exp(-0.5*((X[i]-X0)/S)^2)
        term2 = 1/E[i]*P*T*R
        sum=sum+(term1+term2)^2
    end
    return sum #, grad
end

#SOME UNDEFINED VARS IN SIF
A["VAREIGVL"]=function vareigvl(x::AbstractVector)
    println("Julia port of CUTEST's VAREIGVL")
    grad = zeros(size(x))
    N=4999
    M=6
    Q=1.5
    sum=0
    for i = 1:M
        sum1=0
        for j = 1:(i+M)
            coeff = sin(i*j)*exp(-1/(N^2)*(j-1)^2)
            term1 = coeff*x[j]
            sum1=sum1+term1
        end
        term2 = -x[i]*M
        sum1=sum1+term2
        sum=sum+sum1^2/2
    end
    for i = (M+1):(N-M)
        sum1=0
        for j = (i-M):(i+M)
            coeff = sin(i*j)*exp(-1/(N^2)*(j-1)^2)
            term1 = coeff*x[j]
            sum1=sum1+term1
        end
        term2 = -x[i]*M
        sum1=sum1+term2
        sum=sum+sum1^2/2
    end
    for i = (N-M+1):(N)
        sum1=0
        for j = (i-M):(N)
            coeff = sin(i*j)*exp(-1/(N^2)*(j-1)^2)
            term1 = coeff*x[j]
            sum1=sum1+term1
        end
        term2 = -x[i]*M
        sum1=sum1+term2
        sum=sum+sum1^2/2
    end
    term2 = 0
    for i =1:N
        term2 = term2+x[i]^2
    end
    sum=sum+term2^Q/Q
    return sum #, grad
end

A["COOLHANSLS"]=function coolhansls(x::AbstractVector)
    println("Julia port of CUTEST's COOLHANSLS")
    grad = zeros(size(x))
    N=3
    a=x
    x=zeros(N,N)
    for i = 1:N
        x[i,1:N] = a[1+(i-1)*N:N*i]
    end
    A=zeros(3,3)
    B=zeros(3,3)
    C=zeros(3,3)
    A[1,1]=0.0
    A[2,1]=0.13725E-6
    A[3,1]=0.0
    A[1,2]=0.0
    A[2,2]=937.62
    A[3,2]=0.0
    A[1,3]=0.0
    A[2,3]=-42.207
    A[3,3]=0.0

    B[1,1]=0.0060893
    B[2,1]=0.13880E-6
    B[3,1]=-0.13877E-6
    B[1,2]=-44.292
    B[2,2]=-1886.0
    B[3,2]=42.362
    B[1,3]=2.0011
    B[2,3]=42.362
    B[3,3]=-2.0705

    C[1,1]=0.0
    C[2,1]=0.0
    C[3,1]=0.0
    C[1,2]=44.792
    C[2,2]=948.21
    C[3,2]=-42.684
    C[1,3]=0.0
    C[2,3]=0.0
    C[3,3]=0.0
    sum=0
    G=zeros(3,3)
    for k = 1:N
        for l = 1:N
            G[k,l]=C[k,l]
            for m=1:N
                G[k,l] = G[k,l]+x[m,l]*B[k,m]
            end
        end
    end
    for z=1:N
    for l = 1:N
        for p = 1:N
            for m=1:N
                G[z,l] = G[z,l]+x[l,m]*x[m,p]*A[z,p]
            end
        end
    end
    end
    for i=1:N
        for j=1:N
            sum=sum+G[i,j]^2
        end
    end
    return sum #, grad
end

A["FMINSRF2"]=function fminsrf2(x::AbstractVector)
    println("Julia port of CUTEST's FMINSRF2")
    grad = zeros(size(x))
    P=100
    SLOPEJ=4
    SLOPEI=8
    MID=convert(Int64,P/2)
    SCALE=((P-1))^2
    PARAM=0.5*(P-1)^2
    sum=0
    a=x
    x=zeros(P,P)
    for i = 1:P
        x[i,1:P] = a[1+(i-1)*P:P*i]
    end
    for i = 1:(P-1)
        sum1=0
        for j = 1:(P-1)
            term1 = 1
            term2 = PARAM*(x[i,j]-x[i+1,j+1])^2
            term3 = PARAM*(x[i+1,j]-x[i,j+1])^2
            sum=sum+(1/SCALE)*sqrt(term1+term2+term3)
        end
    end
    sum2 = 1/P^2*x[MID,MID]
    sum=sum+sum2^2
    return sum #, grad
end

A["FMINSURF"]=function fminsurf(x::AbstractVector)
    println("Julia port of CUTEST's FMINSURF")
    grad = zeros(size(x))
    P=75
    SLOPEJ=4
    SLOPEI=8
    MID=P/2
    a=x
    x=zeros(P,P)
    for i = 1:P
        x[i,1:P] = a[1+(i-1)*P:P*i]
    end
    SCALE=((P-1))^2
    PARAM=0.5*(P-1)^2
    sum=0
    for i = 1:(P-1)
        for j = 1:(P-1)
            term1 = 1
            term2 = PARAM*(x[i,j]-x[i+1,j+1])^2
            term3 = PARAM*(x[i+1,j]-x[i,j+1])^2
            sum=sum+(1/SCALE)*sqrt(term1+term2+term3)
        end
    end
    sum2=0
    for j=1:P
        for i=1:P
            sum2=sum2+x[i,j]
        end
    end
    sum=sum+(1/P^4)*sum2^2
    return sum #, grad
end

A["PENALTY2"]=function penalty2(x::AbstractVector)
    println("Julia port of CUTEST's PENALTY2")
    grad = zeros(size(x))
    N=200
    A=10^(-5)
    B=0.1
    M=2*N
    term1 = x[1]-0.2
    sum=B*term1^2
    for i = 2:(N)
        coeff = exp(0.1*(i-1))+exp(0.1*i)
        term1 = -coeff+exp(0.1*x[i])+exp(0.1*x[i-1])
        sum=sum+A*term1^2
    end
    for i = (N+1):(M-1)
        coeff = exp(0.1)
        term1 = -coeff+exp(0.1*x[i-N+1])
        sum=sum+A*term1^2
    end
    term2 = -1
    for i=1:N
        term2=term2+(N-i+1)*x[i]^2
    end
    sum=sum+B*term2^2
    return sum #, grad
end

A["CERI651BLS"]=function ceri651bls(x::AbstractVector)
    println("Julia port of CUTEST's CERI651BLS")
    grad = zeros(size(x))
    N=7
    MPOT = 10186
    M=66
    MLOW=7343
    MUP=7408
    sum=0
    X=zeros(MPOT)
    Y=zeros(MPOT)
    E=zeros(MPOT)
    X[7343]=26052.42188
    X[7344]=26057.64063
    X[7345]=26062.85938
    X[7346]=26068.07813
    X[7347]=26073.29688
    X[7348]=26078.51563
    X[7349]=26083.73438
    X[7350]=26088.95313
    X[7351]=26094.17188
    X[7352]=26099.39063
    X[7353]=26104.60938
    X[7354]=26109.82813
    X[7355]=26115.04688
    X[7356]=26120.26563
    X[7357]=26125.48438
    X[7358]=26130.70313
    X[7359]=26135.92188
    X[7360]=26141.14063
    X[7361]=26146.35938
    X[7362]=26151.57813
    X[7363]=26156.79688
    X[7364]=26162.01563
    X[7365]=26167.23438
    X[7366]=26172.45313
    X[7367]=26177.68750
    X[7368]=26182.93750
    X[7369]=26188.18750
    X[7370]=26193.43750
    X[7371]=26198.68750
    X[7372]=26203.93750
    X[7373]=26209.18750
    X[7374]=26214.43750
    X[7375]=26219.68750
    X[7376]=26224.93750
    X[7377]=26230.18750
    X[7378]=26235.43750
    X[7379]=26240.68750
    X[7380]=26245.93750
    X[7381]=26251.18750
    X[7382]=26256.43750
    X[7383]=26261.68750
    X[7384]=26266.93750
    X[7385]=26272.18750
    X[7386]=26277.43750
    X[7387]=26282.68750
    X[7388]=26287.93750
    X[7389]=26293.18750
    X[7390]=26298.43750
    X[7391]=26303.68750
    X[7392]=26308.93750
    X[7393]=26314.18750
    X[7394]=26319.43750
    X[7395]=26324.68750
    X[7396]=26329.93750
    X[7397]=26335.20313
    X[7398]=26340.48438
    X[7399]=26345.76563
    X[7400]=26351.04688
    X[7401]=26356.32813
    X[7402]=26361.60938
    X[7403]=26366.89063
    X[7404]=26372.17188
    X[7405]=26377.45313
    X[7406]=26382.73438
    X[7407]=26388.01563
    X[7408]=26393.29688

    Y[7343]=  1.96083316
    Y[7344]=  0.98041658
    Y[7345]=  0.00000000
    Y[7346]=  1.96083316
    Y[7347]=  3.92166632
    Y[7348]=  0.00000000
    Y[7349]=  3.92166632
    Y[7350]=  0.98041658
    Y[7351]=  1.96083316
    Y[7352]=  1.96083316
    Y[7353]=  3.92166632
    Y[7354]=  1.96083316
    Y[7355]=  0.98041658
    Y[7356]=  4.90208290
    Y[7357]=  8.82374922
    Y[7358]=  5.88249948
    Y[7359]= 14.70624870
    Y[7360]= 12.74541554
    Y[7361]= 27.45166424
    Y[7362]= 27.45166424
    Y[7363]= 32.35374715
    Y[7364]= 52.94249533
    Y[7365]= 43.13832953
    Y[7366]= 47.05999585
    Y[7367]= 50.00124559
    Y[7368]= 61.76624455
    Y[7369]= 52.94249533
    Y[7370]= 34.31458031
    Y[7371]= 42.15791295
    Y[7372]= 32.35374715
    Y[7373]= 40.19707979
    Y[7374]= 33.33416373
    Y[7375]= 23.52999792
    Y[7376]= 16.66708186
    Y[7377]= 12.74541554
    Y[7378]= 13.72583212
    Y[7379]= 13.72583212
    Y[7380]= 12.74541554
    Y[7381]=  6.86291606
    Y[7382]= 14.70624870
    Y[7383]=  7.84333264
    Y[7384]=  8.82374922
    Y[7385]=  8.82374922
    Y[7386]=  6.86291606
    Y[7387]=  9.80416580
    Y[7388]=  4.90208290
    Y[7389]=  4.90208290
    Y[7390]=  3.92166632
    Y[7391]=  1.96083316
    Y[7392]=  2.94124974
    Y[7393]=  2.94124974
    Y[7394]=  0.00000000
    Y[7395]=  0.98041658
    Y[7396]=  0.98041658
    Y[7397]=  3.92166632
    Y[7398]=  0.98041658
    Y[7399]=  0.98041658
    Y[7400]=  1.96083316
    Y[7401]=  1.96083316
    Y[7402]=  0.00000000
    Y[7403]=  3.92166632
    Y[7404]=  0.98041658
    Y[7405]=  0.98041658
    Y[7406]=  0.98041658
    Y[7407]=  2.94124974
    Y[7408]=  0.00000000

    E[7343]=1.41421356
    E[7344]=1.00000000
    E[7345]=1.00000000
    E[7346]=1.41421356
    E[7347]=2.00000000
    E[7348]=1.00000000
    E[7349]=2.00000000
    E[7350]=1.00000000
    E[7351]=1.41421356
    E[7352]=1.41421356
    E[7353]=2.00000000
    E[7354]=1.41421356
    E[7355]=1.00000000
    E[7356]=2.23606798
    E[7357]=3.00000000
    E[7358]=2.44948974
    E[7359]=3.87298335
    E[7360]=3.60555128
    E[7361]=5.29150262
    E[7362]=5.29150262
    E[7363]=5.74456265
    E[7364]=7.34846923
    E[7365]=6.63324958
    E[7366]=6.92820323
    E[7367]=7.14142843
    E[7368]=7.93725393
    E[7369]=7.34846923
    E[7370]=5.91607978
    E[7371]=6.55743852
    E[7372]=5.74456265
    E[7373]=6.40312424
    E[7374]=5.83095189
    E[7375]=4.89897949
    E[7376]=4.12310563
    E[7377]=3.60555128
    E[7378]=3.74165739
    E[7379]=3.74165739
    E[7380]=3.60555128
    E[7381]=2.64575131
    E[7382]=3.87298335
    E[7383]=2.82842712
    E[7384]=3.00000000
    E[7385]=3.00000000
    E[7386]=2.64575131
    E[7387]=3.16227766
    E[7388]=2.23606798
    E[7389]=2.23606798
    E[7390]=2.00000000
    E[7391]=1.41421356
    E[7392]=1.73205081
    E[7393]=1.73205081
    E[7394]=1.00000000
    E[7395]=1.00000000
    E[7396]=1.00000000
    E[7397]=2.00000000
    E[7398]=1.00000000
    E[7399]=1.00000000
    E[7400]=1.41421356
    E[7401]=1.41421356
    E[7402]=1.00000000
    E[7403]=2.00000000
    E[7404]=1.00000000
    E[7405]=1.00000000
    E[7406]=1.00000000
    E[7407]=1.73205081
    E[7408]=1.00000000
    C=x[1]
    L=x[2]
    A=x[3]
    B=x[4]
    I=x[5]
    S=x[6]
    X0=x[7]
    for i = MLOW:MUP
        term1 = 1/E[i]*C+X[i]/E[i]*L-Y[i]/E[i]
        P = i*0.5*A*B/(A+B)
        R = exp(-0.5*((X[i]-X0)/S)^2)
        BC=sqrt(0.5)*(B*S*(X[i]-X0)/S)
        AC=sqrt(0.5)*(A*S*(X[i]-X0)/S)
        QA=erfc(AC)
        QB=erfc(BC)
        T=QA+QB
        term2 = 1/E[i]*P*R*T
        sum=sum+(term1+term2)^2
    end
    return sum #, grad
end

#issues
A["HEART6LS"]=function heart6ls(x::AbstractVector)
    println("Julia port of CUTEST's HEART6LS")
    grad = zeros(size(x))
    sum_Mx=-0.816
    sum_My=-0.017
    sum_A=-1.826
    sum_B=-0.754
    sum_C=-4.839
    sum_D=-3.259
    sum_E=-14.023
    sum_F=15.467
    a=x[1]
    c=x[2]
    t=x[3]
    u=x[4]
    v=x[5]
    w=x[6]
    sum=0
    E1=t*a
    E2=u*(sum_Mx-a)
    E3=v*c
    E4=w*(sum_My-c)
    E5=v*a
    E6=w*(sum_Mx-a)
    E7=t*c
    E8=u*(sum_My-c)
    E9=a*(t^2-v^2)
    E10=c*t*v
    E11=(sum_Mx-a)*(u^2-w^2)
    E12=(sum_My-c)*u*w
    E13=c*(t^2-v^2)
    E14=a*t*v
    E15=(sum_My-c)*(u^2-w^2)
    E16=(sum_Mx-a)*u*w
    E17=a*t*(t^2-3*v^2)
    E18=c*v*(v^2-3*t^2)
    E19=(sum_Mx-a)*u*(u^2-3*w^2)
    E20=(sum_My-c)*w*(w^2-3*u^2)
    E21=c*t*(t^2-3*v^2)
    E22=a*v*(v^2-3*t^2)
    E23=(sum_My-c)*u*(u^2-3*w^2)
    E24=(sum_Mx-a)*w*(w^2-3*u^2)
    G1=-sum_A+E1+E2-E3-E4
    G2=-sum_B+E5+E6+E7+E8
    G3=-sum_C+E9-2*E10+E11-2*E12
    G4=-sum_D+E13+2*E14+E15+2*E16
    G5=-sum_E+E17+E18+E19+E20
    G6=-sum_F+E21-E22+E23-E24
    sum=G1^2+G2^2+G3^3+G4^2+G5^2+G6^2
    return sum #, grad
end

#issues
A["HEART8LS"]=function heart8ls(x::AbstractVector)
    println("Julia port of CUTEST's HEART8LS")
    grad = zeros(size(x))
    sum_Mx=-0.69
    sum_My=-0.044
    sum_A=-1.57
    sum_B=-1.31
    sum_C=-2.65
    sum_D=2.0
    sum_E=-12.6
    sum_F=9.48
    a=x[1]
    b=x[2]
    c=x[3]
    d=x[4]
    t=x[5]
    u=x[6]
    v=x[7]
    w=x[8]
    sum=0
    E1=t*a
    E2=u*b
    E3=v*c
    E4=w*d
    E5=v*a
    E6=w*b
    E7=t*c
    E8=u*d
    E9=a*(t^2-v^2)
    E10=c*t*v
    E11=b*(u^2-w^2)
    E12=d*u*w
    E13=c*(t^2-v^2)
    E14=a*t*v
    E15=d*(u^2-w^2)
    E16=b*u*w
    E17=a*t*v
    E18=c*v*t
    E19=b*u*w
    E20=d*w*u
    E21=c*t*v
    E22=a*v*t
    E23=d*u*w
    E24=b*w*u
    G1=-sum_Mx+a+b
    G2=-sum_My+c+d
    G3=-sum_A+E1+E2-E3-E4
    G4=-sum_B+E5+E6+E7+E8
    G5=-sum_C+E9-2*E10+E11-2*E12
    G6=-sum_D+E13-2*E14+E15-2*E16
    G7=-sum_E+E17+E18+E19+E20
    G8=-sum_F+E21-E22+E23-E24
    sum=G1^2+G2^2+G3^3+G4^2+G5^2+G6^2+G7^2+G8^2
    return sum #, grad
end

A["SPINLS"]=function spinls(x::AbstractVector)
    println("Julia port of CUTEST's SPINLS")
    grad = zeros(size(x))
    PI4=atan(1)
    TWOPI=8*PI4
    sum=0
    a=x
    MU=a[1]
    OMEGA=a[2]
    N=50
    v=zeros(N,N)
    b=a[3:length(a)]
    x=b[1:2:2*N]
    y=b[2:2:2*N]
    c=b[(2*N+1):length(b)]
    k=1
    for i=2:N
        for j = 1:(i-1)
            v[i,j]=c[k]
            k=k+1
        end
    end
    #R
    for i =1:N
        term1 = -x[i]*MU+y[i]*OMEGA
        for j = 1:(i-1)
            term1 = term1 + (y[i]-y[j])/(v[i,j]^2)
        end
        for j = (i+1):N
            term1 = term1 - (y[j]-y[i])/(v[j,i]^2)
        end
        sum =sum+term1^2
    end
    #I
    for i = 1:N
        term2 = -y[i]*MU-x[i]*OMEGA
        for j = 1:(i-1)
            term2 = term2 - (x[i]-x[j])/(v[i,j]^2)
        end
        for j = (i+1):N
            term2 = term2 + (x[j]-x[i])/(v[j,i]^2)
        end
        sum =sum+term2^2
    end
    #M(I,J)
    for i = 2:N
        for j= 1:(i-1)
            term3= -v[i,j]^2+(x[i]-x[j])^2+(y[i]-y[j])^2
            sum=sum+term3^2
        end
    end
    return sum #, grad
end

#problems
A["HYDCAR6LS"]=function hydcar6ls(x::AbstractVector)
    println("Julia port of CUTEST's HYDCAR6LS")
    grad = zeros(size(x))
    sum=0
    M=3
    N=6
    a=x
    k=1
    t=zeros(N)
    x=zeros(N,M)
    v=zeros(N)
    for i=0:(N-1)
        t[i+1]=a[k]
        k=k+1
        for j = 1:M
            x[i+1,j]=a[k]
            k=k+1
        end
    end
    for i = 0:(N-2)
        v[i+1]=a[k]
        k=k+1
    end
    A=zeros(3)
    B=zeros(3)
    C=zeros(3)
    AL=zeros(3)
    AL1=zeros(3)
    AL2=zeros(3)
    BE=zeros(3)
    BE1=zeros(3)
    BE2=zeros(3)
    FL=zeros(3)
    FV=zeros(3)
    A[1]=9.647
    B[1]=-1*2998
    C[1]=230.66
    A[2]=9.953
    B[2]=-1*3448.1
    C[2]=235.88
    A[3]=9.466
    B[3]=-1*3347.25
    C[3]=215.31
    AL[1]=0
    AL1[1]=37.6
    AL2[1]=0
    AL[2]=0
    AL1[2]=48.2
    AL2[2]=0
    AL[3]=0
    AL1[3]=45.4
    AL2[3]=0
    BE[1]=8425
    BE1[1]=24.2
    BE2[1]=0
    BE[2]=9395
    BE1[2]=35.6
    BE2[2]=0
    BE[3]=10466
    BE1[3]=31.9
    BE2[3]=0
    FL[1]=30
    FL[2]=30
    FL[3]=40
    FV[1]=0
    FV[2]=0
    FV[3]=0
    TF=100
    B1= 40
    D= 60
    Q= 2500000
    for j =1:M
        #2.1
        E11J = -1 * x[2,j] * ( v[1] + B1 )
        E12J = v[1]*x[1,j]*1 * 1 * exp(A[j] + (B[j] / (t[1] + C[j])))
        term1 = x[1,j]*B1+E11J+E12J
        sum = sum + 10^(-4)*term1^2
        #2.3
        E31J = x[N-1,j]*(1 * 1 * exp(A[j] + (B[j] / (t[N-1] + C[j]))))
        term2 = -x[N,j]+E31J
        sum = sum + term2^2
        #2.2
        for i = 2:(N-1)
            E21IJ = -1 * x[i+1,j] * ( v[i] + 1 )
            E22IJ = v[i-1]*x[i-1,j]*-1 * 1 * exp(A[j] + (B[j] / (t[i-1] + C[j])))
            E23IJ=1 * x[i,j] * ( v[i-1] + 1 )
            E24IJ = v[i]*x[i,j]*1 * 1 * exp(A[j] + (B[j] / (t[i] + C[j])))
            term2 = E21IJ+E22IJ+E23IJ+E24IJ
            if i==2
                term2=term2-FL[j]
            elseif i==3
                term2=term2-FV[j]
            end
            sum = sum+ 10^(-4)*term2^2
        end
    end
    #2.7
    for i = 1:(N)
        sum1=0
        for j =1:M
        E71IJ = x[i,j]*(1 * 1 * exp(A[j] + (B[j] / (t[i] + C[j]))))
        term3 = -1+E71IJ
        sum1=sum1+term3
        end
        sum=sum+sum1^2
    end
    #2.8
    term4=0
    for j = 1:M
        E81J = 1 * 1 * exp(A[j] + (B[j] / (t[1] + C[j])))*v[1] * x[1,j]*(BE[j] + BE1[j] * t[1] + BE2[j] * t[1] * t[1])
        E82J = B1*x[1,j]*(AL[j] + AL1[j] * t[1] + AL2[j] * t[1] * t[1])
        E83J = -1 * x[2,j] * ( 1 + v[1] )*(AL[j] + AL1[j] * t[1] + AL2[j] * t[2] * t[2])
        term4 = term4-Q+E81J+E82J+E83J
    end
    sum = sum+10^(-10)*term4^2
    #2.9
    for i = 2:(N-1)
        sum1=0
        SHF=0
        BHF=0
        for j = 1:M
        E91IJ = 1 * 1 * exp(A[j] + (B[j] / (t[i] + C[j])))*v[i] * x[i,j]*(BE[j] + BE1[j] * t[i] + BE2[j] * t[i] * t[i])
        E92IJ = 1 * x[i,j] * ( 1 + v[i-1] ) *(AL[j] + AL1[j] * t[i] + AL2[j] * t[i] * t[i])
        E93IJ = -1 * 1 * exp(A[j] + (B[j] / (t[i-1] + C[j])))*v[i-1] * x[i-1,j]*(BE[j] + BE1[j] * t[i-1] + BE2[j] * t[i-1] * t[i-1])
        E94IJ = -1 * x[i+1,j] * ( 1 + v[i] ) *(AL[j] + AL1[j] * t[i+1] + AL2[j] * t[i+1] * t[i+1])
        term5 = E91IJ+E92IJ+E93IJ+E94IJ
        SHF= SHF+FL[j]*(AL[j]+TF^2*AL2[j]+TF*AL1[j])
        BHF= BHF+FV[j]*(BE[j]+TF^2*BE2[j]+TF*BE1[j])
        sum1=sum1+term5
        end
        if i==2
            sum1=sum1-SHF
        elseif i==3
            sum1=sum1-BHF
        end
        sum = sum+10^(-10)*sum1^2
    end
    return sum #, grad
end

A["SPMSRTLS"]=function spmsrtls(x::AbstractVector)
    println("Julia port of CUTEST's SPMSRTLS")
    grad = zeros(size(x))
    M=1667
    sum=0
    a=x
    x=zeros(M,M)
    x[1,1]=a[1]
    x[1,2]=a[2]
    k=3
    for i = 2:(M-1)
        x[i,i-1]=a[k]
        k=k+1
        x[i,i]=a[k]
        k=k+1
        x[i,i+1]=a[k]
        k=k+1
    end
    x[M,M-1]=a[k]
    k=k+1
    x[M,M]=a[k]
    #CONSTZ
    B =zeros(M,M)
    B[1,1]=sin(1)
    B[1,2]=sin(4)
    k=2
    for i =2:(M-1)
        k=k+1
        B[i,i-1]=sin(k^2)
        k=k+1
        B[i,i]=sin(k^2)
        k=k+1
        B[i,i+1]=sin(k^2)
    end
    k=k+1
    B[M,M-1]=sin(k^2)
    k=k+1
    B[M,M]=sin(k^2)
    E=zeros(M,M)
    #GROUPS
    E[1,1]=-(B[1,1]^2+B[1,2]*B[2,1])
    for i =2:(M-1)
        E[i,i] = -(B[i,i]^2+B[i-1,i]*B[i,i-1]+B[i+1,i]*B[i,i+1])
    end
    E[M,M] = -(B[M,M]^2+B[M-1,M]*B[M,M-1])
    for i = 1:(M-1)
        E[i+1,i] = -(B[i+1,i+1]*B[i+1,i]+B[i+1,i]*B[i,i])
    end
    for i = 2:(M)
        E[i-1,i] = -(B[i-1,i-1]*B[i-1,i]+B[i-1,i]*B[i,i])
    end
    for i = 2:(M-1)
        E[i+1,i-1] = -(B[i+1,i]*B[i,i-1])
    end
    for i = 2:(M-1)
        E[i-1,i+1] = -(B[i-1,i]*B[i,i+1])
    end
    E[1,1]=E[1,1]+x[1,1]^2+x[1,2]*x[2,1]
    E[1,2]=E[1,2]+x[1,1]*x[1,2]+x[2,2]*x[1,2]
    E[1,3]=E[1,3]+x[2,3]*x[1,2]
    E[2,1]=E[2,1]+x[1,1]*x[2,1]+x[2,2]*x[2,1]
    E[2,2]=E[2,2]+x[2,1]*x[1,2]+x[2,2]^2+x[2,3]*x[3,2]
    E[2,3]=E[2,3]+x[2,3]*x[2,2]+x[3,3]*x[2,3]
    E[2,4]=E[2,4]+x[2,3]*x[3,4]
    for i = 3:(M-2)
        E[i,i-2]=E[i,i-2]+x[i,i-1]*x[i-1,i-2]
        E[i,i-1]=E[i,i-1]+x[i,i-1]*x[i-1,i-1]+x[i,i]*x[i,i-1]
        E[i,i]=E[i,i]+x[i,i]^2+x[i,i-1]*x[i-1,i]+x[i,i+1]*x[i+1,i]
        E[i,i+1]=E[i,i+1]+x[i,i]*x[i,i+1]+x[i,i+1]*x[i+1,i+1]
        E[i,i+2]=E[i,i+2]+x[i,i+1]*x[i+1,i+2]
    end
    E[M-1,M-3]=E[M-1,M-3]+x[M-1,M-2]*x[M-2,M-3]
    E[M-1,M-2]=E[M-1,M-2]+x[M-1,M-2]*x[M-2,M-2]+x[M-1,M-1]*x[M-1,M-2]
    E[M-1,M-1]=E[M-1,M-1]+x[M-1,M-2]*x[M-2,M-1]+x[M-1,M-1]^2+x[M-1,M]*x[M,M-1]
    E[M-1,M]=E[M-1,M]+x[M-1,M-1]*x[M-1,M]+x[M-1,M]*x[M,M]
    E[M,M-2]=E[M,M-2]+x[M,M-1]*x[M-1,M-2]
    E[M,M-1]=E[M,M-1]+x[M,M-1]*x[M-1,M-1]+x[M,M-1]*x[M,M]
    E[M,M]=E[M,M]+x[M,M-1]*x[M-1,M]+x[M,M]^2
    for i = 1:M
        for j = 1:M
            sum=sum+E[i,j]^2
        end
    end
    return sum #, grad
end

A["BENNETT5LS"]=function bennett5ls(x::AbstractVector)
    println("Julia port of CUTEST's BENNETT5LS")
    grad = zeros(size(x))
    M=154
    N=3
    X=zeros(154)
    Y=zeros(154)
    X[1]=7.447168E0
    X[2]=8.102586E0
    X[3]=8.452547E0
    X[4]=8.711278E0
    X[5]=8.916774E0
    X[6]=9.087155E0
    X[7]=9.232590E0
    X[8]=9.359535E0
    X[9]=9.472166E0
    X[10]=9.573384E0
    X[11]=9.665293E0
    X[12]=9.749461E0
    X[13]=9.827092E0
    X[14]=9.899128E0
    X[15]=9.966321E0
    X[16]=10.029280E0
    X[17]=10.088510E0
    X[18]=10.144430E0
    X[19]=10.197380E0
    X[20]=10.247670E0
    X[21]=10.295560E0
    X[22]=10.341250E0
    X[23]=10.384950E0
    X[24]=10.426820E0
    X[25]=10.467000E0
    X[26]=10.505640E0
    X[27]=10.542830E0
    X[28]=10.578690E0
    X[29]=10.613310E0
    X[30]=10.646780E0
    X[31]=10.679150E0
    X[32]=10.710520E0
    X[33]=10.740920E0
    X[34]=10.770440E0
    X[35]=10.799100E0
    X[36]=10.826970E0
    X[37]=10.854080E0
    X[38]=10.880470E0
    X[39]=10.906190E0
    X[40]=10.931260E0
    X[41]=10.955720E0
    X[42]=10.979590E0
    X[43]=11.002910E0
    X[44]=11.025700E0
    X[45]=11.047980E0
    X[46]=11.069770E0
    X[47]=11.091100E0
    X[48]=11.111980E0
    X[49]=11.132440E0
    X[50]=11.152480E0
    X[51]=11.172130E0
    X[52]=11.191410E0
    X[53]=11.210310E0
    X[54]=11.228870E0
    X[55]=11.247090E0
    X[56]=11.264980E0
    X[57]=11.282560E0
    X[58]=11.299840E0
    X[59]=11.316820E0
    X[60]=11.333520E0
    X[61]=11.349940E0
    X[62]=11.366100E0
    X[63]=11.382000E0
    X[64]=11.397660E0
    X[65]=11.413070E0
    X[66]=11.428240E0
    X[67]=11.443200E0
    X[68]=11.457930E0
    X[69]=11.472440E0
    X[70]=11.486750E0
    X[71]=11.500860E0
    X[72]=11.514770E0
    X[73]=11.528490E0
    X[74]=11.542020E0
    X[75]=11.555380E0
    X[76]=11.568550E0
    X[77]=11.581560E0
    X[78]=11.594420E0
    X[79]=11.607121E0
    X[80]=11.619640E0
    X[81]=11.632000E0
    X[82]=11.644210E0
    X[83]=11.656280E0
    X[84]=11.668200E0
    X[85]=11.679980E0
    X[86]=11.691620E0
    X[87]=11.703130E0
    X[88]=11.714510E0
    X[89]=11.725760E0
    X[90]=11.736880E0
    X[91]=11.747890E0
    X[92]=11.758780E0
    X[93]=11.769550E0
    X[94]=11.780200E0
    X[95]=11.790730E0
    X[96]=11.801160E0
    X[97]=11.811480E0
    X[98]=11.821700E0
    X[99]=11.831810E0
    X[100]=11.841820E0
    X[101]=11.851730E0
    X[102]=11.861550E0
    X[103]=11.871270E0
    X[104]=11.880890E0
    X[105]=11.890420E0
    X[106]=11.899870E0
    X[107]=11.909220E0
    X[108]=11.918490E0
    X[109]=11.927680E0
    X[110]=11.936780E0
    X[111]=11.945790E0
    X[112]=11.954730E0
    X[113]=11.963590E0
    X[114]=11.972370E0
    X[115]=11.981070E0
    X[116]=11.989700E0
    X[117]=11.998260E0
    X[118]=12.006740E0
    X[119]=12.015150E0
    X[120]=12.023490E0
    X[121]=12.031760E0
    X[122]=12.039970E0
    X[123]=12.048100E0
    X[124]=12.056170E0
    X[125]=12.064180E0
    X[126]=12.072120E0
    X[127]=12.080010E0
    X[128]=12.087820E0
    X[129]=12.095580E0
    X[130]=12.103280E0
    X[131]=12.110920E0
    X[132]=12.118500E0
    X[133]=12.126030E0
    X[134]=12.133500E0
    X[135]=12.140910E0
    X[136]=12.148270E0
    X[137]=12.155570E0
    X[138]=12.162830E0
    X[139]=12.170030E0
    X[140]=12.177170E0
    X[141]=12.184270E0
    X[142]=12.191320E0
    X[143]=12.198320E0
    X[144]=12.205270E0
    X[145]=12.212170E0
    X[146]=12.219030E0
    X[147]=12.225840E0
    X[148]=12.232600E0
    X[149]=12.239320E0
    X[150]=12.245990E0
    X[151]=12.252620E0
    X[152]=12.259200E0
    X[153]=12.265750E0
    X[154]=12.272240E0

    Y[1]=-34.834702E0
    Y[2]=-34.393200E0
    Y[3]=-34.152901E0
    Y[4]=-33.979099E0
    Y[5]=-33.845901E0
    Y[6]=-33.732899E0
    Y[7]=-33.640301E0
    Y[8]=-33.559200E0
    Y[9]=-33.486801E0
    Y[10]=-33.423100E0
    Y[11]=-33.365101E0
    Y[12]=-33.313000E0
    Y[13]=-33.260899E0
    Y[14]=-33.217400E0
    Y[15]=-33.176899E0
    Y[16]=-33.139198E0
    Y[17]=-33.101601E0
    Y[18]=-33.066799E0
    Y[19]=-33.035000E0
    Y[20]=-33.003101E0
    Y[21]=-32.971298E0
    Y[22]=-32.942299E0
    Y[23]=-32.916302E0
    Y[24]=-32.890202E0
    Y[25]=-32.864101E0
    Y[26]=-32.841000E0
    Y[27]=-32.817799E0
    Y[28]=-32.797501E0
    Y[29]=-32.774300E0
    Y[30]=-32.757000E0
    Y[31]=-32.733799E0
    Y[32]=-32.716400E0
    Y[33]=-32.699100E0
    Y[34]=-32.678799E0
    Y[35]=-32.661400E0
    Y[36]=-32.644001E0
    Y[37]=-32.626701E0
    Y[38]=-32.612202E0
    Y[39]=-32.597698E0
    Y[40]=-32.583199E0
    Y[41]=-32.568699E0
    Y[42]=-32.554298E0
    Y[43]=-32.539799E0
    Y[44]=-32.525299E0
    Y[45]=-32.510799E0
    Y[46]=-32.499199E0
    Y[47]=-32.487598E0
    Y[48]=-32.473202E0
    Y[49]=-32.461601E0
    Y[50]=-32.435501E0
    Y[51]=-32.435501E0
    Y[52]=-32.426800E0
    Y[53]=-32.412300E0
    Y[54]=-32.400799E0
    Y[55]=-32.392101E0
    Y[56]=-32.380501E0
    Y[57]=-32.366001E0
    Y[58]=-32.357300E0
    Y[59]=-32.348598E0
    Y[60]=-32.339901E0
    Y[61]=-32.328400E0
    Y[62]=-32.319698E0
    Y[63]=-32.311001E0
    Y[64]=-32.299400E0
    Y[65]=-32.290699E0
    Y[66]=-32.282001E0
    Y[67]=-32.273300E0
    Y[68]=-32.264599E0
    Y[69]=-32.256001E0
    Y[70]=-32.247299E0
    Y[71]=-32.238602E0
    Y[72]=-32.229900E0
    Y[73]=-32.224098E0
    Y[74]=-32.215401E0
    Y[75]=-32.203800E0
    Y[76]=-32.198002E0
    Y[77]=-32.189400E0
    Y[78]=-32.183601E0
    Y[79]=-32.174900E0
    Y[80]=-32.169102E0
    Y[81]=-32.163300E0
    Y[82]=-32.154598E0
    Y[83]=-32.145901E0
    Y[84]=-32.140099E0
    Y[85]=-32.131401E0
    Y[86]=-32.125599E0
    Y[87]=-32.119801E0
    Y[88]=-32.111198E0
    Y[89]=-32.105400E0
    Y[90]=-32.096699E0
    Y[91]=-32.090900E0
    Y[92]=-32.088001E0
    Y[93]=-32.079300E0
    Y[94]=-32.073502E0
    Y[95]=-32.067699E0
    Y[96]=-32.061901E0
    Y[97]=-32.056099E0
    Y[98]=-32.050301E0
    Y[99]=-32.044498E0
    Y[100]=-32.038799E0
    Y[101]=-32.033001E0
    Y[102]=-32.027199E0
    Y[103]=-32.024300E0
    Y[104]=-32.018501E0
    Y[105]=-32.012699E0
    Y[106]=-32.004002E0
    Y[107]=-32.001099E0
    Y[108]=-31.995300E0
    Y[109]=-31.989500E0
    Y[110]=-31.983700E0
    Y[111]=-31.977900E0
    Y[112]=-31.972099E0
    Y[113]=-31.969299E0
    Y[114]=-31.963501E0
    Y[115]=-31.957701E0
    Y[116]=-31.951900E0
    Y[117]=-31.946100E0
    Y[118]=-31.940300E0
    Y[119]=-31.937401E0
    Y[120]=-31.931601E0
    Y[121]=-31.925800E0
    Y[122]=-31.922899E0
    Y[123]=-31.917101E0
    Y[124]=-31.911301E0
    Y[125]=-31.908400E0
    Y[126]=-31.902599E0
    Y[127]=-31.896900E0
    Y[128]=-31.893999E0
    Y[129]=-31.888201E0
    Y[130]=-31.885300E0
    Y[131]=-31.882401E0
    Y[132]=-31.876600E0
    Y[133]=-31.873699E0
    Y[134]=-31.867901E0
    Y[135]=-31.862101E0
    Y[136]=-31.859200E0
    Y[137]=-31.856300E0
    Y[138]=-31.850500E0
    Y[139]=-31.844700E0
    Y[140]=-31.841801E0
    Y[141]=-31.838900E0
    Y[142]=-31.833099E0
    Y[143]=-31.830200E0
    Y[144]=-31.827299E0
    Y[145]=-31.821600E0
    Y[146]=-31.818701E0
    Y[147]=-31.812901E0
    Y[148]=-31.809999E0
    Y[149]=-31.807100E0
    Y[150]=-31.801300E0
    Y[151]=-31.798401E0
    Y[152]=-31.795500E0
    Y[153]=-31.789700E0
    Y[154]=-31.786800E0
    sum=0
    for i =1:M
        term = -Y[i]+x[1]/((x[2]+X[i])^(1/x[3]))
        sum=sum+term^2
    end
    return sum #, grad
end

A["LANCZOS2LS"]=function lanczos2ls(x::AbstractVector)
    println("Julia port of CUTEST's LANCZOS2LS")
    grad = zeros(size(x))
    M=24
    N=6
    sum=0
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

    Y[1]=2.51340E+0
    Y[2]=2.04433E+0
    Y[3]=1.66840E+0
    Y[4]=1.36642E+0
    Y[5]=1.12323E+0
    Y[6]=9.26890E-1
    Y[7]=7.67934E-1
    Y[8]=6.38878E-1
    Y[9]=5.33784E-1
    Y[10]=4.47936E-1
    Y[11]=3.77585E-1
    Y[12]=3.19739E-1
    Y[13]=2.72013E-1
    Y[14]=2.32497E-1
    Y[15]=1.99659E-1
    Y[16]=1.72270E-1
    Y[17]=1.49341E-1
    Y[18]=1.30070E-1
    Y[19]=1.13812E-1
    Y[20]=1.00042E-1
    Y[21]=8.83321E-2
    Y[22]=7.83354E-2
    Y[23]=6.97669E-2
    Y[24]=6.23931E-2
    for i =1:M
        term = -Y[i]+x[1]*exp(-x[2]*X[i])+x[3]*exp(-x[4]*X[i])+x[5]*exp(-x[6]*X[i])
        sum=sum+term^2
    end
    return sum #, grad
end

#problems
A["MSQRTBLS"]=function msqrtbls(x::AbstractVector)
    println("Julia port of CUTEST's MSQRTBLS")
    grad = zeros(size(x))
    P=32
    N=P^2
    sum=0
    a=x
    x=zeros(P,P)
    for i =1:P
        x[1,1:P]=a[1+(i-1)*P:i*P]
    end
    #CONSTZ
    B =zeros(P,P)
    A=zeros(P,P)
    G=zeros(P,P)
    k=0
    for i =1:P
        for j = 1:P
            k=k+1
            B[i,j] = sin(k^2)
        end
    end
    B[3,1]=0
    for i =1:P
        for j = 1:P
            for k = 1:P
                A[i,j] = A[i,j]+B[i,k]*B[k,j]
            end
        end
    end
    for i =1:P
        for j = 1:P
            G[i,j] = -A[i,j]
            for t = 1:P
                G[i,j]=G[i,j]+x[i,t]*x[t,j]
            end
        end
    end
    for i =1:P
        for j = 1:P
            sum = sum+G[i,j]^2
        end
    end
    return sum #, grad
end

A["EIGENBLS"]=function eigenbls(x::AbstractVector)
    println("Julia port of CUTEST's EIGENBLS")
    grad = zeros(size(x))
    N=50
    sum=0
    a=x
    d=zeros(N)
    q=zeros(N,N)
    k=1
    for j =1:N
        d[j] = a[k]
        k=k+1
        for i = 1:N
            q[i,j]=a[k]
            k=k+1
        end
    end
    #CONSTZ
    A=zeros(N,N)
    A[1,1]=2
    E=zeros(N,N)
    O=zeros(N,N)
    for j = 2:N
        for i=1:(j-2)
            A[i,j]=0
        end
        A[j-1,j]=-1
        A[j,j]=2
    end
    for j = 1:N
        O[j,j]=-1
        for i=1:j
            E[i,j]=-A[i,j]
        end
    end
    for j = 1:N
        for i=1:j
            for k=1:N
                E[i,j]=E[i,j]+q[k,i]*q[k,j]*d[k]
                O[i,j]=O[i,j]+q[k,i]*q[k,j]
            end
        end
    end
    for j = 1:N
        for i=1:N
            sum=sum+E[i,j]^2+O[i,j]^2
        end
    end
    return sum #, grad
end

A["EIGENALS"]=function eigenals(x::AbstractVector)
    println("Julia port of CUTEST's EIGENALS")
    grad = zeros(size(x))
    N=50
    sum=0
    a=x
    d=zeros(N)
    q=zeros(N,N)
    k=1
    for j =1:N
        d[j] = a[k]
        k=k+1
        for i = 1:N
            q[i,j]=a[k]
            k=k+1
        end
    end
    A=zeros(N,N)
    E=zeros(N,N)
    O=zeros(N,N)
    for j = 1:N
        A[j,j]=j
        for i=1:(j-1)
            A[i,j]=0
        end
    end
    for j = 1:N
        O[j,j]=-1
        for i=1:j
            E[i,j]=-A[i,j]
        end
    end
    for j = 1:N
        for i=1:j
            for k=1:N
                E[i,j]=E[i,j]+q[k,i]*q[k,j]*d[k]
                O[i,j]=O[i,j]+q[k,i]*q[k,j]
            end
        end
    end
    for j = 1:N
        for i=1:N
            sum=sum+E[i,j]^2+O[i,j]^2
        end
    end
    return sum #, grad
end

A["CERI651DLS"]=function ceri651dls(x::AbstractVector)
    println("Julia port of CUTEST's CERI651DLS")
    grad = zeros(size(x))
    N=7
    MPOT = 10186
    M=67
    MLOW=3862
    MUP=3928
    sum=0
    X=zeros(MPOT)
    Y=zeros(MPOT)
    E=zeros(MPOT)
    X[3862]=12987.48438
    X[3863]=12990.07813
    X[3864]=12992.67188
    X[3865]=12995.26563
    X[3866]=12997.85938
    X[3867]=13000.45313
    X[3868]=13003.04688
    X[3869]=13005.64063
    X[3870]=13008.23438
    X[3871]=13010.82813
    X[3872]=13013.42188
    X[3873]=13016.01563
    X[3874]=13018.60938
    X[3875]=13021.20313
    X[3876]=13023.79688
    X[3877]=13026.39063
    X[3878]=13028.98438
    X[3879]=13031.57813
    X[3880]=13034.17188
    X[3881]=13036.76563
    X[3882]=13039.35938
    X[3883]=13041.95313
    X[3884]=13044.54688
    X[3885]=13047.14063
    X[3886]=13049.75000
    X[3887]=13052.37500
    X[3888]=13055.00000
    X[3889]=13057.62500
    X[3890]=13060.25000
    X[3891]=13062.87500
    X[3892]=13065.50000
    X[3893]=13068.12500
    X[3894]=13070.75000
    X[3895]=13073.37500
    X[3896]=13076.00000
    X[3897]=13078.62500
    X[3898]=13081.25000
    X[3899]=13083.87500
    X[3900]=13086.50000
    X[3901]=13089.12500
    X[3902]=13091.75000
    X[3903]=13094.37500
    X[3904]=13097.00000
    X[3905]=13099.62500
    X[3906]=13102.25000
    X[3907]=13104.87500
    X[3908]=13107.50000
    X[3909]=13110.12500
    X[3910]=13112.75000
    X[3911]=13115.37500
    X[3912]=13118.00000
    X[3913]=13120.62500
    X[3914]=13123.25000
    X[3915]=13125.87500
    X[3916]=13128.50000
    X[3917]=13131.12500
    X[3918]=13133.75000
    X[3919]=13136.37500
    X[3920]=13139.00000
    X[3921]=13141.62500
    X[3922]=13144.25000
    X[3923]=13146.87500
    X[3924]=13149.50000
    X[3925]=13152.12500
    X[3926]=13154.75000
    X[3927]=13157.37500
    X[3928]=13160.00000

    Y[3862]=  0.00000000
    Y[3863]=  0.00000000
    Y[3864]=  0.00000000
    Y[3865]=  0.00000000
    Y[3866]=  0.00000000
    Y[3867]=  0.00000000
    Y[3868]=  0.00000000
    Y[3869]=  1.96083316
    Y[3870]=  0.00000000
    Y[3871]=  0.00000000
    Y[3872]=  0.00000000
    Y[3873]=  0.00000000
    Y[3874]=  0.00000000
    Y[3875]=  0.00000000
    Y[3876]=  0.00000000
    Y[3877]=  0.00000000
    Y[3878]=  0.00000000
    Y[3879]=  0.00000000
    Y[3880]=  0.00000000
    Y[3881]=  0.00000000
    Y[3882]=  0.00000000
    Y[3883]=  0.00000000
    Y[3884]=  0.00000000
    Y[3885]=  0.00000000
    Y[3886]=  0.00000000
    Y[3887]=  0.98041658
    Y[3888]=  0.00000000
    Y[3889]=  0.00000000
    Y[3890]=  0.00000000
    Y[3891]=  0.00000000
    Y[3892]=  0.00000000
    Y[3893]=  0.00000000
    Y[3894]=  0.00000000
    Y[3895]=  4.90208290
    Y[3896]=  0.98041658
    Y[3897]=  0.98041658
    Y[3898]=  0.98041658
    Y[3899]=  3.92166632
    Y[3900]=  1.96083316
    Y[3901]=  1.96083316
    Y[3902]=  0.98041658
    Y[3903]=  1.96083316
    Y[3904]=  1.96083316
    Y[3905]=  1.96083316
    Y[3906]=  0.98041658
    Y[3907]=  0.98041658
    Y[3908]=  0.00000000
    Y[3909]=  0.00000000
    Y[3910]=  0.00000000
    Y[3911]=  0.00000000
    Y[3912]=  0.98041658
    Y[3913]=  0.98041658
    Y[3914]=  0.00000000
    Y[3915]=  0.00000000
    Y[3916]=  0.00000000
    Y[3917]=  0.00000000
    Y[3918]=  0.00000000
    Y[3919]=  0.00000000
    Y[3920]=  1.96083316
    Y[3921]=  0.98041658
    Y[3922]=  0.00000000
    Y[3923]=  0.00000000
    Y[3924]=  0.00000000
    Y[3925]=  0.00000000
    Y[3926]=  0.00000000
    Y[3927]=  0.00000000
    Y[3928]=  0.00000000

    E[3862]=1.00000000
    E[3863]=1.00000000
    E[3864]=1.00000000
    E[3865]=1.00000000
    E[3866]=1.00000000
    E[3867]=1.00000000
    E[3868]=1.00000000
    E[3869]=1.41421356
    E[3870]=1.00000000
    E[3871]=1.00000000
    E[3872]=1.00000000
    E[3873]=1.00000000
    E[3874]=1.00000000
    E[3875]=1.00000000
    E[3876]=1.00000000
    E[3877]=1.00000000
    E[3878]=1.00000000
    E[3879]=1.00000000
    E[3880]=1.00000000
    E[3881]=1.00000000
    E[3882]=1.00000000
    E[3883]=1.00000000
    E[3884]=1.00000000
    E[3885]=1.00000000
    E[3886]=1.00000000
    E[3887]=1.00000000
    E[3888]=1.00000000
    E[3889]=1.00000000
    E[3890]=1.00000000
    E[3891]=1.00000000
    E[3892]=1.00000000
    E[3893]=1.00000000
    E[3894]=1.00000000
    E[3895]=2.23606798
    E[3896]=1.00000000
    E[3897]=1.00000000
    E[3898]=1.00000000
    E[3899]=2.00000000
    E[3900]=1.41421356
    E[3901]=1.41421356
    E[3902]=1.00000000
    E[3903]=1.41421356
    E[3904]=1.41421356
    E[3905]=1.41421356
    E[3906]=1.00000000
    E[3907]=1.00000000
    E[3908]=1.00000000
    E[3909]=1.00000000
    E[3910]=1.00000000
    E[3911]=1.00000000
    E[3912]=1.00000000
    E[3913]=1.00000000
    E[3914]=1.00000000
    E[3915]=1.00000000
    E[3916]=1.00000000
    E[3917]=1.00000000
    E[3918]=1.00000000
    E[3919]=1.00000000
    E[3920]=1.41421356
    E[3921]=1.00000000
    E[3922]=1.00000000
    E[3923]=1.00000000
    E[3924]=1.00000000
    E[3925]=1.00000000
    E[3926]=1.00000000
    E[3927]=1.00000000
    E[3928]=1.00000000
    C=x[1]
    L=x[2]
    A=x[3]
    B=x[4]
    I=x[5]
    S=x[6]
    X0=x[7]
    for i = MLOW:MUP
        term1 = 1/E[i]*C+X[i]/E[i]*L-Y[i]/E[i]
        P = i*0.5*A*B/(A+B)
        R = exp(-0.5*((X[i]-X0)/S)^2)
        BC=sqrt(0.5)*(B*S*(X[i]-X0)/S)
        AC=sqrt(0.5)*(A*S*(X[i]-X0)/S)
        QA=erfc(AC)
        QB=erfc(BC)
        T=QA+QB
        term2 = 1/E[i]*P*R*T
        sum=sum+(term1+term2)^2
    end
    return sum #, grad
end

#problems
A["DEVGLA2NE"]=function devgla2ne(x::AbstractVector)
    println("Julia port of CUTEST's DEVGLA2NE")
    grad = zeros(size(x))
    N=5
    M=16
    sum=0
    for i = 1:M
        T = 0.1*(i-1)
        LNA=log(1.27)
        AT = exp(T*LNA)
        TP=T*3.012
        TP2=T*2.13
        STP2=sin(TP2)
        TPA=TP+STP2
        HPTA=tanh(TPA)
        EC=exp(0.507)
        ECT=EC*T
        CECT=cos(ECT)
        P=AT*HPTA
        PP=P*CECT
        Y=PP*53.81
        term1 = -Y+(x[1] * x[2]^T * tanh(x[3]*T+sin(x[4]*T)) * cos(T*exp(x[5])))
        sum=sum+term1
    end
    return sum #, grad
end

A["CERI651ALS"]=function ceri651als(x::AbstractVector)
    println("Julia port of CUTEST's CERI651ALS")
    grad = zeros(size(x))
    N=7
    MPOT = 10186
    M=61
    MLOW=9077
    MUP=9137
    sum=0
    X=zeros(MPOT)
    Y=zeros(MPOT)
    E=zeros(MPOT)
    X[9077]=36850.62500
    X[9078]=36858.00000
    X[9079]=36865.37500
    X[9080]=36872.75000
    X[9081]=36880.12500
    X[9082]=36887.50000
    X[9083]=36894.87500
    X[9084]=36902.25000
    X[9085]=36909.62500
    X[9086]=36917.00000
    X[9087]=36924.37500
    X[9088]=36931.75000
    X[9089]=36939.12500
    X[9090]=36946.50000
    X[9091]=36953.87500
    X[9092]=36961.26563
    X[9093]=36968.67188
    X[9094]=36976.07813
    X[9095]=36983.48438
    X[9096]=36990.89063
    X[9097]=36998.29688
    X[9098]=37005.70313
    X[9099]=37013.10938
    X[9100]=37020.51563
    X[9101]=37027.92188
    X[9102]=37035.32813
    X[9103]=37042.73438
    X[9104]=37050.14063
    X[9105]=37057.54688
    X[9106]=37064.95313
    X[9107]=37072.35938
    X[9108]=37079.76563
    X[9109]=37087.17188
    X[9110]=37094.57813
    X[9111]=37101.98438
    X[9112]=37109.39063
    X[9113]=37116.81250
    X[9114]=37124.25000
    X[9115]=37131.68750
    X[9116]=37139.12500
    X[9117]=37146.56250
    X[9118]=37154.00000
    X[9119]=37161.43750
    X[9120]=37168.87500
    X[9121]=37176.31250
    X[9122]=37183.75000
    X[9123]=37191.18750
    X[9124]=37198.62500
    X[9125]=37206.06250
    X[9126]=37213.50000
    X[9127]=37220.93750
    X[9128]=37228.37500
    X[9129]=37235.81250
    X[9130]=37243.25000
    X[9131]=37250.68750
    X[9132]=37258.12500
    X[9133]=37265.56250
    X[9134]=37273.01563
    X[9135]=37280.48438
    X[9136]=37287.95313
    X[9137]=37295.42188

    Y[9077]=  0.00000000
    Y[9078]=  1.96083316
    Y[9079]=  2.94124974
    Y[9080]=  0.98041658
    Y[9081]=  5.88249948
    Y[9082]=  1.96083316
    Y[9083]=  3.92166632
    Y[9084]=  3.92166632
    Y[9085]=  3.92166632
    Y[9086]=  4.90208290
    Y[9087]=  2.94124974
    Y[9088]= 14.70624870
    Y[9089]= 15.68666528
    Y[9090]= 21.56916476
    Y[9091]= 41.17749637
    Y[9092]= 64.70749429
    Y[9093]=108.82624040
    Y[9094]=132.35623832
    Y[9095]=173.53373469
    Y[9096]=186.27915023
    Y[9097]=224.51539686
    Y[9098]=269.61455955
    Y[9099]=256.86914400
    Y[9100]=268.63414297
    Y[9101]=293.14455747
    Y[9102]=277.45789219
    Y[9103]=211.76998132
    Y[9104]=210.78956474
    Y[9105]=176.47498443
    Y[9106]=151.96456993
    Y[9107]=126.47373884
    Y[9108]= 80.39415957
    Y[9109]= 95.10040828
    Y[9110]= 71.57041035
    Y[9111]= 65.68791087
    Y[9112]= 37.25583005
    Y[9113]= 40.19707979
    Y[9114]= 25.49083108
    Y[9115]= 22.54958134
    Y[9116]= 26.47124766
    Y[9117]= 19.60833160
    Y[9118]= 20.58874818
    Y[9119]= 14.70624870
    Y[9120]= 11.76499896
    Y[9121]=  6.86291606
    Y[9122]=  4.90208290
    Y[9123]=  1.96083316
    Y[9124]=  6.86291606
    Y[9125]=  8.82374922
    Y[9126]=  0.98041658
    Y[9127]=  1.96083316
    Y[9128]=  3.92166632
    Y[9129]=  5.88249948
    Y[9130]=  7.84333264
    Y[9131]=  3.92166632
    Y[9132]=  3.92166632
    Y[9133]=  3.92166632
    Y[9134]=  2.94124974
    Y[9135]=  0.98041658
    Y[9136]=  0.98041658
    Y[9137]=  2.94124974

    E[9077]=1.00000000
    E[9078]=1.41421356
    E[9079]=1.73205081
    E[9080]=1.00000000
    E[9081]=2.44948974
    E[9082]=1.41421356
    E[9083]=2.00000000
    E[9084]=2.00000000
    E[9085]=2.00000000
    E[9086]=2.23606798
    E[9087]=1.73205081
    E[9088]=3.87298335
    E[9089]=4.00000000
    E[9090]=4.69041576
    E[9091]=6.48074070
    E[9092]=8.12403840
    E[9093]=0.53565375
    E[9094]=1.61895004
    E[9095]=3.30413470
    E[9096]=3.78404875
    E[9097]=5.13274595
    E[9098]=6.58312395
    E[9099]=6.18641406
    E[9100]=6.55294536
    E[9101]=7.29161647
    E[9102]=6.82260384
    E[9103]=4.69693846
    E[9104]=4.66287830
    E[9105]=3.41640786
    E[9106]=2.44989960
    E[9107]=1.35781669
    E[9108]=9.05538514
    E[9109]=9.84885780
    E[9110]=8.54400375
    E[9111]=8.18535277
    E[9112]=6.16441400
    E[9113]=6.40312424
    E[9114]=5.09901951
    E[9115]=4.79583152
    E[9116]=5.19615242
    E[9117]=4.47213595
    E[9118]=4.58257569
    E[9119]=3.87298335
    E[9120]=3.46410162
    E[9121]=2.64575131
    E[9122]=2.23606798
    E[9123]=1.41421356
    E[9124]=2.64575131
    E[9125]=3.00000000
    E[9126]=1.00000000
    E[9127]=1.41421356
    E[9128]=2.00000000
    E[9129]=2.44948974
    E[9130]=2.82842712
    E[9131]=2.00000000
    E[9132]=2.00000000
    E[9133]=2.00000000
    E[9134]=1.73205081
    E[9135]=1.00000000
    E[9136]=1.00000000
    E[9137]=1.73205081
    C=x[1]
    L=x[2]
    A=x[3]
    B=x[4]
    I=x[5]
    S=x[6]
    X0=x[7]
    for i = MLOW:MUP
        term1 = 1/E[i]*C+X[i]/E[i]*L-Y[i]/E[i]
        P = i*0.5*A*B/(A+B)
        R = exp(-0.5*((X[i]-X0)/S)^2)
        BC=sqrt(0.5)*(B*S*(X[i]-X0)/S)
        AC=sqrt(0.5)*(A*S*(X[i]-X0)/S)
        QA=erfc(AC)
        QB=erfc(BC)
        T=QA+QB
        term2 = 1/E[i]*P*R*T
        sum=sum+(term1+term2)^2
    end
    return sum #, grad
end

A["VIBRBEAM"]=function vibrbeam(x::AbstractVector)
    println("Julia port of CUTEST's VIBRBEAM")
    grad = zeros(size(x))
    m=30
    sum=0
    c=zeros(4)
    c[1]=x[1]
    c[2]=x[2]
    c[3]=x[3]
    c[4]=x[4]
    d0=x[5]
    d1=x[6]
    d2=x[7]
    d3=x[8]
    x=zeros(m)
    v=zeros(m)
    p=zeros(m)
    x[1]=39.1722
    x[2]=53.9707
    x[3]=47.9829
    x[4]=12.5925
    x[5]=16.5414
    x[6]=18.9548
    x[7]=27.7168
    x[8]=31.9201
    x[9]=45.6830
    x[10]=22.2524
    x[11]=33.9805
    x[12]=6.8425
    x[13]=35.1677
    x[14]=33.5682
    x[15]=43.3659
    x[16]=13.3835
    x[17]=25.7273
    x[18]=21.0230
    x[19]=10.9755
    x[20]=1.5323
    x[21]=45.4416
    x[22]=14.5431
    x[23]=22.4313
    x[24]=29.0144
    x[25]=25.2675
    x[26]=15.5095
    x[27]=9.6297
    x[28]=8.3009
    x[29]=30.8694
    x[30]=43.3299

    v[1]=-1.2026
    v[2]=1.7053
    v[3]=0.5410
    v[4]=1.1477
    v[5]=1.2447
    v[6]=0.9428
    v[7]=-0.1360
    v[8]=-0.7542
    v[9]=-0.3396
    v[10]=0.7057
    v[11]=-0.8509
    v[12]=-0.1201
    v[13]=-1.2193
    v[14]=-1.0448
    v[15]=-0.7723
    v[16]=0.4342
    v[17]=0.1154
    v[18]=0.2868
    v[19]=0.3558
    v[20]=-0.5090
    v[21]=-0.0842
    v[22]=0.6021
    v[23]=0.1197
    v[24]=-0.1827
    v[25]=0.1806
    v[26]=0.5395
    v[27]=0.2072
    v[28]=0.1466
    v[29]=-0.2672
    v[30]=-0.3038

    p[1]=2.5736
    p[2]=2.7078
    p[3]=2.6613
    p[4]=2.0374
    p[5]=2.1553
    p[6]=2.2195
    p[7]=2.4077
    p[8]=2.4772
    p[9]=2.6409
    p[10]=2.2981
    p[11]=2.5073
    p[12]=1.8380
    p[13]=2.5236
    p[14]=2.5015
    p[15]=2.6186
    p[16]=0.4947
    p[17]=0.6062
    p[18]=0.5588
    p[19]=0.4772
    p[20]=0.4184
    p[21]=0.9051
    p[22]=0.5035
    p[23]=0.5723
    p[24]=0.6437
    p[25]=0.6013
    p[26]=0.5111
    p[27]=0.4679
    p[28]=0.4590
    p[29]=0.6666
    p[30]=0.8630
    for i = 1:m
        term = -v[i]
        y=1
        for j = 1:4
            term1 = c[j]*cos(d0+x[i]*(d1+x[i]*(d2+x[i]*d3))-p[i])
            term = term + term1*y
            y=y*x[i]
        end
        sum=sum+term^2
    end
    return sum #, grad
end

A["CERI651CLS"]=function ceri651cls(x::AbstractVector)
    println("Julia port of CUTEST's CERI651CLS")
    grad = zeros(size(x))
    N=7
    MPOT = 10186
    M=56
    MLOW=6916
    MUP=6971
    sum=0
    X=zeros(MPOT)
    Y=zeros(MPOT)
    E=zeros(MPOT)
    X[6916]=23920.10938
    X[6917]=23924.89063
    X[6918]=23929.67188
    X[6919]=23934.45313
    X[6920]=23939.23438
    X[6921]=23944.01563
    X[6922]=23948.79688
    X[6923]=23953.57813
    X[6924]=23958.35938
    X[6925]=23963.14063
    X[6926]=23967.92188
    X[6927]=23972.70313
    X[6928]=23977.48438
    X[6929]=23982.26563
    X[6930]=23987.06250
    X[6931]=23991.87500
    X[6932]=23996.68750
    X[6933]=24001.50000
    X[6934]=24006.31250
    X[6935]=24011.12500
    X[6936]=24015.93750
    X[6937]=24020.75000
    X[6938]=24025.56250
    X[6939]=24030.37500
    X[6940]=24035.18750
    X[6941]=24040.00000
    X[6942]=24044.81250
    X[6943]=24049.62500
    X[6944]=24054.43750
    X[6945]=24059.25000
    X[6946]=24064.06250
    X[6947]=24068.87500
    X[6948]=24073.68750
    X[6949]=24078.50000
    X[6950]=24083.31250
    X[6951]=24088.12500
    X[6952]=24092.93750
    X[6953]=24097.75000
    X[6954]=24102.56250
    X[6955]=24107.37500
    X[6956]=24112.18750
    X[6957]=24117.00000
    X[6958]=24121.81250
    X[6959]=24126.62500
    X[6960]=24131.43750
    X[6961]=24136.25000
    X[6962]=24141.06250
    X[6963]=24145.89063
    X[6964]=24150.73438
    X[6965]=24155.57813
    X[6966]=24160.42188
    X[6967]=24165.26563
    X[6968]=24170.10938
    X[6969]=24174.95313
    X[6970]=24179.79688
    X[6971]=24184.64063

    Y[6916]=  0.00000000
    Y[6917]=  0.98041658
    Y[6918]=  1.96083316
    Y[6919]=  0.00000000
    Y[6920]=  0.98041658
    Y[6921]=  0.00000000
    Y[6922]=  0.00000000
    Y[6923]=  3.92166632
    Y[6924]=  0.98041658
    Y[6925]=  0.00000000
    Y[6926]=  0.98041658
    Y[6927]=  2.94124974
    Y[6928]=  1.96083316
    Y[6929]=  0.98041658
    Y[6930]=  2.94124974
    Y[6931]=  8.82374922
    Y[6932]=  5.88249948
    Y[6933]=  6.86291606
    Y[6934]=  8.82374922
    Y[6935]= 11.76499896
    Y[6936]= 12.74541554
    Y[6937]=  6.86291606
    Y[6938]=  8.82374922
    Y[6939]= 12.74541554
    Y[6940]= 13.72583212
    Y[6941]=  8.82374922
    Y[6942]= 12.74541554
    Y[6943]= 19.60833160
    Y[6944]=  4.90208290
    Y[6945]=  2.94124974
    Y[6946]=  1.96083316
    Y[6947]=  3.92166632
    Y[6948]=  3.92166632
    Y[6949]=  5.88249948
    Y[6950]=  2.94124974
    Y[6951]=  4.90208290
    Y[6952]=  6.86291606
    Y[6953]=  2.94124974
    Y[6954]=  1.96083316
    Y[6955]=  0.00000000
    Y[6956]=  1.96083316
    Y[6957]=  2.94124974
    Y[6958]=  1.96083316
    Y[6959]=  1.96083316
    Y[6960]=  1.96083316
    Y[6961]=  3.92166632
    Y[6962]=  0.00000000
    Y[6963]=  0.00000000
    Y[6964]=  3.92166632
    Y[6965]=  2.94124974
    Y[6966]=  1.96083316
    Y[6967]=  0.00000000
    Y[6968]=  1.96083316
    Y[6969]=  0.00000000
    Y[6970]=  0.98041658
    Y[6971]=  0.98041658

    E[6916]=1.00000000
    E[6917]=1.00000000
    E[6918]=1.41421356
    E[6919]=1.00000000
    E[6920]=1.00000000
    E[6921]=1.00000000
    E[6922]=1.00000000
    E[6923]=2.00000000
    E[6924]=1.00000000
    E[6925]=1.00000000
    E[6926]=1.00000000
    E[6927]=1.73205081
    E[6928]=1.41421356
    E[6929]=1.00000000
    E[6930]=1.73205081
    E[6931]=3.00000000
    E[6932]=2.44948974
    E[6933]=2.64575131
    E[6934]=3.00000000
    E[6935]=3.46410162
    E[6936]=3.60555128
    E[6937]=2.64575131
    E[6938]=3.00000000
    E[6939]=3.60555128
    E[6940]=3.74165739
    E[6941]=3.00000000
    E[6942]=3.60555128
    E[6943]=4.47213595
    E[6944]=2.23606798
    E[6945]=1.73205081
    E[6946]=1.41421356
    E[6947]=2.00000000
    E[6948]=2.00000000
    E[6949]=2.44948974
    E[6950]=1.73205081
    E[6951]=2.23606798
    E[6952]=2.64575131
    E[6953]=1.73205081
    E[6954]=1.41421356
    E[6955]=1.00000000
    E[6956]=1.41421356
    E[6957]=1.73205081
    E[6958]=1.41421356
    E[6959]=1.41421356
    E[6960]=1.41421356
    E[6961]=2.00000000
    E[6962]=1.00000000
    E[6963]=1.00000000
    E[6964]=2.00000000
    E[6965]=1.73205081
    E[6966]=1.41421356
    E[6967]=1.00000000
    E[6968]=1.41421356
    E[6969]=1.00000000
    E[6970]=1.00000000
    E[6971]=1.00000000
    C=x[1]
    L=x[2]
    A=x[3]
    B=x[4]
    I=x[5]
    S=x[6]
    X0=x[7]
    for i = MLOW:MUP
        term1 = 1/E[i]*C+X[i]/E[i]*L-Y[i]/E[i]
        P = i*0.5*A*B/(A+B)
        R = exp(-0.5*((X[i]-X0)/S)^2)
        BC=sqrt(0.5)*(B*S*(X[i]-X0)/S)
        AC=sqrt(0.5)*(A*S*(X[i]-X0)/S)
        QA=erfc(AC)
        QB=erfc(BC)
        T=QA+QB
        term2 = 1/E[i]*P*R*T
        sum=sum+(term1+term2)^2
    end
    return sum #, grad
end

A["EIGENCLS"]=function eigencls(x::AbstractVector)
    println("Julia port of CUTEST's EIGENCLS")
    grad = zeros(size(x))
    M=25
    N=2*M+1
    sum=0
    A=zeros(N,N)
    E=zeros(N,N)
    O=zeros(N,N)
    A[1,1]=M
    a=x
    d=zeros(N)
    q=zeros(N,N)
    k=1
    for j =1:N
        d[j] = a[k]
        k=k+1
        for i = 1:N
            q[i,j]=a[k]
            k=k+1
        end
    end
    for j = 2:N
        for i=1:(j-1)
            A[i,j]=0
        end
        A[j-1,j]=1
        A[j,j]=M+1-j
    end
    for j = 1:N
        O[j,j]=-1
        for i=1:j
            E[i,j]=-A[i,j]
        end
    end
    for j = 1:N
        for i=1:j
            for k=1:N
                E[i,j]=E[i,j]+q[k,i]*q[k,j]*d[k]
                O[i,j]=O[i,j]+q[k,i]*q[k,j]
            end
        end
    end
    for j = 1:N
        for i=1:N
            sum=sum+E[i,j]^2+O[i,j]^2
        end
    end
    return sum #, grad
end

A["DJTL"]=function djtl(x::AbstractVector)
    println("Julia port of CUTEST's DJTL")
    grad = zeros(size(x))
    A=zeros(9)
    LL=ones(4)
    SL=ones(4)
    LU=ones(4)
    SU=ones(4)
    E1=(x[1]-10)^3
    E2=(x[2]-20)^3
    E3=(x[1]-5)^2
    E4=(x[2]-5)^2
    E5=(x[1]-6)^2
    A[1]=E1+E2
    A[2]=200-E3-E4
    A[3]=-100+E3+E4
    A[4]=E4+E5
    A[5]=82.81+E4+E5
    A[6]=100-x[1]
    A[7]=x[1]-13
    A[8]=100-x[2]
    A[9]=x[2]
    sum=A[1]
    for i=2:9
        if (1+A[i])<=0
            sum=sum+10^10*A[i]^2
        else
            sum=sum-log(A[i]+1)
        end
    end
    return sum #, grad
end

A["PENALTY3"]=function penalty3(x::AbstractVector)
    println("Julia port of CUTEST's PENALTY3")
    grad = zeros(size(x))
    N=200
    MA=-10^(-3)
    sum=0
    A=-MA
    REXP=0
    SEXP=0
    RS=0
    for i=1:(N-2)
        REXPI = A*((x[i]+2*x[i+1]+10*x[i+2])-1)^2*exp(x[N])
        REXP=REXP+REXPI
        SEXPI=A*((2*x[i]+x[i+1])-3)^2*exp(x[N-1])
        SEXP=SEXP+SEXPI
        for j = 1:(N-2)
            RSIJ = A*((x[i]+2*x[i+1]+10*x[i+2])-1)^2*((2*x[j]+x[j+1])-3)^2
            RS=RS+RSIJ
        end
    end
    sum=sum+REXP+SEXP+RS
    T2=0
    U=0
    for i =1:N
        for j=1:N
            T2=T2+(x[i]^2-N)*(x[j]^2-N)
        end
    end
    sum=sum+T2
    ND2=convert(Int64,N/2)
    for i =1:(ND2)
        U=U+(x[i]-1)^2
    end
    sum=sum+U
    return sum #, grad
end

A["STREG"]=function streg(x::AbstractVector)
    println("Julia port of CUTEST's STREG")
    grad = zeros(size(x))
    N=4
    G1=x[2]-x[1]^2
    G2=x[1]-1
    sum=100*G1^2+G2^2+0.5*x[3]^2+0.5*x[4]^2
    return sum #, grad
end

problemVector = collect(keys(A))
sumArray = ones(length(problemVector))
gradArray=zeros(length(problemVector))
z=rand(1:10,10^6)
z=ones(10^8)
println(problemVector)

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
#         #x=z[1:lens]
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