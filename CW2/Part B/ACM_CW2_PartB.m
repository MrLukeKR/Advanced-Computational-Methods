% -- PRELIMINARY SETUP --
    clearvars; % Do not use clear all, it's inefficient -> clear variables
    clc;

    format long;
    
    % t     = time
    % c_0   = initial Gaussian distribution
    % v     = velocity
    % D     = diffusivity (diffusion coefficient)
    
    x_start = 0;
    x_step  = 0.01; % delta x
    x_end   = 2;
   
    xVals = x_start : x_step : x_end;
   
    t_init = 0;
    t_step = 0.5; % delta t
    t_end = 1;
    
    tVals = t_init : t_step : t_end;
    
    c = zeros(length(xVals), length(tVals));
    
    for t = 1 : length(tVals)
        for x = 1 : length(xVals)
            if tVals(t) == 0
                c(x, t) = 0.75 * exp(-((xVals(x) - 0.5)/0.1)^2);
            end
            
        end
        figure();
        toPlot = c(:, t);
        
        plot(xVals, toPlot);
        title('Contaminant Diffusion and Convection');
        xlabel('Domain Point'); 
        ylabel('Concentration'); 
    end
    