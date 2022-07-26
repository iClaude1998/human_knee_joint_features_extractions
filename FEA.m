function [transverse_axis]=FEA(left_femur,right_femur)
%%
err1=[];
err2=[];
[m,n,d]=size(left_femur);
[m1,n1,d1]=size(right_femur);
for i=1:n
    img_test=rot90(squeeze(left_femur(:,i,:)));


Total_area=sum(sum(img_test));

err1=[err1 Total_area]; 
end

for i=1:n1
    img_test=rot90(squeeze(right_femur(:,i,:)));


Total_area=sum(sum(img_test));

err2=[err2 Total_area]; 
end

index1=find(err1==max(err1));
index2=find(err2==max(err2));
figure
subplot(1,2,1)
imshow(rot90(squeeze(left_femur(:,index1,:))));
title('Sagittal slice of lateral femur')
hold on
% scatter(xCenter,yCenter,'ro','LineWidth',3)
% scatter(select_points1(:,1),select_points1(:,2),'bo','LineWidth',1)
subplot(1,2,2)
imshow(rot90(squeeze(right_femur(:,index2,:))))
title('Sagittal slice of medial femur')
hold on;
% scatter(xCenter2,yCenter2,'ro','LineWidth',3)
% scatter(select_points2(:,1),select_points2(:,2),'bo','LineWidth',1)
%%
select_points1=[];


    [p1, p2, p3]=ginput(3);

select_points1=[p1,p2,p3];
select_points1(:,3)=select_points1(:,3).*index1;
select_points1=round(select_points1);
%%
select_points2=[];
    [p4, p5, p6]=ginput(3);

select_points2=[p4,p5,p6];
select_points2(:,3)=select_points2(:,3).*index2;
select_points2=round(select_points2);
%%
numPoints = 3;
x=select_points1(:,1);
y=select_points1(:,2);
xx = x .* x;
yy = y .* y;
xy = x .* y;
A = [sum(x),  sum(y),  numPoints;
     sum(xy), sum(yy), sum(y);
     sum(xx), sum(xy), sum(x)];
B = [-sum(xx + yy) ;
     -sum(xx .* y + yy .* y);
     -sum(xx .* x + xy .* y)];
a = A \ B;
xCenter = round(-.5 * a(1))
yCenter = round(-.5 * a(2))
radius  =  round(sqrt((a(1) ^ 2 + a(2) ^ 2) / 4 - a(3)))

circular_center1=[xCenter,index1,yCenter]
%%
numPoints = 3;
x=select_points2(:,1);
y=select_points2(:,2);
xx = x .* x;
yy = y .* y;
xy = x .* y;
A = [sum(x),  sum(y),  numPoints;
     sum(xy), sum(yy), sum(y);
     sum(xx), sum(xy), sum(x)];
B = [-sum(xx + yy) ;
     -sum(xx .* y + yy .* y);
     -sum(xx .* x + xy .* y)];
a = A \ B;
xCenter2 = round(-.5 * a(1))
yCenter2 = round(-.5 * a(2))
radius2  =  round(sqrt((a(1) ^ 2 + a(2) ^ 2) / 4 - a(3)))

circular_center2=[xCenter2,index2,yCenter2]
%%
% size of left femur is 1:280; size of right femur is 
point1=[xCenter,index1+233,856-yCenter];
point2=[xCenter2,index2,856-yCenter2];
u=(point2-point1)/norm(point2-point1);
d = (-500:1:500)'; 
transverse_axis = point1 + d*u;




end