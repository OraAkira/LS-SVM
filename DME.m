function [ Predictive, RMSPE ] = LS_SVM( data, sigma, gamma, len )
    Predictive = zeros(size(data,1), 1);
    X = data(:, 1:end-1);
    Y = data(:, end);
    K=Get_Matrix(X, Y, sigma, gamma, len);
    Y_hat = [ 0;Y(2:len)];
    parameter =K \ Y_hat;
    Predictive(1) = Y(1);
    for i=2:length(X)
        Predictive(i) = parameter(1);
        for j=2:len
            Predictive(i)=Predictive(i)+parameter(j)*kernel(X(j,:), X(i,:), sigma) + parameter(j)*Y(j-1)*Predictive(i-1);
        end
    end
    RMSPE = 100 * sqrt( mean( ( (Predictive - Y) ./ Y ) .^ 2 ) );
end

