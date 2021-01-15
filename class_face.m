classdef class_face
    properties
        faceNo
        noNodes
        nodeCoordinates
    end
    methods
        function obj = constructor(obj, faceNo, nodeCoordinates)
            obj.faceNo          = faceNo;
            obj.noNodes         = 2;
            obj.nodecoordinates = nodeCoordinates;
        end
    end
end