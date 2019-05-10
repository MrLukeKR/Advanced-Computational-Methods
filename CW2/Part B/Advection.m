 function Advection()  
        x_start = 0;
        x_step  = 0.01; % delta x
        x_end   = 2;
    
        t_start = 0;
        t_step = 0.5; % delta t
        t_end = 1;
        
        xVals = x_start : x_step : x_end;
        tVals = t_start : t_step : t_end;
        
        c = zeros(length(xVals), length(tVals));
        v = 1;
                        
        dxdt = x_step / t_step;
        delta_v   = -v * dxdt;
        
        % c_t -> t = 0 (c_0)
        
        % Initial condition
        for x = 1 : length(xVals)
            c_0 = 0.75 * exp(-((xVals(x) - 0.5)/0.1)^2);
            c(x, 1) = c_0;
        end
        

        
        for t = 1 : length(tVals)-1
            for x = 2 : length(xVals)-1
                c(x, t+1) = delta_v * ((c(x + 1, t) - c(x, t)) / x_step) + c(x, t);
            end
        end
        
        figure();        
        title('Contaminant Advection');
        hold on;
        
        for t = 1 : length(tVals)
            plot(xVals, c(:, t));

            xlabel('Domain Point'); 
            ylabel('Concentration'); 
        end

        legend(cellstr(num2str(tVals', 't = %f')));
        
        hold off;
    end