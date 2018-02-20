function mis = missclassify_heuristic(group, N, n)

forbidden = [];
suma = 0;
nG = max(group);
for i = fliplr(1:N) %differnet concordance levels
    for j = 1:nG %subspaces numbers (found)
        if sum(j==forbidden)==0 %subspace not yet used
            for k = 1:n % subspaces numbers (true)
                if sum(j==group(((k-1)*N+1):(k*N)))==i
                    suma = suma + i;
                    forbidden = [forbidden j];
                    break;
                end
            end
        end
    end
end
mis = 1-suma/(N*n);