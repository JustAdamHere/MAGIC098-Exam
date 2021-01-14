%% Mesh data.
% Structure for mesh data.
global meshData;

% Determines if the domains should be imported for use with CG or DG.
DG = true;

% Reads in mesh data from files.
meshData.element_vertices   = load(['./meshes/' problemData.domain '/element_vertices.txt']);
meshData.element_neighbours = load(['./meshes/' problemData.domain '/element_neighbours.txt']);
meshData.element_boundaries = load(['./meshes/' problemData.domain '/element_boundaries.txt']);
meshData.vertex_coordinates = load(['./meshes/' problemData.domain '/vertex_coordinates.txt']); 

% Sets useful counters.
meshData.no_elements = size(meshData.element_vertices,   1);
meshData.no_vertices = size(meshData.vertex_coordinates, 1);
meshData.no_faces    = numel(meshData.element_neighbours) - nnz(meshData.element_neighbours);