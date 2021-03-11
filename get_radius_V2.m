%% estimate the radius by rayburst sampling
function radius = get_radius_V2(Im, SeedPoint)
    T = 0.2;
    Im = double(Im);
    ImSize=size(Im);
    Imheight=ImSize(1);
    Imwidth=ImSize(2);
    cc = [];

%% bursting rays in 26 directions
% establish the step and length
sl =   [   0 1  1;          0 -1 1;
           1 0  1;          -1 0  1;
           1 1  1.4142;     1 -1 1.4142;      
          -1 1  1.4142;    -1 -1 1.4142;
        ];
   
% the length of casted rays
lr = zeros( 8, 1 );

% direction index
for di = 1 : 8
    % current coordinate
    cc = SeedPoint(1,2:3);
    while Im( cc(1),cc(2)) > T
        cc = cc + sl(di, 1:2);
        lr(di) = lr(di) + sl(di, 3);
        if cc(1)==0 || cc(2)==0 || cc(1)==Imheight || cc(2)==Imwidth
            break;
        end
    end
end

% sort the length vector
lr = sort(lr);
radius = lr(2); % 26*3/4