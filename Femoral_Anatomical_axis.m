function [femur_anatomical_y,femur_anatomical_x]=Femoral_Anatomical_axis(FA_region)
femoral_anatomical_axis=[];
FA_region=edge(FA_region);

for i=1:2032
    p4_y=find(FA_region(i,:)==1);
    p4_y=round(mean(p4_y));
    if isnan(p4_y)
        p4_y=0;
    end
    if p4_y~=0
    femoral_anatomical_axis=[femoral_anatomical_axis;[i,p4_y]];
    else 
    femoral_anatomical_axis=[femoral_anatomical_axis;[0,p4_y]];
    end
end

femoral_anatomical_axis=rmoutliers(femoral_anatomical_axis(416:1015,:));
c = polyfit(femoral_anatomical_axis(:,1),femoral_anatomical_axis(:,2),1);
femur_anatomical_y = polyval(c,1:2032);
femur_anatomical_x=1:2032;

end
