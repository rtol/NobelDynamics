clear all
cd 'C:\Users\rtol\OneDrive\MATLAB\Nobel\Cites'
listing = struct2cell(dir);
NScholar = size(listing,2)-2;

year = 1900;
for i=1901:2024
    year(i-1899) = i;
end
NYear = length(year);

%%
maxcite = zeros(NScholar,NYear);
sumcite = maxcite;
i1000 = maxcite;
i100 = maxcite;
h = maxcite;

for i=1:989
    index(i) = i;
end
index = index';

%%
for s=1:NScholar,
    aux = readtable(listing{1,s+2},Range="V12:EP1000");
    aux = table2array(aux);
    aux(isnan(aux)) = 0;

    caux = aux(:,1);
    for i=2:NYear;
        caux(:,i) = caux(:,i-1)+aux(:,i);
    end

    maxcite(s,:) = max(caux);
    sumcite(s,:) = sum(caux);
    i1000(s,:) = sum(caux>=1000);
    i100(s,:) = sum(caux>=100);
    saux = sort(caux,'descend');
    for t=1:NYear
        haux = saux(:,t);
        haux = haux(haux>index);
        h(s,t) = length(haux);
    end
end

%% get person ID
cd 'C:\Users\rtol\OneDrive\MATLAB\Nobel'
ID = readtable("ID.xlsx");
PID = ID.PID;

%sort citation stats
[PIDs PIDi] = sort(PID); 
maxcite = maxcite(PIDi,:);
sumcite = sumcite(PIDi,:);
h = h(PIDi,:);
i1000 = i1000(PIDi,:);
i100 = i100(PIDi,:);
%%
GID = '1pIC_vGxU2IFIdOZrB6bl7ovQPSHh7QZENG4fhJvMFEc';
urlname = sprintf('https://docs.google.com/spreadsheets/d/%s/gviz/tq?tqx=out:csv&sheet=%s',GID,'demographics');
data = webread(urlname);
data = data(1:NScholar,:);

%%
select = data.PID(data.Born<1969-40 & data.Died>1969);
ns = length(select);
when = 1969*ones(ns,1);
won = zeros(ns,1);
aux = data.Nobel(select);
won(aux==1969) = 1;
gender = data.gender(select);
religion = data.Religion(select);
country = data.Country(select);
ethnicity = data.Ethnicity(select);
name = data.Name(select);

mc = maxcite(select,70);
sc = sumcite(select,70);
hc = h(select,70);
i000 = i1000(select,70);
i00 = i100(select,70);

%%
for t=2:54
    select = data.PID(data.Born<1968+t-40 & data.Died>1968+t & ~(data.Nobel<1968+t));
    ns = length(select);
    when = [when; (t+1968)*ones(ns,1)];
    aux1 = zeros(ns,1);
    aux = data.Nobel(select);
    aux1(aux==t+1968) = 1;
    won = [won; aux1];
    gender = [gender; data.gender(select)];
    religion = [religion; data.Religion(select)];
    country = [country; data.Country(select)];
    ethnicity = [ethnicity; data.Ethnicity(select)];
    name = [name; data.Name(select)];
    
    mc = [mc; maxcite(select,69+t)];
    sc = [sc; sumcite(select,69+t)];
    hc = [hc; h(select,69+t)];
    i000 = [i000; i1000(select,69+t)];
    i00 = [i00; i100(select,69+t)];
end

%%
load editors.mat
edcentral = zeros(NScholar,NYear);
edyear = zeros(NScholar,NYear);
nedcentral = nedcentral(:,end-NYear+1:end);
dur = dur(:,end-NYear+1:end);

%%
load workplace.mat
%workcentral = zeros(NScholar,NYear);
%worknw = worknw(:,end-NYear+1:end); %too many scholars, too few years

%%
load coauthors.mat

%%
for i = 1:NScholar
    select = strcmp(data.Name{i},people);
    if sum(select)>0
        edcentral(i,:) = nedcentral(select,:);
        edyear(i,:) = dur(select,:);
    end
end

%%
select = data.PID(data.Born<1969-40 & data.Died>1969);
edc = edcentral(select,69);
edyr = edyear(select,69);
workc = worknw(select,1);
coac = coanw(select,1);
coad = coadg(select,1);
for t=2:54
    select = data.PID(data.Born<1968+t-40 & data.Died>1968+t & ~(data.Nobel<1968+t));
    edc = [edc; edcentral(select,69+t)];
    edyr = [edyr; edyear(select,69+t)];
    workc = [workc; worknw(select,t)];
    coac = [coac; coanw(select,t)];
    coad = [coad; coadg(select,t)];
end

%%
GID = '1pIC_vGxU2IFIdOZrB6bl7ovQPSHh7QZENG4fhJvMFEc';
urlname = sprintf('https://docs.google.com/spreadsheets/d/%s/gviz/tq?tqx=out:csv&sheet=%s',GID,'study');
study = webread(urlname);
%%
for i=1:NScholar
    aux = study.School(study.Degree == "PhD" & study.PID == i);
    alma{i} = unique(aux);
    aux = study.Subject(study.PID == i);
    if size(aux)>0
        fd{i} = aux{1};
    end
end
%%
alma = alma';
fd = fd';
select = data.PID(data.Born<1969-40 & data.Died>1969);
almamater = alma(select);
firstdegree = fd(select);
for t=2:54
    select = data.PID(data.Born<1968+t-40 & data.Died>1968+t & ~(data.Nobel<1968+t));
    almamater = [almamater; alma(select)];
    firstdegree = [firstdegree; fd(select)];
end

%%
toStata = table(when,name,gender,country,ethnicity,religion,won,mc,sc,hc,i000,i00,edc,edyr,almamater,firstdegree,workc,coac,coad);
writetable(toStata,'nobel.csv')