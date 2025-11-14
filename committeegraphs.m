Power = zeros(NMember,1);
for m=1:NMember
    NobelMatch = eval(string(strcat('data.',MemFld(1))));
    NobelMatch = NobelMatch(NYear+2:end);
    NobelMatch = NobelMatch(Year>=From(m) & Year<=To(m));
    Power(m) = sum(NobelMatch);
end
%%
UMember = unique(Member);
NUM = length(UMember);
UPower = zeros(NUM,1);
for m=1:NUM
    UPower(m) = sum(Power(strcmp(UMember(m),Member)));
end
%%
Served = To - From + 1;
UServed = zeros(NUM,1);
for m=1:NUM
    UServed(m) = UServed(m) + sum(Served(strcmp(UMember(m),Member)));
end

%%
[UPS, IP] = sort(UPower);
UMS = UMember(IP);
figure
barh(UMS,UPS)
xlabel('Number of Nobel laureates in same 2-digit JEL code')

UPY = UPower ./ UServed;
[UPYS, IY] = sort(UPY);
UMY = UMember(IY);
figure
barh(UMY,UPYS)
xlabel('Number of Nobel laureates in same 2-digit JEL code per year served on committee')
