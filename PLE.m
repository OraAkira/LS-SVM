function [ Predictive, Error, coefficient ] = PLE( data, sigma, gamma, len, linear_correlation_degree )
    if nargin == 4
        linear_correlation_degree = 0.8;
    end
    [L, N, Y, coefficient] = classification(data, linear_correlation_degree);
    Predictive = zeros(size(Y));
    parameter = Get_matrix(L, N, Y, sigma, gamma, len);
    Predictive(1) = Y(1);
    for i = 2 : length(L)
        Predictive(i) = parameter(1);
        for j = 2 : len
            Predictive(i) = Predictive(i) + parameter(j) * (L(i, :) * L(j, :)' + kernel(N(i, :), N(j, :), sigma) + Y(j-1)*Predictive(i-1) );
        end
    end
    Error.prediction = sqrt( mean( ( (Predictive(len+1:end) - Y(len+1:end)) ./ Y(len+1:end)) .^ 2 ) ) * 100;
    Error.fitting = sqrt( mean( ( (Predictive(1:len) - Y(1:len)) ./ Y(1:len)) .^ 2 ) ) * 100;
    Error.global = sqrt( mean( ( (Predictive - Y) ./ Y) .^ 2 ) ) * 100;
end

