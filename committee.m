GID = '1pIC_vGxU2IFIdOZrB6bl7ovQPSHh7QZENG4fhJvMFEc';
urlname = sprintf('https://docs.google.com/spreadsheets/d/%s/gviz/tq?tqx=out:csv&sheet=%s',GID,'committee');
data = webread(urlname);
%%
NMember = 71;
Member = data.Name(1:NMember);
From = data.From(1:NMember);
To = data.To(1:NMember);
MemFld = data.Field(1:NMember);
MemCls = data.Class(1:NMember);
%NYear = 56;
Year = data.Var9(1:NYear);
%%
aff = zeros(NScholar,NYear);
afc = zeros(NScholar,NYear);
for t=1:NYear
    aux = MemFld(From<=t+1968 & To>=t+1968);
    aux2 = MemCls(From<=t+1968 & To>=t+1968);
    for s=1:NScholar
        aff(s,t) = sum(strcmp(aux,demo.Field{s}))/length(aux);
        afc(s,t) = sum(strcmp(aux2,demo.Class{s}))/length(aux2);
    end
end
%%
GID = '1pIC_vGxU2IFIdOZrB6bl7ovQPSHh7QZENG4fhJvMFEc';
urlname = sprintf('https://docs.google.com/spreadsheets/d/%s/gviz/tq?tqx=out:csv&sheet=%s',GID,'members');
memdata = webread(urlname);
%%
NMember = length(memdata.member);
memdata.incomm = zeros(NMember,NYear);
for m=1:NMember
    aux = strcmp(Member,memdata.member{m});
    faux = From(aux);
    taux = To(aux);
    for t=1:length(faux)
        for y=1:NYear
            memdata.incomm(m,y) = memdata.incomm(m,y) + (faux(t) <= y+1968 & taux(t) >= y+1968);
        end
    end
end

clear aux faux taux y t m

