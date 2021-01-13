%% Problem data.
% Structure for problem data.
global problemData;

% Directory for domain.
problemData.domain = 'L-shape-dirichlet';

% Diffusion coefficient : a
% Convection coefficient: b
% Reaction coefficient  : c
problemData.a = 1;
problemData.b = [0 0];
problemData.c = 0;

% Forcing, Dirichlet, and Neumann function.
problemData.f  = @(x) 0;
problemData.gD = @(x) x(1)*x(2);
problemData.gN = @(x) 0;

% Exact solutions.
problemData.u  = @(x) x(1)*x(2);
problemData.u_ = @(x) [x(2); x(1)];