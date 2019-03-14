% -- PRELIMINARY SETUP --
    clearvars; % Do not use clear all, it's inefficient -> clear variables
    clc;

    format long;
    syms f
% -----------------------

% \/\/\/ Question (a) \/\/\/

% -- ORIGINAL INPUT VALUES --
    barrelsPerDay = 2000;
    inchesDiameter = 4;
    rough = 0;
% ---------------------------

% -- CONVERSIONS --
%  2000 bbl/day -> bbl/second (Oil Barrel)
    volFlowPerSecond = valuePerDayToSeconds(barrelsPerDay);

%  bbl/second -> gal/second (Oil Barrel to Gallon)
    gallonFlowPerSecond = barrelToGallon(volFlowPerSecond);

%  in -> m
    metersDiameter  = inchToMetre(inchesDiameter);

%  g/cm3 -> kg/m3
    dens    = 0.9 * 1000;

%  8cp -> Pa.s (Centipoise to Pascal Second)
    visc    = 8 * 0.001;
% -----------------

% Calculate the Reynolds (Re) number
    Re = Reynolds(gallonFlowPerSecond, metersDiameter, dens, visc);

% Run the built-in solver to compare our answer to
    matAns = vpasolve(...
       1/sqrt(f) == -2.0 * log((rough / 3.7) + (2.51 / (Re * sqrt(f)))),f);

% Print both answers as a comparison
    fprintf('MANUAL Answer\t%f\n', FrictionFactor(Re, rough));
    fprintf('MATLAB Answer\t%f\n', matAns);

% \/\/\/ Question (b) \/\/\/

% -- Integration Bound and Step settings --
    ReStart = 5000;
    ReEnd   = 100000;
    ReStep  = 500;
    Re = ReStart : ReStep : ReEnd;

    roughStart = 0;
    roughEnd = 0.008;
    roughStep = 0.002;
    rough = roughStart : roughStep : roughEnd;

    ySize = (ReEnd - ReStart + ReStep) / ReStep;
    xSize = (roughEnd - roughStart + roughStep) / roughStep;
% -----------------------------------------


% -- COMPUTE FRICTION VALUES --
%   Fricts contains all computed friction values for each roughness
    fricts = zeros(ySize, xSize);

    for roInd = 1 : xSize
        for ReInd = 1 : ySize
            fricts(ReInd, roInd) = FrictionFactor(Re(ReInd), rough(roInd));
        end
    end
% -----------------------------
   
% -- PLOT FRICTION PROFILES --
    figure('name', 'Friction Factor vs. Reynolds Number');
    leg = cellstr(num2str(rough', '%.3f'));

    plot (Re, fricts);
    roughLeg = legend(leg);
    title(roughLeg, 'Roughness');

    title('Friction Factor vs. Reynolds Number');
    xlabel('Reynolds Number [Re]');
    ylabel('Friction Factor [f]');
% ----------------------------

% \/\/\/ Question (c) \/\/\/

% -- DEFINE VARIABLES --
%   steps: Number of divisions to make when using linspace (default: 100)
    steps = 100;

%   R: radius of pipe
    R = metersDiameter / 2;

%   r: distance from center of pipe
    r = linspace(0, R, steps);

%   theta: angle of volume
    theta = linspace(0, 2 * pi, steps);

%   d: diameter
    
%   u_Avg: average velocity (Q/A)
    A = pi * R^2;
    u_Avg = gallonFlowPerSecond / A;

% -- DOUBLE INTEGRATION --
    syms x y
    firstIntegration = Trapezoid(@(x)((1 - (x./R).^2) .* x), 0, R, steps);
    secondIntegration = Trapezoid(@(y)(firstIntegration .* y ./ pi), 0, 2 * pi, steps);
% ------------------------

%   u_Max: maximum velocity at center of pipe
    u_Max = (u_Avg * pi * R.^2) ./ secondIntegration;

%   u(r): 
    u_r = u_Max .* (1 - (r./R).^2);

% -- PLOT LAMINAR FLOW PROFILE --
    figure('name', '(Incompressible) Laminar Flow Velocity Profile');
    plot(r, u_r);
    title('(Incompressible) Laminar Flow Velocity Profile');
    xlabel('Distance to Center of Pipe [r]');
    ylabel('Velocity Profile [u(r)]');
% -------------------------------

% --- CONVERSION FUNCTIONS ---
    function perSecond = valuePerDayToSeconds(perDayValue)
        perSecond = perDayValue / (24 * 60 * 60);
    end

    function gallons = barrelToGallon(barrels)
        gallons = barrels * 42 * 3.785E-3;
    end

    function meters = inchToMetre(inches)
        meters = inches * 0.0254;
    end
% ----------------------------