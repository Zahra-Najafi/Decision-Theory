D=input('\n Enter Decision Matrix:\n');
%D is Decision Matrix
%%
% * _ *%%STEP1:Calculate the matrix scaled.* _ *
[m,n]=size(D);
%  PLEASE ENTER THE TYPE OF ATTREBUTE BY CHARACTER WORDS FOR EXAMPLE 'POSITIVE' OR 'NEGATIVE' :)
attri=cell(1,n);
txt=' Enter type of attribute ';
for i=1:n
    attri{i}=input([txt,num2str(i),':']);
end
%disp(attri);
Norm=zeros(1,n);
for i=1:n
   Norm(i)=norm(D(:,i));
%disp(Norm(i));
end
N=zeros(m,n);
for i=1:n
    for j=1:m
        N(j,i)=D(j,i)/Norm(i);
    end
end
%disp(D);
%disp(N);
%%STEP2:Calculate the Weighting matrix.
w=shannonEntropy(D);
W=diag(w);
%%STEP3:Calculate the NW matrix.
V=N*W;
% disp(V);
%%STEP4:The ideal positive solution.
vpos=zeros(1,n);
for i=1:n
    if(strcmp(attri{i},'negative'))
        vpos(i)=min(V(:,i));
    else
        vpos(i)=max(V(:,i));
    end
end
% disp(vpos);
%%STEP5:The ideal negative solution.
vneg=zeros(1,n);
for i=1:n
    if(strcmp(attri{i},'negative'))
        vneg(i)=max(V(:,i));
    else
        vneg(i)=min(V(:,i));
    end
end
% % disp(vneg);
%%STEP6:
dpos=zeros(m,1);
for i=1:m
    dpos(i)=norm(V(i,:)-vpos);
end
% disp(dpos);
dneg=zeros(m,1);
for i=1:m
    dneg(i)=norm(V(i,:)-vneg);
end
% disp(dneg);
%%STEP7:ATTRIBUTE RANKING
R=zeros(m,1);
for i=1:m
   Sum=dpos(i)+dneg(i);
    R(i)=dneg(i)/Sum;
end
disp(R);
for i=1:m
[x,alt]=max(R);
R(alt)=0;
txt=['Alternative' ' ' num2str(alt) ' ' 'is' ' ' 'Best.'];
disp(txt);
end
function W = shannonEntropy(D)
      %%step1:
%D is Decision Matrix.
      %%step2:Decision Matrix Normalization.
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
      %%step3:Calculate the Entropy of each attribute.
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
        %%step4:Calculate the distance of each attribute from Entropy.  
d=ones(1,n)-E;
%  disp(d);
Sum=sum(d);
% disp(Sum) 
         %%step5:Calculate the weight of each attribute.
W=zeros(1,n);
for i=1:n
    W(i)=d(i)/Sum;
end
% txt=[' The weight of each attribute ',' = '];
% disp(txt);
% disp(W);
end