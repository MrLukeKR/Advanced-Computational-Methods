function [output] = Bisectional(functionPtr, lowBound, upBound, errTol)
%BISECTIONAL Summary of this function goes here
%   Detailed explanation goes here

%   Set zero values to close-to-zero to fix NaN/Inf errors
    if lowBound == 0
       lowBound = 1E-10; 
    end

    fLow = functionPtr(lowBound);
    fUp = functionPtr(upBound);

    if sign(fLow) == sign(fUp)
        error("Bounds do not contain a root");
    end
    
    midpoint = (lowBound + upBound) /2;
    fMid = functionPtr(midpoint);
    
    output = -1;
    if abs(fMid) < errTol
       output = midpoint;
    elseif sign(fLow) == sign(fMid)
        output = Bisectional(functionPtr, midpoint, upBound, errTol);
    elseif sign(fUp) == sign(fMid)
        output = Bisectional(functionPtr, lowBound, midpoint, errTol);
    end
    if output == -1
       error("FECK"); 
    end
end