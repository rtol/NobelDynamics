disp('read citations')
cd 'C:\Users\rtol\OneDrive\MATLAB\Nobel\Cites'
listing = struct2cell(dir);
NS = size(listing,2)-2;

year = 1900;
for i=1901:2024
    year(i-1899) = i;
end
NY = length(year);

maxcite = zeros(NS,NY);
sumcite = maxcite;
i1000 = maxcite;
i100 = maxcite;
h = maxcite;

for i=1:989
    index(i) = i;
end
index = index';

%%
for s=1:NS,
    aux = readtable(listing{1,s+2},Range="V12:EP1000");
    aux = table2array(aux);
    aux(isnan(aux)) = 0;

    caux = aux(:,1);
    for i=2:NY;
        caux(:,i) = caux(:,i-1)+aux(:,i);
    end

    maxcite(s,:) = max(caux);
    sumcite(s,:) = sum(caux);
    i1000(s,:) = sum(caux>=1000);
    i100(s,:) = sum(caux>=100);
    saux = sort(caux,'descend');
    for t=1:NY
        haux = saux(:,t);
        haux = haux(haux>index);
        h(s,t) = length(haux);
    end
end

%% get person ID
%cd 'C:\Users\rtol\OneDrive\MATLAB\Nobel'
%ID = readtable("ID.xlsx");
%PID = ID.PID;

%%
GID = '1pIC_vGxU2IFIdOZrB6bl7ovQPSHh7QZENG4fhJvMFEc';
urlname = sprintf('https://docs.google.com/spreadsheets/d/%s/gviz/tq?tqx=out:csv&sheet=%s',GID,'citcon');
data = webread(urlname);
PID = data.PID;
CoNobel = data.CoNobel;

clear GID urlname data
%%
%sort citation stats
[PIDs PIDi] = sort(PID); 
maxcite = maxcite(PIDi,:);
sumcite = sumcite(PIDi,:);
h = h(PIDi,:);
i1000 = i1000(PIDi,:);
i100 = i100(PIDi,:);
CoNobel = CoNobel(PIDi);

%%
demo.MaxCite = maxcite(:,end-NYear+1:end);
demo.TotCite = sumcite(:,end-NYear+1:end);
demo.H = h(:,end-NYear+1:end);
demo.I1000 = i1000(:,end-NYear+1:end);
demo.I100 = i100(:,end-NYear+1:end);

cd 'C:\Users\rtol\OneDrive\MATLAB\Nobel'
clear aux caux h haux i* ID listing maxcite NS NY PID* s* t year

%%
year = 1969;
for i=1970:2025
    year(i-1968) = i;
end
CoNobel(CoNobel==0)=2100;
demo.Thwarted = zeros(NScholar,NYear);
for i=1:NYear
    demo.Thwarted(:,i) = CoNobel<year(i);
end

clear year CoNobel i m c
