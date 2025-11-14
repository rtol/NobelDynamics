GID = '1pIC_vGxU2IFIdOZrB6bl7ovQPSHh7QZENG4fhJvMFEc';
urlname = sprintf('https://docs.google.com/spreadsheets/d/%s/gviz/tq?tqx=out:csv&sheet=%s',GID,'family');
data = webread(urlname);

%%
Family = digraph;
layout = 'layered';
StartYear = min(data.Year);

f = 0;
for t=1:2024-StartYear,
    fam = data.Name(data.Year==StartYear+t-1);
    fam1 = data.Name_1(data.Year==StartYear+t-1);
    rel = data.Relationship(data.Year==StartYear+t-1);
    if size(fam)>0
        for i=1:size(fam,1)
            if strcmp(rel{i},'spouse')
                weight = 1;
                Family = addedge(Family,fam1{i},fam{i},weight);
                Family = addedge(Family,fam{i},fam1{i},weight);
            elseif strcmp(rel{i},'child')
                weight = 2;
                Family = addedge(Family,fam1{i},fam{i},weight);
            else
                weight = 3;
                Family = addedge(Family,fam1{i},fam{i},weight);
                Family = addedge(Family,fam{i},fam1{i},weight);
            end
        end
        f=f+1;
        hfig = figure;
        p = plot(Family,'Layout',layout,'NodeLabel',Family.Nodes.Name,'EdgeColor','g');
        highlight(p,'Edges',Family.Edges.Weight == 1,'EdgeColor','r')
        highlight(p,'Edges',Family.Edges.Weight == 2,'EdgeColor','b')
        title(strcat('Family network,',{' '},int2str(StartYear+t-1),', friend=green, spouse=red, child=blue'));
        set(gcf,'units','points','position',[0,0,960,720])
        xticklabels({}); yticklabels({});xticks([]);yticks([]);
        E(f) = getframe(hfig);
    end
end

%%
close all

nframes = size(E,2);

%v = VideoWriter('C:\Users\Richard\Google Drive\Papers\Nobel\nobel.mp4','MPEG-4')
v = VideoWriter('C:\Users\rtol\OneDrive\Matlab\Nobel\Family','Uncompressed AVI');
v.FrameRate = 1;
%v.CompressionRatio = 1;
open(v);
for i = 1:nframes, 
   writeVideo(v,E(i));
end
close(v)