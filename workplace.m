disp('read place of work')
GID = '1pIC_vGxU2IFIdOZrB6bl7ovQPSHh7QZENG4fhJvMFEc';
urlname = sprintf('https://docs.google.com/spreadsheets/d/%s/gviz/tq?tqx=out:csv&sheet=%s',GID,'work');
data = webread(urlname);

[places,ia,ic] = unique(data.School);
plat = data.Lat(ia);
plon = data.Lon(ia);
NPlace = length(places);

StartYear = min(data.From);
AuxYear = 2025-StartYear+1;

work.PID = data.PID;
work.Name = data.Name;
work.School = data.School;
work.From = data.From;
work.To = data.To;
work.Lat = data.Lat;
work.Lon = data.Lon;
work.Prom = data.prominence;

clear ia ic data

work.Nobel = zeros(length(work.PID),1);
for i=1:length(work.PID)
    work.Nobel(i) = demo.Nobel(work.PID(i));
end
work.Nobel(isnan(work.Nobel)) = 2100;

%% network centrality
centraltime = zeros(NScholar,AuxYear);
nobaltime = zeros(NScholar,AuxYear);

WorkPlaces = graph;
%layout = 'layered';

%f = 0;
for i=1:AuxYear
    for l=1:NPlace
        plc = work.Name(work.From <= StartYear+i-1 & work.To >= StartYear+i-1 & strcmp(work.School,places{l}));
        if size(plc,1)>1
            for j=1:size(plc,1)-1
                for k=j+1:size(plc,1)
                    WorkPlaces = addedge(WorkPlaces,plc{j},plc{k},l);
                end
            end
        end
        WorkPlaces = simplify(WorkPlaces);
    end
    
    if size(WorkPlaces.Nodes,1)>0
        central = centrality(WorkPlaces,'closeness');
        nobal = nobelity(WorkPlaces,work.Nobel<i+1969-71);

        for j=1:length(central)
            aux = strcmp(WorkPlaces.Nodes.Name,work.Name{j});
            if max(aux) > 0
               centraltime(j,i) = central(aux);
               nobaltime(j,i) = nobal(aux);
            end
        end
    end
end

%%
[scholars, ia, ic] = unique(work.Name);
PID = work.PID(ia);

[PIDs, index] = sort(PID);
worknw = centraltime(index,(end-56):end); %1969-2025
worknw = worknw./max(worknw);

worknnw = nobaltime(index,(end-56):end); %1969-2025
worknnw = worknnw./max(worknnw);
