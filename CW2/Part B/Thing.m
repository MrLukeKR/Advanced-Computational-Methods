    function DiffusionAndAdvection()  
    % -- PRELIMINARY SETUP --
        x_start = 0;    % Lower bound of x
        x_step  = 0.01; % Delta x
        x_end   = 2;    % Upper bound of x
    
        t_start = 0;    % Lower bound of t
        t_step = 0.25;   % Delta t
        t_end = 3.25;      % Upper bound of t
        
        % Create arrays of x and t values
        xVals = x_start : x_step : x_end;
        tVals = t_start : t_step : t_end;
        
        % Pre-allocating 2D x-by-t matrix in memory
        c = zeros(length(xVals), length(tVals));
        
        % Constant D and v values
        D = 1;
        v = 1;
        
for t = 1 : length(tVals)
    c(1, t) = 1;
end
        
        % -----------------------
        
        % Loop through all t (time) values
        for x = 1 : length(xVals)-1
                        % Wrap back around to allow for matrix edges to be calculated
            Adv_dt_x = v * (x_step / t_step);
            Dif_dt_x = D * (x_step / (t_step^2));
            
            advection =  Adv_dt_x * ((c(x, 2) - c(x, 1)));
            diffusion =  Dif_dt_x * (((c(x, 2) - (2 * c(x, 1)) + c(x, length(tVals)))));
            c(x+1, 1) = c(x, 1) + (diffusion - advection);
            
            % Loop through all x (domain) values            
            for t = 1 : length(tVals)-1
                % Calculate delta t over x * velocity values
                Adv_dt_x = v * (x_step / t_step * 2);
                % Calculate delta t over x * diffusion values
                Dif_dt_x = D * (x_step / (t_step^2));
                
                % Calculate the contamination value at the current position,
                % at the next time step
                
                tMinus1 = t - 1;
                tPlus1 = t + 1;
                
                if t == 1
                   tMinus1 = length(tVals); 
                end
                
                if t == length(tVals)
                   tPlus1 = 1; 
                end
                
                advection =  Adv_dt_x * ((c(x, tPlus1) - c(x, t)));
                diffusion =  Dif_dt_x * (((c(x, tPlus1) - (2 * c(x, t)) + c(x, tMinus1))));
                c(x+1, t) = c(x, t) + (diffusion - advection);
            end
            

        end
    
        % Plot results from previous calculations
        plotResults(c, xVals, tVals);
end

    function plotResults(c, xVals, tVals)
        figure();        
        
        title('Contaminant Advection and Diffusion (Boundary)');
        xlabel('Domain Point'); 
        ylabel('Concentration'); 

        hold on;
        
        plotTimes = [0, 0.25, 0.5, 1, 2, 3];
        
        for t = 1 : length(tVals)
            if ismember(tVals(t), plotTimes) 
                plot(xVals, c(:, t));
            end
        end

        legend(cellstr(num2str(plotTimes', 't = %f')));
        
        hold off;
    end
