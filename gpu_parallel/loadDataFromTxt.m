function [mat_label, mat_unlabel, labels] = loadDataFromTxt()
%Load data from txt
% original_data = load('dataset.txt');
original_data_G = gpuArray(single(load('dataset.txt')));
%Calculate the size of the original dataset.
[rows, ~] = size(original_data_G);
%Choose half of the original data
select_num_rows = floor(rows * 0.1);
%Randomly generate row indexes of original dataset
random_rows = randperm(rows, select_num_rows);
%Generate the random matric using the generated row indexes and the original dataset.
random_matrix = original_data_G(random_rows,:);
%Get the rest of original dataset removing the random chosen dataset.
remain_matrix = setdiff(original_data_G, random_matrix, 'rows');

%Get the unique labels from the original dataset's third column.
mat_label = random_matrix;
labels = mat_label(:,3);
labels = labels';
mat_label(:,3) = [];
mat_unlabel = remain_matrix;
mat_unlabel(:,3) = [];
end