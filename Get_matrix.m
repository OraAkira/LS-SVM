function [ Lagrange_multiplier ] = Get_matrix(L, N, Y, sigma, gamma, len )
K = zeros(len, len);
K(1, 1) = 0;
for i = 2 : len
    K(i, 1) = 1;
    K(1, i) = 1;
end
for i = 2 : len 
    for j = 2 : len
        if i == j
            K(i, j) = Y(i-1)*Y(j-1) + kernel(N(i, :), N(j, :), sigma) + L(i, :)*L(j, :)' + 1/gamma;
        else
            K(i, j) = Y(i-1)*Y(j-1) + kernel(N(i, :), N(j, :), sigma) + L(i, :)*L(j, :)';
        end
    end
end
Y(1) = 0;
Lagrange_multiplier = K \ Y(1:len);
end

