function integ = Trapezoid(functionPtr, boundStart, boundEnd, strips)
%TRAPEZOID Summary of this function goes here
%   Detailed explanation goes here
    
    x = linspace(boundStart, boundEnd, strips);
    y = feval(functionPtr, x);

    integ = 0;
    
    for i = 1 : (strips - 1)
        integ = integ + 0.5 * ((x(i+1) - x(i)) * (y(i) + y(i + 1)));
    end
end