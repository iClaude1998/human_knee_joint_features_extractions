%% Extract femur points (to world coordiantes)
[femur_point_x,femur_point_y,femur_point_z]=volume2world(femur);
%% Extract tibia points (to world coordiantes)
[tibia_point_x,tibia_point_y,tibia_point_z]=volume2world(tibia);
%% estimation of femoral anatomical axis
[xfit,yfit,zfit]=Femoral_Anatomical_axis_3D(femur);
scatter3(femur_point_x,femur_point_y,femur_point_z,'k.')
hold on;
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
set(gca,'ztick',[],'zticklabel',[])
line(yfit,xfit,zfit); 
axis equal
%% estimation of tibial anatomical axis
[t_xfit,t_yfit,t_zfit]=Tibial_Anatomical_axis_3D(tibia)
% Test
scatter3(tibia_point_x,tibia_point_y,tibia_point_z,'k.')
hold on;
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
set(gca,'ztick',[],'zticklabel',[])
line(t_yfit,t_xfit,t_zfit); 
axis equal
%% Femoral mechanical axis estimation
estimate_joint_center=mean([virtual_femoral_center_3D;virtual_tibial_center_3D]);
FA=[xfit;yfit;zfit];
[FAnew,FA_R,FA_t] = AxelRot(FA,3.94,[0 1 0],estimate_joint_center);
% Test
scatter3(femur_point_x,femur_point_y,femur_point_z,'k.')
hold on;
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
set(gca,'ztick',[],'zticklabel',[])
line(yfit,xfit,zfit); 
axis equal
line(FAnew(2,:),FAnew(1,:),FAnew(3,:),'Color','red');
%% Tibial mechanical axis estimation
TA=[t_xfit;t_yfit;t_zfit];
[TAnew,TA_R,TA_t] = AxelRot(TA,-1,[0 1 0],estimate_joint_center);
% Test
scatter3(tibia_point_x,tibia_point_y,tibia_point_z,'k.')
hold on;
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
set(gca,'ztick',[],'zticklabel',[])
line(t_yfit,t_xfit,t_zfit); 
axis equal
line(TAnew(2,:),TAnew(1,:),TAnew(3,:),'Color','red');
%% Estimation of Postior condyles line
% In current stage, the system is unable to recognise condyles on the 
% distal femur. Two condyles shown below are manual selections.
Lateral_condyle=[456,326,493];
Medial_condyle=[417,151,492];
PCL= line_3d_gen(Medial_condyle,Lateral_condyle);
%% Flexion and extension axis estimation(Cross femur)
% Break femur into two parts
% left_femur=Femur(:,1:280,:);
% right_femur=Femur(:,281:end,:);
% from two seprated parts to find two cross section to find most fit cicle
% to simulate circular center and these two circular centers can represent
% as a cylinder axis in distal femur( also known as Flexion and extension axis
[transverse_axis]=FEA(left_femur,right_femur);
% Test
figure
scatter3(femur_point_x,femur_point_y,femur_point_z,'k.')
hold on;
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
set(gca,'ztick',[],'zticklabel',[])
axis equal
plot3(transverse_axis(:,1),transverse_axis(:,2),transverse_axis(:,3),'g-','LineWidth',5)
%%
