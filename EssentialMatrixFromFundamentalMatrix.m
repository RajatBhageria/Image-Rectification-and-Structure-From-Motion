function E = EssentialMatrixFromFundamentalMatrix(F, K)

%Get the F matrix 
E = K'*F*K; 

%make sure two singular values 
[U,~,V] = svd(E); 
newS = [1 0 0; 0 1 0; 0 0 0];

E = U*newS*V'; 
end 