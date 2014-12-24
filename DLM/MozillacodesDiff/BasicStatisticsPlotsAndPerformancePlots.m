%==============================================================================
%basic statistics: Deamnd plot separted by product
%=================================================================================
ColorSet = varycolor(50);
Linetype_ = ['--';'=.';'--';'-.'];
% set(0,'DefaultAxesColorOrder',[0 0 0],...
%       'DefaultAxesLineStyleOrder','-|-.|--|:');
set(0,'DefaultAxesColorOrder',[1 0 0;0 1 0;0 0 1],...
      'DefaultAxesLineStyleOrder','-|--|:')
set(gca, 'ColorOrder', ColorSet);
pluginList_=[1 9 10 20];
PluginName_ = ['Firebug    ';'DownThemAll';'FireFTP    ';'SkipScreen '];
%pluginList_=[26 33 43 49];
%PluginName_ = ['ImTranslator';'Adblock Plus';'Screengrab  ';'Secure Login'];
%m=min(min(checksize(strm),checksize(y)),checksize(usg));
for numrtr=1:4;
    i=pluginList_(1,numrtr); %current plug in
    j=2; %rating
    k=1; %usage
    l=5; %Short term Economic Shock
    demand_=y{i};
    %plot(tx,Y1(1:T(1,currplugin),currplugin), '--' ,tx,y(1:T(1,currplugin),currplugin),'-.' );
    plot(1:T(1,i),demand_);
    hold all
end;
title('Downloads of Firefox Add-ons'); xlabel('Days');
ylabel('Downloads(10M)');
set(legend(PluginName_(1,:),PluginName_(2,:),PluginName_(3,:),PluginName_(4,:)),'FontAngle','italic','TextColor',[.3,.2,.1],'Location','SouthOutside','Orientation','horizontal');
figureHandle = gcf;
%# make all text in the figure to size 14 and bold
set(findall(figureHandle,'type','text'),'fontSize',14); %'fontWeight','bold'

%==============================================================================
%basic statistics: Add-on New Versions
%=================================================================================
ColorSet = varycolor(50);
Linetype_ = ['--';'=.';'--';'-.'];
% set(0,'DefaultAxesColorOrder',[0 0 0],...
%       'DefaultAxesLineStyleOrder','-|-.|--|:');
set(0,'DefaultAxesColorOrder',[1 0 0;0 1 0;0 0 1],...
      'DefaultAxesLineStyleOrder','-|--|:')
set(gca, 'ColorOrder', ColorSet);
pluginList_=[1 9 10 20];
PluginName_ = ['Firebug    ';
               'DownThemAll';
               'FireFTP    ';
               'SkipScreen '];
color       = ['--g','-.b',':c','k']
%pluginList_=[26 33 43 49];
%PluginName_ = ['ImTranslator';'Adblock Plus';'Screengrab  ';'Secure Login'];
%m=min(min(checksize(strm),checksize(y)),checksize(usg));
for numrtr=1:4;
    i=pluginList_(1,numrtr); %current plug in
    j=2; %rating
    k=1; %usage
    l=5; %Short term Economic Shock
    demand_=phetrgn{i}(:,2);
    %plot(tx,Y1(1:T(1,currplugin),currplugin), '--' ,tx,y(1:T(1,currplugin),currplugin),'-.' );
    plot(1:T(1,i),demand_);
    hold all
end;
title('New Version of Firefox Add-ons'); xlabel('Days');
ylabel('New Version Pulse');
set(legend(PluginName_(1,:),PluginName_(2,:),PluginName_(3,:),PluginName_(4,:)),'FontAngle','italic','TextColor',[.3,.2,.1],'Location','SouthOutside','Orientation','horizontal');
figureHandle = gcf;
%# make all text in the figure to size 14 and bold
set(findall(figureHandle,'type','text'),'fontSize',14); %'fontWeight','bold'

%==============================================================================
%basic statistics: RAting Variance
%=================================================================================
ColorSet = varycolor(50);
Linetype_ = ['--';'=.';'--';'-.'];
% set(0,'DefaultAxesColorOrder',[0 0 0],...
%       'DefaultAxesLineStyleOrder','-|-.|--|:');
set(0,'DefaultAxesColorOrder',[1 0 0;0 1 0;0 0 1],...
      'DefaultAxesLineStyleOrder','-|--|:')
set(gca, 'ColorOrder', ColorSet);
pluginList_=[1 9 10 20];
PluginName_ = ['Firebug    ';
               'DownThemAll';
               'FireFTP    ';
               'SkipScreen '];
color       = ['--g','-.b',':c','k']
%pluginList_=[26 33 43 49];
%PluginName_ = ['ImTranslator';'Adblock Plus';'Screengrab  ';'Secure Login'];
%m=min(min(checksize(strm),checksize(y)),checksize(usg));
for numrtr=1:4;
    i=pluginList_(1,numrtr); %current plug in
    j=2; %rating
    k=1; %usage
    l=5; %Short term Economic Shock
    demand_=qhetrgn{i}(:,2);
    %plot(tx,Y1(1:T(1,currplugin),currplugin), '--' ,tx,y(1:T(1,currplugin),currplugin),'-.' );
    plot(1:T(1,i),demand_);
    hold all
end;
title('Variance of Rating of Firefox Add-ons'); xlabel('Days');
ylabel('Variance of Rating');
set(legend(PluginName_(1,:),PluginName_(2,:),PluginName_(3,:),PluginName_(4,:)),'FontAngle','italic','TextColor',[.3,.2,.1],'Location','SouthOutside','Orientation','horizontal');
figureHandle = gcf;
%# make all text in the figure to size 14 and bold
set(findall(figureHandle,'type','text'),'fontSize',14); %'fontWeight','bold'

%==============================================================================
%basic statistics: Daily Users plot separted by product
%=================================================================================
ColorSet = varycolor(50);
Linetype_ = ['--';'=.';'--';'-.'];
% set(0,'DefaultAxesColorOrder',[0 0 0],...
%       'DefaultAxesLineStyleOrder','-|-.|--|:');
set(0,'DefaultAxesColorOrder',[1 0 0;0 1 0;0 0 1],...
      'DefaultAxesLineStyleOrder','-|--|:')
set(gca, 'ColorOrder', ColorSet);
pluginList_=[1 9 10 20];
PluginName_ = ['Firebug    ';'DownThemAll';'FireFTP    ';'SkipScreen '];
%pluginList_=[26 33 43 49];
%PluginName_ = ['ImTranslator';'Adblock Plus';'Screengrab  ';'Secure Login'];
%m=min(min(checksize(strm),checksize(y)),checksize(usg));
for numrtr=1:4;
    i=pluginList_(1,numrtr); %current plug in
    j=2; %rating
    k=1; %usage
    l=5; %Short term Economic Shock
    demand_=min(qhetrgn{i}(:,3),1);
    %plot(tx,Y1(1:T(1,currplugin),currplugin), '--' ,tx,y(1:T(1,currplugin),currplugin),'-.' );
    plot(1:T(1,i),demand_);
    hold all
end;
title('Daily Users of Firefox Add-ons'); xlabel('Days');
ylabel('Daily Users(10M)');
set(legend(PluginName_(1,:),PluginName_(2,:),PluginName_(3,:),PluginName_(4,:)),'FontAngle','italic','TextColor',[.3,.2,.1],'Location','SouthOutside','Orientation','horizontal');
figureHandle = gcf;
%# make all text in the figure to size 14 and bold
set(findall(figureHandle,'type','text'),'fontSize',14); %'fontWeight','bold'


%==============================================================================
%basic statistics: RAting Average
%=================================================================================
ColorSet = varycolor(50);
Linetype_ = ['--';'=.';'--';'-.'];
% set(0,'DefaultAxesColorOrder',[0 0 0],...
%       'DefaultAxesLineStyleOrder','-|-.|--|:');
set(0,'DefaultAxesColorOrder',[1 0 0;0 1 0;0 0 1],...
      'DefaultAxesLineStyleOrder','-|--|:')
set(gca, 'ColorOrder', ColorSet);
pluginList_=[1 9 10 20];
PluginName_ = ['Firebug    ';
               'DownThemAll';
               'FireFTP    ';
               'SkipScreen '];
color       = ['--g','-.b',':c','k']
%pluginList_=[26 33 43 49];
%PluginName_ = ['ImTranslator';'Adblock Plus';'Screengrab  ';'Secure Login'];
%m=min(min(checksize(strm),checksize(y)),checksize(usg));
for numrtr=1:4;
    i=pluginList_(1,numrtr); %current plug in
    j=2; %rating
    k=1; %usage
    l=5; %Short term Economic Shock
    demand_=qhetrgn{i}(:,4);
    %plot(tx,Y1(1:T(1,currplugin),currplugin), '--' ,tx,y(1:T(1,currplugin),currplugin),'-.' );
    plot(1:T(1,i),demand_);
    hold all
end;
title('Variance of Rating of Firefox Add-ons'); xlabel('Days');
ylabel('Variance of Rating');
set(legend(PluginName_(1,:),PluginName_(2,:),PluginName_(3,:),PluginName_(4,:)),'FontAngle','italic','TextColor',[.3,.2,.1],'Location','SouthOutside','Orientation','horizontal');
figureHandle = gcf;
%# make all text in the figure to size 14 and bold
set(findall(figureHandle,'type','text'),'fontSize',14); %'fontWeight','bold'





%basic statistics: Size of User Base plot separted by product
Linetype_ = ['--';'=.';'--';'-.'];
set(0,'DefaultAxesColorOrder',[0 0 0],...
      'DefaultAxesLineStyleOrder','-|-.|--|:');
pluginList_=[1 9 10 20];
PluginName_ = ['Firebug    ';'DownThemAll';'FireFTP    ';'SkipScreen '];
%pluginList_=[26 33 43 49];
%PluginName_ = ['ImTranslator';'Adblock Plus';'Screengrab  ';'Secure Login'];
%m=min(min(checksize(strm),checksize(y)),checksize(usg));
for numrtr=1:4;
    i=pluginList_(1,numrtr); %current plug in
    j=2; %rating
    k=1; %usage
    l=5; %Short term Economic Shock
    Usage_=X(1:T(1,i),5*(i-1)+k);
    %plot(tx,Y1(1:T(1,currplugin),currplugin), '--' ,tx,y(1:T(1,currplugin),currplugin),'-.' );
    plot(1:T(1,i),Usage_);
    hold all
end;
title('Daily users of Firefox Add-ons'); xlabel('Days');
ylabel('Daily Users(M)');
set(legend(PluginName_(1,:),PluginName_(2,:),PluginName_(3,:),PluginName_(4,:)),'FontAngle','italic','TextColor',[.3,.2,.1],'Location','SouthOutside','Orientation','horizontal');
figureHandle = gcf;
%# make all text in the figure to size 14 and bold
set(findall(figureHandle,'type','text'),'fontSize',14); %'fontWeight','bold'


%basic statistics: Rating Valence separted by product
Linetype_ = ['--';'=.';'--';'-.'];
set(0,'DefaultAxesColorOrder',[0 0 0],...
      'DefaultAxesLineStyleOrder','-|-.|--|:');
pluginList_=[1 9 10 20];
PluginName_ = ['Firebug    ';'DownThemAll';'FireFTP    ';'SkipScreen '];
%pluginList_=[26 33 43 49];
%PluginName_ = ['ImTranslator';'Adblock Plus';'Screengrab  ';'Secure Login'];
%m=min(min(checksize(strm),checksize(y)),checksize(usg));
for numrtr=1:4;
    i=pluginList_(1,numrtr); %current plug in
    j=2; %rating
    k=1; %usage
    l=5; %Short term Economic Shock
    ratingvalence_=X(1:T(1,i),5*(i-1)+j);
    %plot(tx,Y1(1:T(1,currplugin),currplugin), '--' ,tx,y(1:T(1,currplugin),currplugin),'-.' );
    plot(1:T(1,i),ratingvalence_);
    hold all
end;
title('Rating Valence of Firefox Add-ons'); xlabel('Days');
ylabel('Rating Valence');
set(legend(PluginName_(1,:),PluginName_(2,:),PluginName_(3,:),PluginName_(4,:)),'FontAngle','italic','TextColor',[.3,.2,.1],'Location','SouthOutside','Orientation','horizontal');
figureHandle = gcf;
%# make all text in the figure to size 14 and bold
set(findall(figureHandle,'type','text'),'fontSize',14); %'fontWeight','bold'


%basic statistics: Variance of Ratings separted by product
Linetype_ = ['--';'=.';'--';'-.'];
set(0,'DefaultAxesColorOrder',[0 0 0],...
      'DefaultAxesLineStyleOrder','-|-.|--|:');
set(0,'DefaultAxesColorOrder',[1 .2 0.5;0 0 .8;0 0.5 .8],...
      'DefaultAxesLineStyleOrder','-|--|:');
pluginList_=[1 9 10 20];
PluginName_ = ['Firebug    ';'DownThemAll';'FireFTP    ';'SkipScreen '];
%pluginList_=[26 33 43 49];
%PluginName_ = ['ImTranslator';'Adblock Plus';'Screengrab  ';'Secure Login'];
%m=min(min(checksize(strm),checksize(y)),checksize(usg));
for numrtr=1:4;
    i=pluginList_(1,numrtr); %current plug in
    j=2; %rating
    k=1; %usage
    l=5; %Short term Economic Shock
    ratingvalence_= st{i};
    %plot(tx,Y1(1:T(1,currplugin),currplugin), '--' ,tx,y(1:T(1,currplugin),currplugin),'-.' );
    plot(1:T(1,i),ratingvalence_);
    hold all
end;
title('Rating Variance of Firefox Add-ons'); xlabel('Days');
ylabel('Rating Variance');
set(legend(PluginName_(1,:),PluginName_(2,:),PluginName_(3,:),PluginName_(4,:)),'FontAngle','italic','TextColor',[.3,.2,.1],'Location','SouthOutside','Orientation','horizontal');
figureHandle = gcf;
%# make all text in the figure to size 14 and bold
set(findall(figureHandle,'type','text'),'fontSize',14); %'fontWeight','bold'

%plot platform cumulative downloads Chrome and IE
[haxes,hline1,hline2]=plotyy(1:pT,yp,1:pT,[ych yie],'plot','plot');
set(0,'DefaultAxesColorOrder',[1 .2 0.5;0 0 .8;0.1 0.3 .3],...
      'DefaultAxesLineStyleOrder','-|--|:');
plot(1:pT,yp);
hold all
plot(1:pT,ych);
hold all
plot(1:pT,yie);
hold all
title('Diffusion of Firefox Platform and its Main Competitors'); xlabel('Days');
ylabel('Users (10 Million)');
set(legend('Firefox','Chrome','IE'),'FontAngle','italic','TextColor',[.3,.2,.1],'Location','SouthOutside','Orientation','horizontal');
figureHandle = gcf;
%# make all text in the figure to size 14 and bold
set(findall(figureHandle,'type','text'),'fontSize',14); %'fontWeight','bold'


%basic statistics: Product Category Search separted by product
pluginList_=[1 9 10 20];
PluginName_ = ['Firebug    ';'DownThemAll';'FireFTP    ';'SkipScreen '];
%pluginList_=[26 33 43 49];
%PluginName_ = ['ImTranslator';'Adblock Plus';'Screengrab  ';'Secure Login'];
%m=min(min(checksize(strm),checksize(y)),checksize(usg));
Linetype_ = ['--';'=.';'--';'-.'];
set(0,'DefaultAxesColorOrder',[0 0 0],...
      'DefaultAxesLineStyleOrder','-|-.|--|:');
for numrtr=1:4;
    i=pluginList_(1,numrtr); %current plug in
    j=2; %rating
    k=1; %usage
    l=5; %Short term Economic Shock
    STES_= X(1:T(1,i),5*(i-1)+l);
    %plot(tx,Y1(1:T(1,currplugin),currplugin), '--' ,tx,y(1:T(1,currplugin),currplugin),'-.' );
    plot(1:T(1,i),STES_);
    hold all
end;
title('Product Category Search of Firefox Add-ons'); xlabel('Days');
ylabel('Product Category Search');
set(legend(PluginName_(1,:),PluginName_(2,:),PluginName_(3,:),PluginName_(4,:)),'FontAngle','italic','TextColor',[.3,.2,.1],'Location','SouthOutside','Orientation','horizontal');
figureHandle = gcf;
%# make all text in the figure to size 14 and bold
set(findall(figureHandle,'type','text'),'fontSize',14); %'fontWeight','bold'

%basic statistics: Versioning separted by product
pluginList_=[1 9 10 20];
PluginName_ = ['Firebug    ';'DownThemAll';'FireFTP    ';'SkipScreen '];
%pluginList_=[26 33 43 49];
%PluginName_ = ['ImTranslator';'Adblock Plus';'Screengrab  ';'Secure Login'];
%m=min(min(checksize(strm),checksize(y)),checksize(usg));
Linetype_ = ['--';'=.';'--';'-.'];
set(0,'DefaultAxesColorOrder',[0 0 0],...
      'DefaultAxesLineStyleOrder','-|-.|--|:');
for numrtr=1:4;
    i=pluginList_(1,numrtr); %current plug in
    j=2; %rating
    k=1; %usage
    l=5; %Short term Economic Shock
    STES_= X(1:T(1,i),5*(i-1)+l);
    %plot(tx,Y1(1:T(1,currplugin),currplugin), '--' ,tx,y(1:T(1,currplugin),currplugin),'-.' );
    plot(1:T(1,i),STES_);
    hold all
end;
title('Product Category Search of Firefox Add-ons'); xlabel('Days');
ylabel('Product Category Search');
set(legend(PluginName_(1,:),PluginName_(2,:),PluginName_(3,:),PluginName_(4,:)),'FontAngle','italic','TextColor',[.3,.2,.1],'Location','SouthOutside','Orientation','horizontal');
figureHandle = gcf;
%# make all text in the figure to size 14 and bold
set(findall(figureHandle,'type','text'),'fontSize',14); %'fontWeight','bold'

%basic statistics: Versioning separted by product
Linetype_ = ['--';'=.';'--';'-.'];
set(0,'DefaultAxesColorOrder',[0 0 0],...
      'DefaultAxesLineStyleOrder','-|-.|--|:');
pluginList_=[1 9 10 20];
PluginName_ = ['Firebug    ';'DownThemAll';'FireFTP    ';'SkipScreen '];
%pluginList_=[26 33 43 49];
%PluginName_ = ['ImTranslator';'Adblock Plus';'Screengrab  ';'Secure Login'];
%m=min(min(checksize(strm),checksize(y)),checksize(usg));
for numrtr=1:4;
    i=pluginList_(1,numrtr); %current plug in
    j=2; %rating
    k=1; %usage
    l=5; %Short term Economic Shock
    vrsnng=4;
    vrsnng_= cumsum(X(1:T(1,i),5*(i-1)+vrsnng));
    %plot(tx,Y1(1:T(1,currplugin),currplugin), '--' ,tx,y(1:T(1,currplugin),currplugin),'-.' );
    plot(1:T(1,i),vrsnng_);
    hold all
end;
title('New Versions of Firefox Add-ons'); xlabel('Days');
ylabel('Number of New Versions');
set(legend(PluginName_(1,:),PluginName_(2,:),PluginName_(3,:),PluginName_(4,:)),'FontAngle','italic','TextColor',[.3,.2,.1],'Location','SouthOutside','Orientation','horizontal');
figureHandle = gcf;
%# make all text in the figure to size 14 and bold
set(findall(figureHandle,'type','text'),'fontSize',14); %'fontWeight','bold'

%basic statistics plot
%pluginList_=[1 9 10 20];
%PluginName_ = ['Firebug    ';'DownThemAll';'FireFTP    ';'SkipScreen '];
pluginList_=[26 33 43 49];
PluginName_ = ['ImTranslator';'Adblock Plus';'Screengrab  ';'Secure Login'];
for numrtr=1:4;
    i=pluginList_(1,numrtr); %current plug in
    j=2; %rating
    k=1; %usage
    l=5; %Short term Economic Shock
    demand_= zscore(y(1:T(1,i),i));
    %plot(demand_)
    %hold all;
    ratingvalence_=zscore(X(1:T(1,i),5*(i-1)+j));
    % plot(ratingvalence_)
    % hold all;
    Usage_=zscore(X(1:T(1,i),5*(i-1)+k));
    % plot(Usage_)
    % hold all;
    STES_= X(1:T(1,i),5*(i-1)+l);
    plotting_=[demand_ Usage_ ratingvalence_ STES_];
    %plotting_ = zscore(plotting_);
    %normalized: http://stackoverflow.com/questions/1719048/plotting-4-curves-in-a-single-plot-with-3-y-axes
    plotting_ = bsxfun(@times, bsxfun(@minus,plotting_,min(plotting_)), 1./range(plotting_));
    %plotting_ = 1 ./ ( 1 + exp( -zscore(plotting_) ) );
    subplot(2,2,numrtr);
    plot(1:T(1,i),plotting_(:,1),1:T(1,i),plotting_(:,2),1:T(1,i),plotting_(:,3),1:T(1,i),plotting_(:,4))
    title(PluginName_(numrtr,:)); xlabel('Days');
    ylabel('Normalized Level');
end;
set(legend('Demand','User Base','Rating Valence','Short Term Economic Shocks'),'FontAngle','italic','TextColor',[.3,.2,.1],'Location','SouthOutside','Orientation','horizontal');
figureHandle = gcf;
%# make all text in the figure to size 14 and bold
set(findall(figureHandle,'type','text'),'fontSize',14); %'fontWeight','bold'

%plot rating responsiveness: effect of rating on downloads
tx_=3:.1:4.5;
%list of type 1: increasing return
%aq_=-15.8223;bs_=3.6705; %type one increasing return" Firebug
%aq_=-6.903;bs_=1.6426; %IETAB
%aq_=-0.0435;bs_=0.0147; %Test Pilot
%aq_=-2.8571;bs_=0.8112; %personas plus
%aq_=-0.4109;bs_=0.088; %super start
%aq_=-0.2855;bs_=0.0533; %tilt 3D
%aq_=-0.1225; bs_=0.0265; %quick local switcher
%aq_=-0.022;bs_=0.0036;
%aq_=-0.1881; bs_=0.0375; %screengrab

%list of type 2: diminishing return
%aq_=3.8473;bs_=-0.8595; %type two increasing reverse return: stylish
%aq_=4.8543; bs_=-1.0992; %fireftp
aq_=0.3918; bs_=-0.0845; %minimize to tray
%aq_=1.0117;bs_=-0.1799; %web developer: positive
%aq_=0.4639;bs_=-0.1194; %status for ever
%aq_=0.8377;bs_=-0.207; %google shortcut
%aq_=0.2078; bs_=-0.0427; %print page to pdf
%aq_=3.0762;bs_=-0.6552; %auto pager
%aq_=1.5951;bs_=-0.339; %ImTranslator
%aq_=0.3185;bs_=-0.0523; %google Translator
%aq_=0.0283;bs_=-0.0063; %Romanian Language
%aq_=0.4391; bs_=-0.0994; %stealty
%aq_=0.8367;bs_=-0.1967; %febe
%aq_=0.1234; bs_=-0.0262; %procon
%aq_=0.0685; bs_=-0.0146; %new tab
%aq_=0.1661;bs_=-0.0349; %pdf viewer
%aq_=0.1197;bs_=-0.0402; %nightly tester
%aq_=0.1984;bs_=-0.0366; %translate
%aq_=0.2023;bs_=-0.0367;
ty_=aq_.*tx_+bs_.*tx_.^2;
plot(tx_,ty_);


%Example of Type 2
tx_=3:.1:4.5;
aq_=0.3918; bs_=-0.0845; %minimize to tray
ty_=aq_.*tx_+bs_.*tx_.^2;
%ty_=aq_+bs_.*tx_;
plot(tx_,ty_);
title('Effectiveness of Rating Valence: Type 2'); xlabel('Rating Valence Level');
ylabel('Effect on Downloads');
set(legend('Example of Add-on: Minimize to Tray'),'FontAngle','italic','TextColor',[.3,.2,.1],'Location','SouthOutside','Orientation','horizontal');
figureHandle = gcf;
%# make all text in the figure to size 14 and bold
set(findall(figureHandle,'type','text'),'fontSize',14); %'fontWeight','bold'

%Example of Type 1
tx_=3:.1:4.5;
aq_=-0.0435;bs_=0.0147; %Test Pilot
ty_=aq_.*tx_+bs_.*tx_.^2;
%ty_=aq_+bs_.*tx_;
plot(tx_,ty_);
title('Effectiveness of Rating Valence: Type 1'); xlabel('Rating Valence Level');
ylabel('Effect on Downloads');
set(legend('Example of Add-on: Test Pilot'),'FontAngle','italic','TextColor',[.3,.2,.1],'Location','SouthOutside','Orientation','horizontal');
figureHandle = gcf;
%# make all text in the figure to size 14 and bold
set(findall(figureHandle,'type','text'),'fontSize',14); %'fontWeight','bold'

%User Base size Negative Effect
set(0,'DefaultAxesColorOrder',[0 0 0],...
      'DefaultAxesLineStyleOrder','-|-.|--|:');
set(0,'DefaultAxesColorOrder',[1 .2 0.5;0 0 .8;1 0 1],...
      'DefaultAxesLineStyleOrder','-|--|:')
i=20;
tx = 1:T(1,i); 
[AX,H1,H2]=plotyy(tx,y(1:T(1,i),i),tx,X(1:T(1,i),((k-1)*(i-1)+1)), 'plot');
set(get(AX(1),'Ylabel'),'String','Downloads(K)') 
set(get(AX(2),'Ylabel'),'String','User Base Size(M)') ;
set(H1,'LineStyle','--');
set(H2,'LineStyle','-.');
title('Negative Effect of Daily Users (Example: Skip Screen)'); xlabel('Days');
%ylabel('Effect on Downloads');
set(legend('Daily Users','Downloads'),'FontAngle','italic','TextColor',[.3,.2,.1],'Location','SouthOutside','Orientation','horizontal');
figureHandle = gcf;
%# make all text in the figure to size 14 and bold
set(findall(figureHandle,'type','text'),'fontSize',14); %'fontWeight','bold' 

%average rating valence Negative Effect
set(0,'DefaultAxesColorOrder',[0 0 0],...
      'DefaultAxesLineStyleOrder','-|-.|--|:'); % black and white
set(0,'DefaultAxesColorOrder',[0 0 1;1 0 1;1 0 0],...
      'DefaultAxesLineStyleOrder','-|--|:')
i=17;
tx = 1:T(1,i); 
[AX,H1,H2]=plotyy(tx,y(1:T(1,i),i),tx,X(1:T(1,i),((k-1)*(i-1)+2)),'plot');
set(get(AX(1),'Ylabel'),'String','Downloads(K)') 
set(get(AX(2),'Ylabel'),'String','Product Rating Valence') ;
set(H1,'LineStyle','--');
set(H2,'LineStyle','-.');
title('Negative Effect of Average Rating Valence(Example: Google Shortcut)'); xlabel('Days');
%ylabel('Effect on Downloads (K)');
set(legend('Downloads ','Average Rating Valence'),'FontAngle','italic','TextColor',[.3,.2,.1],'Location','SouthOutside','Orientation','horizontal');
figureHandle = gcf;
%# make all text in the figure to size 14 and bold
set(findall(figureHandle,'type','text'),'fontSize',14); %'fontWeight','bold' 


%check the shape of star response logit
[num_,txt_,raw_] = xlsread('C:\Users\MHE\Desktop\ActiveCourses\Projects\Noris\Results\LogitOfShape.xlsx',1);
y_=num_(:,1);
for i=1:47;
    X_=num_(:,1+i);
    [blogit,devlogit,statslogit] = glmfit(X_,y_,'binomial','link','logit');
    stats(i,1)=statslogit.p(2,1);
end;
stats
[num_,txt_,raw_] = xlsread('C:\Users\MHE\Desktop\ActiveCourses\Projects\Noris\Results\LogitOfShape.xlsx',1);
y_=num_(:,1);
X_=num_(:,12);
[blogit,devlogit,statslogit] = glmfit(X_,y_,'binomial','link','logit');
stats(i,1)=statslogit.p(2,1);

%check the usage response
[num_,txt_,raw_] = xlsread('C:\Users\MHE\Desktop\ActiveCourses\Projects\Noris\Results\LogitOfShape.xlsx',2);
y_=num_(:,1);
for i=1:47;
    X_=num_(:,1+i);
    [blogit,devlogit,statslogit] = glmfit(X_,y_,'binomial','link','logit');
    stats(i,1)=statslogit.p(2,1);
end;
stats

% 1-step ahead forecast
%pluginList_=[2 7 12 17];
%PluginName_ = ['Flagfox         ';'Stylish         ';'Personas Plus   ';'Google Shortcuts'];
% set(0,'DefaultAxesColorOrder',[1 0 0;0 0 1;0 1 0],...
%       'DefaultAxesLineStyleOrder','-|--|:')
pluginList_=[22 27 33 36];
PluginName_ = ['AutoPager                    ';
               'Google Translator for Firefox';
               'Adblock Plus                 ';
               'Stealthy                     '];
for numrtr=1:4;
    currplugin=pluginList_(1,numrtr);
    tx = 1:T(1,currplugin); 
    subplot(2,2,numrtr);
    plot(tx,Y1{currplugin}, '-.' ,tx,y{currplugin} );
    title(PluginName_(numrtr,:)); xlabel('Days');ylabel('Demand'); 
end;
set(legend('One step ahead forecast','Actual'),'FontAngle','italic','TextColor',[.3,.2,.1],'Location','SouthOutside','Orientation','horizontal');
figureHandle = gcf;
%# make all text in the figure to size 14 and bold
set(findall(figureHandle,'type','text'),'fontSize',14); %'fontWeight','bold'

%MAD and MSE fit
pluginList_=[22 27 33 36];
disp('MADs are:');
for numrtr=1:4;
    currplugin=pluginList_(1,numrtr);
    disp([mean(MAD{currplugin})]);
end;
disp('MSEs are:');
for numrtr=1:4;
    currplugin=pluginList_(1,numrtr);
    disp([mean(MSE{currplugin})]);
end;

