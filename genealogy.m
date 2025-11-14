disp('read academic genealogy')
NobelGraph
CandidateGraph
close all

%%
nyear = 2026-1969;
nnode = size(C1.Nodes,1);

nobool = zeros(nnode,nyear);

for i=1:nyear
    if i>1
       nobool(:,i) = nobool(:,i-1);
    end
    for j=1:nnode        
        test = eval(strcat('length(cell2mat(strfind(table2cell(C1.Nodes(',num2str(j),',1)),"',num2str(i+1968),'")))'));
        if test == 1
           nobool(j,i)=1;
        end
    end
end

%%
nobelarithin = zeros(nnode,nyear);
nobelarithout = zeros(nnode,nyear);
nobelharmin = zeros(nnode,nyear);
nobelharmout = zeros(nnode,nyear);

for i=1:nyear
    nobelarithout(:,i)= nobelity(C1,nobool(:,i),'out');
    nobelarithin(:,i)= nobelity(C1,nobool(:,i),'in');
    nobelharmin(:,i)= harmonicnobelity(C1,nobool(:,i),'in');
    nobelharmout(:,i)= harmonicnobelity(C1,nobool(:,i),'out');
end


%% 90 mins alternative: load econsiblings.mat
if full
    nn = size(C1.Nodes,1);
    in = indegree(C1);

    tic

    sibling = zeros(nyear,nn,nn);
    for t=1:nyear
        disp(t)
        for i=1:nn-1
            if in(i) > 0
                for j=i+1:nn
                    if nobool(i,t) == 1 || nobool(j,t) == 1
                        sibling(t,i,j) = horzdist(C1,C1.Nodes{i,:},C1.Nodes{j,:},2);
                    end
                end
            end
        end
        sibling(t,:,:) = squeeze(sibling(t,:,:)) + squeeze(sibling(t,:,:))';
    end
    toc

    save econsiblings.mat
else
    load econsiblings.mat
end
%%
nn = size(C1.Nodes,1);
siblings = zeros(nn,nyear);
for t=1:nyear
    siblings(:,t) = sum(squeeze(sibling(t,:,:)),1)/sum(nobool(:,t));
end

%%
GID = '1pIC_vGxU2IFIdOZrB6bl7ovQPSHh7QZENG4fhJvMFEc';
urlname = sprintf('https://docs.google.com/spreadsheets/d/%s/gviz/tq?tqx=out:csv&sheet=%s',GID,'tree');
data = webread(urlname);
PID = data.PID;

%%
%load dynnobel.mat

[PIDs PIDi] = sort(PID(~isnan(PID))); 
aux = siblings(~isnan(PID),:);
demo.Siblings = aux(PIDi,:);
aux = nobelarithin(~isnan(PID),:);
demo.AncA = aux(PIDi,:);
aux = nobelarithout(~isnan(PID),:);
demo.DescA = aux(PIDi,:);
aux = nobelharmin(~isnan(PID),:);
demo.AncH = aux(PIDi,:);
aux = nobelharmout(~isnan(PID),:);
demo.DescH = aux(PIDi,:);

%%
demo.Siblings = [zeros(NScholar, 1), demo.Siblings(:,1:end-1)];
demo.AncA = [zeros(NScholar, 1), demo.AncA(:,1:end-1)];
demo.DescA = [zeros(NScholar, 1), demo.DescA(:,1:end-1)];
demo.AncH = [zeros(NScholar, 1), demo.AncH(:,1:end-1)];
demo.DescH = [zeros(NScholar, 1), demo.DescH(:,1:end-1)];

%%
clear aux C1 data F G* hfig i in j layout N names p* P* s* t test urlname nyear nob* nn*