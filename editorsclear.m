demo.Editor = nedc(:,end-NYear+1:end);
demo.EdNobel = nedn(:,end-NYear+1:end);
demo.EdNobel(isnan(demo.EdNobel)) = 0;

clear aux baux central data dur duration edcentral Editors eds EndYear GID i j k l naux nedc nedcentral NJ NPeople NY people StartYear t urlname ednobal nedn* nobal