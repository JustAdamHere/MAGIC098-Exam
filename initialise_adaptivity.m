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