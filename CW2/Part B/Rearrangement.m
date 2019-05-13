function Rearrangement()
syms ct1 t D ct ct2 x v cx

% t = t_step
% x = x_step
% ct = c(x,t)
% ct1 = c(x+1,t)
% ct2 = c(x-1,t)
% cx = c(x,t+1)

eq1 = t*(D*((ct1-(2*ct)+ct2)/(x^2)) - v*((ct1-ct2)/(2*x)))+ct-cx == 0;

fn = solve(eq1,ct1)

% Answer is: -(ct - cx + t*((ct2*v)/(2*x) - (D*(2*ct - ct2))/x^2))/(t*(D/x^2 - v/(2*x)))
% Which Gives: 
% c(x+1,t)= -(c(x,t) - c(x,t+1) + t_step*((c(x-1,t)*v)/(2*xVals) - (D*(2*c(x,t) - c(x-1,t)))/xVals.^2))/(t_step*(D/xVals.^2 - v/(2*xVals)))

end

