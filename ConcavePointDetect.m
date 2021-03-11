% function [EedgeImBW,MergeConcav,MergeConcavNum] = ConcavePointDetect(SignleOpenIm,sigma,Ratio)
function [EedgeIm,ConcavF,ConcavNum,ConcaveIm] = ConcavePointDetect(SignleOpenIm,sigma,Ratio,SpWin)
    [Ix,Iy] = gradient(double(SignleOpenIm));
    Imsize=size(SignleOpenIm);
    Imheight=Imsize(1);
    Imwidth=Imsize(2);
   
    %求取边缘信息

    EedgeIm=Ix.^2+Iy.^2;
    %得到边缘图像之后进行二值化,得到边缘像素点
    EedgeIm=abs(EedgeIm);
%     EdgePixel=size(iX,1);
    ConcavFDensity=[];
    ConcaveIm=zeros(Imsize(1),Imsize(2),'uint8');

%     %遍历滑动窗口的点，找到凹点
    ConcavNum=0;

    Bound=0;
    ConcavF=[];
    
    for i=1:Imheight    
        for j=1:Imwidth                      
                if(EedgeIm(i,j)>0)
                    SpWinSF=get_cancav(SignleOpenIm,i,j,SpWin,Bound,Imsize);                 
                    if(SpWinSF>uint8(Ratio*(2*SpWin+1).^2))
                        ConcavNum=ConcavNum+1;
                        ConcavF(ConcavNum,:)=[ConcavNum,i,j];
                        ConcaveIm(i,j)=255;
                    end
                end              
        end
    end

   
%    %进行凹点密度计算
%    for j=1:ConcavNum      
%        DensityNum=0;
%        HalfSpWin=int8(SpWin);
%            for m=-HalfSpWin:HalfSpWin          
%             for n=-HalfSpWin:HalfSpWin               
%                 for z=-HalfSpWin:HalfSpWin
%                     
%                     if(double(ConcavF(j,2))+m<1)ConcavF(j,2)=1-m;end
%                     if(double(ConcavF(j,2))+m>Imsize(1))ConcavF(j,2)=Imsize(1)-m; end
% 
%                     if(double(ConcavF(j,3))+n<1)ConcavF(j,3)=1-n;end
%                     if(double(ConcavF(j,3))+n>Imsize(2))ConcavF(j,3)=Imsize(2)-n;  end  
%                     
%                     if(double(ConcavF(j,4))+z<1)ConcavF(j,4)=1-z;end
%                     if(double(ConcavF(j,4))+z>Imsize(3))ConcavF(j,4)=Imsize(3)-z;  end 
% 
%                    if(ConcaveIm(uint32(double(ConcavF(j,2))+m),uint32(double(ConcavF(j,3))+n),uint32(double(ConcavF(j,4))+z))>0)
%                         DensityNum=DensityNum+1;                      
%                    end
%                 end%end of z=-HalfSpWin:HalfSpWin
%             end%end of n=-HalfSpWin:HalfSpWin
%          end
%         ConcavF(j,5)=DensityNum;
%    end
   %去掉密度很小的凹点，也就是假凹点,
%    判断标准是滑动窗口里面的满足条件的凹点个数超过一点的数目，也就可以去掉孤立的凹点
%    ConcavFDensity=[];
%    DensityNum=0;
%    for j=1:ConcavNum 
%         if(ConcavF(j,5)>uint8(SpWin))
%            DensityNum=DensityNum+1;
%            ConcavFDensity(DensityNum,:)=ConcavF(j,:);
%            ConcavFDensity(DensityNum,1)=DensityNum;
%        end
%    end 


        
end

