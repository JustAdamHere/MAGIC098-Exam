%% Problem data.
% Global structure for problem data.
global problemData;

% Directory for domain.
problemData.domain = 'L-shaped-dirichlet';

% Diffusion coefficient : a
% Convection coefficient: b
% Reaction coefficient  : c
problemData.a = 1;
problemData.b = [0 0];
problemData.c = 0;

% Forcing, Dirichlet, and Neumann function.
problemData.f  = @(x) 0;
problemData.gD = @(x) u_ex3;
problemData.gN = @(x) 0;

%% Adaptivity data.
% Global structure for adaptivity data.
global adaptivityData;

% Residual weights.
adapt.C = [1 1];

% Tolerance for adaptivity strategy.
adaptivityData.tolerance = 1e-7;

% Maximum iterations for adaptivity strategy.
adaptivityData.maxIterations = 10;

% MARKING STRATEGY:
%   - GR:   Global Refinement
%   - MS:   Maximum Strategy
%   - DORF: D\"orfler's
adaptivityData.strategy = 'DORF';

% MS: Marking thresholds.
adaptivityData.MS_gamma = 0.5;

% DORF: Marking thresholds.
adaptivityData.GERS_thetaStar = 0.8;
adaptivityData.GERS_nu        = 0.1;