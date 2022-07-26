function [point_x,point_y,point_z]=volume2world(bone)
point_x=[];
point_y=[];
point_z=[];

for i=1:856
    x_3D=[];
    y_3D=[];
    XY_plane_input=bone(:,:,i);
    [x_3D,y_3D] = find(XY_plane_input(:,:)==1);
    point_x= [point_x x_3D'];
    point_y= [point_y y_3D'];
    point_z= [point_z ones(1,length(x_3D)).*i];
end

end