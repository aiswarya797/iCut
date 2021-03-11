function I = imread_ncut(Image_file_name,nr,nc);
%  I = imread_ncut(Image_file_name);
%
% Timothee Cour, Stella Yu, Jianbo Shi, 2004.


%% read image 

I = imread(Image_file_name);
[Inr,Inc,nb] = size(I);

if (nb>1),
    I =double(rgb2gray(I));
else
    I = double(I);
end

% I = imresize(I,[nr, nc],'bicubic');
% I = imresize(I,2,'bicubic');
I=uint8(I);
% I = medfilt2(I, [2,2]);
