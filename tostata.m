%%
Year = 1969;
for t=2:NYear
    Year(t)=1+Year(t-1);
end
%%
demo.Award = zeros(NScholar,NYear);
for t=1:NYear
    demo.Award(:,t)=demo.Nobel==Year(t);
end

demo.Died(isnan(demo.Died))=2100;
demo.Nobel(isnan(demo.Nobel))=2100;

%%
group.ClassAward = zeros(NClass,NYear);
for t=1:NYear
    aux = demo.Class(demo.Award(:,t)==1);
    if length(aux) == 1
        for c=1:NClass
            group.ClassAward(c,t) = strcmp(Class{c},aux{1});
        end
    elseif length(aux) == 2
        for c=1:NClass
            group.ClassAward(c,t) = strcmp(Class{c},aux{1}) | strcmp(Class{c},aux{2});
        end
    else
        for c=1:NClass
            group.ClassAward(c,t) = strcmp(Class{c},aux{1}) | strcmp(Class{c},aux{2})  | strcmp(Class{c},aux{3});
        end
    end
end
group.Prox2Comm = comm.Comp;
%%
group.CumAward = zeros(NClass,NYear);
group.WonLastYear = zeros(NClass,NYear);
group.YearsSinceWin = zeros(NClass,NYear);
for t=2:NYear
    group.CumAward(:,t) = group.CumAward(:,t-1) + group.ClassAward(:,t-1);
    group.YearsSinceWin(:,t) = group.YearsSinceWin(:,t-1).*(group.CumAward(:,t)==group.CumAward(:,t-1)) + (group.CumAward(:,t)==group.CumAward(:,t-1));
    group.WonLastYear(:,t) = group.ClassAward(:,t-1);
end
group.NeverWon = group.CumAward==0;
%%
group.NClass = zeros(NClass,NYear);
group.MaxCite = zeros(NClass,NYear);
group.TotCite = zeros(NClass,NYear);
eligible = demo.Born+40<Year & demo.Died>=Year & demo.Nobel>=Year;
for t=1:NYear
    aux = demo.Class(eligible(:,t));
    aux2 = demo.TotCite(eligible(:,t),t);
    aux3 = demo.MaxCite(eligible(:,t),t);
    for i=1:length(aux)
        for c=1:NClass
            if strcmp(aux{i},Class{c})
                group.NClass(c,t) = group.NClass(c,t) + 1;
                group.TotCite(c,t) = group.TotCite(c,t) + aux2(i);
                group.MaxCite(c,t) = max(group.MaxCite(c,t),aux3(i));
            end
        end
    end
end
group.TotCite = group.TotCite./sum(group.NClass);
group.NClass = group.NClass./sum(group.NClass);
%%
memdata.FieldCode = zeros(NMember,1);
for i=1:NClass
    memdata.FieldCode = memdata.FieldCode + i*strcmp(memdata.field,Class{i});
end

Frust = zeros(NMember,NYear);
for t=2:NYear
    for m=1:NMember
        if group.ClassAward(memdata.FieldCode(m),t)==0
            Frust(m,t) = Frust(m,t-1) + 1;
        end    
        Frust(m,t) = memdata.incomm(m,t)*Frust(m,t);
    end
end

%%
AvgFrust = zeros(NClass,NYear);
for i=1:NClass
    aux = memdata.FieldCode==i;
    AvgFrust(i,:) = sum(Frust(aux,:),1);
end
AvgFrust = AvgFrust./sum(memdata.incomm);
%%
stata = struct;
stata.PID = repmat(demo.PID,NYear,1);
%%
stata.Name = repmat(demo.Name,NYear,1);
stata.Gender = repmat(demo.Gender,NYear,1);
stata.Born = repmat(demo.Born,NYear,1);
stata.Died = repmat(demo.Died,NYear,1);
stata.Nobel = repmat(demo.Nobel,NYear,1);
stata.Country = repmat(demo.Country,NYear,1);
stata.Religion = repmat(demo.Religion,NYear,1);
stata.Ethnicity = repmat(demo.Ethnicity,NYear,1);
stata.Attractiveness = repmat(demo.Attractiveness,NYear,1);
stata.Field = repmat(demo.Field,NYear,1);
stata.Degree = repmat(demo.Degree,NYear,1);
stata.School = repmat(demo.School,NYear,1);
stata.Class = repmat(demo.Class,NYear,1);
stata.Year = reshape(repmat(Year,NScholar,1),NScholar*NYear,1);

%%
stata.Family = reshape(demo.Family,NScholar*NYear,1);
stata.NobelFam = reshape(demo.NobelFam,NScholar*NYear,1);
stata.Work = reshape(demo.Work,NScholar*NYear,1);
stata.NobelWork = reshape(demo.NobelWork,NScholar*NYear,1);
stata.Study = reshape(demo.Study,NScholar*NYear,1);
stata.NobelStudy = reshape(demo.NobelStudy,NScholar*NYear,1);
stata.CoAuthDegree = reshape(demo.CoAuthDegree,NScholar*NYear,1);
stata.CoAuthCentr = reshape(demo.CoAuthCentr,NScholar*NYear,1);
stata.CoAuthNobel = reshape(demo.CoAuthNobel,NScholar*NYear,1);
stata.Editor = reshape(demo.Editor,NScholar*NYear,1);
stata.EdNobel = reshape(demo.EdNobel,NScholar*NYear,1);
stata.Affinity = reshape(demo.Affinity,NScholar*NYear,1);
stata.AffClass = reshape(demo.AffClass,NScholar*NYear,1);
stata.MaxCite = reshape(demo.MaxCite,NScholar*NYear,1);
stata.TotCite = reshape(demo.TotCite,NScholar*NYear,1);
stata.H = reshape(demo.H,NScholar*NYear,1);
stata.I1000 = reshape(demo.I1000,NScholar*NYear,1);
stata.I100 = reshape(demo.I100,NScholar*NYear,1);
stata.Siblings = reshape(demo.Siblings,NScholar*NYear,1);
stata.AncA = reshape(demo.AncA,NScholar*NYear,1);
stata.AncH = reshape(demo.AncH,NScholar*NYear,1);
stata.DescA = reshape(demo.DescA,NScholar*NYear,1);
stata.DescH = reshape(demo.DescH,NScholar*NYear,1);
stata.Award = reshape(demo.Award,NScholar*NYear,1);
stata.Thwarted = reshape(demo.Thwarted,NScholar*NYear,1);
stata.Location = reshape(demo.Location,NScholar*NYear,1);

%%
stata.InField = zeros(NScholar*NYear,1);
for t=1969:2025
    aux = stata.Class(stata.Year==t & stata.Award == 1);
    nw = length(aux);
    for i=1:NScholar
        test = false;
        for j=1:nw
            test = test | strcmp(demo.Class{i},aux{j});
        end
        stata.InField(i+NScholar*(t-1969)) = test;
    end
end

%%
time=struct;
time.Year = Year;
for t=1:NYear
    time.NNobel(t) = sum(demo.Nobel==Year(t));
    time.CoAuthNobel(t) = sum(demo.CoAuthNobel(demo.Nobel==Year(t),t));
end

time.CoAuthNobel(isnan(time.CoAuthNobel)) = 0;
stats=struct;
stats.CoAuthNobel = zeros(1,4);
stats.CoAuthNobelSD = zeros(1,4);
for i=1:3
    stats.NNobel(i+1) = sum(time.NNobel==i);
    stats.CoAuthNobel(i+1) = sum(time.CoAuthNobel(time.NNobel==i));
    stats.CoAuthNobel(1) = stats.CoAuthNobel(1)+stats.CoAuthNobel(i+1);
    stats.CoAuthNobel(i+1) = stats.CoAuthNobel(i+1)/stats.NNobel(i+1);
    stats.CoAuthNobelSD(i+1) = sum(time.CoAuthNobel(time.NNobel==i).*time.CoAuthNobel(time.NNobel==i));
    stats.CoAuthNobelSD(1) = stats.CoAuthNobelSD(1)+stats.CoAuthNobelSD(i+1);
    stats.CoAuthNobelSD(i+1) = stats.CoAuthNobelSD(i+1)/stats.NNobel(i+1);
    stats.CoAuthNobelSD(i+1) = sqrt(stats.CoAuthNobelSD(i+1)-stats.CoAuthNobel(i+1)^2);
end
stats.CoAuthNobel(1) = stats.CoAuthNobel(1)/sum(time.NNobel);
stats.CoAuthNobelSD(1) = stats.CoAuthNobelSD(1)/sum(time.NNobel);
stats.CoAuthNobelSD(1) = sqrt(stats.CoAuthNobelSD(1)-stats.CoAuthNobel(1)^2);

time.CoAuthNobel = time.CoAuthNobel./time.NNobel;

%%
group.transition = zeros(NClass,NClass);
for t=2:NYear
    group.transition(group.ClassAward(:,t-1)==1,group.ClassAward(:,t)==1) = group.transition(group.ClassAward(:,t-1)==1,group.ClassAward(:,t)==1) + 1;
end
group.transition = group.transition/sum(sum(group.transition));

%%
writetable(struct2table(stata),'dynnobel.csv')

%%
NPeriod = NYear;
buggins = zeros(NPeriod*NClass,1);
for t=2:NPeriod
    for c=1:NClass
        buggins((t-1)*NClass+1:t*NClass)=buggins((t-1)*NClass+1:t*NClass) + group.transition(c,:)'*group.ClassAward(c,t-1);
    end
end

%%
if full
    ideas
else
    load ideas.mat
end

%%
statac = struct;
statac.Award = reshape(group.ClassAward,NClass*NYear,1);
statac.CumAward = reshape(group.CumAward,NClass*NYear,1);
statac.Number = reshape(group.NClass,NClass*NYear,1);
statac.MaxCite = reshape(group.MaxCite,NClass*NYear,1);
statac.TotCite = reshape(group.TotCite,NClass*NYear,1);
statac.Proximity = reshape(group.Prox2Comm,NClass*NYear,1);
statac.NeverWon = reshape(group.NeverWon,NClass*NYear,1);
statac.YearsSinceWin = reshape(group.YearsSinceWin,NClass*NYear,1);
statac.WonLastYear = reshape(group.WonLastYear,NClass*NYear,1);
statac.Year = reshape(repmat(Year,NClass,1),NClass*NYear,1);
statac.Frustration = reshape(AvgFrust,NClass*NYear,1);
statac.Buggins = buggins;
statac.Class = repmat(Class,NYear,1);

clear buggins

%%
statac.Size1 = reshape(sizc(1:NClass,end-NYear+1:end),NClass*NYear,1);
statac.Size = reshape(sizcc(1:NClass,end-NYear+1:end),NClass*NYear,1);

Size5 = zeros(NClass,NYear);
Size10 = zeros(NClass,NYear);

for t=1:NYear
    Size5(:,t)=sum(sizc(1:NClass,t+40:t+44),2);
    Size10(:,t)=sum(sizc(1:NClass,t+35:t+44),2);
end

statac.Size5 = reshape(Size5(1:NClass,end-NYear+1:end),NClass*NYear,1);
statac.Size10 = reshape(Size10(1:NClass,end-NYear+1:end),NClass*NYear,1);

%%
writetable(struct2table(statac),'dynclass.csv')

