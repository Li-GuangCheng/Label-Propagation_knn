function [knn_set] = compute_knn(dataSet,  query,  k)
% return k neighbors index 
numSamples = size(dataSet,1);

% calculate Euclidean distance
tmp = gpuArray(repmat(query,numSamples,1));  % tmp(numSamples,1) = query;
diff = gpuArray(tmp - dataSet);
squaredDiff = gpuArray(diff .^ 2);
squaredDist = gpuArray(sum(squaredDiff, 2));

%sort the distance 
[~, sortedDistIndices] = sort(squaredDist);
if k > length(sortedDistIndices)       % if k < len(sortedDistIndices)
    k = length(sortedDistIndices);
end
knn_set = gpuArray(sortedDistIndices(1:k));   % knn_set = squaredDist(1:k);
end


