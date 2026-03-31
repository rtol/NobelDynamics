GID = '1pIC_vGxU2IFIdOZrB6bl7ovQPSHh7QZENG4fhJvMFEc';
urlname = sprintf('https://docs.google.com/spreadsheets/d/%s/gviz/tq?tqx=out:csv&sheet=%s',GID,'committee');
data = webread(urlname);
%%
NMember = length(data.From(~isnan(data.From)));
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
afm = zeros(NClass,NYear);
afs = zeros(NClass,NScholar);
for t=1:NYear
    aux = MemFld(From<=t+FirstYear-1 & To>=t+FirstYear-1);
    aux2 = MemCls(From<=t+FirstYear-1 & To>=t+FirstYear-1);
    for s=1:NScholar
        aff(s,t) = sum(strcmp(aux,demo.Field{s}))/length(aux);
        afc(s,t) = sum(strcmp(aux2,demo.Class{s}))/length(aux2);
    end
    for c=1:NClass
        afm(c,t) = sum(strcmp(aux2,Class{c}));
    end
end
for c=1:NClass
    for s=1:NScholar
        afs(c,s) = strcmp(demo.Class{s},Class{c});
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
            memdata.incomm(m,y) = memdata.incomm(m,y) + (faux(t) <= y+FirstYear-1 & taux(t) >= y+FirstYear-1);
        end
    end
end

%%
GID = '1pIC_vGxU2IFIdOZrB6bl7ovQPSHh7QZENG4fhJvMFEc';
urlname = sprintf('https://docs.google.com/spreadsheets/d/%s/gviz/tq?tqx=out:csv&sheet=%s',GID,'classcov');
classcov = webread(urlname);
%%
classvar = table2array(classcov);
for i=1:NClass-1
    for j=i+1:NClass
        classvar(j,i) = classvar(i,j);
    end
end
aux = diag(classvar).^0.5;
classcorr=classvar./aux./aux';

%%
afc2 = afs'*afm;
afc2 = afc2./sum(afm);

%%
afc3 = zeros(NScholar,NYear);
for t=1:NYear
    aux = afm(:,t)'*classcorr;
    afc3(:,t) = aux*afs/sum(aux);
end

%%
clear aux faux taux y t m