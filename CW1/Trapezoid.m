function integ = Trapezoid(functionPtr, boundStart, boundEnd, strips)
    % Initialise the input vector
    x = linspace(boundStart, boundEnd, strips);
    
    % Evaluate all inputs in one function call
    y = feval(functionPtr, x);

    integ = 0;
    
    % Perform trapezoidal loop
    for i = 1 : (strips - 1)
        integ = integ + 0.5 * ((x(i+1) - x(i)) * (y(i) + y(i + 1)));
    end
end