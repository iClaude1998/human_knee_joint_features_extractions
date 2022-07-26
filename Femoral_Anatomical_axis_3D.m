function [xfit,yfit,zfit]=Femoral_Anatomical_axis_3D(femur)
Anaomical_axis=[];
for i=1:856
    [labeledImage, numberOfBlobs] = bwlabel(femur(:,:,i),8);
    blobMeasurements = regionprops(labeledImage, 'area', 'Centroid');
    allAreas = [blobMeasurements.Area];
    allcentroid=[blobMeasurements.Centroid];
    [sortedareas,sortimdex] = sort(allAreas, 'descend');
    if length(sortimdex)>0
        Anaomical_axis(i,:)=[round(allcentroid(1,2*sortimdex(1)-1:2*sortimdex(1)))];
    else
        Anaomical_axis(i,:)=[0 0];
    end


end
Anaomical_axis_x=Anaomical_axis(571:end,1)';
Anaomical_axis_y=Anaomical_axis(571:end,2)';
Anaomical_axis_z=571:856;
xyz_FA=[Anaomical_axis_x(:), Anaomical_axis_y(:), Anaomical_axis_z(:)]
r0_FA=mean(xyz_FA);
[~,~,V1_FA]=svd(bsxfun(@minus,xyz_FA,r0_FA),0);
    t=linspace(-500,500,1000);
    xfit=r0_FA(1)+t*V1_FA(1,1);
    yfit=r0_FA(2)+t*V1_FA(2,1);
    zfit=r0_FA(3)+t*V1_FA(3,1);
end
