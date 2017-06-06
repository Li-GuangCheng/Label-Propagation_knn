function [unlabel_data_labels] = labelPropagation(Mat_Label, Mat_Unlabel, labels, knn_num_neighbors, max_iter)
% label propagation  
num_label_samples = size(Mat_Label,1);
num_unlabel_samples = size(Mat_Unlabel,1);
num_samples = num_label_samples + num_unlabel_samples;
labels_list = unique(labels);
num_classes = length(labels_list);
MatX = [Mat_Label; Mat_Unlabel];
clamp_data_label = zeros(num_label_samples, num_classes, 'double');
for i = 1:num_label_samples
    clamp_data_label(i, labels(i)) = 1.0;
end
label_function = zeros(num_samples, num_classes, 'double');
label_function_tmp = zeros(num_unlabel_samples, num_classes, 'double');
label_function_tmp(:) = -1;
label_function = [clamp_data_label;label_function_tmp];
% graph construction 
affinity_matrix = buildGraph(MatX, knn_num_neighbors);
% start to propagation  
iter = 0;
pre_label_function = zeros(num_samples, num_classes, 'double');
changed = sum(sum(abs(pre_label_function - label_function)));
tol = 1e-10;
while (iter < max_iter && changed > tol)
    if mod(iter, 1) == 0
        disp(['---> Iteration', num2str(iter), '/', num2str(max_iter), ',changed', num2str(changed)])
    end
    pre_label_function = label_function;
    iter = iter + 1;
    % propagation
    label_function = affinity_matrix * label_function;
    % clamp  
    label_function(1 : num_label_samples, :) = clamp_data_label;
    % check converge
    changed = sum(sum(abs(pre_label_function - label_function)));
end
% get terminate label of unlabeled data
unlabel_data_labels = zeros(num_unlabel_samples,1);
for i = 1: num_unlabel_samples
    [~,max_index]=max(label_function(i+num_label_samples, :));
    unlabel_data_labels(i) = max_index;
end
end