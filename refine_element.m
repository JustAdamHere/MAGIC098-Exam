function meshDataNew = refine_element(element, meshData)    
    % Get the element's neighbours.
    neighbours = meshData.element_neighbours(element, 3);
    
    meshDataNew = meshData;
end