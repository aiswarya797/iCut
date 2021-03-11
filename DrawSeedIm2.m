function [ SeedRGBIm] = DrawSeedIm2(AdjustIm,SeedPoint,SomaNum,Scale)
    Imsize=size(AdjustIm);
    SeedRGBIm=zeros(Imsize(1),Imsize(2),3,'uint8');
    if(length(Imsize)==3)
        SeedRGBIm=AdjustIm;
    else
        SeedRGBIm(:,:,1)=AdjustIm;
        SeedRGBIm(:,:,2)=AdjustIm;
        SeedRGBIm(:,:,3)=AdjustIm;
    end
    for i=1:SomaNum
        for m=-Scale:Scale
            for n=-Scale:Scale 
                dist=sqrt(double(m*m+n*n));
                if(dist<double(Scale)&SeedPoint(i,2)+m>0&SeedPoint(i,2)+m<Imsize(1)&SeedPoint(i,3)+n>0&SeedPoint(i,3)+n<Imsize(2))
                    SeedRGBIm(SeedPoint(i,2)+m,SeedPoint(i,3)+n,1)=255;
                    SeedRGBIm(SeedPoint(i,2)+m,SeedPoint(i,3)+n,2)=0;
                    SeedRGBIm(SeedPoint(i,2)+m,SeedPoint(i,3)+n,3)=255;
                end
            end
        end
    end




