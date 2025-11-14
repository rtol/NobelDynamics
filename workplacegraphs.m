StartYear = min(data.From);
latNobel = zeros(2024-StartYear,1);
lonNobel = zeros(2024-StartYear,1);
latBC = zeros(2024-StartYear,1);
lonBC = zeros(2024-StartYear,1);
latNobelsq = zeros(2024-StartYear,1);
lonNobelsq = zeros(2024-StartYear,1);
latBCsq = zeros(2024-StartYear,1);
lonBCsq = zeros(2024-StartYear,1);
latNobelse = zeros(2024-StartYear,1);
lonNobelse = zeros(2024-StartYear,1);
latBCse = zeros(2024-StartYear,1);
lonBCse = zeros(2024-StartYear,1);
for i=1:2024-StartYear,
    xNN = 0;
    xNB = 0;
    for j=1:NP,
        xlatN = data.Lat(data.From <= StartYear+i-1 & data.To >= StartYear+i-1 & strcmp(data.School,places{j}) & data.Nobel == 1 & data.BatesClark == 1);
        xlonN = data.Lon(data.From <= StartYear+i-1 & data.To >= StartYear+i-1 & strcmp(data.School,places{j}) & data.Nobel == 1 & data.BatesClark == 1);
        xlatB = data.Lat(data.From <= StartYear+i-1 & data.To >= StartYear+i-1 & strcmp(data.School,places{j}) & data.Nobel == 0 & data.BatesClark == 1);
        xlonB = data.Lon(data.From <= StartYear+i-1 & data.To >= StartYear+i-1 & strcmp(data.School,places{j}) & data.Nobel == 0 & data.BatesClark == 1);
        latNobel(i) = latNobel(i) + sum(xlatN);
        lonNobel(i) = lonNobel(i) + sum(xlonN);
        latNobelsq(i) = latNobelsq(i) + xlatN'*xlatN;
        lonNobelsq(i) = lonNobelsq(i) + xlonN'*xlonN;
        xNN = xNN + length(xlatN);
        latBC(i) = latBC(i) + sum(xlatB);
        lonBC(i) = lonBC(i) + sum(xlonB);
        latBCsq(i) = latBCsq(i) + xlatB'*xlatB;
        lonBCsq(i) = lonBCsq(i) + xlonB'*xlonB;
        xNB = xNB + length(xlatB);
    end
    latNobel(i) = latNobel(i)/xNN;
    lonNobel(i) = lonNobel(i)/xNN;
    latNobelsq(i) = latNobelsq(i)/xNN;
    lonNobelsq(i) = lonNobelsq(i)/xNN;
    latNobelse(i) = sqrt(latNobelsq(i) - latNobel(i)*latNobel(i))/sqrt(xNN);
    lonNobelse(i) = sqrt(lonNobelsq(i) - lonNobel(i)*lonNobel(i))/sqrt(xNN);
    latBC(i) = latBC(i)/xNB;
    lonBC(i) = lonBC(i)/xNB;
    latBCsq(i) = latBCsq(i)/xNB;
    lonBCsq(i) = lonBCsq(i)/xNB;
    latBCse(i) = sqrt(latBCsq(i) - latBC(i)*latBC(i))/sqrt(xNB);
    lonBCse(i) = sqrt(lonBCsq(i) - lonBC(i)*lonBC(i))/sqrt(xNB);
end        

difflat = latNobel - latBC;
difflatse = (latNobelse.*latNobelse + latBCse.*latBCse).^0.5;

difflon = lonNobel - lonBC;
difflonse = (lonNobelse.*lonNobelse + lonBCse.*lonBCse).^0.5;

clear x*

figure
plot(year,difflat,'-+b',year,difflat+2*difflatse,'--b',year,difflat-2*difflatse,'--b',year,zeros(length(year),1),'k')
title('Bates Clark, Nobel vs not')
ylabel('difference in latitude')

figure
plot(year,difflon,'-+b',year,difflon+2*difflonse,'--b',year,difflon-2*difflonse,'--b',year,zeros(length(year),1),'k')
title('Bates Clark, Nobel vs not')
ylabel('difference in longitude')

%% 
StartYear = min(data.From);
load coastlines
for i=1:2024-StartYear;
    year(i)=StartYear+i-1;
    scale(i)= 0.5 + i/202;
end

year0 = year;
year0(mod(year/10,1)~=0) = NaN;

latlim = [min([min(latNobel) min(latBC)])-1 max([max(latNobel) max(latBC)])+1];
lonlim = [min([min(lonNobel) min(lonBC)])-1 max([max(lonNobel) max(lonBC)])+1];

latlim = [min(latNobel)-1 max(latNobel)+1];
lonlim = [min(lonNobel)-1 max(lonNobel)+1];

worldmap(latlim,lonlim)
set(gcf,'units','points','position',[0,0,960,720])
plotm(coastlat,coastlon)
scattertextm(latNobel,lonNobel,year0,'colormap',summer)
%scattertextm(latBC,lonBC,year0,'colormap',autumn)
%scatterm(latNobel,lonNobel,'MarkerEdgeColor',[1 0 0])
%scatterm(latBC,lonBC,'MarkerEdgeColor',[0 0 1])

%for i=1:2024-StartYear
%    scatterm(latNobel(i),lonNobel(i),'MarkerEdgeColor',[scale(i) 1-scale(i) 0])
%    scatterm(latBC(i),lonBC(i),'MarkerEdgeColor',[1-scale(i) scale(i) 0])
%end


%%
for i=1:NY
    distnobel(i) = distance(latNobel(i), lonNobel(i),42.373611, -71.110556);
    distbc(i) = distance(latBC(i), lonBC(i), 42.373611, -71.110556);
    distdiff(i) = distance(difflat(i), difflon(i), 42.373611, -71.110556);
    distse(i) = distance(difflatse(i), difflonse(i), 42.373611, -71.110556);
end
figure
plot(year,distnobel)
hold on
plot(year,distbc)
hold off

figure
plot(year,distdiff,'-b',year,distdiff+2*distse,'--b',year,distdiff-2*distse,'--b')

%% this is unreadable
for i=1:NY
    yrstr(i,:) = num2str(year(i));
end

plot(lonNobel,latNobel,'+')
text(lonNobel,latNobel,yrstr)
hold on
plot(lonBC,latBC,'x')
text(lonBC,latBC,yrstr)