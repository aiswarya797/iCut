function [ SomaNum,SeedImagePtr,SeedPoint] = GetSeed3(ThreeDGaussIm,scale,BigBinaryThreeIm)
    SomaNum=0;
    GaussImSize=size(ThreeDGaussIm);
    Imheight=GaussImSize(1);
    Imwidth=GaussImSize(2);
    Bound=2;
    SeedPoint=[];
    SeedImagePtr=zeros(Imheight,Imwidth,'uint8');
     for i=1+Bound:1:Imheight-Bound    
        for j=1+Bound:1:Imwidth-Bound

                min_r=max(1,i-scale);
                min_c=max(1,j-scale);
     
                max_r=min(Imheight,i+scale);
                max_c=min(Imwidth,j+scale);
             
                mx=get_maximum3(ThreeDGaussIm,min_r,max_r,min_c,max_c);
                if(ThreeDGaussIm(i,j)==mx&&BigBinaryThreeIm(i,j)>0)
%                 if(ThreeDGaussIm(i,j,z)==mx&&BigBinaryThreeIm(i,j,z)>0)
                    SomaNum=SomaNum+1;
                    SeedImagePtr(i,j)=255; 
                    SeedPoint(SomaNum,:)=[SomaNum,i,j];
                else 
                    SeedImagePtr(i,j)=0;
                end        
            
        end
     end

