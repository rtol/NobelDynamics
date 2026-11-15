%C2 = digraph({'Simon' 'Simon' 'Mart' 'Lia' 'Richard' 'Marco'},{'Mart' 'Lia' 'Richard' 'Marco' 'Meabh' 'Sandra'});
%plot(C2)
%%
A = adjacency(C1);
Siblings = A'*A;
Siblings = Siblings-diag(diag(Siblings));
A2 = A*A;
Cousins = A2'*A2;
Cousins = Cousins - diag(diag(Cousins));
Aunts = Siblings*A;
Aunts = Aunts + Aunts';
A3 = A*A*A;
Cousins2 = A3'*A3;
Cousins2 = Cousins2 - diag(diag(Cousins2));
Cousins1R = Cousins*A;
Cousins1R = Cousins1R + Cousins1R';
GreatAunts = Siblings*A2;
GreatAunts = GreatAunts + GreatAunts';

%%
nob = sum(nobool);

nsdist = zeros(nnode,NYear);
for t=1:NYear
    sel = repmat(nobool(:,t),1,nnode);
    nsdist(:,t) = sum(Siblings.*sel)/nob(t) + sum(Aunts.*sel)/2/nob(t) + sum(Cousins.*sel)/3/nob(t) + sum(GreatAunts.*sel)/4/nob(t) + sum(Cousins1R.*sel)/4/nob(t) + sum(Cousins2.*sel)/5/nob(t);
end
