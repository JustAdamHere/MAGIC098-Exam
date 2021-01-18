classdef class_solution
    properties
        f
    end
    methods
        function uh = solve(obj, meshData)
            A = sparse(3*meshData.noElements, 3*meshData.noElements);
            L = zeros (3*meshData.noElements, 1);

            % Element loop.
            for i = 1:meshData.noElements
                element = meshData.elements{i};
                J = element.Jacobian();

                [points, weights] = element.elementQuadrature();

                map = @(xi) element.mapLocalToGlobal(xi);

                DoFs = i*(1:3);
                for j = 1:length(DoFs)
                    m = DoFs(j);

                    basis1  = @(xi) element.basis(j, 0, xi);
                    basis1_ = @(xi) element.basis(j, 1, xi);

                    L(m) = L(m) + obj.l(basis1, map, J, points, weights);

                    for k = 1:length(DoFs)
                        n = DoFs(k);

                        basis2  = @(xi) element.basis(k, 0, xi);
                        basis2_ = @(xi) element.basis(k, 1, xi);

                        A(n, m) = A(n, m) + obj.a(basis1_, basis2_, map, J, points, weights);
                    end
                end
            end
            
            % Flux parameters.
            theta = -1;
            h     = 2*meshData.elements{1}.Jacobian();% A rough estimate of element sizes for penalty parameter.
            sigma = 10/h;
            
            % Boundary face loop.
            for i = 1:meshData.noBoundaryFaces
                face      = meshData.boundaryFaces{i};
                neighbour = face.neighbours;
                
                J = face.Jacobian();
                [points, weights] = face.faceQuadrature();

                DoFs = neighbour*(1:3);
                for j = 1:length(DoFs)
                    m = DoFs(j);
                    
                    basis1  = @(xi) face.basis(j, 0, xi);
                    basis1_ = @(xi) face.basis(j, 1, xi);
%                     if (j==1)
%                         basis1  = @(xi) xi/2;
%                         basis1_ = @(xi) 1/2;
%                     elseif (j==2)
%                         basis1  = @(xi) -xi/2;
%                         basis1_ = @(xi) -1/2;
%                     elseif (j==3)
%                         basis1  = @(xi) 0;
%                         basis1_ = @(xi) 0;
%                     end

                    L(m) = L(m) + obj.l_bf(basis1, basis1_, J, theta, sigma, points, weights);

                    for k = 1:length(DoFs)
                        n = DoFs(k);
                        
                        basis2  = @(xi) face.basis(k, 0, xi);
                        basis2_ = @(xi) face.basis(k, 1, xi);
%                         if (k==1)
%                             basis2  = @(xi) xi/2;
%                             basis2_ = @(xi) 1/2;
%                         elseif (k==2)
%                             basis2  = @(xi) -xi/2;
%                             basis2_ = @(xi) -1/2;
%                         elseif (k==3)
%                             basis2  = @(xi) 0;
%                             basis2_ = @(xi) 0;
%                         end

                        A(n, m) = A(n, m) + obj.a_bf(basis1, basis1_, basis2, basis2_, J, theta, sigma, points, weights);
                    end
                end
            end
            
            % Internal face loop.
            for i = 1:meshData.noInternalFaces
                face       = meshData.internalFaces{i};
                neighbours = face.neighbours;
                
                J = face.Jacobian();
                [points, weights] = face.faceQuadrature();
                
                DoFs1 = neighbours(1)*(1:3);
                DoFs2 = neighbours(2)*(1:3);
                
                for j = 1:length(DoFs1)
                    m = DoFs1(j);
                    
                    basis1  = @(xi) face.basis(j, 0, xi);
                    basis1_ = @(xi) face.basis(j, 1, xi);
                    
                    L(m) = L(m) + obj.l_if(basis1, basis1_, J, theta, sigma, points, weights);
                    
                    for k = 1:length(DoFs2)
                        n = DoFs2(k);
                        
                        basis2  = @(xi) face.basis(k, 0, xi);
                        basis2_ = @(xi) face.basis(k, 1, xi);
                        
                        A(n, m) = A(n, m) + obj.a_if(basis1, basis1_, basis2, basis2_, J, theta, sigma, points, weights);
                    end
                end
            end

            uh = A \ L;
        end

        function integral = a(~, basis1_, basis2_, map, J, points, weights)
            integral = 0;

            for i = 1:length(points)
                p  = points(i, :);
                w  = weights(i);
                gP = map(p);

                integral = integral + dot(basis1_(p), basis2_(p))*w/J;
            end
        end

        function integral = l(obj, basis, map, J, points, weights)
            integral = 0;

            for i = 1:length(points)
                p  = points(i, :);
                w  = weights(i);
                gP = map(p);

                integral = integral + basis(p)*obj.f(gP)*w*J;
            end
        end
        
        function integral = a_bf(~, b1, b1_, b2, b2_, J, theta, sigma, points, weights)
            integral = 0;
            
            for i = 1:length(points)
                p = points(i, :);
                w = weights(i);
                
                integral = integral + (-(b2_(p))*(-b1(p)) + theta*(b1_(p))*(-b2(p)) + sigma*(-b2(p))*(-b1(p)))*w/J;
            end
        end
        
        function integral = a_if(~, b1, b1_, b2, b2_, J, theta, sigma, points, weights)
            integral = 0;
            
            for i = 1:length(points)
                p = points(i, :);
                w = weights(i);
                
                integral = integral + 0;
            end
        end
        
        function integral = l_bf(~, b, b_, J, theta, sigma, points, weights)
            integral = 0;
            
            for i = 1:length(points)
                p = points(i, :);
                w = weights(i);
                
                integral = integral + 0;
            end
        end
        
        function integral = l_if(~, b, b_, J, theta, sigma, points, weights)
            integral = 0;
            
            for i = 1:length(points)
                p = points(i, :);
                w = weights(i);
                
                integral = integral + 0;
            end
        end
    end
end