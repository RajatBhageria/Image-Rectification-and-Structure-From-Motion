function X = LinearTriangulation(K, C1, R1, C2, R2, x1, x2)
    [numPts,~] = size(x1); 
    allX1s = [x1,ones(numPts,1)];
    allX2s = [x2,ones(numPts,1)];

    %find the poses of the two cameras 
    P1 = K* R1*[eye(3),-C1];
    P2 = K* R2*[eye(3),-C2];
    
    A = [];
    
    %instantiate empty X matrix of points to return 
    X = zeros(numPts,3); 
    
    %find scews 
    for i = 1: numPts
        x1 = allX1s(i,:);
        x2 = allX2s(i,:); 
        
        x1Skew = vec2skew(x1); 
        x2Skew = vec2skew(x2); 
        
        a = [x1Skew * P1; x2Skew * P2]; 
        
        [~,~,V] = svd(a); 
        x = V(:,end)/V(end,end);
        x = x(1:3)';

        X(i,:) = x; 
    end 
    
end 

function X = vec2skew(x)
    X=[0 -x(3) x(2) ; x(3) 0 -x(1) ; -x(2) x(1) 0 ];
end 