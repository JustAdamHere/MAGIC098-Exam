function [Dirichlet, Neumann, noNeumannSegments] = get_boundaryConditions(meshData)    
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
end