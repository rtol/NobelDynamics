disp('read field of research')
GID = '1pIC_vGxU2IFIdOZrB6bl7ovQPSHh7QZENG4fhJvMFEc';
urlname = sprintf('https://docs.google.com/spreadsheets/d/%s/gviz/tq?tqx=out:csv&sheet=%s',GID,'field');
data = webread(urlname);

aux1 = data.PID(1:end);
aux2 = data.Field2D(1:end);
aux5 = data.Class(1:end);
aux7 = data.Nobel(1:end);
[aux3 index] = sort(aux1);
aux4 = aux2(index);
aux6 = aux5(index);
aux8 = aux7(index);

demo.Field = aux4;
demo.Class = aux6;

%%
nlogit = 'nlogitgen type = PID(' ;
Class = unique(aux5);
NClass = length(Class);
for c=1:NClass
    aux7 = aux1(strcmp(Class{c},aux5));
    nlogit = [nlogit Class{c} ': '];
    for i=1:length(aux7);
        nlogit = [nlogit int2str(aux7(i))];
        if i<length(aux7)
            nlogit = [nlogit ' | '];
        end
    end
    if c<NClass
        nlogit = [nlogit ', '];
    end
end
nlogit = [nlogit ')'];
%%
fid = fopen('nlogit.do', 'wt');
fprintf(fid,nlogit);
fclose(fid);
%%
clear GID urlname data aux* index c i fid nlogit ans