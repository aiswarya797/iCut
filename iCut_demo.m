clc;
clear all;
close all;

addpath('C:\Users\aiswarys\Downloads\iCuttoolbox\Ncuts');
SrcFile='C:\Users\aiswarys\Downloads\iCuttoolbox\data\';
dirfile=dir(SrcFile);
disp(dirfile)
ImageFileNum=size(dirfile,1)-2; 
Parameter=3; %%% This is S factor in paper.

% tic;
for ImNum=1:ImageFileNum     %%% Only one image for demo
    Name=dirfile(ImNum+2).name;
    SrcI=imread([SrcFile dirfile(ImNum+2).name]); 
    %imwrite(SrcI,[Name(1:end-4) 'SrcI.bmp']);
    %imwrite(SrcI,[Name(1:end-4) 'SrcI.tif']);
    [Inr,Inc,nb] = size(SrcI);
    if (nb>1)
        SrcI =rgb2gray(SrcI);
    end
    AdjustIm=imadjust(SrcI);
    %imwrite(AdjustIm,[Name(1:end-4) 'AdjustIm.bmp']);
    AdjustIm = medfilt2(AdjustIm, [3,3]);
BwIm=im2bw(AdjustIm,0.7);
%imwrite(BwIm,[Name(1:end-4) 'Bw.bmp']);
BwIm=uint8(BwIm);
BwIm=imdilate(BwIm,strel('disk',1));
BwIm=imfill(BwIm);
BwIm=ConnectRegionAnysis2D(BwIm,20);
AdjustImSubstract=AdjustIm;
AdjustImSubstract(BwIm==0)=0;
%imwrite(BwIm,[Name(1:end-4) 'BwConnect.bmp']);
sRate=2.5;
Rate=Parameter;
CRate=0.0;
PatchSize=20;
SrcLabeIm = bwlabeln(BwIm,4);      
BBoxIm= regionprops(SrcLabeIm, 'BoundingBox');
SrcImheight=size(SrcLabeIm,1);
SrcImwidth=size(SrcLabeIm,2);
BigEdgeIm = edge(BwIm,0.01); 
RegionalNum=size(BBoxIm,1);  %%% Connected region number
BcutBoundIm=zeros(SrcImheight,SrcImwidth);
TotalSeedPoint=[];
TotalSeedNum=0;
for ii=1:RegionalNum
    BoundW=4;
    [BBoxImage,YH,XW,Ystart,Xstart] = BlockConIm(BBoxIm(ii),SrcLabeIm,ii,BoundW);
    I=BBoxImage; 
    NewSize=size(I);   
    tempImg=I;
    ForgPixel=find(tempImg(:)>0);
    LocalSeedNum=uint16(length(ForgPixel)/(PatchSize*PatchSize));
    sigma=5;
    [EedgeIm,ConcavF,ConcavNum,ConcaveIm] = ConcavePointDetect(tempImg,sigma,0.6,5); %%%%%% Key step 1    
    if(ConcavNum==0||YH*XW<1300)
        tempImg=ConnectRegionAnysis2D(tempImg,20); 
        LabeIm = bwlabeln(tempImg,4);      
        BCentroidIm = regionprops(LabeIm, 'Centroid');
        SeedNum=1;
        SeedPoint(SeedNum,1:3)=[1,BCentroidIm.Centroid(2),BCentroidIm.Centroid(1)];
        SeedPoint=uint16(SeedPoint);           
        TotalSeedPoint(1+TotalSeedNum,1)=1+TotalSeedNum;
        TotalSeedPoint(1+TotalSeedNum,2)=SeedPoint(:,2)+uint16(Ystart);
        TotalSeedPoint(1+TotalSeedNum,3)=SeedPoint(:,3)+uint16(Xstart);
        TotalSeedNum=TotalSeedNum+1;
                bw = edge(tempImg,0.01);  
        for i=1:YH
            for j=1:XW
                if(bw(i,j)>0)
                    BcutBoundIm(Ystart+i,Xstart+j)=bw(i,j);
                end
            end
        end        
        SeedPoint=[];        
    else            
        cLabeIm = bwlabeln(ConcaveIm,4);      
        cBBoxIm= regionprops(cLabeIm, 'BoundingBox');
        cLocalSeedNum=size(cBBoxIm,1);
        nbSegments=uint16((cLocalSeedNum+1)*sRate);
        
        if(cLocalSeedNum>3)
             nbSegments =uint16((LocalSeedNum+1)*Rate);
        end

        [SegLabel,NcutDiscrete,NcutEigenvectors,NcutEigenvalues,W,imageEdges]= NcutImage(I,nbSegments);    %%%%%% Key step 2    
    
        [SeedSegLabel,SeedPoint,SeedNum] = BlockSeedpoint(I,SegLabel,CRate);
        SeedRGBIm= DrawSeedIm2(tempImg,SeedPoint,SeedNum,2);
        if(~isempty(SeedPoint))       
            bw = edge(SeedSegLabel,0.01);  
            for i=1:YH
                for j=1:XW
                    if(bw(i,j)>0&&I(i,j)>0)
                        BcutBoundIm(Ystart+i,Xstart+j)=bw(i,j);
                    end
                end
            end  
            SeedSegLabel(bw>0)=0;  
            TotalSeedPoint(1+TotalSeedNum:SeedNum+TotalSeedNum,1)=1+TotalSeedNum:SeedNum+TotalSeedNum;
            TotalSeedPoint(1+TotalSeedNum:SeedNum+TotalSeedNum,2)=SeedPoint(:,2)+double(Ystart)*ones(size(SeedPoint,1),1,'double');
            TotalSeedPoint(1+TotalSeedNum:SeedNum+TotalSeedNum,3)=SeedPoint(:,3)+double(Xstart)*ones(size(SeedPoint,1),1,'double');
            TotalSeedNum=TotalSeedNum+SeedNum;
            SeedPoint=[];
        end       
    end   
 
end
J1=zeros(SrcImheight,SrcImwidth,3,'uint8');
J1(:,:,1)=SrcI(:,:);
J1(:,:,2)=SrcI(:,:);
J1(:,:,3)=SrcI(:,:);
BcutLabelIm=imdilate(BcutBoundIm,strel('disk',3));
for i=1:SrcImheight
    for j=1:SrcImwidth
        if(BcutBoundIm(i,j)>0||BigEdgeIm(i,j)>0)
            J1(i,j,1)=0;
            J1(i,j,2)=255;
            J1(i,j,3)=255;
        end
    end
end

%%%% Results output %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sprintf('%s%d','All segmented cells number:', TotalSeedNum);
SeedRGBIm= DrawSeedIm2(J1,TotalSeedPoint,TotalSeedNum,2);
figure;imshow(SeedRGBIm,[]);
%Name=dirfile(ImNum+2).name;
% imwrite(SeedRGBIm,[Name(1:end-4) '_' num2str(Rate) '_Ncut.bmp']);
% SwcName = ['Gray' Name(1:end-4) '_' num2str(Rate) '_Ncut.swc'];
% fp=fopen(SwcName,'wb+');
% SwcWrite(fp,TotalSeedPoint,TotalSeedNum,SrcImheight);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
% toc;


