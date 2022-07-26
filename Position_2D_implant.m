function [new_coordinate_rotated]=Position_2D_implant(implant_coordinates,slope,reference_center,scale_factor_test)


tranlation_matrix=[1 0 reference_center(1);0 1 reference_center(2);0 0 1];
tranlation_matrix_minus=[1 0 -reference_center(1);0 1 -reference_center(2);0 0 1];
scaling_matrix=[scale_factor_test 0 0;0 scale_factor_test 0;0 0 1];


test_angle=slope;
rotation_matrix=[cos(test_angle) -sin(test_angle) 0;sin(test_angle) cos(test_angle) 0; 0 0 1];
fuse_Matrix_scaled=tranlation_matrix*scaling_matrix*tranlation_matrix_minus;
fuse_Matrix_rotated=tranlation_matrix*rotation_matrix*tranlation_matrix_minus;

implant_coordinates=[implant_coordinates,ones(length(implant_coordinates),1)];
implant_coordinates=implant_coordinates';

new_coordinate_scaled=zeros(3,length(implant_coordinates));
new_coordinate_rotated=zeros(3,length(implant_coordinates));
for i=1:length(implant_coordinates)
    new_coordinate_scaled(:,i)=fuse_Matrix_scaled*implant_coordinates(:,i);
end

for i=1:length(implant_coordinates)
    new_coordinate_rotated(:,i)=fuse_Matrix_rotated*new_coordinate_scaled(:,i);
end


end