
%% 
% The first part is to read the CT scan dataset
% Initial extract the CT scan images into VOLUME
% V1 is the raw knee volume
sourcetable = dicomCollection(fullfile('F:\2020secondsememster\ENGN4200\Mendeley\Knee_raw_data\dataforcompetition\Raw CT Data\PreOp\all\Knee'));
[V1,spatial,dim] = dicomreadVolume(sourcetable);

%%
% dimension of V1 is 4, so use squeeze function to reform 3d volume(V)
V = squeeze(V1);
% make sure the variable type is double
V = im2double(V);
% filter the volume based on binary intensities to get a raw knee data
Knee_3D=imbinarize(mat2gray(V),0.53);
% Resize the volume(V) to reality-based proportion(leg proportion)
scale_3D=imresize3((Knee_3D),[512 512 856]);

%%
% The second part is to read the X-ray image
% The original X-ray image dataset contains three separated images taken from the same leg
% Im3 is the combined image that processed before.(Without any
% brightness change, only change the image size)
load("Im3.mat");
raw_image=Im3;
% use 'histeq'or'imadjust' function to enhance image contrast
enhanced_image_Xray=histeq(raw_image);
% determine the intensity values to figure out the approximate bone region
thresh_Xray = imbinarize(enhanced_image_Xray,0.29);
% Based on previous methods, the quality of segmented bone region is poor,
% so advanced matlab built-in App is required.("Image segmentater")
% Therefore, this part of coding is required further modifications
% The variable "BW_full_bone" is the final bone segmentation computed from
% "Image segmentater"

% BW_full_bone;



