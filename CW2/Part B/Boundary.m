function Boundary()
x_start = 0;
x_step  = 0.01; % delta x
x_end   = 2;

t_start = 0;
t_step = 0.25; % delta t
t_end = 3;

xVals = x_start : x_step : x_end;
tVals = t_start : t_step : t_end;

c = zeros(length(xVals), length(tVals));
D = 1;
v = 1;

% c_t -> t = 0 (c_0)
x_0 = 1;

for t = 1 : length(tVals)
    c(1, t) = x_0;
end

for x = 1 : length(xVals)-1
    for t = 1 :length(tVals)
        if t == length(tVals)
            tPlus1 = 1;
        else
            tPlus1 = t + 1;
        end
    
        c(x+1,t) = calculateThing(x, xVals, tVals, t, D, v, tPlus1, t_step, c);
    end
    
end
    plot(xVals, c(:, 1));
    
figure();

hold on;
for t = 1 : length(tVals)-1    
    plot(xVals, c(:, t));
    title(sprintf('Contaminant Boundary (t = %f)', tVals(t)));
    xlabel('Domain Point');
    ylabel('Concentration');
end
hold off;
end

function output = calculateThing(x, xVals, tVals, t, D, v, tPlus1, t_step, c)
    x_step = 0.01;
    if x > 1 && x <= length(xVals)
        xMinus1 = x - 1;
    elseif x == 1
        xMinus1 = length(xVals);
    end
        
    ct = c(x,t);

    ct2 = c(xMinus1, t);
    cx = c(x, tPlus1);

    
    %upperTerm = -(c(x,t) - c(x,t+1) + t_step*((c(xMinus1, t) * v)/(2 * x_step) - (D * (2 * c(x,t) - c(xMinus1, t))) / x_step^2));
    %lowerTerm =  (t_step *  (D / x_step^2 - v / (2 * x_step)));
    output = -(ct - cx + t_step*((ct2*v)/(2*x_step) - (D*(2*ct - ct2))/x_step^2))/(t_step*(D/x_step^2 - v/(2*x_step)));
end