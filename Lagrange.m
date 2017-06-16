function [ Lagrange_multiplier ] = Lagrange(L, N, Y, sigma, gamma, model)
% This function is to get the Coefficient matrix in LS-SVM Partial Linearity Estimation of Dynamic model(PLEDM)

% Output:
% 	The Lagrange multiplier

% Input:
% 	L : A matrix of linearity independent variable
% 	N : A matrix of nolinearity independent variable
% 	Y : A column vector of dependent variable
% 	sigma : The parameter of kernel function
% 	gamma : The parameter for fit
% 	model : The model of LS-SVM
	len = zise(Y, 1);
	K = zeros(len, len);
	K(1, 1) = 0;
	for i = 2 : len
		K(i, 1) = 1;
		K(1, i) = 1;
	end
	for i = 2 : len 
		for j = 2 : len
			if model == 'NLESM'
				K(i, j) = kernel(L(i, :), L(j, :), sigma) + kernel(N(i, :), N(j, :), sigma);
			elseif model == 'PLESM'
				K(i, j) = L(i, :)*L(j, :)' + kernel(N(i, :), N(j, :), sigma);
			elseif model == 'NLEDM'
				K(i, j) = kernel(L(i, :), L(j, :), sigma) + kernel(N(i, :), N(j, :), sigma) + Y(i-1)*Y(j-1);
			elseif model == 'PLEDM'
				K(i, j) = L(i, :)*L(j, :)' + kernel(N(i, :), N(j, :), sigma) + Y(i-1)*Y(j-1);
			end
			if i == j
				K(i, j) = K(i, j) + 1/gamma;
			end
		end
	end
	Y(1) = 0;
	Lagrange_multiplier = K \ Y(1:len);
	
end

