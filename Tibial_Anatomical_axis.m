function [Tibial_anatomical_y,Tibial_anatomical_x]=Tibial_Anatomical_axis(TA_region)
Tibial_anatomical_axis=[];
TA_region=edge(TA_region);

for i=1:2032
    p4_y=find(TA_region(i,:)==1);
    p4_y=round(mean(p4_y));
    if isnan(p4_y)
        p4_y=0;
    end
    if p4_y~=0
    Tibial_anatomical_axis=[Tibial_anatomical_axis;[i,p4_y]];
    else 
    Tibial_anatomical_axis=[Tibial_anatomical_axis;[0,p4_y]];
    end
end
% Remove outliers that will potentially affect the performance of
% estimation of anatomical axis
Tibial_anatomical_axis=rmoutliers(Tibial_anatomical_axis(1293:1860,:));
c = polyfit(Tibial_anatomical_axis(:,1),Tibial_anatomical_axis(:,2),1);
Tibial_anatomical_y = polyval(c,1:2032);
Tibial_anatomical_x=1:2032;

end