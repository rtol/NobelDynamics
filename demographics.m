disp('read demographics')
GID = '1pIC_vGxU2IFIdOZrB6bl7ovQPSHh7QZENG4fhJvMFEc';
urlname = sprintf('https://docs.google.com/spreadsheets/d/%s/gviz/tq?tqx=out:csv&sheet=%s',GID,'demographics');
data = webread(urlname);
%%
demo.PID = data.PID(1:end-3);
demo.Name = data.Name(1:end-3);
demo.Gender = data.gender(1:end-3);
demo.Born = data.Born(1:end-3);
demo.Died = data.Died(1:end-3);
demo.Nobel = data.Nobel(1:end-3);
demo.Walker = data.Walker(1:end-3);
demo.Clarivate = data.Clarivate(1:end-3);
demo.BBVA = data.BBVA(1:end-3);
demo.Soderstrom = data.Soderstrom(1:end-3);
demo.Yrjo = data.YrjoJahnssonLecture(1:end-3);
demo.Nobel(isnan(demo.Nobel))=2100;
demo.Country = data.Country(1:end-3);
demo.Religion = data.Religion(1:end-3);
demo.Ethnicity = data.Ethnicity(1:end-3);
demo.Attractiveness = data.Attractiveness(1:end-3);
demo.FES = data.FES(1:end-3);

NScholar = length(demo.PID);
NYear = FinalYear-FirstYear+1;

clear data;