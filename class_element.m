classdef class_element
    properties
        elementNo
        noNodes
        nodeCoordinates
    end
    methods
        function obj = constructor(obj, elementNo, nodeCoordinates)
            obj.elementNo       = elementNo;
            obj.nodecoordinates = nodeCoordinates;
        end
        function map = mapLocalToGlobal(obj, xi)
            c   = obj.nodeCoordinates;
            map = c(1, :) + (xi + [1 1])/2*[c(2, :)-c(1, :); c(3, :)-c(1, :)];
        end
        function J = Jacobian(obj)
            c = obj.nodeCoordinates;
            J = [
                c(2, 1)-c(1, 1)    0
                0                  c(3, 2)-c(1, 2)
            ]/2;
        end
        function b = basis(~, n, i, xi)
            func0(:, :) = [-(xi(1)+xi(2))/2; (xi(1)+1)/2; (xi(2)+1)/2];
            func1(:, :) = [-1 -1;            1 0;         0 1];
            
            if i==0
                b = func0(n, :);
            else
                b = func1(n, :);
            end
        end
        function [points, weights] = elementQuadrature(~)
            points = [
                -0.666666666666667, -0.666666666666667;
                -0.666666666666667,  0.333333333333333;
                 0.333333333333333, -0.666666666666667 
            ];
            weights = [
                0.666666666666667;
                0.666666666666667;
                0.666666666666667 
            ];
        end
        function DoFs = elementDoFs(obj)
            DoFs = obj.elementNo*(1:3);
        end
    end
end