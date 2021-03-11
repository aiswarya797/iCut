function [ SeedSegLabel,SeedPoint,SeedNum] = BlockSeedpoint(I,SegLabel,CRate)

    RegIm= regionprops(SegLabel, 'Centroid'); 
    RegNum=size(RegIm,1);

    SeedSegLabel=SegLabel;
    SeedNum=0;
    SeedPoint=[];

     for i=1:RegNum

         [ix,iy]=find(SegLabel==i);%ix是高度方向
         PixelNum=double(max(size(ix)));
         
        
         [ixx,iyy]=find(I(sub2ind(size(I), ix, iy))>0);%这些点的前景像素
         FPixelNum=double(max(size(ixx)));
         
         SeedI=uint16(mean(ix));
         SeedJ=uint16(mean(iy));
         SeedI=double(SeedI);
         SeedJ=double(SeedJ);
         if(SeedI<2|SeedJ<2|FPixelNum<0.1*PixelNum)             
             SeedSegLabel(SegLabel==i)=0;
             continue
         end
         
         Num=0;
         Scale=3;
         for m=-Scale:Scale
             for n=-Scale:Scale
                 DeltX=min(max(SeedI+m,1),size(I,1));
                 DeltY=min(max(SeedJ+n,1),size(I,2));
                 if(I(DeltX,DeltY)>0)
                     Num=Num+1;
                 end
             end
         end

         if(Num>CRate*((2*Scale+1)*(2*Scale+1)))
            SeedNum=SeedNum+1;
            SeedPoint(SeedNum,1:3)=[SeedNum,SeedI,SeedJ];         
         else
%              CurrentLabel=SegLabel(SeedI,SeedJ);
             SeedSegLabel(SegLabel==i)=0;
         end
     end 


end

