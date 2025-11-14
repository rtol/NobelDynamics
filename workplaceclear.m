demo.Work = worknw;
worknnw(isnan(worknnw))=0;
demo.NobelWork = worknnw; %[zeros(NScholar, 1), worknnw(:,1:end-1)];

%%
demo.Location = cell(NScholar,NYear);
for i=1:NScholar
    auxf = work.From(work.PID==i);
    auxt = work.To(work.PID==i);
    auxl = work.School(work.PID==i);
    auxp = work.Prom(work.PID==i);
    for t=1:NYear
        auxs= auxl(auxf<=t+1968 & auxt>=t+1968);
        if isempty(auxs)
            demo.Location{i,t} = 'Heaven';
        else
            demo.Location{i,t} = auxs{1};
        end
    end
end

%%

clear aux central* GID i ia ic index j k l NPlace AuxYear PID PIDs places plat plc plon scholars StartYear urlname work worknw WorkPlaces nobal nobaltime worknnw