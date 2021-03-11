function SwcWrite(fp,CandRpoint,RSeedNum,Imheight)
CandRpoint=int32(CandRpoint);

for i=1:RSeedNum
    fprintf(fp,'%d',CandRpoint(i,1));fprintf(fp,' ');
    fprintf(fp,'%d',1);fprintf(fp,' ');
    %针对V3D的坐标系统
%     fprintf(fp,'%d',CandRpoint(i,3));fprintf(fp,' ');
%     fprintf(fp,'%d',Imheight-CandRpoint(i,2));fprintf(fp,' ');
%     fprintf(fp,'%d',CandRpoint(i,4));fprintf(fp,' ');
% 针对amira的坐标系统
    fprintf(fp,'%d',CandRpoint(i,3));fprintf(fp,' ');
    fprintf(fp,'%d',CandRpoint(i,2));fprintf(fp,' ');
    fprintf(fp,'%d',0);fprintf(fp,' ');
    fprintf(fp,'%d',1);fprintf(fp,' ');
    fprintf(fp,'%d',-1);fprintf(fp,' ');
    fprintf(fp,'\n');
end
fclose(fp);
end

