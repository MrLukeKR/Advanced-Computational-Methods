% Question (a)

clear all;
clc;

format long;
syms f;

barrelsPerDay = 2000;

% --- CONVERSIONS ---
% 2000 bbl/day -> bbl/second (Oil Barrel)
volFlowPerSecond = valuePerDayToSeconds(barrelsPerDay);

% bbl/second -> gal/second (Oil Barrel to Gallon)
gallonFlowPerSecond = barrelToGallon(volFlowPerSecond);

% ----------------------------
    
% in -> m
    indiam  = 4 * 0.0254;

% g/cm3 -> kg/m3
    dens    = 0.9 * 1000;

% 8cp -> Pa.s (Centipoise to Pascal Second)
    visc    = 8 * 0.001;

% -----------------------------------------
roughness = 0;

Re = Reynolds(gallonFlowPerSecond, indiam, dens, visc);

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
        %fric = vpasolve(1/sqrt(f) == -2.0 * log((roughness / 3.7) + (2.51 / (Re * sqrt(f)))), f);
        fric  = FrictionFactor(Re, roughness);
        %fprintf('My Fact: %f\tMATLAB: %f\n', myfric, matfric);
        valuesToPlot(xInd, yInd) = fric;
        xInd = xInd + 1;
    end
    yInd = yInd + 1;
end

figure('name', 'Friction Factor vs. Reynolds Number');

roughnessLabels = roughnessStart : roughnessStep : roughnessEnd;
leg = cellstr(num2str(roughnessLabels', 'Roughness = %.3f'));

plot (ReStart : ReStep : ReEnd, valuesToPlot);
legend(leg);
title('Friction Factor vs. Reynolds Number');
xlabel('Reynolds Number (Re)');
ylabel('Friction Factor (f)');

% Question (c)

% r: distance from center of pipe
% R: radius of pipe
% u_Max: maximum velocity at center of pipe
% d: diameter
% u_Avg: average velocity (Q/A)

% Given
R = indiam / 2;
A = pi * R^2;
uAvg = gallonFlowPerSecond / A;


r = 10;
theta = 10;

func = @funcIDK;

integral2(func ,0,2 * pi, 0, R);

integ1 = trapz(func);
integ2 = trapz(integ1);

function uMax = calculateUMax(uAvg, r, R)
uMax =(uAvg * pi * R^2);
end

function answer = funcIDK(r, R)
answer = (1 - (r/R)^2);
end

% --- CONVERSION FUNCTIONS ---
function perSecond = valuePerDayToSeconds(perDayValue)
    perSecond = perDayValue / (24 * 60 * 60);
end

function gallons = barrelToGallon(barrels)
    gallons = barrels * 42 * 3.785E-3;
end