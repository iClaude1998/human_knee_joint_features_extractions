function [new_femoral_component_3D]=Position_3D_implant(component_3D,thetax,thetay,thetaz,SF_3d,point1,point2)
[m,n]=size(component_3D);
new_femoral_component_3D=zeros(m,n);
% temp_TT
TT_arbitary=[1 0 0 point2(1);0 1 0 point2(2);0 0 1 point2(3);0 0 0 1];
TT_arbitary_minus=[1 0 0 -point2(1);0 1 0 -point2(2);0 0 1 -point2(3);0 0 0 1];

% Translation
TT_x=point1(1)-point2(1);
TT_y=point1(2)-point2(2);
TT_z=point1(3)-point2(3);
TT=[1 0 0 TT_x;0 1 0 TT_y;0 0 1 TT_z;0 0 0 1];
TT_minus=[1 0 0 -TT_x;0 1 0 -TT_y;0 0 1 -TT_z;0 0 0 1];
% scaling  3d

TS=[SF_3d 0 0 0;0 SF_3d 0 0;0 0 SF_3d 0;0 0 0 1];

% Rotation
rotation_cos_fx=cos(thetax);
rotation_sin_fx=sin(thetax);
TR_x=[1 0 0 0; 0 rotation_cos_fx -rotation_sin_fx 0;0 rotation_sin_fx rotation_cos_fx 0;0 0 0 1];

rotation_cos_fy=cos(thetay);
rotation_sin_fy=sin(thetay);
TR_y=[rotation_cos_fy 0 rotation_sin_fy 0; 0 1 0 0;-rotation_sin_fy 0 rotation_cos_fy 0;0 0 0 1];

rotation_cos_fz=cos(thetaz);
rotation_sin_fz=sin(thetaz);
TR_z=[rotation_cos_fz -rotation_sin_fz 0 0; rotation_sin_fz rotation_cos_fz 0 0;0 0 1 0;0 0 0 1];

rotation_matrix=(TR_x*TR_y*TR_z);


fuse_Matrix_scaled=TT_arbitary*TS*TT_arbitary_minus;
fuse_Matrix_rotated=TT_arbitary*rotation_matrix*TT_arbitary_minus;

 for i=1:length(component_3D)
     new_femoral_component_3D(:,i)=TT*fuse_Matrix_scaled*fuse_Matrix_rotated*component_3D(:,i);
 end

end