disp('read field of research')
GID = '1pIC_vGxU2IFIdOZrB6bl7ovQPSHh7QZENG4fhJvMFEc';
urlname = sprintf('https://docs.google.com/spreadsheets/d/%s/gviz/tq?tqx=out:csv&sheet=%s',GID,'field');
data = webread(urlname);

aux1 = data.PID(1:end);
aux2 = data.Field2D(1:end);
aux5 = data.Class(1:end);
[aux3 index] = sort(aux1);
aux4 = aux2(index);
aux6 = aux5(index);

demo.Field = aux4;
demo.Class = aux6;
clear GID urlname data aux* index