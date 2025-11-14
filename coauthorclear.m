demo.CoAuthDegree = coadg(:,end-NYear+1:end);
demo.CoAuthCentr = coanw(:,end-NYear+1:end);
demo.CoAuthCentr = demo.CoAuthCentr./max(demo.CoAuthCentr);
demo.CoAuthNobel = coann(:,end-NYear+1:end);
demo.CoAuthNobel = demo.CoAuthNobel./max(demo.CoAuthNobel);
demo.CoAuthNobel(isnan(demo.CoAuthNobel)) = 0;

clear auth* aux centr Coauthors co* cs data deg ds GID i j MS N NP NY StartYear urlname ncs nobal
