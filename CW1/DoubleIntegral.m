function output = DoubleIntegral(functionHandle,integral1Start, integral1End, integral2Start, integral2End, steps)
%DOUBLEINTEGRAL Summary of this function goes here
%   Detailed explanation goes here

x = linspace(integral1Start, integral1End, steps);
y = linspace(integral2Start, integral2End, steps);

[X, Y] = meshgrid(x, y);

end

