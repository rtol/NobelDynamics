disp('read co-authors')

GID = '1pIC_vGxU2IFIdOZrB6bl7ovQPSHh7QZENG4fhJvMFEc';
urlname = sprintf('https://docs.google.com/spreadsheets/d/%s/gviz/tq?tqx=out:csv&sheet=%s',GID,'coauthor');
data = webread(urlname);
NP = size(unique([data.Name; data.Name_1]),1);
%%

data.Nobel1 = zeros(length(data.PID1),1);
data.Nobel2 = zeros(length(data.PID1),1);

for i=1:length(data.PID1)
    if ~isnan(data.PID1(i))
        data.Nobel1(i) = demo.Nobel(data.PID1(i));
    end
    if ~isnan(data.PID2(i))
        data.Nobel2(i) = demo.Nobel(data.PID2(i));
    end
end

data.Nobel1(data.Nobel1==0|isnan(data.Nobel1)) = 2100;
data.Nobel2(data.Nobel2==0|isnan(data.Nobel2)) = 2100;

%%
dage = zeros(NScholar,NYear);
for i=1:NScholar
    %auxyear = data.Year(data.PID1==demo.PID(i));
    auxage = data.Age1(data.PID1==demo.PID(i)) - data.Age2(data.PID1==demo.PID(i));
    auxnob = data.Nobel2(data.PID1==demo.PID(i));
    %auxyear = auxyear(~isnan(auxage));
    auxnob = auxnob(~isnan(auxage));
    auxage = auxage(~isnan(auxage));
    %auxyear = auxyear(auxnob<2100);
    auxage = auxage(auxnob<2100);
    auxnob = auxnob(auxnob<2100);
    for j=1:length(auxnob)
        dage(i,auxnob(j)-FirstYear+1) = auxage(j);
    end
    
    auxage = data.Age2(data.PID2==demo.PID(i)) - data.Age1(data.PID2==demo.PID(i));
    auxnob = data.Nobel1(data.PID2==demo.PID(i));
    %auxyear = auxyear(~isnan(auxage));
    auxnob = auxnob(~isnan(auxage));
    auxage = auxage(~isnan(auxage));
    %auxyear = auxyear(auxnob<2100);
    auxage = auxage(auxnob<2100);
    auxnob = auxnob(auxnob<2100);
    for j=1:length(auxnob)
        dage(i,auxnob(j)-FirstYear+1) = auxage(j);
    end
end
dage= abs(dage);
for i=2:NYear
    dage(:,i) = max(dage(:,i),dage(:,i-1));
end

%%
StartYear = min(data.Year);
NY = FinalYear-StartYear+1;
ds = zeros(NP,NY);
cs = zeros(NP,NY);
ncs = zeros(NP,NY);
Coauthors = graph;

%%

for i=1:NY
    auth = data.Name(data.Year==StartYear+i-1);
    auth1 = data.Name_1(data.Year==StartYear+i-1);
    N = size(auth,1);
    for j=1:N
        Coauthors = addedge(Coauthors,auth{j},auth1{j});
    end

    deg = degree(Coauthors);
    centr = centrality(Coauthors,'closeness');
    nobal = nobelity(Coauthors,data.Nobel1<i+FirstYear-41|data.Nobel2<i+FirstYear-41);
    ds(1:length(deg),i) = deg';
    cs(1:length(centr),i) = centr';
    ncs(1:length(centr),i) = nobal';
    %if max(deg) > min(deg)
    %   MS = 2+8*(deg-min(deg))/(max(deg)-min(deg));
    %else
    %    MS = 2*deg/min(deg);
    %end
    %hfig = figure;
    %p = plot(Coauthors,'Layout','layered','NodeLabel',Coauthors.Nodes.Name);
    %title(strcat('Coauthor network',{' '},int2str(StartYear+i-1),'. Node size is proportional to degree.'));
    %p.MarkerSize = MS;
    %set(gcf,'units','points','position',[0,0,960,720])
    %xticklabels({}); yticklabels({});xticks([]);yticks([]);
    %E(i) = getframe(hfig);
end

%%
%aux = size(Coauthors.Nodes,1);
%people = {};
%for i = 1:NScholar
%    people{i} = demo.Name{i};
%end

%%
coadg = zeros(NScholar,NY);
coanw = zeros(NScholar,NY);
coann = zeros(NScholar,NY);

for i=1:NScholar
    aux = strcmp(Coauthors.Nodes.Name,demo.Name{i});
    if max(aux) == 1
        coadg(i,:) = ds(aux,:);
        coanw(i,:) = cs(aux,:);
        coann(i,:) = ncs(aux,:);
    end
end
%%
save coauthors.mat coanw coadg