function [time, output] = EulerSolver(ODEFunc, time_init, time_step, time_end, init_value, delta_h_over_t, Kc)
%EULERSOLVER Summary of this function goes here
%   Detailed explanation goes here
  
    time = time_init : time_step : time_end;
    steps = length(time) ;
    
    output = zeros(1, steps);
    output(1) = init_value;
    
    for t = 2 : steps
        result = ODEFunc(output(t-1), delta_h_over_t, Kc);
        output(t) = output(t-1) + time_step * delta_h_over_t;
        
        delta_h_over_t = delta_h_over_t + time_step * result;
    end
end