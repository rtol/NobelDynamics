%%
Year = FirstYear;
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
demo.Walker(isnan(demo.Walker))=0;
demo.Clarivate(isnan(demo.Clarivate))=0;
demo.BBVA(isnan(demo.BBVA))=0;
demo.Soderstrom(isnan(demo.Soderstrom))=0;
demo.Yrjo(isnan(demo.Yrjo))=0;
demo.FES(isnan(demo.FES))=0;

%% this constructs the dependent variable
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
group.Prox2Corr = comm.Comc;
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
group.NCSave = sum(group.NClass);
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
stata.FES = repmat(demo.FES,NYear,1);
stata.Walker = repmat(demo.Walker,NYear,1);
stata.Clarivate = repmat(demo.Clarivate,NYear,1);
stata.BBVA = repmat(demo.BBVA,NYear,1);
stata.Soderstrom = repmat(demo.Soderstrom,NYear,1);
stata.Yrjo = repmat(demo.Yrjo,NYear,1);
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
stata.AgeDiff = reshape(demo.AgeDiff,NScholar*NYear,1);
stata.Editor = reshape(demo.Editor,NScholar*NYear,1);
stata.EdNobel = reshape(demo.EdNobel,NScholar*NYear,1);
stata.Affinity = reshape(demo.Affinity,NScholar*NYear,1);
stata.AffClass = reshape(demo.AffClass,NScholar*NYear,1);
stata.AffClCor = reshape(demo.AffClCrr,NScholar*NYear,1);
stata.MaxCite = reshape(demo.MaxCite,NScholar*NYear,1);
stata.TotCite = reshape(demo.TotCite,NScholar*NYear,1);
stata.H = reshape(demo.H,NScholar*NYear,1);
stata.I1000 = reshape(demo.I1000,NScholar*NYear,1);
stata.I100 = reshape(demo.I100,NScholar*NYear,1);
stata.Top5 = reshape(demo.Top5,NScholar*NYear,1);
stata.MaxCiteY = reshape(demo.MaxCiteY,NScholar*NYear,1);
stata.TotCiteY = reshape(demo.TotCiteY,NScholar*NYear,1);
stata.HY = reshape(demo.HY,NScholar*NYear,1);
stata.I1000Y = reshape(demo.I1000Y,NScholar*NYear,1);
stata.I100Y = reshape(demo.I100Y,NScholar*NYear,1);
stata.MaxCiteFY = reshape(demo.MaxCiteFY,NScholar*NYear,1);
stata.TotCiteFY = reshape(demo.TotCiteFY,NScholar*NYear,1);
stata.HFY = reshape(demo.HFY,NScholar*NYear,1);
stata.I1000FY = reshape(demo.I1000FY,NScholar*NYear,1);
stata.I100FY = reshape(demo.I100FY,NScholar*NYear,1);
stata.MaxCiteZ = reshape(demo.MaxCiteZ,NScholar*NYear,1);
stata.TotCiteZ = reshape(demo.TotCiteZ,NScholar*NYear,1);
stata.HZ = reshape(demo.HZ,NScholar*NYear,1);
stata.I1000Z = reshape(demo.I1000Z,NScholar*NYear,1);
stata.I100Z = reshape(demo.I100Z,NScholar*NYear,1);
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

%% empirical transition and annual Bayes
group.transition = zeros(NClass,NClass);
alpha = zeros(NClass,NClass,NYear);
beta = zeros(NClass,NClass,NYear);
group.bayestrans = zeros(NClass,NClass,NYear);
auxt = zeros(NClass,NClass,NYear);
auxm = 1/NClass/NClass;
auxv = 1/(NClass*NClass+2);
alpha(:,:,1) = (auxm*(1-auxm)/auxv-1)*auxm;
beta(:,:,1) = (auxm*(1-auxm)/auxv-1)*(1-auxm);
group.bayestrans(:,:,1) = alpha(:,:,1)./(alpha(:,:,1)+beta(:,:,1));
for t=2:NYear
    auxt(group.ClassAward(:,t-1)==1,group.ClassAward(:,t)==1,t) = 1;
    auxt(:,:,t) = auxt(:,:,t)/(sum(sum(auxt(:,:,t))));
    alpha(:,:,t) = alpha(:,:,t-1)+auxt(:,:,t);
    beta(:,:,t) = beta(:,:,t-1)+1-auxt(:,:,t);
    group.bayestrans(:,:,t) = alpha(:,:,t)./(alpha(:,:,t)+beta(:,:,t));
    group.transition(group.ClassAward(:,t-1)==1,group.ClassAward(:,t)==1) = group.transition(group.ClassAward(:,t-1)==1,group.ClassAward(:,t)==1) + 1;
end
group.transition = group.transition/sum(sum(group.transition));

%% 11 year running average
alpha = zeros(NClass,NClass,NYear);
beta = zeros(NClass,NClass,NYear);
alpha(:,:,1) = (auxm*(1-auxm)/auxv-1)*auxm;
beta(:,:,1) = (auxm*(1-auxm)/auxv-1)*(1-auxm);
group.trans11 = zeros(NClass,NClass,NYear);
auxs = zeros(NClass,NClass,NYear);
smooth = 5;

for t=smooth+2:NYear-smooth-1
    auxs(:,:,t) = sum(auxt(:,:,t-smooth:t+smooth),3);
end
for t=1:smooth+1
    auxs(:,:,t) = auxs(:,:,smooth+2);
end
for t=NYear-smooth:NYear
    auxs(:,:,t) = auxs(:,:,NYear-smooth-1);
end

for t=1:NYear
    alpha(:,:,t) = alpha(:,:,1)+auxs(:,:,t);
    beta(:,:,t) = beta(:,:,1)+2*smooth+1-auxs(:,:,t);
    group.trans11(:,:,t) = alpha(:,:,t)./(alpha(:,:,t)+beta(:,:,t));
end

%% 5 year running average
alpha = zeros(NClass,NClass,NYear);
beta = zeros(NClass,NClass,NYear);
alpha(:,:,1) = (auxm*(1-auxm)/auxv-1)*auxm;
beta(:,:,1) = (auxm*(1-auxm)/auxv-1)*(1-auxm);
group.trans5 = zeros(NClass,NClass,NYear);
auxs = zeros(NClass,NClass,NYear);
smooth = 2;

for t=smooth+2:NYear-smooth-1
    auxs(:,:,t) = sum(auxt(:,:,t-smooth:t+smooth),3);
end
for t=1:smooth+1
    auxs(:,:,t) = auxs(:,:,smooth+2);
end
for t=NYear-smooth:NYear
    auxs(:,:,t) = auxs(:,:,NYear-smooth-1);
end

for t=1:NYear
    alpha(:,:,t) = alpha(:,:,1)+auxs(:,:,t);
    beta(:,:,t) = beta(:,:,1)+2*smooth+1-auxs(:,:,t);
    group.trans5(:,:,t) = alpha(:,:,t)./(alpha(:,:,t)+beta(:,:,t));
end

%% 3 year running average
alpha = zeros(NClass,NClass,NYear);
beta = zeros(NClass,NClass,NYear);
alpha(:,:,1) = (auxm*(1-auxm)/auxv-1)*auxm;
beta(:,:,1) = (auxm*(1-auxm)/auxv-1)*(1-auxm);
group.trans3 = zeros(NClass,NClass,NYear);
auxs = zeros(NClass,NClass,NYear);
smooth = 1;

for t=smooth+2:NYear-smooth-1
    auxs(:,:,t) = sum(auxt(:,:,t-smooth:t+smooth),3);
end
for t=1:smooth+1
    auxs(:,:,t) = auxs(:,:,smooth+2);
end
for t=NYear-smooth:NYear
    auxs(:,:,t) = auxs(:,:,NYear-smooth-1);
end

for t=1:NYear
    alpha(:,:,t) = alpha(:,:,1)+auxs(:,:,t);
    beta(:,:,t) = beta(:,:,1)+2*smooth+1-auxs(:,:,t);
    group.trans3(:,:,t) = alpha(:,:,t)./(alpha(:,:,t)+beta(:,:,t));
end

%% 7 year running average
alpha = zeros(NClass,NClass,NYear);
beta = zeros(NClass,NClass,NYear);
alpha(:,:,1) = (auxm*(1-auxm)/auxv-1)*auxm;
beta(:,:,1) = (auxm*(1-auxm)/auxv-1)*(1-auxm);
group.trans7 = zeros(NClass,NClass,NYear);
auxs = zeros(NClass,NClass,NYear);
smooth = 3;

for t=smooth+2:NYear-smooth-1
    auxs(:,:,t) = sum(auxt(:,:,t-smooth:t+smooth),3);
end
for t=1:smooth+1
    auxs(:,:,t) = auxs(:,:,smooth+2);
end
for t=NYear-smooth:NYear
    auxs(:,:,t) = auxs(:,:,NYear-smooth-1);
end

for t=1:NYear
    alpha(:,:,t) = alpha(:,:,1)+auxs(:,:,t);
    beta(:,:,t) = beta(:,:,1)+2*smooth+1-auxs(:,:,t);
    group.trans7(:,:,t) = alpha(:,:,t)./(alpha(:,:,t)+beta(:,:,t));
end
%% 9 year running average
alpha = zeros(NClass,NClass,NYear);
beta = zeros(NClass,NClass,NYear);
alpha(:,:,1) = (auxm*(1-auxm)/auxv-1)*auxm;
beta(:,:,1) = (auxm*(1-auxm)/auxv-1)*(1-auxm);
group.trans9 = zeros(NClass,NClass,NYear);
auxs = zeros(NClass,NClass,NYear);
smooth = 4;

for t=smooth+2:NYear-smooth-1
    auxs(:,:,t) = sum(auxt(:,:,t-smooth:t+smooth),3);
end
for t=1:smooth+1
    auxs(:,:,t) = auxs(:,:,smooth+2);
end
for t=NYear-smooth:NYear
    auxs(:,:,t) = auxs(:,:,NYear-smooth-1);
end

for t=1:NYear
    alpha(:,:,t) = alpha(:,:,1)+auxs(:,:,t);
    beta(:,:,t) = beta(:,:,1)+2*smooth+1-auxs(:,:,t);
    group.trans9(:,:,t) = alpha(:,:,t)./(alpha(:,:,t)+beta(:,:,t));
end

%% before and after Lindbeck
alpha = zeros(NClass,NClass,NYear);
beta = zeros(NClass,NClass,NYear);
alpha(:,:,1) = (auxm*(1-auxm)/auxv-1)*auxm;
beta(:,:,1) = (auxm*(1-auxm)/auxv-1)*(1-auxm);
group.transl = zeros(NClass,NClass,NYear);
auxs = zeros(NClass,NClass,NYear);
lindberg = 25;

for t=2:lindberg
    auxs(:,:,t) = sum(auxt(:,:,1:lindberg),3);
    alpha(:,:,t) = alpha(:,:,1)+auxs(:,:,t);
    beta(:,:,t) = beta(:,:,1)+lindberg-1-auxs(:,:,t);
end
for t=lindberg+1:NYear
    auxs(:,:,t) = sum(auxt(:,:,lindberg+1:NYear),3);
    alpha(:,:,t) = alpha(:,:,1)+auxs(:,:,t);
    beta(:,:,t) = beta(:,:,1)+(NYear-lindberg)-auxs(:,:,t);
end
alpha(:,:,1) = alpha(:,:,2);
beta(:,:,1) = beta(:,:,2);

for t=1:NYear
    group.transl(:,:,t) = alpha(:,:,t)./(alpha(:,:,t)+beta(:,:,t));
end


%%
writetable(struct2table(stata),'dynnobel.csv')

%%
NPeriod = NYear;
buggins = zeros(NPeriod*NClass,1);
bugginsA = zeros(NPeriod*NClass,1);
buggins3 = zeros(NPeriod*NClass,1);
buggins5 = zeros(NPeriod*NClass,1);
buggins7 = zeros(NPeriod*NClass,1);
buggins9 = zeros(NPeriod*NClass,1);
buggins11 = zeros(NPeriod*NClass,1);
bugginsL = zeros(NPeriod*NClass,1);
bugginsF = zeros(NPeriod*NClass,1);
for t=2:NPeriod
    for c=1:NClass
        buggins((t-1)*NClass+1:t*NClass)=buggins((t-1)*NClass+1:t*NClass) + group.transition(c,:)'*group.ClassAward(c,t-1);
        bugginsA((t-1)*NClass+1:t*NClass)=bugginsA((t-1)*NClass+1:t*NClass) + group.bayestrans(c,:,t-1)'*group.ClassAward(c,t-1);
        buggins3((t-1)*NClass+1:t*NClass)=buggins3((t-1)*NClass+1:t*NClass) + group.trans3(c,:,t-1)'*group.ClassAward(c,t-1);
        buggins5((t-1)*NClass+1:t*NClass)=buggins5((t-1)*NClass+1:t*NClass) + group.trans5(c,:,t-1)'*group.ClassAward(c,t-1);
        buggins7((t-1)*NClass+1:t*NClass)=buggins7((t-1)*NClass+1:t*NClass) + group.trans7(c,:,t-1)'*group.ClassAward(c,t-1);
        buggins9((t-1)*NClass+1:t*NClass)=buggins9((t-1)*NClass+1:t*NClass) + group.trans9(c,:,t-1)'*group.ClassAward(c,t-1);
        buggins11((t-1)*NClass+1:t*NClass)=buggins11((t-1)*NClass+1:t*NClass) + group.trans11(c,:,t-1)'*group.ClassAward(c,t-1);
        bugginsL((t-1)*NClass+1:t*NClass)=bugginsL((t-1)*NClass+1:t*NClass) + group.transl(c,:,t-1)'*group.ClassAward(c,t-1);
        bugginsF((t-1)*NClass+1:t*NClass)=bugginsF((t-1)*NClass+1:t*NClass) + group.bayestrans(c,:,NYear)'*group.ClassAward(c,t-1);
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
statac.ProxCorr = reshape(group.Prox2Corr,NClass*NYear,1);
statac.NeverWon = reshape(group.NeverWon,NClass*NYear,1);
statac.YearsSinceWin = reshape(group.YearsSinceWin,NClass*NYear,1);
statac.WonLastYear = reshape(group.WonLastYear,NClass*NYear,1);
statac.Year = reshape(repmat(Year,NClass,1),NClass*NYear,1);
statac.Frustration = reshape(AvgFrust,NClass*NYear,1);
statac.Buggins = buggins;
statac.BayesAnn = bugginsA;
statac.Bayes3 = buggins3;
statac.Bayes5 = buggins5;
statac.Bayes7 = buggins7;
statac.Bayes9 = buggins9;
statac.Bayes11 = buggins11;
statac.BayesLb = bugginsL;
statac.BayesF = bugginsF;
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

