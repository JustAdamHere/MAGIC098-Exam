%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% THIS IS A MODIFIED DG CODE BASED UPON THE WORK OF PEDRO MORIN %
%                       BY ADAM BLAKEY                          %
%                 FOR THE ASSESSMENT OF MAGIC098                %  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AFEM in 2d for the elliptic problem                 %
%  -div(a grad u) + b . grad u + c u = f   in Omega   %
%       u = gD  in Gamma_D                            %
%   du/dn = gN  in Gamma_N                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Setup.
% Sets problem and adaptivity data, mesh data, solution data, and adaptivity data.
initialise_problem
initialise_mesh
initialise_solution
initialise_adaptivity

%% Plotting.
%figure(1)
%title('Initial Mesh');
%triplot(meshData.element_vertices, meshData.vertex_coordinates(:, 1), meshData.vertex_coordinates(:, 2));

% Solving.
solutionData.uh = solve_cg(problemData, meshData);

% Plot solution.
trimesh(meshData.element_vertices, meshData.vertex_coordinates(:, 1), meshData.vertex_coordinates(:, 2), solutionData.uh);
hold on

% Plot exact.
x = linspace(-1, 1, 50);
y = linspace(-1, 1, 50);
[X, Y] = meshgrid(x, y);
Z = zeros(50);
for i = 1:50
    for j = 1:50
        Z(i, j) = problemData.u([x(j) y(i)]);
    end
end
surf(X, Y, Z)