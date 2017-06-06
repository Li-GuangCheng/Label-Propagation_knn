function [] = main()
[Mat_Label, Mat_Unlabel, labels] = loadDataFromTxt();
knn_num_neighbors = 10;
max_iter = 100000;
unlabel_data_labels = labelPropagation(Mat_Label, Mat_Unlabel, labels, knn_num_neighbors, max_iter);
show(Mat_Label, labels, Mat_Unlabel, unlabel_data_labels);
end
