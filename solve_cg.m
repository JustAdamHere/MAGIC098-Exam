function uh = solve_cg(problemData, meshData)
    %% Boundary conditions.
    % Flags 1 if Dirichlet vertex.
    vertexIsDirichlet = zeros(meshData.no_vertices, 1);
    
    % Loops over all elements to find Dirichlet vertices.
    for element = 1:meshData.no_elements
        f = find(meshData.element_boundaries(element, :) > 0);
        if (f)
           if (length(f)>1)
                vertexIsDirichlet(meshData.element_vertices(element, :)) = 1;
           else
               localDirichletVertices    = [1:3];
               localDirichletVertices(f) = [];
               
               vertexIsDirichlet(meshData.element_vertices(element, localDirichletVertices)) = 1;
           end
        end
    end
    
    % List of all vertices that are Dirichlet.
    Dirichlet = find(vertexIsDirichlet==1);
    
    % Flags all Neumann segments.
    Neumann           = zeros(meshData.no_vertices, 2);
    noNeumannSegments = 0;
    
    % Loops over all elements to find Neumann segments.
    for element = 1:meshData.no_elements
        for vertex = 1:3
            if (meshData.element_boundaries(element, vertex) < 0)
                localNeumannVertices         = [1:3];
                localNeumannVertices(vertex) = [];
                
                noNeumannSegments = noNeumannSegments + 1;
                
                Neumann(noNeumannSemgnets, :) = meshData.element_vertices(element, localNeumannVertices);
            end
        end
    end
    
    % Removes Neumann data if no segments found.
    if (noNeumannSegments == 0)
        Neumann = [];
    else
        Neumann(noNeumannSegments+1:end, :) = [];
    end
    
    %% Linear system.
    % Sets up stiffness matrix and load vector.
    A = sparse(meshData.no_vertices, meshData.no_vertices);
    b = zeros (meshData.no_vertices, 1);
    
    % Gradient of basis functions.
    basis_ = [-1 -1; 1 0; 0 1]';
    
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
         
        A(vertices, vertices) = A(vertices, vertices) + localA;
        b(vertices)           = b(vertices) + localb;
    end
    
    % Imposes boundary conditions.
    if (Neumann ~= [])
        for i = 1:noNeumannSegments
            segment = Neumann(i, :);
        end
    end
    
    for i = 1:length(Dirichlet)
        vertex = Dirichlet(i);
        
        A(vertex, :)      = zeros(1, meshData.no_vertices);
        A(vertex, vertex) = 1;
        b(vertex)         = problemData.gD(meshData.vertex_coordinates(vertex, :));
    end
    
    % Solves linear system.
    uh = A \ b;
end