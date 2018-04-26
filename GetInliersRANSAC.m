function [y1, y2, idx] = GetInliersRANSAC(x1, x2)

%num of pts 
[numPts, ~] = size(x1); 

%find the Nx3 reprsentations of the data
allX1s = [x1,ones(numPts,1)];
allX2s = [x2,ones(numPts,1)];

%Do RANSAC: 
maxDistance = .005; 
numIter = 10000; 
maxInlierCount = 0;

%indices 
idx = [];

for k = 1:numIter
    %get three random points to estimate a 3D line 
    indices = randperm(numPts,8)';

    %find the correspondence points to use for x1 and x2 
    x1Pts = x1(indices,:);
    x2Pts = x2(indices,:); 

    %Comupte the matrix F
    F = EstimateFundamentalMatrix(x1Pts, x2Pts);

    %local num Inliers 
    numInliers = 0;

    norms = dot(allX2s,(F*allX1s')',2);
    norms = abs(norms); 
    
    %find inliers 
    indiciesToKeep = norms < maxDistance;
    [numInliers,~] = size(find(indiciesToKeep == 1));

    %line results in a better fit of data than old line 
    if (numInliers > maxInlierCount)
        maxInlierCount = numInliers;
        idx = find(indiciesToKeep==1); 
    end 

end 

% return the inliers
y1 = x1(idx,:);
y2 = x2(idx,:);

end 