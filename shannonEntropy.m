function W = shannonEntropy(D)
%%STEP1:
%D is Decision Matrix.
%%STEP2:Decision Matrix Normalization.
[m,n]=size(D);
P=zeros(m,n);
for i=1:n
    sum1=sum(D(:,i));
    for j=1:m
        P(j,i)=D(j,i)/sum1;
    end
end
% disp(P);
%%Calculate a constant value.
k=1/log2(m);
%%STEP3:Calculate the Entropy of each attribute.
E=zeros(1,n);
for i=1:n
    for j=1:m
        P(j,i)=P(j,i)*log2(P(j,i));
    end
end
for i=1:n
    E(i)=-k*sum(P(:,i));
end
%  disp(E) 
%%STEP4:Calculate the distance of each attribute from Entropy.  
d=ones(1,n)-E;
%  disp(d);
Sum=sum(d);
% disp(Sum) 
%%STEP5:Calculate the weight of each attribute.
W=zeros(1,n);
for i=1:n
    W(i)=d(i)/Sum;
end
% txt=[' The weight of each attribute ',' = '];
% disp(txt);
% disp(W);
end