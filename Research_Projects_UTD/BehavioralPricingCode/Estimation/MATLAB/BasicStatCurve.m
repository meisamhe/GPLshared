%basic statistics: Deamnd plot separted by product
[num,txt,raw] = xlsread('C:\Users\MHE\Desktop\ActiveCourses\Projects\BehavioralPricing\DataG\DataforBasicStat.xlsx',1);
[J,p]   =   size(num);
x=num(:,2);
Data=num(:,3:5);
DataName_ = ['Sales       ';'Availability';'Price       '];
Linetype_ = ['--';'=.';'--';'-.'];
set(0,'DefaultAxesColorOrder',[0 0 0],...
      'DefaultAxesLineStyleOrder','-|-.|--|:');
[haxes,hline1,hline2]=plotyy(x,Data(:,2),x,Data(:,1),'plot','plot');
axes(haxes(1));
miny=min(Data(:,2));
maxy=max(Data(:,2));
ylabel('Sales');
axis([min(x) max(x) floor(miny/100)*100 ceil(maxy/100)*100]);
L = get(gca,'YLim');
set(gca,'YTick',linspace(floor(miny/100)*100,ceil(maxy/100)*100,11));
axes(haxes(2));
miny=min(Data(:,1));
maxy=max(Data(:,1));
ylabel('Price');
set(hline2,'LineStyle','-.');
axis([min(x) max(x) floor(miny/100)*100 ceil(maxy/100)*100]);
L = get(gca,'YLim');
set(gca,'YTick',linspace(floor(miny/100)*100,ceil(maxy/100)*100,11));
set(gca,'XGrid','off','YGrid','on');
title('Price and Sales for Sample Product'); xlabel('Weeks');
set(legend('Sales','Price'),'FontAngle','italic','TextColor',[.3,.2,.1],'Location','SouthOutside','Orientation','horizontal');
figureHandle = gcf;
%# make all text in the figure to size 14 and bold
set(findall(figureHandle,'type','text'),'fontSize',14); %'fontWeight','bold'
set(legend(PluginName_(1,:),PluginName_(2,:),PluginName_(3,:),PluginName_(4,:)),'FontAngle','italic','TextColor',[.3,.2,.1],'Location','SouthOutside','Orientation','horizontal');

%table of frequencies
revenuep=S2.*P2./(S1.*P1);
relativePrice=P2./P1;
Quantity=S2./S1;
for j=1:10;
    i=10-j;
 disp([i./10 (i+1)./10 ...
     sum(relativePrice(:,1)>i./10 & relativePrice(:,1)<(i+1)./10,1)...
     size(revenuep(relativePrice(:,1)>i./10 & relativePrice(:,1)<(i+1)./10,1),1) ...
     mean(revenuep(relativePrice(:,1)>i./10& relativePrice(:,1)<(i+1)./10,1))...
     mean(Quantity(relativePrice(:,1)>i./10& relativePrice(:,1)<(i+1)./10,1))]);
end;

%,'YMinorGrid','on'
% set(gca ...
%     ,'Box' , 'off' ...
%     ,'TickDir' , 'in' ...
%     ,'TickLength' , [.02 .02] ...
%     ,'XMinorTick' , 'off' ...
%     ,'YMinorTick' , 'on' ...
%     ,'YTick' , miny:100:maxy ...
%     ,'XGrid','off','YGrid','on','YMinorGrid','on'...
% );
%    ,'FontSize' , 16 ...
%     ,'YGrid' , 'off' ...
%     ,'XColor' , [.3 .3 .3] ...
%     ,'YColor' , [.3 .3 .3] ...
%     ,'YLim' , [0 10] ...
%     ,'LineWidth' , 3 ...

% xlim=get(gca,'xlim');
% hold on
% plot(xlim,[30 30; 2 2],':')
% for i=1:3;
%     y_=Data(:,i);
%     %plot(tx,Y1(1:T(1,currplugin),currplugin), '--' ,tx,y(1:T(1,currplugin),currplugin),'-.' );
%     plot(x,y_);
%     hold all
% end;
% ylabel('Downloads(K)');
