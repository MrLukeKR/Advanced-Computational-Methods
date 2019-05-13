    function DiffusionAndAdvection()  
    % -- PRELIMINARY SETUP --
        x_start = 0;    % Lower bound of x
        x_step  = 0.01; % Delta x
        x_end   = 2;    % Upper bound of x
    
        t_start = 0;    % Lower bound of t
        t_step = 0.5;   % Delta t
        t_end = 1;      % Upper bound of t
        
        % Create arrays of x and t values
        xVals = x_start : x_step : x_end;
        tVals = t_start : t_step : t_end;
        
        % Pre-allocating 2D x-by-t matrix in memory
        c = zeros(length(xVals), length(tVals));
        
        % Constant D and v values
        D = 1;
        v = 1;
        
        % c_t -> t = 0 (c_0)
        for x = 1 : length(xVals)
            c(x, 1) = 0.75 * exp(-((xVals(x) - 0.5)/0.1)^2);
        end
        
        % -----------------------
        
        % Loop through all t (time) values
        for t = 1 : length(tVals)-1
                        % Wrap back around to allow for matrix edges to be calculated
            Adv_dt_x = v * (t_step / xVals(1));
            Dif_dt_x = D * (t_step / (xVals(1)^2));
            
            advection =  Adv_dt_x * ((c(2, t) - c(1, t)));
            diffusion =  Dif_dt_x * (((c(2, t) - (2 * c(1, t)) + c(length(xVals), t))));
            c(1, t+1) = c(1, t) + (diffusion - advection);
            
            % Loop through all x (domain) values            
            for x = 2 : length(xVals)-1
                % Calculate delta t over x * velocity values
                Adv_dt_x = v * (t_step / xVals(x));
                % Calculate delta t over x * diffusion values
                Dif_dt_x = D * (t_step / (xVals(x)^2));
                
                % Calculate the contamination value at the current position,
                % at the next time step
                advection =  Adv_dt_x * ((c(x+1, t) - c(x, t)));
                diffusion =  Dif_dt_x * (((c(x+1, t) - (2 * c(x, t)) + c(x - 1, t))));
                c(x, t+1) = c(x, t) + (diffusion - advection);
            end
            

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
