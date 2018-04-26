function [Mu, Mv, V, RGB] = ParseData(folder)
%% Parse raw data and encode them into proper data structure (e.g. a search table)
%% Author: Haoyuan Zhang

% [Input] folder
% - represents the directory of all stored data.

% [Output] Mu/Mv (N x num_frame):
%  - represents correspondences in all frames in u/v dimension.
%  e.g. Mu[i, :]: stores the ith feature position in all frames, if the jth frame doesn't be observed by 
%  the ith feature, Mu[i, j] = 0, otherwise, Mu[i ,j] stores the u coordinate of ith feature in jth camera frame. Same as Mv.

% [Output] V (N x num_frame): 
%  - represents the visible state of each observed feature in all frames.
%  e.g. V[i, :]: stores the visible state of the ith feature, V[i, j] = 1 means the ith feature can be seen in
%  the jth camera, otherwise, V[i, j] = 0.

% [Output] RGB (N x 3): 
%  - store RGB information for each observed feature.

%%
% the folder stores correspondences matching data
srcFiles = dir([folder '/matching*.txt']);
nfiles = length(srcFiles);

% Mu and Mv store u and v coordinates respectfully
Mu = []; Mv = []; 

% V is the visibility matrix
V = []; RGB = [];
for i = 1 : nfiles
    filename = strcat('data/matching', int2str(i), '.txt');
    
    % store matching data into matrix form
    [mu, mv, v, rgb] = createMatrix(filename, i, 6);
    Mu = [Mu; mu];
    Mv = [Mv; mv];
    V = [V; v];
    RGB = [RGB; rgb];
    
    
end

end


%% encode data function
function [Mu, Mv, v, rgb] = createMatrix(filename, image_idx, nImages)

% Your Code Goes Here
A = dlmread(filename,'',1,0);

[numFeatures,~] = size(A);

rgb = zeros(numFeatures,3);
Mu = zeros(numFeatures,6); 
Mv = zeros(numFeatures,6); 
v = zeros(numFeatures,6); 

for i = 1:numFeatures
    numMatches = A(i,1); 
    
    %get the color 
    rgb(i,1) = A(i,2); %red 
    rgb(i,2) = A(i,3); %green
    rgb(i,3) = A(i,4); %blue 
    
    %store the current pixel 
    uij = A(i,5); 
    vij = A(i,6); 
    Mu(i,image_idx) = uij; 
    Mv(i,image_idx) = vij; 
    v(i,image_idx) = 1; 
    
    %store the other pixels 
    imgCoord = 7; 
    for j = 1:numMatches-1 
        %get the pixel locations and add to Mu and MV
        imgNumber = A(i,imgCoord); 
        uFrame = A(i,imgCoord+1); 
        vFrame = A(i,imgCoord+2);
        
        Mu(i,imgNumber) = uFrame;
        Mv(i,imgNumber) = vFrame; 
        
        %update the V matrix 
        v(i,imgNumber) = 1;
        
        imgCoord = imgCoord + 3;
    end 
end 

end