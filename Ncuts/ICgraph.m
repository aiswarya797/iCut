function [W,imageEdges] = ICgraph(I,dataW,dataEdgemap);
% [W,imageEdges] = ICgraph(I,dataW,dataEdgemap);
% Input:
% I = gray-level image
% optional parameters: 
% dataW.sampleRadius=10;
% dataW.sample_rate=0.3;
% dataW.edgeVariance = 0.1;
% 
% dataEdgemap.parametres=[4,3, 21,3];%[number of filter orientations, number of scales, filter size, elongation]
% dataEdgemap.threshold=0.02;
% 
% Output: 
% W: npixels x npixels similarity matrix based on Intervening Contours
% imageEdges: image showing edges extracted in the image
%
% Timothee Cour, Stella Yu, Jianbo Shi, 2004.



[p,q] = size(I);

if (nargin< 2) | isempty(dataW),
    dataW.sampleRadius=10;
%     dataW.sample_rate=0.6;
    dataW.sample_rate=1;
%     dataW.edgeVariance = 0.1;
    dataW.edgeVariance = 0.1;
end

if (nargin<3) | isempty(dataEdgemap),
%     dataEdgemap.parametres=[4,3, 21,3];%[number of filter orientations, number of scales, filter size, elongation]
    dataEdgemap.parametres=[4,1,7,3];%[number of filter orientations, number of scales, filter size, elongation]
%     dataEdgemap.threshold=0.02;
    dataEdgemap.threshold=0.02;
end


edgemap = computeEdges(I,dataEdgemap.parametres,dataEdgemap.threshold);
imageEdges = edgemap.imageEdges;
% EdgeIm=edge(I);
% h = fspecial('gaussian', [8 8], 2);
% filtered = imfilter(double(255*EdgeIm), h);
% % figure;imshow(filtered ,[]);
% edgemap.emag=filtered;
% edgemap.ephase=I;
W = computeW(I,dataW,edgemap.emag,edgemap.ephase);
