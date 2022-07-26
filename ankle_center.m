function [ankle_center]=ankle_center(Ankle_region)
Ankle_region=edge(Ankle_region);
[ALX,ALY]=find(Ankle_region==1);
group_AL=[ALY,ALX];
% To find two most outer point in the selective region
index1=find(group_AL(:,1)==min(group_AL(:,1)));
index2=find(group_AL(:,1)==max(group_AL(:,1)));
ankle_center=round(mean([group_AL(round(mean(index1)),:);group_AL(round(mean(index2)),:)]));
end