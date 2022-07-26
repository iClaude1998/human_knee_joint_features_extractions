%%
% This section is focusing on voxel-based 3D bone segmentation.
% Use function"bwlabeln" to determine the voxel connectivity 
% Number 26 means (6 faces+12 edges+8 conners), so voxels are connected if
% their faces, edges and conners touch.
scale_3D1=scale_3D;
scale_3D1(:,:,430:430)=zeros(512,512,1);
[labeledImage_3d, numberOfBlobs_3d] = bwlabeln(scale_3D1,26);

% function "regionprops3" returns measurements for the set of properties for
% each 26-connected component (object) in the 3-D volumetric binary image
% "labeledImage_3d".
blobMeasurements = regionprops3(labeledImage_3d, 'Volume', 'Centroid');
% Extract volume pieces and associated centroid
allVolume = [blobMeasurements.Volume];
allcentroid=[blobMeasurements.Centroid];
% Sort all the volume pieces into descend order to find the femur, tibia,
% and patella, each volume pieces are labeled(has a label number).
[sortedvolume,sortindex] = sort(allVolume, 'descend');
% Use function "Ismember" to find the particular volume pieces refers to
% the sorted labels("sortindex"). Ideally, this step can remove most of
% noise
largestcomponents123 = ismember(labeledImage_3d, sortindex(1:2));
femur=ismember(labeledImage_3d, sortindex(1));
tibia=ismember(labeledImage_3d, sortindex(2));
Patella=ismember(labeledImage_3d, sortindex(3));
virtual_femoral_center_3D=allcentroid(sortindex(1),:);
virtual_tibial_center_3D=allcentroid(sortindex(2),:);