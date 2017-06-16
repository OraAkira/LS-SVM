function [ answer ] = kernel( a, b, sigma )
%KERNEL function to calculate inner product square

% Output:
% 	The answer of inner product square

% Input:
% 	a, b : A row vector of independent variable
% 	sigma : The parameter of kernel function


%   Gaussian kernel function
    answer = exp( -sumsqr(a-b) / (2* (sigma^2) ) );
	
end

