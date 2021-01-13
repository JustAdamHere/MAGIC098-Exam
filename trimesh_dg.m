function trimesh_dg(vertices, coord_x, coord_y, u)
    if (nargin == 3)
        trimesh(vertices(1, :), coord_x(:), coord_y(:));
        hold on
        for i = 2:length(vertices(:, 1))
            trimesh(vertices(i, :), coord_x(:), coord_y(:));
        end
    elseif (nargin == 4)
        x = coord_x(vertices(1, :));
        y = coord_y(vertices(1, :));
        
        trimesh(1:3, x, y, u(1:3));
        hold on
        for i = 2:length(vertices(:, 1))
            x = coord_x(vertices(i, :));
            y = coord_y(vertices(i, :));
            
            trimesh(1:3, x, y, u(i*(1:3)));
        end
    end
end