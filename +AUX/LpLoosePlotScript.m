plot(Data); title(Title);
MaxMin=[min(Data),max(Data)];
DynRange=max(MaxMin(2)-MaxMin(1),0.5);
ylim([MaxMin(1)-Loose*DynRange,MaxMin(2)+Loose*DynRange]);
%set(gca, 'YTickLabel', num2str(get(gca, 'YTick').'));

