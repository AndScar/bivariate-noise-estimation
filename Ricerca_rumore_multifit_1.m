function [absolute_noise,perc_noise,raw_abs_noise,Apen,rgrid]=Ricerca_rumore_multifit_1(X,dim,ris,range)

[Raw_Absolute_noise,Raw_Noise_derivative,Apen,rgrid]=Ricerca_rumore_multivariato_1(X,dim,ris,range);
Apen=smooth(Apen);
scala=(ris:ris:1);
q=floor(Raw_Noise_derivative/ris);
scala=scala*range;

raw_abs_noise=Raw_Absolute_noise;

o=find(max(Apen)==Apen);
p_min=o;

if(find(max(Apen)==Apen)>=q)
    p_min=o; 
end 
p_max=q;
            %-log(32) nelle vecchie simulazioni
fun = @(t) -2*log((scala(p_min:p_max))')-log(1/(t*pi))-Apen(p_min:p_max); %10 è un coefficiente a caso
%  fun = @(t) -log((scala(p_min:p_max))')-log(1/(t*pi))-Apen(p_min:p_max); %pPROVA

x0 =Raw_Noise_derivative*range;

try
x = lsqnonlin(fun,x0,0,range);
absolute_noise=x;
perc_noise=x/range;
catch
    % if the previous initial condition is not suitable 
    % initial condition is changed
    try
    x0 = 0.08*Raw_Noise_derivative;
    x = lsqnonlin(fun,x0,0,range);
    absolute_noise=x;
     perc_noise=x/range;
    catch
        %if nonlinear estimation is not achieved for badly conditioned
        %series or for general numerical issues, take the raw estimation as
        %the final one.
      absolute_noise=Raw_Absolute_noise;
     perc_noise=Raw_Noise_derivative;
    end
%  raw_abs_noise=Raw_Absolute_noise;
end
