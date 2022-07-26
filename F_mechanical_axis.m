function [y,x,m_FMA]=F_mechanical_axis(BW_full_bone_s,joint_center)
full_bone_edge = edge(BW_full_bone_s,'Sobel');
imshow(full_bone_edge)
%  manually select a point, and its size will grow as a circle. This 
% step can repeat multiple times to find the best-fit circle of the femoral head.
[FHL_x,FHL_y]=ginput(1);
[group_fx,group_fy]=find(full_bone_edge==1);
group_f=[group_fy,group_fx];
for i=1:length(group_f)
    distance_set(i,:)=norm( -group_f(i,:) + [FHL_x,FHL_y] ) ;
end
radius=round(min(distance_set));
viscircles([FHL_x,FHL_y],radius+1);
% Assume the femoral mechanical axis is crossing the distal femoral joint
% center and femoral head
[m_FMA, b_FMA] = str_lin1(FHL_y, FHL_x, joint_center(2), joint_center(1));
x=1:2032;
y=x*m_FMA+b_FMA;


end

