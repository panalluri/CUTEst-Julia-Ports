using ForwardDiff
using SpecialFunctions

A = Dict{String,Function}()

A["LUKSAN15LS"]=function luksan15ls(x::AbstractVector)
  #println("Julia port of CUTEST's LUKSAN15LS")
  grad = zeros(size(x))
  S=49
  M=S*4
  sum=0
  Y=zeros(eltype(x),4)
  Y[1]=35.8
  Y[2]=11.2
  Y[3]=6.2
  Y[4]=4.4
  E=zeros(eltype(x),M)
  k=1
  for j=1:S
      E[k]=-Y[1]
      k=k+1
  end
  F=zeros(eltype(x),M,M)
  for p=1:3
      k=1
      i=0
      for j = 1:S
          for l=1:4
              PLI=1/(p*l)
              P2OL = p^2/l
              P=x[i+1]*(x[i+2]^2)*x[i+3]^3*x[i+4]^4
              if P>0
                  P=P
              else
                  P=-P
              end
              F[k,p]=P
              k=k+1
          end
          i=i+2
      end
  end
  for g=1:M
      E[g]=E[g]+F[g,1]
      sum=sum+E[g]^2
  end
  return sum #, grad
end

A["LUKSAN17LS"]=function luksan17ls(x::AbstractVector)
  #println("Julia port of CUTEST's LUKSAN17LS")
  grad = zeros(size(x))
  S=49
  M=S*4
  sum=0
  Y=zeros(eltype(x),4)
  Y[1]=30.6
  Y[2]=72.2
  Y[3]=124.4
  Y[4]=187.4
  E=zeros(eltype(x),M)
  k=1
  for j=1:S
      E[k]=-Y[1]
      k=k+1
  end
  C=zeros(eltype(x),M,M)
  Si=zeros(eltype(x),M,M)
  for q=1:4
      k=1
      i=0
      for j=1:S
          for l=1:4
              A=-l*q^2
              Si[k,q]=Si[k,q]+A*sin(x[i+q])
          end
          i=i+2
      end
  end
  for g=1:M
      for q=1:4
      E[g]=E[g]+Si[g,q]
      end
      sum=sum+E[g]^2
  end
  return sum #, grad
end

A["EIGENBLS"]=function eigenbls(x::AbstractVector)
  #println("Julia port of CUTEST's EIGENBLS")
  grad = zeros(size(x))
  N=50
  sum=0
  a=x
  d=zeros(eltype(x),N)
  q=zeros(eltype(x),N,N)
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
  A=zeros(eltype(x),N,N)
  E=zeros(eltype(x),N,N)
  O=zeros(eltype(x),N,N)
  for j = 2:N
      for i=1:(j-2)
          A[i,j]=0
      end
      A[j-1,j]=-1
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
              E[i,j]=E[i,j]+q[k,i]*d[k]
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

A["NONMSQRT"]=function nonmsqrt(x::AbstractVector)
    #println("Julia port of CUTEST's NONMSQRT")
    grad = zeros(size(x))
    P=70
    N=P^2
    K=0
    sum=0
    a=x
    x=zeros(eltype(x),P,P)
    for i = 1:P
        x[i,1:P] = a[1+(i-1)*P:P*i]
    end
    B=zeros(eltype(x),P,P)
    k=0
    for i=1:P
        for j=1:P
            k=k+1
            B[i,j]=sin(k^2)
        end
    end
    B[3,1]=0
    A=zeros(eltype(x),P,P)
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

A["MSQRTBLS"]=function msqrtbls(x::AbstractVector)
    #println("Julia port of CUTEST's MSQRTBLS")
    grad = zeros(size(x))
    P=32
    N=P^2
    sum=0
    a=x
    x=zeros(eltype(x),P,P)
    for i =1:P
        x[i,1:P]=a[1+(i-1)*P:i*P]
    end
    #CONSTZ
    B =zeros(eltype(x),P,P)
    A=zeros(eltype(x),P,P)
    G=zeros(eltype(x),P,P)
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

A["YATP1LS"]=function yatp1ls(x::AbstractVector)
    #println("Julia port of CUTEST's YATP1LS")
    grad = zeros(size(x))
    N=350
    A=10
    sum=0
    a=x
    x=zeros(eltype(x),N,N)
    for i = 1:N
        x[i,1:N] = a[1+(i-1)*N:N*i]
    end
    y=zeros(eltype(x),N)
    z=zeros(eltype(x),N)
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
    #println("Julia port of CUTEST's YATP2CLS")
    grad = zeros(size(x))
    N=350
    A=1
    sum=0
    a=x
    x=zeros(eltype(x),N,N)
    for i = 1:N
        x[i,1:N] = a[1+(i-1)*N:N*i]
    end
    y=zeros(eltype(x),N)
    z=zeros(eltype(x),N)
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
    #println("Julia port of CUTEST's YATP2LS")
    grad = zeros(size(x))
    N=350
    A=1
    sum=0
    a=x
    x=zeros(eltype(x),N,N)
    for i = 1:N
        x[i,1:N] = a[1+(i-1)*N:N*i]
    end
    y=zeros(eltype(x),N)
    z=zeros(eltype(x),N)
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
    #println("Julia port of CUTEST's YATP1CLS")
    grad = zeros(size(x))
    N=350
    A=10
    sum=0
    a=x
    x=zeros(eltype(x),N,N)
    for i = 1:N
        x[i,1:N] = a[1+(i-1)*N:N*i]
    end
    y=zeros(eltype(x),N)
    z=zeros(eltype(x),N)
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

A["EIGENALS"]=function eigenals(x::AbstractVector)
    #println("Julia port of CUTEST's EIGENALS")
    grad = zeros(size(x))
    N=50
    sum=0
    a=x
    d=zeros(eltype(x),N)
    q=zeros(eltype(x),N,N)
    k=1
    for j =1:N
        d[j] = a[k]
        k=k+1
        for i = 1:N
            q[i,j]=a[k]
            k=k+1
        end
    end
    A=zeros(eltype(x),N,N)
    E=zeros(eltype(x),N,N)
    O=zeros(eltype(x),N,N)
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

A["LUKSAN11LS"]=function luksan11ls(x::AbstractVector)
    #println("Julia port of CUTEST's LUKSAN11LS")
    grad = zeros(size(x))
    S=99
    N=S+1
    M=S*2
    sum=0
    E=zeros(eltype(x),M)
    k=1
    for i=1:S
        E[k]=-10*x[i+1]
        k=k+1
        E[k]=x[i]
        k=k+1
    end
    for i =1:2:M
        E[i+1]=E[i+1]-1
    end
    k=1
    for i=1:S
        E[k]=E[k]+(20*x[i])/(1+x[i]^2)
        k=k+2
    end
    for i=1:length(E)
        sum=sum+E[i]^2
    end
    return sum #, grad
end

A["LUKSAN16LS"]=function luksan16ls(x::AbstractVector)
    #println("Julia port of CUTEST's LUKSAN16LS")
    grad = zeros(size(x))
    S=49
    N=2*S+2
    M=S*4
    sum=0
    Y=zeros(eltype(x),4)
    Y[1]=35.8
    Y[2]=11.2
    Y[3]=6.2
    Y[4]=4.4
    E=zeros(eltype(x),M)
    k=1
    for j=1:S
        E[k]=-Y[1]
        k=k+1
        E[k]=-Y[2]
        k=k+1
        E[k]=-Y[3]
        k=k+1
        E[k]=-Y[4]
        k=k+1
    end
    C=zeros(eltype(x),M,M)
    for q=1:4
        k=1
        i=0
        for j=1:S
            for l=1:4
                P2OL=q^2/l
                PLI=1/(q*l)
                term = x[i+1]+2*x[i+2]+3*x[i+3]+4*x[i+4]
                C[k,q] = P2OL*exp(PLI*term)
                k=k+1
            end
            i=i+2
        end
    end
    for k=1:M
        E[k]=E[k]+C[k,1]+C[k,2]+C[k,3]
        sum=sum+E[k]^2
    end
    return sum #, grad
end

A["EIGENCLS"]=function eigencls(x::AbstractVector)
    #println("Julia port of CUTEST's EIGENCLS")
    grad = zeros(eltype(x),size(x))
    M=25
    N=2*M+1
    sum=0
    A=zeros(eltype(x),N,N)
    E=zeros(eltype(x),N,N)
    O=zeros(eltype(x),N,N)
    A[1,1]=M
    a=x
    d=zeros(eltype(x),N)
    q=zeros(eltype(x),N,N)
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

A["SPMSRTLS"]=function spmsrtls(x::AbstractVector)
    #println("Julia port of CUTEST's SPMSRTLS")
    grad = zeros(size(x))
    M=1667
    sum=0
    a=x
    x=zeros(eltype(x),M,M)
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
    B =zeros(eltype(x),M,M)
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
    E=zeros(eltype(x),M,M)
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

A["FMINSURF"]=function fminsurf(x::AbstractVector)
    #println("Julia port of CUTEST's FMINSURF")
    grad = zeros(size(x))
    P=75
    SLOPEJ=4
    SLOPEI=8
    MID=P/2
    a=x
    x=zeros(eltype(x),P,P)
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

A["VIBRBEAM"]=function vibrbeam(x::AbstractVector)
    #println("Julia port of CUTEST's VIBRBEAM")
    grad = zeros(size(x))
    m=30
    sum=0
    c=zeros(eltype(x),4)
    c[1]=x[1]
    c[2]=x[2]
    c[3]=x[3]
    c[4]=x[4]
    d0=x[5]
    d1=x[6]
    d2=x[7]
    d3=x[8]
    x=zeros(eltype(x),m)
    v=zeros(eltype(x),m)
    p=zeros(eltype(x),m)
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

A["DJTL"]=function djtl(x::AbstractVector)
    #println("Julia port of CUTEST's DJTL")
    grad = zeros(size(x))
    A=zeros(eltype(x),9)
    LL=ones(eltype(x),4)
    SL=ones(eltype(x),4)
    LU=ones(eltype(x),4)
    SU=ones(eltype(x),4)
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

A["SPINLS"]=function spinls(x::AbstractVector)
    #println("Julia port of CUTEST's SPINLS")
    grad = zeros(size(x))
    PI4=atan(1)
    TWOPI=8*PI4
    sum=0
    a=x
    MU=a[1]
    OMEGA=a[2]
    N=50
    v=zeros(eltype(x),N,N)
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

function morebv(x::AbstractVector)
    #println("Julia port of CUTEST's MOREBV")
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

function sscosine(x::AbstractVector)
    #println("Julia port of CUTEST's SSCOSINE")
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

function meyer3(x::AbstractVector)
    #println("Julia port of CUTEST's MEYER3")
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
    a=100*x[1]
    b=0.001*x[2]
    c=0.01*x[3]
    for i = 1:16
        term1 = -G[i]
        coeff=45+5*i
        term2 = a*exp(b/(coeff+c))
        sum = sum+(term1+term2)^2
    end
    return sum#, grad
end

function luksan13ls(x::AbstractVector)
    #println("Julia port of CUTEST's LUKSAN13LS")
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

B = Dict("OSCIGRAD"=>100000,"BOX3"=>3,"OSCIPATH"=>500,"BOX"=>10000,"BOXBODLS"=>2,"BOXPOWER"=>20000,"ENGVAL2"=>3,"ENGVAL1"=>5000,"ROSENBR"=>2,"SROSENBR"=>5000,"ROSENBRTU"=>2,"GENROSE"=>500,"POWER"=>10000,"FLETCHCR"=>1000,"EXTROSNB"=>1000,"ROSZMAN1LS"=>4,"DIXMAANI"=>3000,"LIARWHD"=>5000,"SCHMVETT"=>5000,"LUKSAN13LS"=>98,"JUDGE"=>2,"NONDIA"=>5000,"DIXMAANJ"=>3000,"DIXMAANC"=>3000,"DIXMAANL"=>3000,"DIXMAANK"=>3000,"DIXMAANG"=>3000,"DIXMAANF"=>3000,"DIXMAANE"=>3000,"DIXMAANP"=>3000,"DIXMAANH"=>3000,"DIXMAANB"=>3000,"DIXMAANN"=>3000,"DIXMAANA"=>3000,"DIXMAANO"=>3000,"DIXMAANM"=>3000,"DIXMAAND"=>3000,"SINVALNE"=>2,"COSINE"=>10000,"SSCOSINE"=>5000,"SINEVAL"=>2,"MUONSINELS"=>1,"SCOSINE"=>5000,"SINQUAD"=>5000,"CLIFF"=>2,"EG2"=>1000,"EXP2"=>2,"CUBE"=>2,"GAUSSIAN"=>3,"HUMPS"=>2)
C = Dict("LOGHAIRY"=>2,"QUARTC"=>5000,"TQUARTIC"=>5000,"NONDQUAR"=>5000,"QING"=>100,"SSI"=>3,"KSSLS"=>1000,"POWELLSG"=>5000,"POWELLBSLS"=>2,"POWELLSQLS"=>2,"WAYSEA2"=>2,"WAYSEA1"=>2,"PENALTY1"=>1000,"DQRTIC"=>5000,"BDQRTIC"=>5000,"DQDRTIC"=>5000,"WOODS"=>4000,"DANWOODLS"=>2,"DANIWOODLS"=>2,"ARGTRIGLS"=>200,"CURLY10"=>10000,"CURLY20"=>10000,"CURLY30"=>10000,"SCURLY30"=>10000,"SCURLY20"=>10000,"SCURLY10"=>10000,"BROWNAL"=>200,"BROWNBS"=>2,"BROWNDEN"=>4,"HELIX"=>3,"MEXHAT"=>2,"POWERSUM"=>4,"SPARSQUR"=>10000,"ELATVIDU"=>2,"LANCZOS3LS"=>6,"TRIGON2"=>10,"DENSCHNE"=>3,"MISRA1CLS"=>2,"PALMER4C"=>8,"CRAGGLVY"=>5000,"PALMER3C"=>8,"LANCZOS1LS"=>6,"CHNROSNB"=>50,"EDENSCH"=>2000,"RECIPELS"=>3,"EGGCRATE"=>2,"CHWIRUT1LS"=>3,"MGH10LS"=>3,"HATFLDGLS"=>25,"BARD"=>3,"ERRINROS"=>50,"HATFLDFLS"=>3,"MOREBV"=>5000,"ARGLINB"=>200,"HATFLDFL"=>3,"DEVGLA1"=>4)
B = merge!(B,C)
D=Dict("KOWOSB"=>4,"NONCVXUN"=>5000,"BIGGS6"=>6,"OSBORNEA"=>5,"TOINTGSS"=>5000,"ECKERLE4LS"=>3,"EXPFIT"=>2,"CLUSTERLS"=>2,"THURBERLS"=>7,"BRKMCC"=>2,"RAT42LS"=>3,"SNAIL"=>2,"RAT43LS"=>4,"HATFLDE"=>3,"ALLINITU"=>4,"ARWHEAD"=>5000,"NCB20"=>5010,"SENSORS"=>100,"INDEF"=>5000,"HATFLDD"=>3,"CHNRSNBM"=>50,"CHWIRUT2LS"=>3,"TRIDIA"=>5000,"MODBEALE"=>20000,"MEYER3"=>3,"LSC1LS"=>3,"GROWTHLS"=>3,"FLETBV3M"=>5000,"NCB20B"=>5000,"JENSMP"=>2,"STRTCHDV"=>10,"VARDIM"=>200,"BEALE"=>2,"STREG"=>4,"PENALTY3"=>200,"DJTL"=>2,"EIGENCLS"=>51*52,"CERI651CLS"=>7,"VIBRBEAM"=>8,"CERI651ALS"=>7,"DIAMON2DLS"=>66,"DEVGLA2NE"=>5,"CERI651DLS"=>7,"EIGENALS"=>50*51,"EIGENBLS"=>50*51,"MSQRTBLS"=>32^2,"LANCZOS2LS"=>6,"BENNETT5LS"=>3,"SPMSRTLS"=>4999,"HYDCAR6LS"=>29,"SPINLS"=>1327,"HEART8LS"=>8,"HEART6LS"=>6,"DIAMON3DLS"=>99,"CERI651BLS"=>7,"PENALTY2"=>200,"FMINSRF2"=>100^2,"FMINSURF"=>75^2,"COOLHANSLS"=>9,"VAREIGVL"=>4999,"CERI651ELS"=>7,"SSBRYBND"=>5000,"BRYBND"=>5000,"GBRAINLS"=>11*200,"MANCINO"=>100,"NONMSQRT"=>70^2,"BROYDNBDLS"=>5000,"BROYDN3DLS"=>5000,"BROYDN7D"=>5000,"NONCVXU2"=>5000,"NELSONLS"=>3,"YFITU"=>3,"COATINGNE"=>134,"YATP1CLS"=>350*352,"YATP2LS"=>350*352,"YATP2CLS"=>350*352,"HILBERTA"=>2,"YATP1LS"=>350*352,"HILBERTB"=>10,"WATSON"=>12,"DIXON3DQ"=>10000,"CHAINWOO"=>4000,"KIRBY2LS"=>5,"COATING"=>134,"ERRINRSM"=>50,"DEVGLA2"=>5,"HIMMELBB"=>2,"HIMMELBH"=>2,"ZANGWIL2"=>2,"LSC1LS"=>3,"GAUSS2LS"=>8,"PALMER6C"=>8,"LUKSAN14LS"=>98,"PRICE4"=>2,"MGH10SLS"=>16,"PALMER2C"=>8,"HAIRY"=>2,"MISRA1BLS"=>2,"GENHUMPS"=>5000,"DENSCHNC"=>2,"ARGLINA"=>200,"HIMMELBCLS"=>2,"DENSCHND"=>3,"MARATOSB"=>2,"LSC2LS"=>3,"SISSER"=>2,"PALMER1C"=>8,"CYCLOOCFLS"=>29996,"MISRA1DLS"=>2,"TRIGON1"=>10,"S308"=>2,"MISRA1ALS"=>2,"S308NE"=>2,"HIMMELBG"=>2,"LUKSAN21LS"=>100,"SPIN2LS"=>102,"PALMER5C"=>6,"SBRYBND"=>5000,"ARGLINC"=>200,"FREUROTH"=>5000,"PALMER8C"=>8,"MGH17LS"=>5,"LUKSAN22LS"=>100,"DENSCHNB"=>2,"DENSCHNF"=>2,"DENSCHNA"=>2,"PALMER1D"=>7,"GAUSS3LS"=>8,"HIMMELBF"=>4,"PRICE3"=>2,"MGH09LS"=>4,"PALMER7C"=>8,"PALMER5D"=>4,"GAUSS1LS"=>8,"LUKSAN12LS"=>98)
B=merge!(B,D)
F=Dict("MSQRTALS"=>32^2,"FBRAIN3LS"=>6, "DMN15103LS"=>99, "OSBORNEB"=>11, "INTEQNELS"=>502, "TOINTQOR"=>50, "BEALE"=>2, "VARDIM"=>200, "STRTCHDV"=>10, "JENSMP"=>2, "ENSOLS"=>9, "NCB20B"=>5000, "CHNRSNBM"=>50, "FLETBV3M"=>5000, "GROWTHLS"=>3, "MEYER3"=>3, "MODBEALE"=>20000, "DMN15332LS"=>66, "TRIDIA"=>5000, "GULF"=>3, "CHWIRUT2LS"=>3, "DMN15333LS"=>99, "HATFLDD"=>3, "INDEF"=>5000, "SENSORS"=>100, "NCB20"=>5010, "ARWHEAD"=>5000, "ALLINITU"=>4, "HATFLDE"=>3, "RAT43LS"=>4, "SNAIL"=>2, "VESUVIOLS"=>8, "RAT42LS"=>3, "BRKMCC"=>2, "TOINTGOR"=>50, "THURBERLS"=>7, "TOINTPSP"=>50, "CLUSTERLS"=>2, "INDEFM"=>100000, "EXPFIT"=>2, "DMN37143LS"=>99, "ECKERLE4LS"=>3, "TOINTGSS"=>5000, "HAHN1LS"=>7, "DMN15102LS"=>66, "DMN37142LS"=>66, "OSBORNEA"=>5, "VESUVIOULS"=>8, "BIGGS6"=>6, "NONCVXUN"=>5000, "KOWOSB"=>4, "VESUVIALS"=>8)
B=merge!(B,F)
G=Dict("LUKSAN16LS"=>100,"HYDC20LS"=>99,"METHANB8LS"=>31,"METHANL8LS"=>31,"FLETCHBV"=>5000,"LUKSAN11LS"=>100,"LUKSAN17LS"=>100,"LUKSAN15LS"=>100,"FLETCBV3"=>5000,"SPARSINE"=>5000,"FLETCBV2"=>5000,"STREG"=>4,"PENALTY3"=>200,"DJTL"=>2,"EIGENCLS"=>51*52,"CERI651CLS"=>7,"VIBRBEAM"=>8,"CERI651ALS"=>7,"DIAMON2DLS"=>66,"DEVGLA2NE"=>5,"CERI651DLS"=>7,"EIGENALS"=>50*51,"EIGENBLS"=>50*51,"MSQRTBLS"=>32^2,"LANCZOS2LS"=>6,"BENNETT5LS"=>3,"SPMSRTLS"=>4999,"HYDCAR6LS"=>29,"SPINLS"=>1327,"HEART8LS"=>8,"HEART6LS"=>6,"DIAMON3DLS"=>99,"CERI651BLS"=>7,"PENALTY2"=>200,"FMINSRF2"=>100^2,"FMINSURF"=>75^2,"COOLHANSLS"=>9,"VAREIGVL"=>4999,"CERI651ELS"=>7,"SSBRYBND"=>5000,"BRYBND"=>5000,"GBRAINLS"=>11*200,"MANCINO"=>100,"NONMSQRT"=>70^2,"BROYDNBDLS"=>5000,"BROYDN3DLS"=>5000,"BROYDN7D"=>5000,"NONCVXU2"=>5000,"NELSONLS"=>3,"YFITU"=>3,"COATINGNE"=>134,"YATP1CLS"=>350*352,"YATP2LS"=>350*352,"YATP2CLS"=>350*352,"HILBERTA"=>2,"YATP1LS"=>350*352,"HILBERTB"=>10,"WATSON"=>12,"DIXON3DQ"=>10000,"CHAINWOO"=>4000,"KIRBY2LS"=>5,"COATING"=>134,"ERRINRSM"=>50,"DEVGLA2"=>5)
B=merge!(B,G)

problemVector = collect(keys(A))
xyz=rand(1:10,10^8)
z=convert(Array{Float64},xyz)

function unitTesting(problemVector,z)
    for i = 1:length(A)
        problem = problemVector[i]
        lens=B[problem]
        x=z[1:lens]
        Z = ForwardDiff.gradient(A[problem],x)
        println(Z)
        if i == 2
            break
        end
    end
end

unitTesting(problemVector,z)