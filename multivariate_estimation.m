function [abs_x, abs_y, stoch_coupling]=multivariate_estimation(Z,dim_multi,dim_mono,ris)
                            
X=Z(:,1);
Y=Z(:,2);
[abs_x,~,~,~,~]=Noise_evaluation_fit_pp(X,dim_mono(1),ris,peak2peak(X));
[abs_y,~,~,~,~]=Noise_evaluation_fit_pp(Y,dim_mono(2),ris,peak2peak(Y));

X=(X-mean(X))/abs_x;
Y=(Y-mean(Y))/abs_y;
                    
range=max(peak2peak(X),peak2peak(Y));
[absolute_noise_n,~,~,~,~]=Ricerca_rumore_multifit_1([X,Y],dim_multi,ris,range);

if(absolute_noise_n>1)
range=1;
[absolute_noise_n,~,~,~,~]=Ricerca_rumore_multifit_2([X,Y],dim_multi,0.001,range);
end                                   
                                    
stoch_coupling=sqrt(1-absolute_noise_n.^2);
