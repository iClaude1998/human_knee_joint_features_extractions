%% Import left femur implant mesh
FL_implant=imread('femur_implant_2d.jpg');
FL_implant=imadjust(FL_implant);
FL_implant = imbinarize(FL_implant);
FL_implant=~FL_implant;
FL_implant = imfill(FL_implant,'holes');
FL_implant=edge(FL_implant,'Sobel');
[FL_implant_x,FL_implant_y]=find(FL_implant==1);
FL_coordinates=[FL_implant_y,FL_implant_x];

%% import right femur implant mesh
FR_implant=imread('femur_implant_2d_right.jpg');
FR_implant=imadjust(FR_implant);
FR_implant = imbinarize(FR_implant);
FR_implant=~FR_implant;
FR_implant = imfill(FR_implant,'holes');
FR_implant=edge(FR_implant,'Sobel');
[FR_implant_x,FR_implant_y]=find(FR_implant==1);
FR_coordinates=[FR_implant_y,FR_implant_x];

%% Import tibia implant mesh
TL_implant=imread('tibia_implant_2d_new.jpg');
TL_implant=imadjust(TL_implant);
TL_implant = imbinarize(TL_implant);
TL_implant=~TL_implant;
TL_implant = imfill(TL_implant,'holes');
TL_implant=edge(TL_implant,'Sobel');
[TL_implant_x,TL_implant_y]=find(TL_implant==1);
TL_coordinates=[TL_implant_y,TL_implant_x];
TR_coordinates=[TL_implant_y,TL_implant_x];
%% find the dimension of implant
% Left femoral implant
temp_scale=1;
[FL_implant_Width,FL_implant_center]=implant_dim(FL_implant);
[~,column_L_LF]=find(left_femur_area(:,:)==1);
Left_Femur_Width=abs(max(column_L_LF)-min(column_L_LF));
scale_factor_LF=(Left_Femur_Width/FL_implant_Width)*temp_scale;
% scaled femoral implant
FL_coordinates=(FL_coordinates.*scale_factor_LF);
% shift implant to femur
distance_FL=left_femur_center-(FL_implant_center.*scale_factor_LF);
FL_coordinates(:,1)=FL_coordinates(:,1)+distance_FL(1);
FL_coordinates(:,2)=FL_coordinates(:,2)+distance_FL(2);


% Right femoral implant
[FR_implant_Width,FR_implant_center]=implant_dim(FR_implant)
% find the width of right distal femur
[~,column_L_RF]=find(Right_femur_area(:,:)==1);
Right_Femur_Width=abs(max(column_L_RF)-min(column_L_RF));
scale_factor_RF=(Right_Femur_Width/FR_implant_Width)*temp_scale ;
% scaled femoral implant
FR_coordinates=(FR_coordinates.*scale_factor_RF);
% shift implant to femur
distance_FR=Right_femur_center-(FR_implant_center.*scale_factor_RF);
FR_coordinates(:,1)=FR_coordinates(:,1)+distance_FR(1);
FR_coordinates(:,2)=FR_coordinates(:,2)+distance_FR(2);

% Left tibial implant
[TL_implant_Width,TL_implant_center]=implant_dim(TL_implant);
% find the width of left top tibia
[~,column_LT]=find(left_tibia_area(:,:)==1);
LT_Width=abs(max(column_LT)-min(column_LT));
scale_factor_LT=(LT_Width/TL_implant_Width)*temp_scale ;
% scaled femoral implant
TL_coordinates=(TL_coordinates.*scale_factor_LT);
% shift implant to tibia
distance_TL=left_tibia_center-(TL_implant_center.*scale_factor_LT);
TL_coordinates(:,1)=TL_coordinates(:,1)+distance_TL(1);
TL_coordinates(:,2)=TL_coordinates(:,2)+distance_TL(2);

% Right tibial implant
[TR_implant_Width,TR_implant_center]=implant_dim(TL_implant);
% find the width of left top tibia
[~,column_RT]=find(Right_tibia_area(:,:)==1);
RT_Width=abs(max(column_RT)-min(column_RT));
scale_factor_RT=(RT_Width/TR_implant_Width)*temp_scale ;
% scaled femoral implant
TR_coordinates=(TR_coordinates.*scale_factor_RT);
% shift implant to tibia
distance_TR=Right_tibia_center-(TR_implant_center.*scale_factor_RT);
TR_coordinates(:,1)=TR_coordinates(:,1)+distance_TR(1);
TR_coordinates(:,2)=TR_coordinates(:,2)+distance_TR(2);

%%
function [implant_Width,implant_center]=implant_dim(FL_implant)
[FL_implant_x,FL_implant_y]=find(FL_implant==1);
FL_coordinates=[FL_implant_y,FL_implant_x];
implant_Width=abs(max(FL_coordinates(:,1))-min((FL_coordinates(:,1))));
implant_center=round(mean(FL_coordinates));
end