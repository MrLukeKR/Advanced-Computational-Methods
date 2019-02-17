% Question (a)

clear all;
clc;

format long;
syms f;

% 2000 bbl/day -> bbl/second (Oil Barrel)
volflow = 2000 / (24*60*60);

% bbl/second -> gal/second (Oil Barrel to Gallon)
volflow = volflow * 42 * 3.785E-3;

% in -> m
indiam  = 4 * 0.0254;

% g/cm3 -> kg/m3
dens    = 0.9 * 1000;

% 8cp -> Pa.s (Centipoise to Pascal Second)
visc    = 8 * 0.001;

roughness = 0;

Re = Reynolds(volflow, indiam, dens, visc);

matAns = vpasolve(1/sqrt(f) == -2.0 * log((roughness / 3.7) + (2.51 / (Re * sqrt(f)))), f);
fprintf('CUSTOM Answer\t%f\n', FrictionFactor(Re, roughness));
fprintf('MATLAB Answer\t%f\n', matAns);

% Question (b)
ReStart = 5000;
ReEnd   = 100000;
ReStep  = 500;

roughnessStart = 0;
roughnessEnd = 0.008;
roughnessStep = 0.002;

ySize = (ReEnd - ReStart) / ReStep;
xSize = (roughnessEnd - roughnessStart) / roughnessStep;

% valuesToPlot = ([Re, roughness] <- Friction Factor)
valuesToPlot = zeros(ySize, xSize);

yInd = 1;
for roughness = roughnessStart : roughnessStep : roughnessEnd
    xInd = 1;
    for Re = ReStart : ReStep : ReEnd
        matfric = vpasolve(1/sqrt(f) == -2.0 * log((roughness / 3.7) + (2.51 / Re * sqrt(f))), f);
        %myfric  = FrictionFactor(Re, roughness, indiam);
        %fprintf('My Fact: %f\tMATLAB: %f\n', myfric, matfric);
        valuesToPlot(xInd, yInd) = matfric;
        xInd = xInd + 1;
    end
    yInd = yInd + 1;
end

figure('name', 'Friction Factor vs. Reynolds Number');
title('Friction Factor vs. Reynolds Number');
xlabel('Reynolds Number (Re)'); 
ylabel('Friction Factor (f)');

roughnessLabels = roughnessStart : roughnessStep : roughnessEnd;
leg = cellstr(num2str(roughnessLabels', 'Roughness = %.3f'));

plot (ReStart : ReStep : ReEnd, valuesToPlot)
legend(leg);