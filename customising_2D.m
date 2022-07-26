function [new_coordinate_final]=customising_2D(implant_coordinates,angle,left_femur_center,scale_factor,translation)


tranlation_matrix=[1 0 left_femur_center(1);0 1 left_femur_center(2);0 0 1];
tranlation_matrix_minus=[1 0 -left_femur_center(1);0 1 -left_femur_center(2);0 0 1];
final_translation=[1 0 translation(1);0 1 translation(2);0 0 1];
scaling_matrix=[scale_factor 0 0;0 scale_factor 0;0 0 1];

test_angle=angle;
rotation_matrix=[cos(test_angle) -sin(test_angle) 0;sin(test_angle) cos(test_angle) 0; 0 0 1];
fuse_Matrix_scaled=tranlation_matrix*scaling_matrix*tranlation_matrix_minus;
fuse_Matrix_rotated=tranlation_matrix*rotation_matrix*tranlation_matrix_minus;


new_coordinate_final=zeros(3,length(implant_coordinates));


 for i=1:length(implant_coordinates)
     new_coordinate_final(:,i)=final_translation*fuse_Matrix_scaled*fuse_Matrix_rotated*implant_coordinates(:,i);
 end

end