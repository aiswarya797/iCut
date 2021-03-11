function [ ThreeDGaussIm ] = ThreeDGaussianConv(RegionalRestrictIm,sigma)
    ScaleBonud=16;
    x=[-ScaleBonud:1:ScaleBonud];
    y=[-ScaleBonud:1:ScaleBonud];
    dimx=size(x,2);
    dimy=size(y,2);

    filtro=zeros(dimx,dimy);
    for ii=1:dimx
        for jj=1:dimy        
            esponente=exp(-(x(ii)^2+y(jj)^2)/(2*sigma^2));
            filtro(ii,jj)=1/(2*pi*sigma^2)*esponente;         
        end
    end
    % TwoGaussIm=conv2(RegionalRestrictIm,filtro,'same');
    ThreeDGaussIm=convn(RegionalRestrictIm,filtro,'same');


