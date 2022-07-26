%% Import femur component mesh
gmt_femur = stlread('Femoral Component.stl');
x_femoral_component = gmt_femur.Points(:,1);
y_femoral_component  = gmt_femur.Points(:,2);
z_femoral_component  = gmt_femur.Points(:,3);

%% Import tibia component mesh
gmt_tibia = stlread('Tibial Tray_new.stl');
x_tibial_component = gmt_tibia.Points(:,1);
y_tibial_component  = gmt_tibia.Points(:,2);
z_tibial_component  = gmt_tibia.Points(:,3);

%% Position femoral implant
femoral_component_3D=[x_femoral_component';y_femoral_component';z_femoral_component';ones(1,length(x_femoral_component))];
% "rotate angle, 1.675, -0.1, 0.07" are measured by the FEA axis on
% transverse plane and axial plane, and the femoral anatomical axis (
% thesis Fig.22) the first input point is where FEA axis across the
% lateral distal femur, shown in thesis Fig.21, the second input point is the 
% reference point on the femoral implant,"2.9" is the scale factor)
[new_femoral_component_3D]=Position_3D_implant(femoral_component_3D,1.675,-0.1,0.07,2.9,[380,120,503],[16,-16,37]);
%% Position tibial implant (a second method to place the implant)

tibial_implant_points=[x_tibial_component(:),y_tibial_component(:),z_tibial_component(:)]';
tibial_implant_points=tibial_implant_points.*2.8; %scaling

unit_vector_t_implant=([0,0,0]-tibial_implant_points(:,128306)')/norm(([0,0,0]-tibial_implant_points(:,128306)'));
% unit vector of tibial mechanical axis
unit_mech_T=(TAnew(:,1)-TAnew(:,end))/norm(TAnew(:,1)-TAnew(:,end));
unit_mech_T1=unit_mech_T';
rotation_tibial_implant = vrrotvec(unit_mech_T1,u_original_implant);
u_rotational_vector = vrrotvec2mat(rotation_tibial_implant);
r_tibial_implant = vrrotmat2vec(u_rotational_vector);
input_test_tibia=tibial_implant_points';
for i=1:length(input_test_tibia)
    new_tibial_component_3D(i,:)=(input_test_tibia(i,:)*-u_rotational_vector+[228 340 400]);
end
temp_new_femoral_component_3D=new_tibial_component_3D';
temp_tibial_implant_points = AxelRot(temp_new_femoral_component_3D,90,unit_mech_T,[235 350 400]);
new_tibial_implant_points=temp_tibial_implant_points';
% Test
scatter3(tibia_point_x(:),tibia_point_y(:),tibia_point_z(:),'k.');
hold on
scatter3(new_tibial_implant_points(:,2),new_tibial_implant_points(:,1),new_tibial_implant_points(:,3),'m.')
axis equal


