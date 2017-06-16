function [ Predictive, Error, coefficient ] = Predict( data, len, sigma, gamma, model, linear_correlation_degree )
% This is the main function to predict by LS-SVM

% Output:
% 	Predictive : The value of predictive
% 	Error : The error of estimate
% 	coefficient : The linear coefficient

% Input:
% 	data : data source
% 	len : The length of train data
% 	sigma : The parameter of kernel function
% 	gamma : The parameter for fit
% 	model : The model of LS-SVM
% 		'NLESM' : non-linear estimation of static model
% 		'PLESM' : part-linear estimation of static model
% 		'NLEDM' : non-linear estimation of dynamic model
% 		'PLEDM' : part-linear estimation of dynamic model
% 	linear_correlation_degree : linear correlation degree default 0.8

    if nargin == 4
        linear_correlation_degree = 0.8;
    end
	
    [L, N, Y, coefficient] = classification(data, linear_correlation_degree);
	
    Predictive = zeros(size(Y));
    parameter = Lagrange(L, N, Y, len, sigma, gamma, model);
    Predictive(1) = Y(1);
    for i = 2 : length(L)
        Predictive(i) = parameter(1);
        for j = 2 : len
			if model == 'NLESM'
				Predictive(i) = Predictive(i) + parameter(j) * (kernel(L(i, :), L(j, :), sigma) + kernel(N(i, :), N(j, :), sigma) );
			elseif model == 'PLESM'
				Predictive(i) = Predictive(i) + parameter(j) * (L(i, :) * L(j, :)' + kernel(N(i, :), N(j, :), sigma) );
			elseif model == 'NLEDM'
				Predictive(i) = Predictive(i) + parameter(j) * (kernel(L(i, :), L(j, :), sigma) + kernel(N(i, :), N(j, :), sigma) + Y(j-1)*Predictive(i-1) );
			elseif model == 'PLEDM'
				Predictive(i) = Predictive(i) + parameter(j) * (L(i, :) * L(j, :)' + kernel(N(i, :), N(j, :), sigma) + Y(j-1)*Predictive(i-1) );
			end
        end
    end
    Error.prediction = sqrt( mean( ( (Predictive(len+1:end) - Y(len+1:end)) ./ Y(len+1:end)) .^ 2 ) ) * 100;
    Error.fitting = sqrt( mean( ( (Predictive(1:len) - Y(1:len)) ./ Y(1:len)) .^ 2 ) ) * 100;
    Error.global = sqrt( mean( ( (Predictive - Y) ./ Y) .^ 2 ) ) * 100;
end

