 function Diffusion()  
        x_start = 0;
        x_step  = 0.01; % delta x
        x_end   = 2;
    
        t_start = 0;
        t_step = 0.5; % delta t
        t_end = 1;
        
        xVals = x_start : x_step : x_end;
        tVals = t_start : t_step : t_end;
        
        c = zeros(length(xVals), length(tVals));
        D = 1;
        
        % c_t -> t = 0 (c_0)
        for x = 1 : length(xVals)
            c(x, 1) = 0.75 * exp(-((xVals(x) - 0.5)/0.1)^2);
        end
        
        for t = 1 : length(tVals)-1
            for x = 2 : length(xVals)-1
                c(x, t+1) = -D * t_step * ((c(x + 1, t) - (2 * c(x, t)) + c(x-1, t)) / (x_step ^ 2)) + c(x, t);
            end
        end
    
        for t = 1 : length(tVals)
            figure();
            plot(xVals, c(:, t));
            title(sprintf('Contaminant Diffusion (t = %f)', tVals(t)));
            xlabel('Domain Point'); 
            ylabel('Concentration'); 
        end
  end