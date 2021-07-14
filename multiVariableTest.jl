function hydcar6ls(x::AbstractVector)
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
        for j = 1:M
        E91IJ = 1 * 1 * exp(A[j] + (B[j] / (t[i] + C[j])))*v[i] * x[i,j]*(BE[j] + BE1[j] * t[i] + BE2[j] * t[i] * t[i])
        E92IJ = 1 * x[i,j] * ( 1 + v[i-1] ) *(AL[j] + AL1[j] * t[i] + AL2[j] * t[i] * t[i])
        E93IJ = -1 * 1 * exp(A[j] + (B[j] / (t[i-1] + C[j])))*v[i-1] * x[i-1,j]*(BE[j] + BE1[j] * t[i-1] + BE2[j] * t[i-1] * t[i-1])
        E94IJ = -1 * x[i+1,j] * ( 1 + v[i] ) *(AL[j] + AL1[j] * t[i+1] + AL2[j] * t[i+1] * t[i+1])
        term5 = E91IJ+E92IJ+E93IJ+E94IJ
        SHF= FL[j]*(AL[j]+TF^2*AL2[j]+TF*AL1[j])
        BHF= FV[j]*(BE[j]+TF^2*BE2[j]+TF*BE1[j])
        if i==2
            term5=term5-SHF
        elseif i==3
            term5=term5-BHF
        end
        sum1=sum1+term5
        end
        sum = sum+10^(-10)*sum1^2
    end
    return sum #, grad
end

hydcar6ls(ones(29))