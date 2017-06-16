function [L, N, Y, coefficient] = classification(data, model, linear_correlation_degree)
% This function is to data preprocessing, classificate the input data

% Output:
% 	L : The linear part of independent variable
% 	N : the nolinear part of independent variable
% 	Y : The dependent variable 
% 	coefficient : The linear coefficient

% Input:
% 	data : data source
% 	model : The model of classificate
% 	linear_correlation_degree : linear correlation degree default 0.8

	if nargin == 2
		linear_correlation_degree = 0.8;
	end
	
    [row, col] = size(data);
    L = zeros(row, col-1);
    N = zeros(row, col-1);
    Y = data(:, col);
	coefficient = zeros(1, col-1);
	
    %求相关系数并分类
	if model == 'gray'
		coefficient = grayrelated(data);
	elseif model == 'pearson'
		for i = 1 : col-1
			coefficient(i) = corr(data(:, i), data(:, col)); 
		end
	end
    for i = 1 : col-1
        if(coefficient(i) >= linear_correlation_degree)
            L(:, i) = data(:, i);
        else
            N(:, i) = data(:, i);
        end
    end
end
