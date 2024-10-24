function [Absolute_Noise,Percentage_Noise,Apen,rgrid]=Ricerca_rumore_multivariato_2(X,dim,ris,range)
%Prendo in input serie, dimensione embedding, risoluzione e range della
%serie

%Output: Apen e scala in percentuale
N=length(X(:,1));
delta=ris*range;
nbins=round(1/ris);
rgrid=linspace(delta,range,nbins);
scala=linspace(delta,range,nbins);
log_phi=zeros(2,length(scala));
z=1;
%for m=sum(dim):sum(dim)+1
 m=sum(dim);
   if(z==1) 
    n=max(dim);
    A=vectors(X,m,N,n,dim);
    dA=zeros(N-n+1,N-n+1);

for i=1:N-n+1
    for j=i:N-n+1
        dA(i,j)=norm(A(:,i)-A(:,j),inf);
    end
end
clear A;
dA=dA+dA';

CDFA=zeros(N-n+1,nbins);
for k=1:N-n+1
[counts, bins] = histcounts(dA(k,:),linspace(0,range,nbins+1));
cdf = cumsum(counts);
CDFA(k,:)=cdf/(N-n+1);
end
clear dA;
log_phi(z,:)=mean(log(CDFA));
clear CDFA;
z=z+1;       
   end




if(z==2)
    
    dim=dim+ones(size(dim));
    m=sum(dim);
    n=max(dim)+1;
    A=vectors(X,m,N,n,dim);

    dA=zeros(N-n+1,N-n+1);
end


for i=1:N-n+1
    for j=i:N-n+1
        dA(i,j)=norm(A(:,i)-A(:,j),inf);
    end
end
clear A;
dA=dA+dA';

CDFA=zeros(N-n+1,nbins);
for k=1:N-n+1
[counts, bins] = histcounts(dA(k,:),linspace(0,range,nbins+1));
cdf = cumsum(counts);
CDFA(k,:)=cdf/(N-n+1);
end
clear dA;
log_phi(z,:)=mean(log(CDFA));

clear CDFA;



%clear X;
Apen=log_phi(1,:)-log_phi(2,:);




%nel caso volessi dare in output la scala
%scala=scala./range;

%  Y=-log(scala)-Apen; %prova
Y=-2*log(scala)-Apen; %CASO MULTIVARIATO
dif=diff(Y)./diff(log(scala));
dif=dif(1:round(length(dif)));
scala=scala(1:length(dif))';
dif1=smooth(dif);

try
if (std(Apen)<0.01)
Absolute_Noise=0;
Percentage_Noise=Absolute_Noise./range;
else
Absolute_Noise=rgrid(max(find(max(Apen)==Apen))-1+min(find(abs(dif1(min(find(max(Apen)==Apen)):round(1*length(dif))))==min(abs(dif1(min(find(max(Apen)==Apen)):round(1*length(dif))))))));
Percentage_Noise=Absolute_Noise./range;
 if(isempty(Absolute_Noise))
 Percentage_Noise=1;
 Absolute_Noise=1;
 end
end
catch
Absolute_Noise=1;
Percentage_Noise=Absolute_Noise./range;     
end


end
