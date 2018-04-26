function [] = PC3Dshow(points, Cset, Rset, RGB)
%% input clarification
% Author: Haoyuan Zhang

% points: 3D points matrix which is N x 3
% Cset: a cell, represents the translation set which contains translation vector (3x1) for all cameras
% Rset: a cell, represents the rotation set which contains rotation matrix (3x3) for all cameras
% RGB: the rgb information matrix which is N x 3

RGB = uint8(RGB); 

%% plot point cloud
R = [0, 0, 1; -1, 0, 0; 0, -1, 0];
points_r = (R * points')';
pcshow([points_r(:, 1), points_r(:, 2), points_r(:, 3)], RGB, 'MarkerSize', 80);
hold on;
for i = 1 : length(Cset)
    if isempty(Cset{i})
        break;
    end
    unit = [0, 0, 2.5]';
    unit_r = R * Rset{i}' * unit;
    Cr = R * Cset{i};
    quiver3(Cr(1), Cr(2), Cr(3), unit_r(1), unit_r(2), unit_r(3), 'MaxHeadSize', 0.5, 'LineWidth', 2);
end

hold off;
end
