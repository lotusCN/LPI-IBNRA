% plot ROC curve
function auc = plot_roc(deci,label_y,colour)
[threshold,ind] = sort(deci,'descend');
roc_y = label_y(ind);
stack_x = cumsum(roc_y == 0)/sum(roc_y == 0);%xÖá£ºFPR
stack_y = cumsum(roc_y == 1)/sum(roc_y == 1);%yÖá£ºTPR
auc=sum((stack_x(2:length(roc_y))-stack_x(1:length(roc_y)-1)).*stack_y(2:length(roc_y)));

figure;
plot(stack_x,stack_y,colour);
xlabel('1-Specificity');
ylabel('Sensitivity');
end
