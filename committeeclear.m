demo.Affinity = aff;
demo.AffClass = afc;

Class = unique(demo.Class);
NClass = length(Class);

comm = struct;
comm.Year = Year;
comm.Field = MemFld;
comm.Class = MemCls;
comm.To = To;
comm.From = From;
comm.Member = Member;
comm.Comp = zeros(NClass,NYear);
for t=1:NYear
    for c=1:NClass
        for m=1:NMember
            comm.Comp(c,t) = comm.Comp(c,t) + (To(m)>=t+1968 & From(m)<=t+1968 & strcmp(Class{c},MemCls{m}));
        end
    end
end
comm.Comp=comm.Comp./sum(comm.Comp);

clear aff afc aux aux2 data From GID Mem* s t To urlname Year