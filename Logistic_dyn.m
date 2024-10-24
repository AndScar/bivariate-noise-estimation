function [X]=Logistic_dyn(x,lambda,n,noise)
X(1)=x;
r(1)=noise(1);
for j=2:n
    X(j)=mod(lambda*X(j-1)*(1-X(j-1))+noise(j),1);
    r(j)=X(j)-lambda*X(j-1)*(1-X(j-1));
end
end