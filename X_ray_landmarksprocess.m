% This section is focusing on X-ray pipeline to find out the required bony
% landmarks

%%
% Im3 is the fundamental image that has been extracted before.
% BW_full_bone is the bone segmentation outcomes computed by matlab
% in-built APP
clear
clc

load('bone_X_ray.mat');
load('Im3.mat');

%% Smooth bone edge
windowSize = 15;
kernel = ones(windowSize) / windowSize ^ 2;
BW_full_bone_s = conv2(single(BW_full_bone), kernel, 'same');
BW_full_bone_s = BW_full_bone_s > 0.5; % Rethreshold

%% Left femoral anatomical axis
% LFA is Left Femoral axis; LF is left femur. "Crop_out" function requires
% your hand slection.
LF_region=crop_out(BW_full_bone_s);
% Function"Femoral_Anatomical_axis" is to compute the estimation of Left Femoral axis
[Left_femur_anatomical_y,Left_femur_anatomical_x]=Femoral_Anatomical_axis(LF_region);
% Test
imshow(Im3)
hold on
plot(Left_femur_anatomical_y,Left_femur_anatomical_x,'r-','LineWidth',1)
%% Right femoral anatomical axis
RF_region=crop_out(BW_full_bone_s);
[Right_femur_anatomical_y,Right_femur_anatomical_x]=Femoral_Anatomical_axis(RF_region);
% Test
imshow(Im3)
hold on
plot(Right_femur_anatomical_y,Right_femur_anatomical_x,'r-','LineWidth',1)
%% Left tibial anatomical axis
LT_region=crop_out(BW_full_bone_s);
[Left_tibial_anatomical_y,Left_tibial_anatomical_x]=Tibial_Anatomical_axis(LT_region);
% Test
imshow(Im3)
hold on
plot(Left_tibial_anatomical_y,Left_tibial_anatomical_x,'r-','LineWidth',1)
%% Right tibial anatomical axis
RT_region=crop_out(BW_full_bone_s);
[Right_tibial_anatomical_y,Right_tibial_anatomical_x]=Tibial_Anatomical_axis(RT_region);
% Test
imshow(Im3)
hold on
plot(Right_tibial_anatomical_y,Right_tibial_anatomical_x,'r-','LineWidth',1)
%% Determine the left knee joint region
Left_knee_center_region=crop_out(BW_full_bone_s);
% function "knee_joint_center" returns the approximate left knee joint
% center(x,y), the rough left knee joint line (close to femur), two lowest
% points on both left and right distal femur, and the estimate femoral
% center and tibial head center(position may be dramatically changed when your selected joint 
% region varies with others) .
[left_joint_center,y_JLF,x_JLF,L_lowest_point_DFL,L_lowest_point_DFR,left_femur_center,left_tibia_center,left_femur_area,left_tibia_area]=knee_joint_center(Left_knee_center_region);
% Test
figure
imshow(Im3)
hold on
plot(y_JLF,1:2032,'b-','LineWidth',2)
plot(left_joint_center(1),left_joint_center(2),'r.','MarkerSize',20);
plot(L_lowest_point_DFR(1),L_lowest_point_DFR(2),'ro','LineWidth',2)
plot(L_lowest_point_DFL(1),L_lowest_point_DFL(2),'ro','LineWidth',2)
plot(left_femur_center(1),left_femur_center(2),'r.','MarkerSize',20);
plot(left_tibia_center(1),left_tibia_center(2),'r.','MarkerSize',20);
%% Determine the Right knee joint region
Right_knee_center_region=crop_out(BW_full_bone_s);
% Similar to previous section
[Right_joint_center,y_JRF,x_JRF,R_lowest_point_DFL,R_lowest_point_DFR,Right_femur_center,Right_tibia_center,Right_femur_area,Right_tibia_area]=knee_joint_center(Right_knee_center_region);
imshow(Im3)
hold on;
plot(y_JRF,x_JRF,'b-','LineWidth',2)
plot(R_lowest_point_DFL(1),R_lowest_point_DFL(2),'ro','LineWidth',2)
plot(R_lowest_point_DFR(1),R_lowest_point_DFR(2),'ro','LineWidth',2)
plot(Right_femur_center(1),Right_femur_center(2),'r.','MarkerSize',20);
plot(Right_joint_center(1),Right_joint_center(2),'r.','MarkerSize',20);
plot(Right_tibia_center(1),Right_tibia_center(2),'r.','MarkerSize',20);
%% Left Femoral mechanical axis
% function "F_mechanical_axis" is to compute the approximate femoral
% mechanical axis. The main idea is to find a line cross the joint center
% and femoral head center.
[y_LFMA,x_LFMA,m_LFMA]=F_mechanical_axis(BW_full_bone_s,left_joint_center);
% Test
figure
imshow(Im3)
hold on;
plot(y_LFMA,x_LFMA,'b-','LineWidth',1);
%% Right Femoral mechanical axis
[y_RFMA,x_RFMA,m_RFMA]=F_mechanical_axis(BW_full_bone_s,Right_joint_center);
% Test
figure
imshow(Im3)
hold on;
plot(y_RFMA,x_RFMA,'b-','LineWidth',1);
%% Determine the Left ankle center
% Function "Ankle_center" is to compute the approximate tibial ankle center
L_Ankle_region=crop_out(BW_full_bone_s);
[Left_ankle_center]=ankle_center(L_Ankle_region);
% Test
imshow(Im3)
hold on;
plot(Left_ankle_center(1),Left_ankle_center(2),'ro','LineWidth',2)
%% Determine the Right ankle center
R_Ankle_region=crop_out(BW_full_bone_s);
[Right_ankle_center]=ankle_center(R_Ankle_region);
% Test
imshow(Im3)
hold on;
plot(Right_ankle_center(1),Right_ankle_center(2),'ro','LineWidth',2)
%% Left & Right tibial mechanical axis
% Left tibial mechanical axis
% Function "str_lin1" is to compute a virtual line slope "m" and shift"b"
% by two known points.
[m_LTMA, b_LTMA] = str_lin1(Left_ankle_center(2), Left_ankle_center(1), left_joint_center(2), left_joint_center(1))
x_LTMA=1:2032;
y_LTMA=x_LTMA*m_LTMA+b_LTMA;
% Right tibial mechanical axis
[m_RTMA, b_RTMA] = str_lin1(Right_ankle_center(2), Right_ankle_center(1), Right_joint_center(2), Right_joint_center(1))
x_RTMA=1:2032;
y_RTMA=x_RTMA*m_RTMA+b_RTMA;
% Test
figure
imshow(Im3)
hold on;
plot(y_LTMA,x_LTMA,'r-','LineWidth',1);
plot(y_RTMA,x_RTMA,'r-','LineWidth',1);
%% The Left proximal tibial joint line
% In the current stage, the proximal tibial joint line was determined by two
% lowest points on tibial plateau. However, the algorithm of automically
% detecting those two points was not prefect, so in here just use matlab
% in-build data tips to get the exactly points

% "TLJ" is tibial left joint.
[TLJ_m, b_TLJ] = str_lin1(1152, 233, 1159, 100);
x_TLJ=1:2032;
y_TLJ=x_TLJ*TLJ_m+b_TLJ;
% Test
imshow(Im3)
hold on
plot(y_TLJ,x_TLJ,'w-.','LineWidth',1)
%% The Right proximal tibial joint line
[TRJ_m, b_TRJ] = str_lin1(1192, 773, 1172, 621);
x_TRJ=1:2032;
y_TRJ=x_TRJ*TRJ_m+b_TRJ;
% Test
imshow(Im3)
hold on
plot(y_TRJ,x_TRJ,'w-.','LineWidth',1)




