function F = EstimateFundamentalMatrix(x1, x2)
%both Nx2 

[numPts,~] = size(x1); 

x1x = x1(:,1);
x1y = x1(:,2);
x2x = x2(:,1);
x2y = x2(:,2);

A = [x1x.*x2x, x1y.*x2x, x2x, x1x.*x2y, x1y.*x2y, x2y, x1x, x1y, ones(numPts,1)];

%find Af = 0 
[~,~,V] = svd(A); 
f = V(:,9) / V(end,end);
F = reshape(f,[3,3]);
F = F';

%remove the singular value 
[UP,SP,VP] = svd(F); 
SP(end,end) = 0; 

F = UP * SP * VP'; 
end

