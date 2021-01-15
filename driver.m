points = [
-1  1
 0  1
 1  1
-1  0
 0  0
 1  0
-1 -1
 0 -1
];
connectivity = [
4 5 1
2 1 5
5 6 2
3 2 6
7 8 4
5 4 8
];

%mesh     = delaunayTriangulation(points);
mesh     = triangulation(connectivity, points);
meshData = class_mesh;
meshData = meshData.constructor(mesh);

problemData   = class_solution;
problemData.f = @(x) sin(x(1))*sin(x(2));

problemData.solve(meshData);