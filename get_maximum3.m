function mx=get_maximum3(InIm,r1,r2,c1,c2)
    mx=InIm(r1,c1);    
    for i=r1:r2
        for j=c1:c2               
            if(InIm(i,j)>mx)
                mx=InIm(i,j);
            end  
        end
    end

