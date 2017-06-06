function [] = show(Mat_Label, labels, Mat_Unlabel, unlabel_data_labels)
x = [Mat_Label(:,1) ;Mat_Unlabel(:,1)];
y = [Mat_Label(:, 2) ;Mat_Unlabel(:,2)];
c = [labels, unlabel_data_labels'];
scatter(x,y,'filled','cdata',c)
end