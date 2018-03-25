% identification for with regret and heterogeneous case
clear all; 


%==================================Define Variables, and  real data========================
global P1 P2 Dur1 Dur2 gamma shares km cost   %outside_n
global vcm se_est betas 
global YnNLSQ
global pi1r bpdr alphapdr betardr cr
global deltatemp
global availlambda
[num,txt,raw] = xlsread('H:\RegretPrj\cleaned10232013.xlsx',1);
[J,p]   =   size(num);
Dur1=num(:,2); % duration of first period (in weeks)
Dur2=num(:,3); % duration of second period (in weeks)
P1=num(:,4); % average of price of second period
P2=num(:,5); %recover main price ended in 8
Av1=num(:,6); % availability in first period average
Av2=num(:,7); % availability in the second period average 
Av3=num(:,12); % availability right at the beginning of second period
S1=num(:,8); % sales in the first period
S2=num(:,9); % sales of second period
MKTSz=num(:,10); % total market size (inventory * 1.25)
cost = num(:,11); % unit cost of an item
T  =  3;

% First Experiment: test for average of second period availability, and normalized S2
lambda  = Av2;

%inflate MKTSz with the availability as well [No inflation for now]
%MKTSz=MKTSz./lambda;
%S2 = S2./lambda;

% contraction mapping facilitator
deltatemp = zeros(J,T-1);


% heterogeneity
km   =    1e-13;


%discount factor when Dur1=1 then it will show weekly discount factor of gamma =.975;
gamma=1./(1+.0025).^Dur1;
% create shares
shares=[S1./MKTSz S2./MKTSz];
outside=repmat(ones(J,1) - sum(shares,2),[1 2]);


% test how many shares are lower than 0.0001 remove couple to avoid problem
% size(shares(shares(:,2)>0.0004,2))
% size(shares(shares(:,1)>0.0004,1))
% size(outside(outside(:,2)>0.0004,2))
% size(outside(outside(:,1)>0.0004,1))
% size((shares(:,2)>0.0001))
% size((shares(:,1)>0.0001) )
% size((outside(:,2)>0.0001))
sharestemp =shares((shares(:,2)>0.0001) & (shares(:,1)>0.0001) & (outside(:,2)>0.0001), :);
J = size(sharestemp,1);
outsidetemp = outside((shares(:,2)>0.0001) & (shares(:,1)>0.0001) & (outside(:,2)>0.0001), :);
%beta=[alpha c bp];
p = 5;
cost = cost((shares(:,2)>0.0001) & (shares(:,1)>0.0001) & (outside(:,2)>0.0001), :);
Dur1 = Dur1((shares(:,2)>0.0001) & (shares(:,1)>0.0001) & (outside(:,2)>0.0001), :);
Dur2 = Dur2((shares(:,2)>0.0001) & (shares(:,1)>0.0001) & (outside(:,2)>0.0001), :);
P1   = P1((shares(:,2)>0.0001) & (shares(:,1)>0.0001) & (outside(:,2)>0.0001), :);
P2 = P2((shares(:,2)>0.0001) & (shares(:,1)>0.0001) & (outside(:,2)>0.0001), :);
lambda = lambda((shares(:,2)>0.0001) & (shares(:,1)>0.0001) & (outside(:,2)>0.0001), :);
gamma = gamma((shares(:,2)>0.0001) & (shares(:,1)>0.0001) & (outside(:,2)>0.0001), :);
X1= [cost (0.5*Dur1+gamma.*Dur2).*ones(J,1) P1  lambda.*(P1-P2) zeros(J,1)];
X2= [gamma.*lambda.*cost gamma.*lambda.*Dur2.*0.5 gamma.*lambda.*P2 zeros(J,1) gamma.*(ones(J,1)-lambda).*(0.5*Dur1+gamma.*Dur2)];
% X1 = X1((shares(:,2)>0.0001) & (shares(:,1)>0.0001) & (outside(:,2)>0.0001), :);
% X2 = X2((shares(:,2)>0.0001) & (shares(:,1)>0.0001) & (outside(:,2)>0.0001), :);
shares  = sharestemp;
outside = outsidetemp;
availlambda = lambda;

%=========================================Prepare data and run OLS========================

shares_n=reshape(shares',J*2,1); %stack shares on top of eachother
outside_n=reshape(outside',J*2,1); %stack outside share
shares_n=max(shares_n,1e-50);   %As a precaution
outside_n=max(outside_n,1e-50);   %As a precaution

%Check Quality of Data simulated: test how share are separated
% sum(uij1s2>uij2s2)
% sum(uij1s1>uij2s1)
% check parameter difference 
%disp([pi bpd alphapd betard])
size(shares)
% size(outside)


% filter X to only those selected


X=[X1 X2]';
Xn=reshape(X,p,J*2);
Xn=Xn'; %stack X's
Yn=log(shares_n./outside_n);


%OLS

betas=inv(Xn'*Xn)*Xn'*Yn;
errors=Yn-Xn*betas;
vcm=(errors'*errors)*inv(Xn'*Xn)/(2*J);
se_est=sqrt(diag(vcm));

% params1=[alpha c bp(1,1) alphap(1,1) betar(1,1)];
% params2=[alpha c bp(1,2) alphap(1,2) betar(1,2)];

disp('restimates is for the first segment (regression):')
disp([betas'])
disp('estimates is for the second segment(regression):')
disp([betas'])
disp('t-stat is:')
disp([betas'./se_est'])
se_est';

betas   =  betas';
se_est  =  se_est';
a_e     =  betas(1,p-4);
c_e     =  betas(1,p-3);
bp_e    =  betas(1,p-2);
tt1_e   =  betas(1,p);
betar_e =tt1_e/c_e;
STEFOC=[1/c_e -tt1_e/c_e^2];
ParamCovar =vcm([p-4 p],[p-4 p])*(2*J);
betarSTE=sqrt(STEFOC*ParamCovar*STEFOC'/(2*J));
disp('Result of simple regression for alpha, c, bp, alphap, betar is for the first segment:');
disp([betas(1,1:p-1) betar_e]);
disp('t-stat are:');
disp([betas(1,1:p-1)./se_est(1,1:p-1) betar_e./betarSTE]);
disp('Result of simple regression for alpha, c, bp, alphap, betar is for the second segment:');
disp([betas(1,1:p-1) betar_e]);
J


%==================================MPEC EStimation of the static model on the simulation data===========================================================
%check real likelihood
%delta = zeros(1,2*J);
%start with real parameter
%delta =deltareal(:)';
% test GA:
%X0=[log((1/0.973176799194654)-1),log(0.458100329684134),1.73915018559787,0.958730923600936,1.75109759752376,2.02472789213327,1.17925873423034,1.62696544394604,1.99593476684710,1.92666252863839,1.90236913094135,0.779522920463007,0.840115173883619,1.23369933453394,1.72241560332553,2.21665188983408,1.94961294393532,1.38600165865365,0.790499430554159,1.15247037174087,1.48100966168744,2.10872756858267,1.99264555417457,2.21446858841210,2.94247655583381,1.58725573844529,2.33660781456627,3.29270684874929,1.75802258303929,2.37231254615452,1.55353818988320,1.46562215943815,1.65413818638787,1.77174176987254,1.04650400771738,1.13963426819110,0.966819471227466,1.53537851449505,3.42885027296881,2.31348882556127,2.58513936961783,2.85498421546715,1.98785137456042,1.36178766068156,0.442718418367414,2.02308286170947,3.03146096438780,3.01806470421272,1.79997708455222,2.04851884173024,1.61739946552193,0.973145558915336,2.05721836865145,1.96366635536948,0.915151312947871,3.51790962448774,0.761178054261447,3.49662812485492,2.82796719083943,1.98470355761471,1.57037274821035,2.04762156194618,2.51734540972677,2.71111523904897,0.797005030782306,4.07925626360434,2.21378415594381,2.97652865694410,2.87365031612178,1.81000963007788,2.45030907454181,1.91102752031219,1.10910205130334,1.90417306735263,0.729838143998004,1.22110084824516,2.39664490682707,1.00131028254444,1.85774284575754,1.47787623961672,0.599190561705108,1.43117415112098,0.983420172449438,1.44060168080038,0.656062247850764,1.65818680360696,2.08531574994567,0.203229787413866,0.844103948752915,0.956034562758160,1.36455755902280,1.26944175982818,1.32691464078670,1.76162787701797,1.83068984988591,1.96529183375134,1.51928285566972,1.25767775104305,1.79384765219583,2.71186171563489,2.27264678767457,1.35781543142376,1.61423259254170,1.75970377387150,2.55612710205472,1.48133944114504,1.43931441721192,2.15471237267872,2.71538705607903,1.61371587838733,2.36625046237883,1.47567409249312,1.98236983774710,1.75028449640268,1.51487051182502,1.90517604423102,1.31477871735906,1.43316394292240,1.48717912017159,2.48472568599264,1.99451428181600,1.14323640615123,1.96338472309874,1.05668854135991,2.74735535453693,2.51682914592151,3.81448096284569,1.31986802376171,1.01176430118682,1.42871287517531,0.704893800406429,1.28746719529406,1.88483176550649,2.16503193558642,2.37386260227180,1.20137002891308,2.45073254051693,3.62307688284418,3.23524001423516,2.46444924164234,1.82638569320418,1.46831168868501,1.70285572737894,2.91685875725942,1.97189431716935,1.25135077194593,1.39483643134946,1.74334044592578,1.95628796994816,1.88473485191902,3.27704150659714,2.13138343991148,2.81371488853356,1.84402379347654,2.65150064890301,2.67718059571282,1.93660232803169,2.30379547851652,1.87526315350331,1.58922367609769,1.64814924687343,0.886016218191462,2.72578473496440,1.81266026182212,1.22970190637540,2.30319659186055,3.63280512290543,1.75821661669695,1.80398179844850,3.09743964394203,4.51359918759739,3.29600029361071,3.53813774104846,1.92540125733992,2.06275170285402,3.25456360299864,1.75392338653652,1.43421283769521,1.89553067535238,1.02103570887203,0.855737088473803,2.20777311607934,1.64278900373617,1.69014517168488,1.54626726621637,1.68283476989752,2.44073088508542,1.84073478947745,2.03007604668720,1.46771243938533,2.99850535611119,3.78584773450036,2.39149182074185,1.99875451245194,1.38651104000567,1.85930036034125,2.37246794715044,2.23759909411292,2.02424997992063,2.38282932974805,1.36107518185165,2.59038517113868,2.04713970103650,2.00835768868987,2.20643765564688,1.90966653874868,1.07533002036519,2.23197381476294,2.23322392488843,3.09045436762609,0.971749584508300,1.66962685852464,2.29862390054035,2.59703302962160];
%X0=[log((1/0.973176799194654)-1),0.458100329684134,1.73915018559787,0.958730923600936,delta];
%X0 = [log((1/99.8104207578402)-1),37.1441536956521,41.8029939670832,38.4308102576456,28.1938431953876,33.9170393580197,39.0470230916854,32.6738288057108,38.7392863180154,41.5983135726800,29.6274975275869,36.3945633065582,41.0353310577493,32.8280810254830,36.9170634036272,26.9989813669926,37.7318464138090,28.4417820860123,29.5259404442269,35.6507053837399,34.0597155854271,46.6076954805852,33.5700549087032,29.3712353233684,36.4184389700258,39.3331779253440,29.8488504544472,53.7756787920869,51.1681283586840,32.8209557195195,41.6616012579243,34.6631381911267,37.1881263018224,33.1146435692256,34.5004047066663,45.3196483155958,39.5575306274252,32.0830571284035,32.7623203619937,30.2726100818395,51.3860044337102,31.8588791677480,40.6410555966088,34.8269160201690,44.6881736927943,34.9144088684448,36.9472480612329,29.6550093354252,39.5882587520570,37.1808710423417,41.4347232593342,26.4987385336757,33.9891751512757,35.2135026527525,38.7926997851328,53.8638997216762,32.7246280268231,36.9170631804419,38.7056895556704,38.0561201736418,39.2715137956105,32.5066843357091,42.4691726589452,33.8462660242954,38.4041906272541,41.0018173990802,35.3467278682088,49.9152699618885,34.0800448157336,29.9105833757286,38.2972342301771,49.3048702953317,40.9407640350172,37.1391979938627,34.3081664712075,33.6501843807322,30.1090642458371,36.3807229351782,38.9913120229322,47.7255079460351,36.0335751951681,36.3591177471532,33.7531456691895,41.7793577188208,41.5553511540094,28.9222766956544,34.7197872781896,33.8882557750368,38.4515685217790,32.7585066431652,36.2800003731544,30.9436301900073,32.2025364247183,38.6963457765761,39.6441068330184,33.4769520239707,31.1718825135653,30.4279279605619,33.7275396034011,39.4511146876934,32.3370830607018,39.8517851899549,30.4680304283944,31.6410547062138,38.6732122415894,49.4218487611544,36.4128721791482,39.7533165488082,34.1774551079069,52.7901075102991,35.0339622784896,41.7744922916074,48.1568571887576,41.5401732864686,33.2384122390078,39.2958404306449,36.5127416118912,46.3866914760270,39.4266063324411,43.4906289575509,42.0608599408642,36.0571789074158,34.9423202700759,41.3662881159975,37.5458321179191,38.0754175033566,34.8319953953712,43.5887968279728,42.2983592844897,34.1286211434724,33.8471741910036,39.7802865265807,37.5952266721587,32.2031303818987,51.7139269993277,36.4717692977697,45.7184325004339,25.8457307445421,41.3940465696772,43.3873547444816,40.4771357197801,44.3070223601022,50.0376460195753,37.9075055676312,34.0200691396314,33.4029912278250,42.0809808315890,30.8420836118795,32.9168615542340,35.0568431563109,28.1685018776582,38.6004668140216,39.7791568480353,37.7644315547491,30.1649355069538,30.5203118369883,33.4852479302877,41.2537293087607,36.0314287259312,31.0146169436130,36.6803234321433,37.4784522788693,40.4160426331230,47.5998052908565,33.3813669194867,45.2679271130837,46.1015677396077,36.2775155950156,22.1302449634058,32.6262535933541,48.2675256885800,33.5183697041663,29.9589491089848,37.0745418166880,46.4174702627222,40.0789670448047,35.4507358350491,30.2692555099835,29.2929981688878,44.0951866484309,28.9314956260347,34.7377403965096,36.3410425201262,30.3541482867551,30.9941238789971,40.5775837313231,40.0457895202775,35.1879026419647,35.0418659579972,26.6835911571249,40.8960614624823,38.9828473925710,42.7200544472710,27.1546542785676,39.6582437841090,47.5519280449298,41.6932837192572,42.8011636972989,34.3248010599848,32.7475584024555,36.3192079664632,44.6198387720648,28.6975484174112,35.7122400254695,40.7565410669627,40.0769951979732,27.9244467685572,35.3871788166260,38.2157424302753,34.3918938294793,35.4257997931306,36.2190330215702,36.8451471889735,47.4321190350939];

%X0 = xresultGA;
%GA result with fvalue =  -2.2337e+04, multiply to 0.9999 in order to
%provide perturbation
%X0 = 0.8*[87.1157077392189,41.2563117887399,36.4551672813811,27.9676849427083,27.5283504189061,35.9036453382758,34.9017314032687,41.6164073834011,32.2055010435786,30.3807504430154,37.5373460318563,43.4616457191955,35.5753508316925,43.2171674505994,29.8335317490799,39.6696299502307,28.2857096038419,46.0916196196583,33.5217597642561,34.8661921341289,36.7589232497040,38.0445012438241,36.7536319350584,32.4729321779552,42.7965385800894,34.5653332140634,28.3458881868571,34.2425000144742,40.0739434350637,41.2600601725355,43.0439525809023,32.4953642713684,31.9875157993143,43.4136693725051,40.9247152790229,39.9017517965313,36.5140381546436,37.0917229492860,41.8395879572961,31.6052112694082,30.1688877082786,31.7762190831093,41.0871858732717,34.4756081676427,47.0739984923140,36.5204241069213,38.1560411505006,35.5589430066646,31.3560822057082,43.0749647664799,31.1115733032871,36.1319216792750,35.4439918831243,41.5253429874756,38.1788199528051,34.3326924671673,35.1355034880756,25.3404152189325,47.1639645787521,40.9437805607413,33.4148777613948,29.9314841445528,31.7890313050630,33.6443219670411,36.4211490550464,25.9435489584221,47.8328825405957,41.9008228953120,38.9373830062454,32.5838284145965,37.2311433683442,37.4392841274599,43.8589559895383,34.6427955765133,39.4220267786765,32.6919967061371,36.6734694784705,41.2614877815026,30.1722602424717,36.6821312870267,36.9427981459885,36.5251210557141,44.4801003173446,32.1258527686226,29.8040889891510,39.7518766848674,43.5561490925437,36.8834823418939,36.8504529620215,32.6022815650807,31.2352834170112,38.3958211334765,38.1885021332809,38.7504542291109,28.0765220835269,29.3382465877404,37.6511573642965,48.4453375537209,41.1215154007316,32.0977495144241,33.0156291551105,40.0897777174965,42.6780316246841,26.0918033948825,39.6549980802467,37.8346606550540,38.1125547733613,43.6487304102987,31.7568290300030,51.5253352445695,33.5297797228055,42.6701979613343,33.7327126068497,41.9122162010274,44.0807069819166,27.0147927216174,26.6662588037382,37.4052287634040,24.9528958873578,40.3953789547760,23.7644592470274,39.7457837688488,30.9132938326977,46.3544115900411,38.7171057430052,38.6992872521023,34.3362332751898,36.9674843153055,39.7150044561134,39.3376358647486,45.4345474101792,42.3062874234118,34.6525574060093,31.4347976716224,30.3321265670024,35.3270517077711,32.2044392514882,38.4278220205131,32.8214261022193,37.2705591052276,29.1003278812828,30.8453148910182,36.3925247181223,36.3391529584526,36.9290250405786,35.3392037021987,43.1544507357631,26.7354827880964,38.9765540391087,35.1096137784346,35.2871823292134,44.8500941610354,47.8482406871907,53.7703421310808,32.7412166021506,43.2288681687419,25.9610380430089,31.9103876696520,36.3698210092527,32.1856834386191,37.6442038655941,42.1958990152181,43.0420319650558,37.4012295384091,35.5196010919235,51.3865807624680,36.9865636993055,25.5695137530931,34.3199002386452,35.0227106621989,44.5176283704826,39.0482314795661,30.2449300207283,40.2156358384858,36.5562737202779,28.3730437134933,36.7520173509473,24.7925255236031,27.6780161839823,27.4492551194319,46.1530423947099,42.6837514041805,33.1067390747943,37.6809489872469,28.6570507236218,32.1016401938463,41.0419088194644,32.2913494558297,30.9976920508208,45.8962798799786,31.1371221898173,29.2747005138088,40.5946415574064,29.8124854520175,34.8641635641122,42.4753849049293,36.6367275658307,42.8072825464437,33.4462753636671,39.6471420256015,37.3358469340763,38.8210564271933,35.7723328570715,30.8411212364318,31.4161367087251,40.9321774936294,42.9351727485383,35.9970236182720,43.4019200299466,33.0977094618601,36.0476312086541,35.3651828480516,38.2243490289096,28.1125995116543];
% result of previous randomization maximum, 
% without purterbation:starting with this gives 2.22e3
% purturb 1.01:  2.2539e3
% perturb 1.02:  2.2786e3
% perturb 1.03:  2.3031e3
% perturb 1.04:  2.3280e3
% perturb 1.06:  2.3778e3
% perturb  1.0625: 2.3839e3
% perturb 1.063: 2.385e3
% perturb 1.064: 2.3876e3
% preturb 1.06425: 2.3882
% after that discontinuity
%X0=1.06425*[0.693964476687669	-14.1361332151285	1.04382210562182	1.86814499318988	15.8835356597127	10.4576392408176	1.48377084331435	-3.85824092350348	-0.367120792124107	29.7615625128982	2.80886263282092	4.64203013123230	-7.75833414029373	-5.58776315492222	-0.716615982383409	1.04794880508142	-8.41510709420183	0.731254343186938	14.0404382710999	1.17125350763822	5.01128803152794	-5.89880897027754	-25.1976135451440	17.5675569788081	0.270269238625845	0.306758156716237	3.02118353331469	25.6207069952313	8.68967023205604	-2.34976062318971	-3.39997642365265	4.04266057607592	-4.47798431845153	-2.54486621209012	16.5582824251566	13.0669005883367	0.714948081158390	19.3453504640626	3.65343059102103	-3.36216561274444	-6.52968532746419	-13.6136632842949	10.9936945790849	6.10420036961368	-14.6804965029986	-11.9342497656955	-13.2000625698461	-6.92610331318755	-10.0722626985512	-9.52589306338638	12.1379753924466	34.9591000477725	-14.1781433111888	2.41729522877097	-2.43700655261529	11.6563873778268	4.56968178259531	15.2623958049270	7.44592059105442	7.38514805636527	29.3849318276725	-18.0164786658917	-3.51305645930264	13.3391256544520	13.7126640576171	-3.13855756133987	28.1709044355674	1.43314929446935	17.4576066048680	-3.70437304063103	-1.85839307593344	-14.8819578098874	1.66926521874068	19.8278541550849	4.67546681035110	-5.45330632975776	17.4472193267949	1.04311476586473	0.663483453002859	8.98505805119633	22.0695339914173	2.35138336029736	-2.88488688596635	-0.166182391685327	19.4838629576620	11.9595191230570	-4.21582147585051	2.21494015137556	30.8293604873773	15.6074625580432	-5.47075212738086	-4.36881726133730	9.99794077883425	4.94883482067153	-19.0594694925146	22.4828036395017	-2.51477256696005	14.1707750004603	30.6524995292902	-4.99189217566681	6.36497586512191	-5.00041160550133	-21.3618843833165	11.2373311345080	-1.24842181536727	25.8071523734436	-4.47723589001173	3.50384501019326	-6.08768321942120	-10.2907489297675	-8.45285061015145	-15.6299144651876	-2.94634611175449	0.151577471574313	-4.33208036281519	0.154699005188887	10.9401388889319	17.8978901066840	-0.731633334990610	4.31805415476134	11.7218591721191	14.2952255435207	-14.6727165626546	-0.301077274037923	-15.7715153353810	-19.7688737201692	19.9261918623398	-0.265478382017939	13.7352550721236	-17.3906783304425	3.41794287734809	-1.05196209930708	9.17142580979188	-12.9126796863912	0.317193124721855	-2.42796497761699	-6.80369076779978	-23.6917178526618	-1.52878495934011	-7.32305872213736	-3.93172271016757	-2.26316861461419	-3.58518400182158	3.06459668932164	-1.18897586091556	10.9672143685029	-6.15677187736647	-2.55178228446006	8.59239269149604	11.3162778790579	10.6452022768358	-18.9780398576346	11.1774267024844	-7.12137190429450	12.2787792377864	-2.35358520982702	-14.5360345036664	3.64377381004416	0.911950541657257	-19.8064484872546	8.72197655493816	-5.55985815856477	3.11384145693850	28.6379300813998	3.79299737915371	-12.5152108497248	-17.8147727558793	11.0468830862899	-0.854923334859859	-2.09273535685895	-17.7643794348960	6.50746562792071	-11.0522287432531	-6.23538647264826	8.44076947788218	2.69793462190444	10.6147734366161	-10.5557663291762	-1.37625044334665	-11.0929671526674	-3.36036746783125	3.99390786709941	16.4457917738099	-3.66867954056148	-6.20678712727923	-1.88844865425231	-9.60838689269316	-1.55759784633425	2.88211075790629	-7.70989992402082	-7.20704241417253	-33.4194457442529	-3.14490108369247	18.9503640941991	-6.80716265422067	-13.9065470300147	6.63964320900925	10.9294608848931	9.92114586538473	4.58852079922614	-5.15647142167556	-0.0546136821991948	-418.218942858022	-10.3531788127738	-16.9438030518672	5.80805089866559	14.2164352735279	0.175316533739684	-5.72500107628223	12.0504740313059	-5.67925989458287	0.430845722819266	20.7607803464577	0.100360445342465];



% create starting values for delta and optimization function


% %constraint on probability only for now
% lb = [-Inf,-Inf,-Inf(1,2*J+2)];
% ub = [+Inf,0,Inf(1,2*J+2)];
% X0(2) = -abs(X(2));
% %setting options
% options  =  optimset('fmincon');
% options = optimset(options,'Algorithm','interior-point','Display','Iter','TolCon',1e-35,'TolFun',1e-25,'TolX',1e-35);
% options = optimset(options,'MaxFunEvals',1e15,'GradObj','off','GradConstr','on');
% options = optimset(options,'MaxIter',1e15); %This keeps the previous options
% [xnew,fval,exitflag,output,lambda,grad,hessian] =fmincon(@(x)0,X0,[],[],[],[],lb,ub,'shareconstraint',options);
% X0 = xnew;
%setting options
% options  =  optimset('fmincon');
% options = optimset(options,'Algorithm','interior-point','Display','Iter','TolCon',1e-35,'TolFun',1e-25,'TolX',1e-35);
% options = optimset(options,'MaxFunEvals',1e15,'GradObj','on','GradConstr','on');
% options = optimset(options,'MaxIter',1e15); %This keeps the previous options


% use starting point found by BLP
delta=[ 2.593664740118618   2.343356819514873
   1.907265249749331   2.219795274597620
   2.048372803829352   2.271564212337704
   2.190578157419271   2.487492355871354
   3.113711653130107   2.787675745838864
   2.468174945956107   1.876672398544790
   2.119565465465821   2.051343108977823
   1.672111915323338   2.152251728385885
   1.693281260085928   2.300527126488776
   1.944066829351350   2.123634679051687
   2.417761434375201   3.212177566618839
   3.032287907758485   2.678318349183425
   1.839865889361414   0.664005908534915
   2.488010059969347   3.048081768035462
   2.475254867327812   2.663288214694370
   0.762062081306160   2.707330690644201
   1.494747121666509   2.667767205594954
   1.074242848099976   3.278387868280769
   3.109709263691046   2.240659246183294
   3.298505037964921   1.737640529977555
   3.338346563219628   1.112013901725338
   3.135404544952765   2.039635963768098
   3.055749369572788   1.607330215881200
   3.183862621395280   1.207447033838861
   2.544654102497112   2.931499445096011
   2.820846074225802   2.737533512549630
   2.588799701206948   2.112732072189834
   1.839733060534749   2.897533156249875
   0.774983217395294   3.243779947603364
   1.395886087423255   3.137330625465036
   1.502570433178064   3.126627799575768
   2.296956774639110   2.946941967411042
   2.221690844497596   2.717075283775209
   2.803640296593615   2.903618707616491
   2.975223498664985   2.261752845133126
   2.007204135259532   1.483133284743520
   3.062944021223423   1.169951862282662
   2.476540260415820   0.154889256246953
   2.940431439353461   2.559329889030340
   2.398369142869638   2.996862742466970
   0.944229552611818   2.433763537820397
   0.962130981762013   2.482162306480528
   3.060189345131259   1.823444659224764
   2.211092744856318   1.871916960784078
   1.919347795231024   1.873190366237391
   1.707381374274988   2.345172068157992
   1.806408327867496   2.990599123241394
   1.692340782183365   2.642079448125061
   1.959817263749257   2.168018268531032
   2.181427992004526   1.972717052223810
   1.781140576260636   2.451060906210765
   3.542671751726315   0.335109686758388
   2.371075580145051   2.404182913686696
   2.295453850822415   1.159416094295324
   4.001415645335383   2.701558179658903
   2.234410904960074   1.190763483876313
   1.698811935412816   2.464039998148289
   1.246124311633912   3.165009632983821
   4.886299565800121   3.896080572438556
   1.697739103315640   0.308711255300088
  -0.575567878231502   2.606010805959879
   2.258751992797349   2.719935975149460
   1.587615462558009   2.822196111970186
   1.445352306709987   2.050930230210046
   2.475416825536622   1.131972459962794
   2.096308754313883   2.275171731964635
   1.834365204233789   2.722678392128175
   2.707723590219833   2.460398488124506
   2.608934406003021   2.859047560789717
   1.549848171772898   1.428028564091574
   2.600363192497539   2.806347123528922
   2.509584317534970   1.993667268745891
   2.449425165423347   2.118068029468905
   2.062989130445694   2.653141642241199
   2.499100284993022   2.211969997579795
   2.851078916690718   2.850311280205645
   2.128856223595774   3.164335472735047
   2.153631383998628   3.239805304682063
   1.865961324156024   2.787023832998342
   2.202606336467551   2.761796103010257
   1.425106162549661   2.229337358562785
   1.446958757002977   2.982171399816846
   0.302709343914157   2.811996951829806
   0.364617124942874   3.206086855589900
   1.473418675117094   2.685547781366854
   2.561120836306233   2.913315940174313
   2.689404222174268   3.130669276453388
   1.451973787838375   2.630950586274512
   1.079336527060893   2.080347027932418
   2.712670257171387   2.922514234978892
   2.471139283922778   3.017517814791505
   2.296428862938436   1.461569788134252
   1.230902263114122   2.454280159449747
   2.061896460470162   2.874627684971289
   2.488978669857324   2.643371275414564
   3.054534457405462   2.381274599661354
   2.961299705118171   2.453317236007889
   2.494945908363166   2.073436629056041
   2.389786691158308   2.993403005249759
   2.497760650408589   2.947359630998148
   2.356547749738223   2.901132509976040
   1.979666155497892   1.255453155363056
   2.293088941929502   2.440472447362176
   2.561890428277332   2.634510673898283
   3.110522815766676   2.889851453597855];
X0=[ 1.530291022330786 -21.484713882079134  -0.500000000000000  -6.818972394649697 delta(:)'];

%constraint on probability only for now
delta = 0.01*randn(1,2*J);
X0=[0.5 -1.7 0.7 -1 delta]; %starting from correct point
X0 = -0.5*ones(1,2*J+4);
[c,ceq]=shareconstraint(X0)
format long
FuncMPECIdentificationBLPWithReg(X0) %  -1.8741e+03
clc

lb = [-Inf,-Inf(1,2*J+3)];
ub = [+Inf,Inf(1,2*J+3)];
X0(2) = -abs(X(2));
options  =  optimset('fmincon');
options = optimset(options,'Algorithm','interior-point','Display','Iter','TolCon',1e-13,'TolX',1e-13);
options = optimset(options,'MaxFunEvals',1e15);
options = optimset(options,'MaxIter',1e15); %This keeps the previous options
[xnew,fval,exitflag,output,lambda,grad,hessian] =fmincon(@(x)0,X0,[],[],[],[],lb,ub,'shareconstraint',options);
X0 = xnew;
%[ce,ceq]=shareconstraint(X0)
%setting options


options  =  optimset('fmincon');
options = optimset(options,'Algorithm','interior-point','Display','Iter','TolCon',1e-13,'TolFun',1e-13,'TolX',1e-20);
options = optimset(options,'MaxFunEvals',1e15);%,'GradObj','on','GradConstr','on');
options = optimset(options,'MaxIter',1e15); %This keeps the previous options

[x,fval,exitflag,output,lambda,grad,hessian] = fmincon('FuncMPECIdentificationBLPWithReg',X0,[],[],[],[],lb,ub,'shareconstraint',options);
x = X0;
betas = [-0.000144185381460   0.073324832892292   0.009269501699468  -0.031432523407112   0.190013318693815];
hessian = MPECHessian(x);
%x(1)= 1/(1+exp(x(1)));
%x(2) = -exp(x(2));
disp('estimation time is:');
toc;
p       =  5;
betas   =  betas';
se_est  =  se_est';
a_e     =  betas(1,p-4);
c_e     =  betas(1,p-3);
bp_e    =  betas(1,p-2);
tt1_e   =  betas(1,p);
betar_e =tt1_e/c_e;
STEFOC=[1/c_e -tt1_e/c_e^2];
ParamCovar =vcm([p-4 p],[p-4 p])*2*J;
betarSTE=sqrt(STEFOC*ParamCovar*STEFOC'/(2*J));
disp('Estimation of First Segment alpha, c, bp, alphap, betar is (for the first segment):');
disp([betas(1,1:p-1) betar_e]);
disp('t-stat are:');
disp([betas(1,1:p-1)./se_est(1,1:p-1) betar_e./betarSTE]);
% nonlinear parameters
ste = diag(-inv(hessian));
ste = sqrt(ste);
trat = x(1,1:3)./ste(1:3,1)';
tth1_e=x(1,4);
betarh_e =tth1_e/c_e;
STEFOCh=[1/c_e -tth1_e/c_e^2];
ParamCovarh =diag([vcm(p-3,p-3) ste(4,1).^2])*(2*J);
betarSTEh=sqrt(STEFOCh*ParamCovarh*STEFOCh'/(2*J));
disp('parm estimates for heterogeneity param of second segment (pi,bp,alphap,betar) are:');
disp([x(1,1:3) betarh_e])
disp('t-stat for the heterogeneity parameter is:');
disp([trat(1,1:3) betarh_e./betarSTEh])
tstatresult = [trat(1,1:3) betarh_e./betarSTEh];
% disp('full parameter for second segment for (pi1 a c bp alphap betar) are:');
% disp([pi1 alpha c bp(1,2) alphap(1,2) betar(1,2)])
% disp('t-stat for the heterogeneity parameter is:');
% disp([x(1,1) betas(1,1:2) betas(1,3:4)-x(1,2:3) betar_e+betarh_e])
%disp('full parameter for second segment for (pi1 a c bp) are:');
%disp([pi1 alpha c bp(1,2);exp(x(1,1))/(1+exp(x(1,1))) betas(1,1:2) betas(1,3)-x(1,2)])

LL=-fval;
AIC = 2*p-2*LL;
BIC = -2*LL+p*log(J);
disp('Log Likelihood, AIC, BIC is:');
disp([LL AIC BIC]);


%check likelihood
disp('the likelihood for the real original point')
-FuncMPECIdentificationBLPWithReg(X0)


%------------------------------------GA for the data--------------------------
%options = gaoptimset('MutationFcn',@mutationadaptfeasible);
%constraint on probability only for now
delta = 0.3.*ones(1,2*J);
X0=[0.5 -1.7 0.7 -1 delta]; %starting from correct point
lb = [-Inf,-Inf(1,2*J+3)];
ub = [+Inf,Inf(1,2*J+3)];
X0(2) = -abs(X(2));
options  =  optimset('fmincon');
options = optimset(options,'Algorithm','interior-point','Display','Iter','TolCon',1e-13);
options = optimset(options,'MaxFunEvals',1e15);
options = optimset(options,'MaxIter',1e15); %This keeps the previous options
[xnew,fval,exitflag,output,lambda,grad,hessian] =fmincon(@(x)0,X0,[],[],[],[],lb,ub,'shareconstraint',options);
X0 = xnew;
options = gaoptimset('Display','iter');
options =gaoptimset(options,'Generations',1e4)
options =gaoptimset(options,'TolFun',1e-12)
% options =gaoptimset(options,'UseParallel','true')
% options =gaoptimset(options,'Vectorized','on')
options = gaoptimset(options, 'TolCon',1e-13);
options = gaoptimset(options,'InitialPopulation',X0);
ObjectiveFunction = @FuncMPECIdentificationBLPWithReg;
nvars = size(X0,2);    % Number of variables
LB = lb';   % Lower bound
UB = ub';  % Upper bound
ConstraintFunction = @shareconstraint;
[x,fval] = ga(ObjectiveFunction,nvars,[],[],[],[],LB,UB, ...
    ConstraintFunction,options)
xga= x;

% check constraint
[ce,ceq]=shareconstraint(xga)


%%----------------------------------------------------------
%==========================Calculate Numerica Hessian at the point of interest===================================================
km= 1e-15;
FuncIdentificationBLPWithRegEffcnt(X0)
f = @(x0)FuncIdentificationBLPWithRegEffcnt(x0);
point =X0(1:4);
hessian(f,point)


%%--------------------------------------------------------





x=xresultGA
%test constraint
disp('constraint satisfaction for the found point:')
shareconstraint(x)
disp('constraint satisfaction for real original point:')
shareconstraint(X0)


%=========================================GA Algorithm for MPEC========================

% genetic algorithm for constraint optimization
% ConstraintFunction = @shareconstraint;
% ObjectiveFunction = @FuncMPECIdentificationBLPWithReg;
% nvars = size(X0,2);    % Number of variables
% [x,fval] = ga(ObjectiveFunction,nvars,[],[],[],[],lb,ub,ConstraintFunction);

% run GA:
%constraint on probability only for now
delta =deltareal(:)';
lb = [0,-Inf(1,2*J+3)];
ub = [1,Inf(1,2*J+3)];
X0=[pi1 bpd alphapd betard*c delta]; %starting from correct point
ObjectiveFunction = @FuncMPECIdentificationBLPWithReg;
nvars = size(X0,2);    % Number of variables
LB = lb';   % Lower bound
UB = ub';  % Upper bound
ConstraintFunction = @shareconstraint;
[x,fval] = ga(ObjectiveFunction,nvars,[],[],[],[],LB,UB, ...
    ConstraintFunction)

xresultGA = x;
shareconstraint(xresultGA)


%============================================BLP========================================

% estimating BLP
shares=max(shares,1e-50);
tic;
%X0= [0.1 0.1 0.1 0.1];
%X0 = [0.3397   -0.1835    3.9435    1.6116]; % GA found point
%X0=[log(pi1/(1-pi1))+0.01 bpd+0.01 alphapd+0.01 betard*c+0.01];
X0=[log(pi1/(1-pi1)) bpd alphapd betard*c]; %starting from correct point
options=optimset('Display','on','MaxIter',10000,'TolX',10^-30,'TolFun',10^-30,'UseParallel','always');
[x,fval,exitflag,output,grad,hessian]=fminunc('FuncIdentificationBLPWithRegEffcnt',X0,options);
%[x,fval,exitflag,output,grad,hessian]=fminunc('FuncIdentificationLikelihood',X0,options);
disp('estimation time is:');
toc;
p       =  5;
betas   =  betas';
se_est  =  se_est';
a_e     =  betas(1,p-4);
c_e     =  betas(1,p-3);
bp_e    =  betas(1,p-2);
tt1_e   =  betas(1,p);
betar_e =tt1_e/c_e;
STEFOC=[1/c_e -tt1_e/c_e^2];
ParamCovar =vcm([p-4 p],[p-4 p])*2*J;
betarSTE=sqrt(STEFOC*ParamCovar*STEFOC'/(2*J));
disp('Result of simple regression for alpha, c, bp, alphap, betar is (for the first segment):');
disp([params1;betas(1,1:p-1) betar_e]);
disp('Result of simple regression for alpha, c, bp, alphap, betar is (for the second segment):');
disp([params2;betas(1,1:p-1) betar_e]);
disp('t-stat are:');
disp([betas(1,1:p-1)./se_est(1,1:p-1) betar_e./betarSTE]);
% nonlinear parameters
ste = diag(inv(hessian));
ste = sqrt(ste);
trat = [exp(x(1,1))/(1+exp(x(1,1))) x(1,2:3)]./ste(1:3,1)';
tth1_e=x(1,4);
betarh_e =tth1_e/c_e;
STEFOCh=[1/c_e -tth1_e/c_e^2];
ParamCovarh =diag([vcm(p-3,p-3) ste(4,1).^2])*(2*J);
betarSTEh=sqrt(STEFOCh*ParamCovarh*STEFOCh'/(2*J));
disp('parm estimates for heterogeneity (pi,bp,alphap,betar) are:');
disp([pi1 bpd alphapd betard;exp(x(1,1))/(1+exp(x(1,1))) x(1,2:3) betarh_e])
disp('t-stat for the heterogeneity parameter is:');
disp([trat(1,1:3) betarh_e./betarSTEh])
disp('full parameter for second segment for (pi1 a c bp alphap betar) are:');
disp([pi1 alpha c bp(1,2) alphap(1,2) betar(1,2)])
disp('t-stat for the heterogeneity parameter is:');
disp([exp(x(1,1))/(1+exp(x(1,1))) betas(1,1:2) betas(1,3:4)-x(1,2:3) betar_e+betarh_e])
%disp('full parameter for second segment for (pi1 a c bp) are:');
%disp([pi1 alpha c bp(1,2);exp(x(1,1))/(1+exp(x(1,1))) betas(1,1:2) betas(1,3)-x(1,2)])

LL=-fval;
AIC = 2*p-2*LL;
BIC = -2*LL+p*log(J);
disp('Log Likelihood, AIC, BIC is:');
disp([LL AIC BIC]);

%===========================================Genetic Algorithm BLP=================================

%genetic algorithm to show identification
FitnessFunction = @FuncIdentificationBLPWithRegEffcnt;
numberOfVariables = 4;
[x,fval] = ga(FitnessFunction,numberOfVariables);
[exp(x(1))/(1+exp(x(1))) x(2) x(3) x(4)]

%Likelihood at the point
X0=[log(pi1/(1-pi1)) bpd+0.1 alphapd betard*c]; %starting from correct point
FuncIdentificationBLPWithRegEffcnt(X0);


%===================================Non Linear case just test===========================
% test nonlinear least square to find a, c, bp, alpap, betar
tic;
YnNLSQ = log(shares)- log(outside);
X0= params1;
[x,resnorm] = lsqnonlin(@NonlinearLeastSquare,X0);
options=optimset('Display','on','MaxIter',10000,'TolX',10^-30,'TolFun',10^-30,'UseParallel','always');
[x,fval,exitflag,output,grad,hessian]=fminunc('NonlinearLeastSquare',X0,options);
disp('estimation time is:');
toc;
params1=[alpha c bp(1,1) alphap(1,1) betar(1,1)];
%genetic algorithm to show identification
YnNLSQ = log(shares)- log(outside);
FitnessFunction = @NonlinearLeastSquare;
numberOfVariables = 5;
[x,fval] = ga(FitnessFunction,numberOfVariables);