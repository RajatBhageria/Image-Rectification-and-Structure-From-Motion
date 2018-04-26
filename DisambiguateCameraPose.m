function [C, R, X0,bestInFront] = DisambiguateCameraPose(Cset, Rset, Xset)

maxCherality = 0; 
bestI = 1;
bestInFront = [];

for i = 1:4
    %get the ith C and R
    C = Cset{i}';
    R = Rset{i};
    r3 = R(3,:);
    X = Xset{i};
    
    cheirality = (r3*(X - C)' > 0)'; 
    inFront = X(:,3) > 0;
    
    both = sum((cheirality + inFront) == 2);
    
    if (both > maxCherality)
        maxCherality = cheirality;
        bestI = i; 
        bestInFront = inFront; 
    end 
    
end 

%return the best cheirality camerapose 
C = Cset{bestI};
R = Rset{bestI};
X0 = Xset{bestI};

end 