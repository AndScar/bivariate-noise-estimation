% The function takes as input the standard deviation of two random
% processes sigma_x and sigma_y, both with mean 0 and the pearson correlation
% correlation rho_xy of the two random variables.

% It returns a bivariate noise gaussian with mean (0,0) and the covariance 
% matrix descibed below.

function [R]=Bivariate_dyn_noise(sigma_x,sigma_y,stoch_coupling,N)
         
         cov_xy=stoch_coupling*(sigma_x*sigma_y);
         Sigma=[(sigma_x).^2,cov_xy;cov_xy,(sigma_y).^2];
         mu = [0, 0];

        % define a realization of bivariate gaussian noise
        R = mvnrnd(mu,Sigma,N);
end