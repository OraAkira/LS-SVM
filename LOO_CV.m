function [ err  ] = LOO_CV( Sample_size ,K,sigma,gamma)
%LOO_CV Summary of this function goes here
%   Detailed explanation goes here
data=load('data5.txt');
[row, col]=size(data);
indices = crossvalind('Kfold',Sample_size,K);
for i=1:K
    test=(indices==i);
    train=~test;
    data_train=data(train,:);
    data_test=data(test,:);
    X=[data_train(:,1:col-1);
         data_test(:,1:col-1)];
    Y=[data_train(:,col);
         data_test(:,col)];
    [error, yu]=LS_SVM(X, Y, size(data_train), sigma, gamma);
    err(i)=sum( abs( (Y(size(data_train)+1:end) - yu(size(data_train)+1:end)' ) ./ Y(size(data_train)+1:end) ) );
end
end

