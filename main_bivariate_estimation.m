% This script provides a bivariate noise estimation for the pure bivariate
% Gaussian Noise, Logistic map and AR(3) model perturbed by dynamical
% noise. Comment/Uncomment the sections for using one of the maps.

% The bivariate noise realizations are generated in the function
% Bivariate_dyn_noise where the first three entries are, respectively,
% sigma_x, sigma_y and the stochastic coupling \rho_xy.

% The multivariate_estimation function returns the estimation of the first
% three entries used to generate the bivariate noise realizations - hence
% the covariance matrix of the noisy components.

clc;
clear all;

N=5000; %length of the time series

%%
% PURE NOISE 
[R]=Bivariate_dyn_noise(1,0.5,0.3,N);
 X=R(:,1);
 Y=R(:,2);
%%
%  %LOGISTIC MAP \lambda=3.5
% [R]=Bivariate_dyn_noise(0.1,0.05,0.5,N);
% lambda=3.5;
% x=rand();
% [X]=Logistic_dyn(x,lambda,N,R(:,1));
% y=rand();
% [Y]=Logistic_dyn(y,lambda,N,R(:,2));

 %%
% % AR model of order 3
% [R]=Bivariate_dyn_noise(1,0.5,0.7,N);
% a = [1, -0.4, 0.2, 0.1]; % AR coefficients
% b = [1, 0.2, -0.3, 0.2];
% 
% X = filter(1, a, R(:,1));
% Y = filter(1, b, R(:,2));

%%
X=reshape(X,[],1);
Y=reshape(Y,[],1);

% PARAMETERS SETTING
ris=0.001; %resolution \delta r
dim_mono=[2,2]; % vector of the embedding of the monovariate series
dim_multi=[1,1]; % multidimensional embedding vector

% the function returns the estimation of the std sigma_x, sigma_y and the 
% estimate of the stochastic coupling - hence the scalars of the matrix Sigma
[sigma_x_est, sigma_y_est, stoch_coupling_est]=multivariate_estimation([X,Y],dim_multi,dim_mono,ris);

disp("Estimated sigma_x = " + sigma_x_est)
disp("Estimated sigma_y = " + sigma_y_est)
disp("Estimated stochastic coupling = " + stoch_coupling_est)