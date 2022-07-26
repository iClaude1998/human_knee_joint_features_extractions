function [joint_center,y,x,lowest_point_Left,lowest_point_Right,femur_area_center,tibial_area_center,knee_center_region,Left_tibial_region]=knee_joint_center(knee_center_region)
[labeledImage_knee_center, numberOfBlobs_nc] = bwlabel(knee_center_region);
blobMeasurements_klc = regionprops(labeledImage_knee_center, 'area', 'Centroid');
allAreas_klc = [blobMeasurements_klc.Area];
allcentroid_klc=[blobMeasurements_klc.Centroid];
[sortedareas_klc,sortimdex_klc] = sort(allAreas_klc, 'descend');
knee_center_region=ismember(labeledImage_knee_center,sortimdex_klc(1));
femur_area_center=round(allcentroid_klc(1,2*sortimdex_klc(1)-1:2*sortimdex_klc(1)));
% knee_center_region(:,area_center(1))=0;
% imshow(knee_center_region)
% find lowest point in left
[row_Left,~]=find(knee_center_region(:,1:femur_area_center(1))==1);
index_lowest_row_Left=find(knee_center_region(max(row_Left),1:femur_area_center(1))==1);
lowest_point_Left = [round(mean(index_lowest_row_Left)),max(row_Left)];
%find lowest point in right
[row_Right,~]=find(knee_center_region(:,femur_area_center(1):end)==1);
index_lowest_row_Right=find(knee_center_region(max(row_Right),femur_area_center(1):end)==1);
lowest_point_Right = [femur_area_center(1)+round(mean(index_lowest_row_Right)),max(row_Right)];

[~,column_L]=find(knee_center_region(:,:)==1);
Femur_Width=abs(max(column_L)-min(column_L));
[FL_m, b] = str_lin1(lowest_point_Left(2), lowest_point_Left(1), lowest_point_Right(2), lowest_point_Right(1));
x=1:2032;
y=x*FL_m+b;
joint_center=(mean([lowest_point_Left;lowest_point_Right]));


Left_tibial_region=ismember(labeledImage_knee_center,sortimdex_klc(2));
tibial_area_center=round(allcentroid_klc(1,2*sortimdex_klc(2)-1:2*sortimdex_klc(2)));

% imshow(Left_tibial_region)
% hold on
% plot(tibial_area_center(1),tibial_area_center(2),'r.','MarkerSize',20);
end


