classdef class_face
    properties
        faceNo
        noNodes
        nodeCoordinates
        neighbours
    end
    methods
        function obj = constructor(obj, faceNo, nodeCoordinates, neighbours)
            obj.faceNo          = faceNo;
            obj.noNodes         = 2;
            obj.nodeCoordinates = nodeCoordinates;
            obj.neighbours      = neighbours;
        end
        
        function J = Jacobian(obj)
            c = obj.nodeCoordinates;
            J = sqrt(sum((c(1, :) - c(2, :)).^2));
        end
        % THIS PROBABLY NEEDS CHANGING FOR ACCOUNTING ON WHICH SIDE WE'RE ON
        function b = basis(~, n, i, xi)
            func0(:) = [xi/2; -xi/2; 0];
            func1(:) = [ 1/2; - 1/2; 0];
                
            if i==0
                b = func0(n);
            else
                b = func1(n);
            end
        end
        function [points, weights] = faceQuadrature(~)
            points = [
               -0.7745966692414833770358531 
                0.0000000000000000000000000
                0.7745966692414833770358531
            ];
            weights = [
                0.5555555555555555555555556
                0.8888888888888888888888889
                0.5555555555555555555555556
            ];            
        end
    end
end