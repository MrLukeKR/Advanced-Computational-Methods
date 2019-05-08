function [output] = Bisectional(functionPtr, lowBound, upBound, errTol)
%   Set zero values to close-to-zero to fix NaN/Inf errors
    if lowBound == 0
       lowBound = 1E-10; 
    end

%   Precompute function results to save computation time
    fLow = functionPtr(lowBound);
    fUp = functionPtr(upBound);

    if sign(fLow) == sign(fUp)
        error("Bounds do not contain a root");
    end
    
    midpoint = (lowBound + upBound) /2;
    fMid = functionPtr(midpoint);
    
%   Recursively call Bisection until satisfactory threshold is reached
    if abs(fMid) < errTol
       output = midpoint;
    elseif sign(fLow) == sign(fMid)
        output = Bisectional(functionPtr, midpoint, upBound, errTol);
    elseif sign(fUp) == sign(fMid)
        output = Bisectional(functionPtr, lowBound, midpoint, errTol);
    end
end