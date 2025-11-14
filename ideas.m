JEL = {'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'O' 'P' 'Q' 'R' 'Y' 'Z'};
size = zeros(200,101);
for i=1:20
    for j=1:10
        aux = strcat('https://ideas.repec.org/j/',JEL{i},num2str(j-1),'.html');
        try
            site = webread(aux);
            for t=1:101
                size((i-1)*10+j,t) = length(strfind(site,strcat(num2str(t+1924),'.')));
            end
        catch
            disp('nope')
        end
    end
end
%%
GID = '1pIC_vGxU2IFIdOZrB6bl7ovQPSHh7QZENG4fhJvMFEc';
urlname = sprintf('https://docs.google.com/spreadsheets/d/%s/gviz/tq?tqx=out:csv&sheet=%s',GID,'JEL2Class');
data = webread(urlname);
data(:,{'Var1'})=[];
conc = table2array(data);
%%
sizc = conc'*size;
sizcc = sizc;
year = 1925;
for t=2:101
    year(t)=year(t-1)+1;
    sizcc(:,t)=sizcc(:,t-1)+sizc(:,t);
end
%%
clear a* data GID i j JEL site t urlname
save ideas