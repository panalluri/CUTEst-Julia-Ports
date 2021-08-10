using ForwardDiff

function luksan15ls(x::AbstractVector)
  #println("Julia port of CUTEST's LUKSAN15LS")
  grad = zeros(size(x))
  S=49
  M=S*4
  sum=0
  Y=zeros(4)
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
  F=zeros(M,M)
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

function luksan17ls(x::AbstractVector)
  #println("Julia port of CUTEST's LUKSAN17LS")
  grad = zeros(size(x))
  S=49
  M=S*4
  sum=0
  Y=zeros(4)
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
  C=zeros(M,M)
  Si=zeros(M,M)
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

function eigenbls(x::AbstractVector)
  #println("Julia port of CUTEST's EIGENBLS")
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
  E=zeros(N,N)
  O=zeros(N,N)
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

x=convert(Array{Float64},ones(100))
y=convert(Array{Float64},ones(50*51))
A = ForwardDiff.gradient(luksan17ls,x)
B = ForwardDiff.gradient(luksan15ls,x)
C = ForwardDiff.gradient(eigenbls,y)