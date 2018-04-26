clear all; 
close all; 
folder = 'data';

%get the K camera calibration matrix 
K = [568.996140852, 0, 643.21055941;
     0, 568.988362396, 477.982801038;
     0, 0, 1];

%parse the data 
[Mu, Mv, V, RGB] = ParseData(folder);

%get the correspondences between two images 
img1Num = 1;
img2Num = 2;
[img1Pts, img2Pts, V, RGB] = getCorrespondences(Mu, Mv, V, RGB,img1Num, img2Num);

%get the inliers of the data between the corresponding points 
[y1, y2, idx] = GetInliersRANSAC(img1Pts, img2Pts);

%get the fundamental matrix 
F = EstimateFundamentalMatrix(y1, y2);

%get the essential matrix 
E = EssentialMatrixFromFundamentalMatrix(F, K);

%get the camera pose
[Cset, Rset] = ExtractCameraPose(E);

%find the Xset 
Xset = cell(4,1);
%Camera 1 is the origin 
C1 = zeros(3,1);
R1 = eye(3); 

%find the Xset 
for i = 1:4    
    %get the ith C and R
    C2 = Cset{i};
    R2 = Rset{i};
    
    %do linear triangulation 
    x = LinearTriangulation(K, C1, R1, C2, R2, y1, y2);
    Xset{i} = x; 
end 

%disamniguate the camera pose and get the best camera for camera 2
[C, R, X0,inFront] = DisambiguateCameraPose(Cset, Rset, Xset);
X0 = X0(inFront,:);
y1 = y1(inFront,:);
y2 = y2(inFront,:);

%plot the point cloud 
figure; 
RGBIdx = RGB(idx,:);
RGBIdx = RGB(inFront,:);
PC3Dshow(X0, {C1,C},{R1,R},RGBIdx);

%plot cameras and points
scale = 5;
figure; 
PlotCamerasAndPoints({C1,C},{R1,R}, X0, scale);

%plot the camera projection
firstImg = imread('data/image0000002.bmp');
figure; 
plot_reprojection(firstImg, R, C, K, X0, y2);