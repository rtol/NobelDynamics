layout = 'layered';

for i=1:NY
    hfig = figure;
    p = plot(Coauthors,'Layout',layout,'NodeLabel',Coauthors.Nodes.Name);
    title(strcat('Coauthor network',{' '},int2str(StartYear+i-1),'. Node size is proportional to degree.'));
    p.MarkerSize = MS;
    set(gcf,'units','points','position',[0,0,960,720])
    xticklabels({}); yticklabels({});xticks([]);yticks([]);
    E(i) = getframe(hfig);
end

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
