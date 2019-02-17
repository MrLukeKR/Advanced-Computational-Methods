function Re = Reynolds(volumetricFlowrate, innerDiameter, density, viscosity)
%REYNOLDS Summary of this function goes here
%   Detailed explanation goes here

% Reynolds number:
% Re = (rho * D * Q) / (mu * A)

% Q   = Volumetric flowrate of fluid
% D   = Inner diameter of pipe
% A   = Cross-sectional area of pipe
% rho = Density of fluid
% mu  = Viscosity of fluid

A = (pi / 4) * innerDiameter^2;

Re = (density * innerDiameter * volumetricFlowrate) / (viscosity * A);
end

