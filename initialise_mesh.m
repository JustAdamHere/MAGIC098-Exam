%% Mesh data.
% Structure for mesh data.
global meshData;

% Reads in mesh data from files.
meshData.element_vertices   = load(['./domains/' problemData.domain '/element_vertices.txt']);
meshData.element_neighbours = load(['./domains/' problemData.domain '/element_neighbours.txt']);
meshData.element_boundaries = load(['./domains/' problemData.domain '/element_boundaries.txt']);
meshData.vertex_coordinates = load(['./domains/' problemData.domain '/vertex_coordinates.txt']);

% Sets useful variables.
meshData.no_elements = size(meshData.element_vertices,   1);
meshData.no_vertices = size(meshData.vertex_coordinates, 1);