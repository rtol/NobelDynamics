dist = distances(G54);

pos = find(strcmp('Hendrik Houthakker',G54.Nodes{:,1}));
idx = isfinite(dist(pos,:));
S1 = subgraph(G54,idx);

hfig = figure;
plot(S1,'Layout',layout,'NodeLabel',S1.Nodes.Name)
set(gcf,'units','points','position',[0,0,960,720])
xticklabels({}); yticklabels({});xticks([]);yticks([]);
