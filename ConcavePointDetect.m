% function [EedgeImBW,MergeConcav,MergeConcavNum] = ConcavePointDetect(SignleOpenIm,sigma,Ratio)
function [EedgeIm,ConcavF,ConcavNum,ConcaveIm] = ConcavePointDetect(SignleOpenIm,sigma,Ratio,SpWin)
    [Ix,Iy] = gradient(double(SignleOpenIm));
    Imsize=size(SignleOpenIm);
    Imheight=Imsize(1);
    Imwidth=Imsize(2);
   
    %��ȡ��Ե��Ϣ

    EedgeIm=Ix.^2+Iy.^2;
    %�õ���Եͼ��֮����ж�ֵ��,�õ���Ե���ص�
    EedgeIm=abs(EedgeIm);
%     EdgePixel=size(iX,1);
    ConcavFDensity=[];
    ConcaveIm=zeros(Imsize(1),Imsize(2),'uint8');

%     %�����������ڵĵ㣬�ҵ�����
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

   
%    %���а����ܶȼ���
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
   %ȥ���ܶȺ�С�İ��㣬Ҳ���Ǽٰ���,
%    �жϱ�׼�ǻ���������������������İ����������һ�����Ŀ��Ҳ�Ϳ���ȥ�������İ���
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

