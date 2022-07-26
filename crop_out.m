function [segmented_region]=crop_out(BW_full_bone)

[A1,rect1] = imcrop(BW_full_bone);
rect1=round(rect1);
segmented_region=zeros(2032,929);
segmented_region(rect1(2):(rect1(2)+rect1(4))-1,rect1(1):(rect1(1)+rect1(3))-1)=A1;

end