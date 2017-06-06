function [] = main()
[Mat_Label, Mat_Unlabel, labels] = loadDataFromTxt();
knn_num_neighbors = 10;
max_iter = 100000;
tic
unlabel_data_labels = labelPropagation(Mat_Label, Mat_Unlabel, labels, knn_num_neighbors, max_iter);
toc   
labeled = gather(Mat_Label);
unlabeled = gather(Mat_Unlabel);
unlabeled_labels = gather(unlabel_data_labels);
lbls = gather(labels);
show(labeled, lbls, unlabeled, unlabeled_labels);
end
