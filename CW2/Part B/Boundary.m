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
        c_0 = 1;

        for t = 1 : length(tVals)
            c(1, t) = c_0;    
        end
        
        for t = 1 : length(tVals)-1
            for x = 2 : length(xVals)-1
                advection =  (2 * (x_step ^ 2) * ((c(x, t + 1) - c(x, t))) / t_step);
                diffusion = 2 * D * c(x-1, t) - c(x,t) * (2*D - v * x_step);
                c(x, t+1) = (advection + diffusion) / (v * x_step - 2 * D);
            end
        end
    
        for t = 1 : length(tVals)
            figure();
            plot(xVals, c(:, t));
            title(sprintf('Contaminant Boundary (t = %f)', tVals(t)));
            xlabel('Domain Point'); 
            ylabel('Concentration'); 
        end
    end