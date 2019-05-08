% -- PRELIMINARY SETUP --
    clearvars; % Do not use clear all, it's inefficient -> clear variables
    clc;

    format long;
    
%   A      = cross-sectional area of tank (m^2)    
%   Kc     = proportional gain (m^2/min)
%   tau1   = integral time constant (min)
%   t      = time
%   deltah = deviation height of the liquid level in tank

    A               = 2;
    tau             = 0.1;

    Kc_initial      = 1;
    Kc_step         = 1;
    Kc_final        = 5;
    
    t_initial       = 0;
    t_step          = 1;
    t_final         = 60; % 1 minute
    
    delta_h_initial = 0;
    delta_h_over_t  = 2;
    delta_h         = [delta_h_initial, delta_h_over_t];
    
    % 2nd Order ODE
    % A * (deltah^2 / t^2) + (Kc * deltah_over_t) + ((Kc / tau1) * deltah);
    %
    % -> Convert to 2 1st Order ODEs

    [var1, var2] = ode45(@ODEFunc, [t_initial t_final], delta_h);
    
    plot(var1, var2(:,1));
    
    for Kc = Kc_initial : Kc_step : Kc_final
       for t = t_initial : t_step : t_final

       end
    end
% -----------------------

% \/\/\/ Question (a) \/\/\/

% \/\/\/ Question (b) \/\/\/

function yprime = ODEFunc(t, delta_h, Kc)
    Kc = 1;
    A = 2;
    tau = 0.1;
    
    ode1 = -(Kc/A) * delta_h(2);
    ode2 = (Kc / tau / A) * delta_h(1);
    yprime = [delta_h(2); ode1 - ode2];
end
