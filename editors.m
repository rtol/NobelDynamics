disp('read co-editors')

GID = '1pIC_vGxU2IFIdOZrB6bl7ovQPSHh7QZENG4fhJvMFEc';
urlname = sprintf('https://docs.google.com/spreadsheets/d/%s/gviz/tq?tqx=out:csv&sheet=%s',GID,'editor');
data = webread(urlname);

data.JournalCode(strcmp(data.Journal,'AER')) = 1;
data.JournalCode(strcmp(data.Journal,'Ectra')) = 2;
data.JournalCode(strcmp(data.Journal,'JPE')) = 3;
data.JournalCode(strcmp(data.Journal,'REStud')) = 4;
data.JournalCode(strcmp(data.Journal,'QJE')) = 5;
NJ = 5;
%%
duration = data.To-data.From+1;
people = unique(data.Name);
NPeople = size(people,1);
StartYear = min(data.From);
EndYear = 2024;
NY = EndYear-StartYear+1;
edcentral = zeros(NPeople,NY);
ednobal = zeros(NPeople,NY);

data.Nobel = zeros(length(data.PID),1);
for i=1:length(data.PID)
    if ~isnan(data.PID(i))
        data.Nobel(i) = demo.Nobel(data.PID(i));
    end
end
data.Nobel(isnan(data.Nobel)|data.Nobel==0) = 2100;

%%
dur = zeros(NPeople,NY);
for i=1:NPeople
    for j=1:size(data,1)
        if strcmp(people{i},data.Name{j})
           for t=1:NY
               dur(i,t) = dur(i,t) + 1 + min(data.To(j), t-1 + StartYear) - data.From(j);
            end
        end
    end
end
dur = max(0,dur);
%%
Editors = graph;

for i=1:NY
    for l=1:NJ
        eds = data.Name(data.From <= StartYear+i-1 & data.To >= StartYear+i-1 & data.JournalCode == l);
        if size(eds,1)>1
            %disp(size(eds,1))
            for j=1:size(eds,1)-1
                for k=j+1:size(eds,1)
                    Editors = addedge(Editors,eds{j},eds{k},l);
                end
            end
        end
        Editors = simplify(Editors);
    end
    if size(Editors.Nodes,1)>0
        central = centrality(Editors,'closeness');
        nobal = nobelity(Editors,data.Nobel<i+1969-77);
        naux = size(Editors.Nodes,1);
        for j=1:naux
            baux = strcmp(Editors.Nodes.Name{j},people);
            edcentral(:,i) = edcentral(:,i) + central(j)*baux;
            ednobal(:,i) = ednobal(:,i) + nobal(j)*baux;
        end
    end
end

%%
nedcentral = edcentral./max(edcentral);
nednobal = ednobal./max(ednobal);
%%
nedc=zeros(NScholar,NY);
nedn=zeros(NScholar,NY);

for i=1:NScholar
    aux = strcmp(Editors.Nodes.Name,demo.Name{i});
    if max(aux) == 1
        nedc(i,:) = nedcentral(aux,:);
        nedn(i,:) = nednobal(aux,:);
    end
end

%%

save 'editors.mat' nedcentral people dur