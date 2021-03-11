function SpWinSF=get_cancav(SignleOpenIm,i,j,SpWin,Bound,Imsize)     
    SpWinSF=0;
    for m=-SpWin:SpWin
        for n=-SpWin:SpWin  
           
               if(i+m>Bound&&i+m<Imsize(1)-Bound&&...
                  j+n>Bound&&j+n<Imsize(2)-Bound&&) 
                      if(SignleOpenIm(i+m,j+n)>0)
                               SpWinSF=SpWinSF+1; 
                      end
               end
           
        end
    end
