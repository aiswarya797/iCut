function [BBoxImage,YH,XW,Ystart,Xstart]= BlockConIm(BBoxIm,SrcLabeIm,LL,BoundW)
%     BoundW=4;
    
    SrcImheight=size(SrcLabeIm,1);
    SrcImwidth=size(SrcLabeIm,2);
    
    SrcLabeImCrop=zeros(SrcImheight,SrcImwidth);

    Xstart=uint32(BBoxIm.BoundingBox(1))-BoundW;%宽度方向
    Ystart=uint32(BBoxIm.BoundingBox(2))-BoundW;%高度方向


    XW=uint32(BBoxIm.BoundingBox(3))+2*BoundW;
    YH=uint32(BBoxIm.BoundingBox(4))+2*BoundW;
  
    if(Xstart<1)  Xstart=1;end 
    if(Ystart<1)  Ystart=1;end
 
    if(XW+Xstart>SrcImwidth)   XW=SrcImwidth-Xstart;end
    if(YH+Ystart>SrcImheight)  YH=SrcImheight-Ystart;end
%     
    SrcLabeImCrop(SrcLabeIm==LL)=255;
    BBoxImage=SrcLabeImCrop(Ystart+1:Ystart+YH,Xstart+1:Xstart+XW);

end

