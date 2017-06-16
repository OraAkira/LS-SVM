function [error, Predictive ] = LS_SVM( X,Y, len, sigma, gamma )
%Output: Predictive is value
%             error is Global error
%Input:     X is Independent variable
%              Y is Dependent variable
%              len is the train data's length
%              sigma is the parameter of the kernel function
%              gamma is the parameter of the fit degree
K=Get_Matrix(X(1:len,:),gamma,sigma);
outputs = [ 0;Y(1:len)];
parameter =K \ outputs;
for i=1:length(X)
    Predictive(i) = parameter(1);
    for j=1:len
        Predictive(i)=Predictive(i)+parameter(j+1)*kernel(X(j,:),X(i,:),sigma);
    end
end
error = mean(abs((Predictive' - Y) ./ Y));
end

