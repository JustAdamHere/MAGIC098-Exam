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
            
            % Face loop.
            for i = 1:meshData.noFaces
                
            end

            uh = A \ L;
        end

        function integral = a(obj, basis1_, basis2_, map, J, points, weights)
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
    end
end