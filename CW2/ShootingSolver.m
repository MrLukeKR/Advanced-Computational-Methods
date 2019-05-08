function [time, delta] = ShootingSolver(ODEFunc, t,  Kc, tau1, init_value)
%SHOOTINGSOLVER Summary of this function goes here
%   Detailed explanation goes here
%   t = [initial time : time step : end time]
    time_step = t(2) - t(1);
    rate_per_second = Kc / 60;
    
    rate = Kc * tau1;
    
    y = zeros(length(t));
    
    y(1) = init_value;
    y(2) = y(1) + 
    
    for time = t
        
    end
end

