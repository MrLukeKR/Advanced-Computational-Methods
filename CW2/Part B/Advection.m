 function Advection()  
        x_start = 0;
        x_step  = 0.005; % delta x
        x_end   = 2;
    
        t_start = 0;
        t_step = 0.5; % delta t
        t_end = 1;
        
        xVals = x_start : x_step : x_end;
        tVals = t_start : t_step : t_end;
        
        c = zeros(length(xVals), length(tVals));
        v = 1;
                       
        % c_t -> t = 0 (c_0)
        
        % Initial condition
        for x = 1 : length(xVals)
            c(x, 1) = 0.75 * exp(-((xVals(x) - 0.5)/0.1)^2);
        end
           
        for t = 1 : length(tVals)-1
            % Wrap back around
            dt_x = v * (t_step / xVals(1));
            c(1, t+1) = c(1, t) - dt_x * (c(1,t) - c(length(xVals), t));
            
            for x = 2 : length(xVals)
                dt_x = v * (t_step / xVals(x));

                c(x, t+1) = c(x, t) - dt_x * (c(x, t) - c(x-1, t));     
            end
        end
        
        figure();        
        
        title('Contaminant Advection');
        xlabel('Domain Point'); 
        ylabel('Concentration'); 

        hold on;
        
        for t = 1 : length(tVals)
            plot(xVals, c(:, t));
        end

        legend(cellstr(num2str(tVals', 't = %f')));
        
        hold off;
    end