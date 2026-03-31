dist = distances(Editors);
pos = find(strcmp('Esther Duflo',Editors.Nodes{:,1}));
idx = isfinite(dist(pos,:));
S1 = subgraph(Editors,idx);
%%
for i=1:length(S1.Nodes.Name)
    aux=data.Nobel(strcmp(S1.Nodes.Name{i},data.Name));
    nobed(i)=aux(1);
end
label = S1.Nodes.Name;
label(nobed==2100)={''};
%%
layout = 'force';
hfig = figure;
p = plot(S1,'Layout',layout,'NodeLabel',label,'EdgeColor','g');
highlight(p,'Edges',S1.Edges.Weight == 1,'EdgeColor','r')
highlight(p,'Edges',S1.Edges.Weight == 3,'EdgeColor','b')
highlight(p,'Edges',S1.Edges.Weight == 4,'EdgeColor','c')
highlight(p,'Edges',S1.Edges.Weight == 5,'EdgeColor','m')
title('JPE = blue, Ectra = green, AER = red, REStud = cyan, QJE = magenta');
set(gcf,'units','points','position',[0,0,1152,864])
xticklabels({}); yticklabels({});xticks([]);yticks([]);

%%        
f = 0;
for i=1:NYear,
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
    central = centrality(Editors,'closeness');
    naux = size(Editors.Nodes,1);
    for j=1:naux
        baux = strcmp(Editors.Nodes.Name{j},people);
        edcentral(:,i) = edcentral(:,i) + central(j)*baux;
    end

    if size(Editors.Nodes,1)>0
        f = f + 1;
        hfig = figure;
        p = plot(Editors,'Layout',layout,'NodeLabel',Editors.Nodes.Name,'EdgeColor','g');
        highlight(p,'Edges',Editors.Edges.Weight == 1,'EdgeColor','r')
        highlight(p,'Edges',Editors.Edges.Weight == 3,'EdgeColor','b')
        highlight(p,'Edges',Editors.Edges.Weight == 4,'EdgeColor','c')
        highlight(p,'Edges',Editors.Edges.Weight == 5,'EdgeColor','m')
        title(strcat('Editor network',{' '},int2str(StartYear+i-1),' JPE = blue, Ectra = green, AER = red, REStud = cyan, QJE = magenta'));
        set(gcf,'units','points','position',[0,0,960,720])
        xticklabels({}); yticklabels({});xticks([]);yticks([]);
        E(f) = getframe(hfig);
    end
end

%%
close all

nframes = size(E,2);

%v = VideoWriter('C:\Users\Richard\Google Drive\Papers\Nobel\nobel.mp4','MPEG-4')
v = VideoWriter('C:\Users\rtol\OneDrive\Matlab\Nobel\Editors','Uncompressed AVI');
v.FrameRate = 1;
%v.CompressionRatio = 1;
open(v);
for i = 1:nframes, 
   writeVideo(v,E(i));
end
close(v)
