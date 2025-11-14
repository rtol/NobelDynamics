disp('read place of study')
GID = '1pIC_vGxU2IFIdOZrB6bl7ovQPSHh7QZENG4fhJvMFEc';
urlname = sprintf('https://docs.google.com/spreadsheets/d/%s/gviz/tq?tqx=out:csv&sheet=%s',GID,'study');
data = webread(urlname);

%%
data.Nobel = zeros(length(data.PID),1);
for i=1:length(data.PID)
    data.Nobel(i) = demo.Nobel(data.PID(i));
end
data.Nobel(isnan(data.Nobel)) = 2100;

%%
N = length(data.Name);
for i=1:NScholar
    aux = data.Degree(strcmp(data.Name,demo.Name{i}));
    aux2 = data.School(strcmp(data.Name,demo.Name{i}));
    if max(strcmp(aux,'PhD'))>0
        demo.Degree{i} = 'PhD';
        pos = max(strcmp(aux,'PhD'));
        demo.School{i} = aux2{pos(1)};
    elseif max(strcmp(aux,'Master'))>0
        demo.Degree{i} = 'Master';
        pos = max(strcmp(aux,'Master'));
        demo.School{i} = aux2{pos(1)};
    elseif max(strcmp(aux,'Bachelor'))>0
        demo.Degree{i} = 'Bachelor';
        pos = max(strcmp(aux,'Bachelor'));
        demo.School{i} = aux2{pos(1)};
    else
        demo.Degree{i} = 'unknown';
        demo.School{i} = 'unknown';
    end
end
demo.Degree = demo.Degree';
demo.School = demo.School';

%%
[places,ia,ic] = unique(data.School);
StartYear = min(data.From);
AuxYear = 2025-StartYear+1;
centraltime = zeros(NScholar,AuxYear);
nobaltime = zeros(NScholar,AuxYear);
StudyPlaces = graph;
NPlace = size(places,1);

for i=1:AuxYear
    for l=1:NPlace
        plc = data.Name(data.From <= StartYear+i-1 & data.To >= StartYear+i-1 & strcmp(data.School,places{l}));
        if size(plc,1)>1
            for j=1:size(plc,1)-1
                for k=j+1:size(plc,1)
                    StudyPlaces = addedge(StudyPlaces,plc{j},plc{k});
                end
            end
        end
        StudyPlaces = simplify(StudyPlaces);
    end
    if size(StudyPlaces.Nodes,1)>0
        central = centrality(StudyPlaces,'closeness');
        nobal = nobelity(StudyPlaces,data.Nobel<i+1969-77);

        for j=1:length(central)
            aux = strcmp(StudyPlaces.Nodes.Name,data.Name{j});
            if max(aux) > 0
               centraltime(j,i) = central(aux);
               nobaltime(j,i) = nobal(aux);
            end
        end
    end
end
%%
demo.Study = centraltime(:,end-NYear+1:end)./max(centraltime(:,end-NYear+1:end));
demo.NobelStudy = nobaltime(:,end-NYear+1:end)./max(nobaltime(:,end-NYear+1:end));
demo.NobelStudy(isnan(demo.NobelStudy)) = 0;

clear aux* AuxYear central centraltime data GID i ia ic j k l N NPlace places plc pos StartYear urlname StudyPlaces nobal nobaltime