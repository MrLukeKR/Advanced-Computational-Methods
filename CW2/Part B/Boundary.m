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
        x_0 = 1;

        for t = 1 : length(tVals)
            c(1, t) = x_0;    
        end
       
        for t = 1 : length(tVals)-1
            for x = 2 : length(xVals)-1
                upperTerm1 =  ((2 * (x ^2) * ((c(x, t + 1) - c(x, t)))) / t_step);
                upperTerm2 = c(x-1, t) * (v * xVals(x) + 2 * D) + (2 * D * c(x, t));
                c(x+1, t) = ((-upperTerm1 + upperTerm2) / (2 * D - v * xVals(x)));
            end
        end
    
        figure();
        hold on
        for t = 1 : length(tVals)
           
            plot(xVals, c(:, t));
            title(sprintf('Contaminant Boundary (t = %f)', tVals(t)));
            xlabel('Domain Point'); 
            ylabel('Concentration'); 
        end
    end