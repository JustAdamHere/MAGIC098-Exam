function uh = solve_cg(problemData, meshData)
    % Loads in boundary conditions.
    [Dirichlet, Neumann, noNeumannSegments] = get_boundaryConditions(meshData);
    
    % Sets up stiffness matrix and load vector.
    A = sparse(3*meshData.no_elements, 3*meshData.no_elements);
    b = zeros (3*meshData.no_elements, 1);
    
    % Gradient of basis functions.
    basis_ = [-1 -1; 1 0; 0 1]';
    
    % Element loop.
    for element = 1:meshData.no_elements       
        % Get this element's vertices.
        vertices = meshData.element_vertices(element, :);
        
        % Global coordinates for these local vertices.
        globalCoordinates = meshData.vertex_coordinates(vertices, :);
        
        % Midpoints of coordinate combinations for the quadrature.
        m12 = (globalCoordinates(1, :) + globalCoordinates(2, :));
        m23 = (globalCoordinates(2, :) + globalCoordinates(3, :));
        m31 = (globalCoordinates(3, :) + globalCoordinates(1, :));
        
        % Evaluation of forcing function at each quadrature point.
        f12 = problemData.f(m12);
        f23 = problemData.f(m23);
        f31 = problemData.f(m31);
        
        % Transformation from local element to global element.
        B = [ ...
            globalCoordinates(2, :) - globalCoordinates(1, :); ...
            globalCoordinates(3, :) - globalCoordinates(1, :) ...
        ];
        Binv = inv(B);
        element_area = abs(det(B))*0.5;
        
        % Creates local stiffness matrix.
        localA = ...
            problemData.a * basis_' * (Binv*Binv') * basis_ * element_area + ...
            problemData.c * element_area * [ 1/6 1/12 1/12 ; 1/12 1/6 1/12; 1/12 1/12 1/6];
        
        % Creates local load vector.
        localb = [...
            (f12+f31)/2; ...
            (f12+f23)/2; ...
            (f23+f31)/2 ...
            ] * element_area/3;
    
        A(element*(1:3), element*(1:3)) = A(element*(1:3), element*(1:3)) + localA;
        b(element*(1:3))                = b(element*(1:3))                + localb;
    end
    
    % Calculate faces.
    faces = zeros(meshData.no_internalFaces, 2);
    faceCounter = 1;
    for element = 1:meshData.no_elements
        internalNeighbours = meshData.element_neighbours(element, meshData.element_neighbours(element, :) ~= 0);
        
        % Check to see if any of the neighbours have already been added, and discard these.
        % COMBINE THE LOOPS BELOW!! It's removing before finishing its check.
        for i = 1:size(faces, 1)
            for j = 1:length(internalNeighbours)
                if faces(i, 1) == internalNeighbours(j)
                    internalNeighbours(j) = 0;
                end
            end 
        end
        
        for i = 1:length(internalNeighbours)
            if internalNeighbours ~= 0
                faces(faceCounter, :) = [element, internalNeighbours(i)]; 
                faceCounter = faceCounter + 1;
            end
        end
    end
    
    % Calculate face vertices.
    faceVertices = zeros(meshData.no_internalFaces, 2);
    for face = 1:meshData.no_internalFaces
        elements = faces(face, :);
        
        elementVertices = meshData.element_vertices(elements, :);
        
        faceVertices(face, :) = intersect(elementVertices(1, :), elementVertices(2, :));
    end
    
    % Face loop.
    for face = 1:meshData.no_internalFaces
        elements = faces(face, :);
        
        faceCoordinates = meshData.vertex_coordinates(faceVertices(face, :), :);
        
        mid = faceCoordinates(1, :) + faceCoordinates(2, :);
        
        b1  = basis(1, 1, mid);
    end
    
    % Solves linear system.
    uh = A \ b;
end