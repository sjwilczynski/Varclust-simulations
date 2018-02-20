% Piotr Sobczyk

function mis = moje_symulacje(n, dim, sigma, K, p)
filename = ['../../data/X_'  num2str(dim) '_'  num2str(sigma) '.csv'];
X = csvread(filename);
%normalizing X
for i=1:size(X,2)
   X(:,i) = X(:,i) - repmat(mean(X(:,i)), size(X,1), 1); 
end
%X = normc(X); -nie mam tego toolboxa
lengths = sqrt(sum(X.*X,1));
X = bsxfun(@rdivide, X, lengths);

N = p/K; %each group has the same number of ,,points" 

r = 0; %Enter the projection dimension e.g. r = d*n, enter r = 0 to not project

%%
SSCstart = tic
Cst = 0; %Enter 1 to use the additional affine constraint sum(c) == 1
OptM = 'Lasso'; %OptM can be {'L1Perfect','L1Noise','Lasso','L1ED'}
lambda = 0.01; %Regularization parameter in 'Lasso' or the noise level for 'L1Noise'
M = dim+1; %Number of top coefficients to build the similarity graph, enter K=0 for using the whole coefficients
Xp = DataProjection(X,r,'NormalProj');
CMat = SparseCoefRecovery(Xp,Cst,OptM,lambda);
%[CMatC,sc,OutlierIndx,Fail] = OutlierDetection(CMat,s);
CKSym = BuildAdjacency(CMat,M);
[Grps , SingVals, LapKernel] = SpectralClustering(CKSym,K);
SSCtime = toc(SSCstart)

%% low-rank subspace clustering, we minimize rank of C -affinity matrix
LRSCstart = tic
tau = 100; %penalty on data not being self expressive
alpha = 10; %penalty on noise
Xp = DataProjection(X,r,'NormalProj');
[A,C] = lrsc_noisy(Xp,tau,alpha); 
%now post-processing starts
CKSym = abs(C);
[Grps , SingVals, LapKernel] = SpectralClustering(CKSym,K);
LRSCtime = toc(LRSCstart)


filename = ['../../timeMATLAB', num2str(dim) '.csv'];
fid = fopen(filename,'at');   
fprintf(fid, '%.4f,', SSCtime);  
fprintf(fid, '%.4f', LRSCtime);
fprintf(fid, '\n');
fclose(fid);
%%