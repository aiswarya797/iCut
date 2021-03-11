function [OutIm,LabelIm]=ConnectRegionAnysis2D(InIm,MinAreaSize)

    LabeIm = bwlabeln(InIm,4);      
    RegionalAreaIm= regionprops(LabeIm, 'Area'); 
    RegionalNum=size(RegionalAreaIm);
    AreaRate(1)=0.0;
     for i=1:RegionalNum(1)
       AreaRate(i)=RegionalAreaIm(i).Area;      
     end  
    MeanArea=mean(AreaRate);
    MaxArea=max(AreaRate);
    MinArea=min(AreaRate);
       
    RegionalRestrictIm=ismember(LabeIm,find(([RegionalAreaIm.Area]>=MinAreaSize)));
    LabelIm = bwlabeln(RegionalRestrictIm,4);
    OutIm=im2bw(LabelIm);
%     NewRegionalAreaIm= regionprops(LabeIm, 'Area'); 

