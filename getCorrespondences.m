function [img1Pts, img2Pts, V, RGB] = getCorrespondences(Mu, Mv, V, RGB,img1Num, img2Num)

    %only taking first two columns
    first = V(:,img1Num);
    second = V(:,img2Num); 
    [ptsToKeep,~] = find(sum([first,second],2)==2); %they're both one-- i.e., one to one correspondence. 
    img1U = Mu(ptsToKeep,img1Num); 
    img1V = Mv(ptsToKeep,img1Num); 
    img2U = Mu(ptsToKeep,img2Num); 
    img2V = Mv(ptsToKeep,img2Num); 
    RGB = RGB(ptsToKeep,:);
    V = V(ptsToKeep);

    %get the image 1 and 2 u,v points of the corresponding points 
    img1Pts = [img1U,img1V];
    img2Pts = [img2U,img2V];

end 