global meshData;

% Reads in mesh data from files.
meshData.element_vertices   = load(['./meshes/' problemData.domain '/element_vertices.txt']);
meshData.element_neighbours = load(['./meshes/' problemData.domain '/element_neighbours.txt']);
meshData.element_boundaries = load(['./meshes/' problemData.domain '/element_boundaries.txt']);
meshData.vertex_coordinates = load(['./meshes/' problemData.domain '/vertex_coordinates.txt']); 

% Sets useful variables.
meshData.no_elements = size(meshData.element_vertices,   1);
meshData.no_vertices = size(meshData.vertex_coordinates, 1);

%trimesh(meshData.element_vertices(1, :), meshData.vertex_coordinates(:, 1), meshData.vertex_coordinates(:, 2), [1 2 3 4]);
% hold on
% trimesh(meshData.element_vertices(2, :), meshData.vertex_coordinates(:, 1), meshData.vertex_coordinates(:, 2));

trimesh_dg(meshData.element_vertices, meshData.vertex_coordinates(:, 1), meshData.vertex_coordinates(:, 2), [1, 2, 3, 2, 2, 1]);