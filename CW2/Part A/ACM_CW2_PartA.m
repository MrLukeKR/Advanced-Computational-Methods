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
    t_step          = 0.001;
    t_final         = 45;
    
    delta_h_initial = 0; % Initial value
    delta_h_over_t  = 2;
    delta_h = [delta_h_initial, delta_h_over_t];

% -----------------------

% \/\/\/ Question (a) \/\/\/
 figure();
 hold on;
 [t, out] = ode45(@ODEFunc2, [t_initial, t_final], delta_h);
 plot(t, out(:,1));
    
 [t, out] = EulerMethod(@ODEFunc, t_initial, t_step, t_final, delta_h_initial, delta_h_over_t, Kc_initial);
 plot(t, out);
    
% \/\/\/ Question (b) \/\/\/

    for Kc = Kc_initial : Kc_step : Kc_final
        [t, out] = EulerMethod(@ODEFunc, t_initial, t_step, t_final, delta_h_initial, delta_h_over_t, Kc);
        
        figure();
        plot(t, out);
        title(sprintf('Kc = %d', Kc));
        xlabel('Time (s)'); 
        ylabel('Error (\Deltah)'); 
    end
    
function output = ODEFunc2(time, delta_h)
Kc=1;
    A = 2;
    tau = 0.1;
    
    ode1 = -(Kc * delta_h(2)) / A;
    ode2 = (Kc / tau / A) * delta_h(1);
    
    output = [delta_h(2) ;ode1 - ode2];
end
    
function output = ODEFunc(delta_h, delta_h_over_t, Kc)
    A = 2;
    tau = 0.1;
    
    ode1 = -(Kc * delta_h_over_t) / A;
    ode2 = (Kc / tau / A) * delta_h;
    
    output = ode1 - ode2;
end
