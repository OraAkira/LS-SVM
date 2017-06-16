function [ res ] = kernel( a,b,sigma )
%KERNEL Summary of this function goes here
%   Detailed explanation goes here
res = exp(-sumsqr(a-b)/(2*(sigma^2)));
end