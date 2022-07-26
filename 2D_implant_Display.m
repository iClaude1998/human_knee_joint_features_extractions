clc;
%% Left femoral implant
[new_FL_coordinate]=Position_2D_implant(FL_coordinates,-m_LFMA,left_femur_center,0.9)
figure
imshow(BW_full_bone_s)
hold on
plot(new_FL_coordinate(1,:),new_FL_coordinate(2,:),'r.');

%% Right femoral implant
% Left femoral implant
[new_FR_coordinate]=Position_2D_implant(FR_coordinates,-m_RFMA,Right_femur_center,0.9)
figure
imshow(BW_full_bone_s)
hold on
plot(new_FR_coordinate(1,:),new_FR_coordinate(2,:),'r.');
%% Left tibial implant
[new_TL_coordinate]=Position_2D_implant(TL_coordinates,-m_LTMA,left_tibia_center,0.9)
figure
imshow(BW_full_bone_s)
hold on
plot(new_TL_coordinate(1,:),new_TL_coordinate(2,:),'r.');
%% Right tibial implant
[new_TR_coordinate]=Position_2D_implant(TR_coordinates,-m_RTMA,Right_tibia_center,0.9)
figure
imshow(BW_full_bone_s)
hold on
plot(new_TR_coordinate(1,:),new_TR_coordinate(2,:),'r.');

%% custom transform
[new_FL_coordinate_custom]=customising_2D(new_FL_coordinate,0,left_femur_center,1,[0,0]);
figure
imshow(BW_full_bone_s)
hold on
plot(new_FL_coordinate(1,:),new_FL_coordinate(2,:),'r.');
plot(new_FL_coordinate_custom(1,:),new_FL_coordinate_custom(2,:),'g.');
%% Rest of implant could test by your selection of input variable