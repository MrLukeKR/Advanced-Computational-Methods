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
    t_step          = 0.0001;
    t_final         = 30;
    
    delta_h_initial = 0; % Initial value
    delta_h_over_t  = 2;
    delta_h = [delta_h_initial, delta_h_over_t];

% -----------------------

% \/\/\/ Question (a) \/\/\/
 figure();
 [t, out] = ode45(@ODEFunc2, [t_initial, t_final], delta_h);
 plot(t, out(:,1));
 
 title('Built-in Method (ode45)');
 xlabel('Time (min)'); 
 ylabel('Error (\Deltah)'); 
 
 figure();
 
 hold on;   
 plot(t, out(:,1));
 
 title('Comparison: Built-in (ode45) vs. Custom Method');
 xlabel('Time (min)'); 
 ylabel('Error (\Deltah)'); 
 
 % Calculate graph values using custom-written ODE solver, based on the
 % Euler Method, also allowing the input of Kc
 [t, out] = EulerMethod(@ODEFunc, t_initial, t_step, t_final, delta_h_initial, delta_h_over_t, Kc_initial);
 plot(t, out);
 
 legend('Built-in (ode45)', 'Custom Method');
 
 hold off;
 
 % Plot the output of the custom ODE function and add appropriate labels
 figure();
 plot(t, out);
 
 title('Custom Method');
 xlabel('Time (min)'); 
 ylabel('Error (\Deltah)');
 
% \/\/\/ Question (b) \/\/\/

% Step through the Kc values and re-plot each resulting graph as a separate
% figure
    for Kc = Kc_initial : Kc_step : Kc_final
        [t, out] = EulerMethod(@ODEFunc, t_initial, t_step, t_final, delta_h_initial, delta_h_over_t, Kc);
        
        figure();
        plot(t, out);
        title(sprintf('Kc = %d', Kc));
        xlabel('Time (min)'); 
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

% Custom written ODE function
function output = ODEFunc(delta_h, delta_h_over_t, Kc)
    % A and tau values are constant within the application domain and are 
    % therefore hard-coded here
    A = 2;
    tau = 0.1;
    
    % Splitting the 2nd order ODE into 2 1st order ODEs gives the following
    % calculations, which can then be used to calculate the final output
    ode1 = -(Kc * delta_h_over_t) / A;
    ode2 = (Kc / tau / A) * delta_h;
    
    output = ode1 - ode2;
end