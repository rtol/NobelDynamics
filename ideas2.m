clear scores scholars a* m* n*
year = {'05' '06' '07' '08' '09' '10' '11' '12' '13' '14' '15' '16' '17' '18' '19' '20' '21' '22' '23' '24'};
month = {'01' '02' '03' '04' '05' '06' '07' '08' '09' '10' '11' '12'};
ny = length(year);
nm = length(month);
scholars = {};
scores = [];
s=0;
months = 0; %101
for y=1:ny %need to split the sample because the cell structure is too large
    for m=1:nm
        aux = strcat('https://ideas.repec.org/top/old/',year{y},month(m),'/top.person.wsccites.html');
        try
            site = webread(string(aux));
        catch
            disp('nope')
        end
        months = months+1;
        if months <= 101
            aux0 = strfind(site,'<TD>Score</TD>');
            auxm1 = strfind(site,'Credits:');
            auxm2 = strfind(site,'deceased author');
            if length(auxm2)==0
                site1 = site(aux0:auxm1);
            else
                site1 = site(aux0:auxm2);
            end
            aux1 = strfind(site1,'<A HREF');
            na = length(aux1);
            for a=1:na
                s=s+1;
                aux2=site1(aux1(a):end);
                aux3=strfind(aux2,'.html');
                aux4=strfind(aux2,'</A>');
                scholars{s}=aux2(aux3+6:aux4-1);
                aux5=aux2(aux3(1):end);
                aux6=strfind(aux5,'</TD><TD>');
                aux7=strfind(aux5,'</TD></TR>');
                aux8=aux5(aux6(1)+9:aux7(1)-1);
                auxs(a)=str2double(aux8); 
            end
            auxs = auxs/max(auxs);
            scores = [scores auxs];
        else
            aux0 = strfind(site,'Score');
            auxm1 = strfind(site,'Credits:');
            auxm2 = strfind(site,'deceased author');
            site1 = site(aux0:auxm2);
            aux1 = strfind(site1,'<A NAME');
            na = length(aux1);
            for a=1:na
                s=s+1;
                aux2=site1(aux1(a):end);
                aux3=strfind(aux2,'.html');
                aux4=strfind(aux2,'</A>');
                scholars{s}=aux2(aux3(1)+7:aux4(2)-1);
                aux5=aux2(aux3(1):end);
                aux6=strfind(aux5,'</TD><TD>');
                aux7=strfind(aux5,'</TD></TR>');
                aux8=aux5(aux6(1)+9:aux7(1)-1);
                auxs(a)=str2double(aux8); 
            end
            auxs = auxs/max(auxs);
            scores = [scores auxs];
        end
    end
end

%%
sc = [sc1 sc2 sc3 sc4 sc5 sc6 sc7 sc8 sc9 sc10];
sh = [sch1 sch2 sch3 sch4 sch5 sch6 sch7 sch8 sch9 sch10]; 
[scholar1,ia,ic] = unique(sh);
for i=1:length(scholar1)
    score1(i) = sum(sc(ic==i));
end
%%
sc = [sc11 sc20 sc25];
sh = [sch11 sch20 sch25];
[scholar2,ia,ic] = unique(sh);
for i=1:length(scholar2)
    score2(i) = sum(sc(ic==i));
end
%%
sc = [score1 score2];
sh = [scholar1 scholar2];
[scholar,ia,ic] = unique(sh);
for i=1:length(scholar)
    score(i) = sum(sc(ic==i));
end