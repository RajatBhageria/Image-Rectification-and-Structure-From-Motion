function [Cset, Rset] = ExtractCameraPose(E)

[U,~,V] = svd(E); 
W = [0 -1 0; 1 0 0; 0 0 1];

Cset = cell(4,1);
Rset = cell(4,1); 

%config 1 
t1 = U(:,3); 
R1 = U*W*V';
C1 = -R1'*t1;
if (det(R1) < 0 )
    R1 = -R1;
    C1 = -C1; 
end 
Cset{1} = C1; 
Rset{1} = R1; 

%config 2 
t2 = -U(:,3); 
R2 = U*W*V';
C2 = -R2'*t2;
if (det(R2) < 0 )
    R2 = -R2;
    C2 = -C2; 
end 
Cset{2} = C2; 
Rset{2} = R2;

%config 3 
t3 = U(:,3); 
R3 = U*W'*V';
C3 = -R3'*t3;
if (det(R3) < 0)
    R3 = -R3;
    C3 = -C3; 
end 
Cset{3} = C3; 
Rset{3} = R3; 

%config 4; 
t4 = -U(:,3); 
R4 = U*W'*V';
C4 = -R4'*t4; 
if (det(R4) < 0)
    R4 = -R4;
    C4 = -C4;
end 
Cset{4} = C4; 
Rset{4} = R4; 

end 