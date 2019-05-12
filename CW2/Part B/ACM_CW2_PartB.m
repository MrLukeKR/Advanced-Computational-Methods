% -- PRELIMINARY SETUP --
    clearvars; % Do not use clear all, it's inefficient -> clear variables
    clc;
    close all;

    format long;
    
    % t     = time
    % c_0   = initial Gaussian distribution
    % v     = velocity
    % D     = diffusivity (diffusion coefficient)

    Advection();
    Diffusion();
    DiffusionAndAdvection();
    Boundary();