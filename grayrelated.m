function [coefficient] = grayrelated(data)
% This fuction is to get linear correlation coefficient about independent variable and dependent variable

% Output:
% 	coefficient : linear correlation coefficient

% Input:
% 	data : data source

    [row, col] = size(data);
    coefficient = zeros(1, col-1);
    range = zeros(1, col);
    delta = zeros(row, col - 1);
    for i = 1:col
        range(i) = max(data(:, i)) - min(data(:, i));              %求极差
        data(:, i) = (data(:, i) - min(data(:, i))) ./ range(i);    %标准化
    end
    for i = 1 : col - 1
        delta(:, i) = abs(data(:, i) - data(:, col));                  %到参考序列的差值
    end
    deltamax = max(max(delta));                                   %第二级最大差
    deltamin = min(min(delta));                                     %第二级最小差
    Rho = 0.5;                                                               %分辨系数
    for i = 1 : col-1                                                        %关联度
        coefficient(i) = abs(mean((deltamin + Rho * deltamax) ./ (delta(:, i) + Rho * deltamax)));
    end
end