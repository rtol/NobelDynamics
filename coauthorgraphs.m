close all

nframes = size(E,2);

%v = VideoWriter('C:\Users\Richard\Google Drive\Papers\Nobel\nobel.mp4','MPEG-4')
v = VideoWriter('C:\Users\rtol\OneDrive\Matlab\Nobel\Coauthors','Uncompressed AVI');
v.FrameRate = 1;
%v.CompressionRatio = 1;
open(v);
for i = 1:nframes, 
   writeVideo(v,E(i));
end
close(v)
%%
layout = 'layered';
hfig = figure;
labels = Coauthors.Nodes.Name;
labels(deg<5)={''};
p = plot(Coauthors,'Layout','force','NodeLabel',labels);
%title(strcat('Coauthor network',{' '},int2str(StartYear+i-1),'. Node size is proportional to degree.'));
p.MarkerSize = deg;
set(gcf,'units','points','position',[0,0,960,720])
xticklabels({}); yticklabels({});xticks([]);yticks([]);
%%
dist = distances(Coauthors);

pos = find(strcmp('Ernst Fehr',Coauthors.Nodes{:,1}));
idx = isfinite(dist(pos,:));
S1 = subgraph(Coauthors,idx);
deg = degree(S1);
MS = 2+8*(deg-min(deg))/(max(deg)-min(deg));
p = plot(S1,'Layout','force');
p.MarkerSize = MS;
%title(strcat('Coauthor network',{' '},int2str(StartYear+i-1),'. Node size is proportional to degree.'));
set(gcf,'units','points','position',[0,0,960,720],'Color','w')
set(gca,'Color','w')
axis off
%xticklabels({}); yticklabels({});xticks([]);yticks([]);
%%
deg = degree(Coauthors);
sum(deg==1)

%%
clear dist E hfig idx labels layout nframes p pos S1 v