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
        range(i) = max(data(:, i)) - min(data(:, i));              %�󼫲�
        data(:, i) = (data(:, i) - min(data(:, i))) ./ range(i);    %��׼��
    end
    for i = 1 : col - 1
        delta(:, i) = abs(data(:, i) - data(:, col));                  %���ο����еĲ�ֵ
    end
    deltamax = max(max(delta));                                   %�ڶ�������
    deltamin = min(min(delta));                                     %�ڶ�����С��
    Rho = 0.5;                                                               %�ֱ�ϵ��
    for i = 1 : col-1                                                        %������
        coefficient(i) = abs(mean((deltamin + Rho * deltamax) ./ (delta(:, i) + Rho * deltamax)));
    end
end