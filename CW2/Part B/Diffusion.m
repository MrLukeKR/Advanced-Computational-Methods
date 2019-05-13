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

        % Loop through all t (time) values
        for t = 1 : length(tVals)-1
            % Loop through all x (domain) values
            for x = 2 : length(xVals)-1
                % Calculate delta t over x * diffusion values
                dt_x = D * (t_step / (xVals(x)^2));
                
                % Calculate the contamination value at the current position,
                % at the next time step
                c(x, t+1) = c(x, t) + (dt_x * (c(x + 1, t) - (2 * c(x, t)) + c(x - 1, t)));
            end
            
            % Wrap back around to allow for matrix edges to be calculated
            dt_x = D * (t_step / xVals(1)^2);
            c(1, t+1) = c(x, t) + (dt_x * (c(x + 1, t) - (2 * c(x, t)) + c(x - 1, t)));
        end
        
        % Plot results from previous calculations
        plotResults(c, xVals, tVals);
end

    function plotResults(c, xVals, tVals)
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
