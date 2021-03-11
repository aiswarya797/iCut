clc;
clear;
load all.mat;
[e n] = imRAG2(MaXSeedSegLabel);
MaXSeedSegLabel=uint8(MaXSeedSegLabel);
figure;subplot(121);imshow(255*MaXSeedSegLabel,[]);
n=uint32(n);
e=uint32(e);
Xstart=uint32(Xstart);
Ystart=uint32(Ystart);

NewSeedRGBIm=zeros(SrcImheight,SrcImwidth,3,'uint8');
NewSeedRGBIm(:,:,1)=GrayImBack(:,:);
NewSeedRGBIm(:,:,2)=GrayImBack(:,:);
NewSeedRGBIm(:,:,3)=GrayImBack(:,:);
RAG2_Point_Num=0;
for i=1:size(e, 1)
    x((i-1)*2+1,:)=[n(e(i,1), 1),e(i,3)];
    y((i-1)*2+1,:)=[n(e(i,1), 2),e(i,4)];
    RAG2_Point{(i-1)*2+1+RAG2_Point_Num,1}=x((i-1)*2+1,:);
    RAG2_Point{(i-1)*2+1+RAG2_Point_Num,2}=y((i-1)*2+1,:);
                        
    x((i-1)*2+2,:)=[e(i,3),n(e(i,2), 1)];
    y((i-1)*2+2,:)=[e(i,4),n(e(i,2), 2)];
    
    RAG2_Point{(i-1)*2+2+RAG2_Point_Num,1}=x((i-1)*2+2,:);
    RAG2_Point{(i-1)*2+2+RAG2_Point_Num,2}=y((i-1)*2+2,:);
end
                        
                        

for i=1:RAG2_Point_Num
%     hold on;
    x=RAG2_Point{i,1};
    y=RAG2_Point{i,2};  
    nPoints=20;
    %进行插值得到中心连接更多的点
   [xi,yi]=snakeinterp(double(x),double(y),1,0); 
    for i=1:size(xi,1)
        for m=0:Drawscale
            for n=0:Drawscale
                if(uint16(xi(i))+m>0&int16(xi(i))+m<SrcImheight&uint16(yi(i))+n>0&int16(yi(i))+n<SrcImwidth)
                    SeedRGBIm(uint16(xi(i))+m,uint16(yi(i))+n,1)=0;
                    SeedRGBIm(uint16(xi(i))+m,uint16(yi(i))+n,2)=255;
                    SeedRGBIm(uint16(xi(i))+m,uint16(yi(i))+n,3)=0;
                end
            end
         end
    end
%     plot(y, x, 'linewidth', 2, 'color', 'b');
end
     
 
subplot(122);imshow(SeedRGBIm,[]); 