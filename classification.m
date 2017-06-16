function [L, N, Y, coefficient] = classification(data, linear_correlation_degree)
    [row, col] = size(data);
    L = zeros(row, col-1);
    N = zeros(row, col-1);
    Y = data(:, col);
    %求相关系数并分类
    coefficient = grayrelated(data);
    for i=1 : col -1
        if(coefficient(i) >= linear_correlation_degree)
            L(:, i) = data(:, i);
        else
            N(:, i) = data(:, i);
        end
    end
end
