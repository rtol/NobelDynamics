disp('read personal relationships')
GID = '1pIC_vGxU2IFIdOZrB6bl7ovQPSHh7QZENG4fhJvMFEc';
urlname = sprintf('https://docs.google.com/spreadsheets/d/%s/gviz/tq?tqx=out:csv&sheet=%s',GID,'family');
data = webread(urlname);

%%
dist = zeros(NScholar,NScholar,NYear);
nist = zeros(NScholar,NScholar,NYear);

Family = graph;
StartYear = min(data.Year);
%%
for t=1:2025-StartYear
    fam = data.Name(data.Year==StartYear+t-1);
    fam1 = data.Name_1(data.Year==StartYear+t-1);
    if size(fam)>0
        for i=1:size(fam,1)
            Family = addedge(Family,fam{i},fam1{i});
        end
    end
    for i=1:NScholar-1
        aux = find(strcmp(demo.Name{i},Family.Nodes{:,1}));
        if ~isempty(aux)
            %disp(demo.Name{i})
            for j=i:NScholar
                aux2 = find(strcmp(demo.Name{j},Family.Nodes{:,1}));
                if ~isempty(aux2)
                    dist(i,j,t)=length(shortestpath(Family,demo.Name{i},demo.Name{j}));
                    dist(j,i,t)=dist(i,j,t);
 %                   if demo.Nobel(i)+94<t+1969 & demo.Nobel(j)+94>=t+1969
 %                       nist(i,j,t)=dist(i,j,t-94);
 %                   elseif demo.Nobel(j)+94<t+1969 & demo.Nobel(i)+94>=t+1969
 %                       nist(j,i,t)=dist(j,i,t-94);
 %                   end
                end
            end
        end
    end
end

%%
nist = zeros(NScholar,NScholar,NYear);
for t=1:NYear
    aux1 = demo.Nobel<t+1969-1;
    aux2 = demo.Nobel>=t+1969-1;
    aux3 = aux1*aux2';
    nist(:,:,t) = aux3.*dist(:,:,t+93);
end