/***********************
* SECTION CONSTANTS
*************************/
var IMAGE_BASE ="/Content"
//var IMAGE_BASE ="/" 

var SECTION_MEN = "men";
var SECTION_WOMEN = "women";
var SECTION_BOYS = "boys";
var SECTION_BROOKSBUYS = "brooksbuys";
var SECTION_GIFTCARD = "giftcard";
var SECTION_HELP = "help";

/* This var will be used to take actions like 
light up correct top nav image and show the correct left 
nav ect. */
var currentSection = "";

/***********************
* preload Nav Images
*************************/
MM_preloadImages(IMAGE_BASE + '/nav/images/topnav/nav-men1.gif', 
				 IMAGE_BASE + '/nav/images/topnav/nav-women1.gif', 
				 IMAGE_BASE + '/nav/images/topnav/nav-boys1.gif', 
				 IMAGE_BASE + '/nav/images/topnav/nav-brooks-buys1.gif', 
				 IMAGE_BASE + '/nav/images/topnav/nav-gift1.gif')


/***********************
* setCurrentSection - pass in a section constant
*************************/
function setCurrentSection( sectionConstant )
{
	currentSection = sectionConstant
	lightupTopNav( );
}

/***********************
* Degrade nice for older browser
*************************/
if (!document.getElementById)
    document.getElementById = function() { return null; }
	
	
/***********************
* Debug - Add title to al pages
*************************/
// if (document.all)
// {
//	var detect = navigator.userAgent.toLowerCase();
//	var browser,thestring;
//	var version = 0;

//	if (checkIt('msie')) 
//	{
//		browser = "IE "
//		browser += detect.substr(place + thestring.length,3);
//		document.title = browser + ' - ' + document.title;
//	}
// }

// function metadata() {
//<title>Brooks Brothers - Classically Modern Men's and Women's Apparel</title>
//NAME=DESCRIPTION and casual clothing for men women - classically modern dress shirts, ties, pants, sweaters. Legendary quality customer service are a click away. brother, brook brothers, brooks, brooks boys, brother , brothers clothes, clothing, online, brooksbrothers, brooksbrothers.com, apparel, belt, big & tall, tall blouse, bowtie, business attire, casual, dress, suit, button down oxford, button-down shirt, career chino, chinos, store, designer suits, factory outlet, ladies, men,'s,'s mens menswear, necktie, oxford pant, slacks, sportcoat, Sport Coats, tie, trousers, tuxedo, women, work wrinkle free, www.brooksbrothers.com, blazer, boxer, boxer short, boxers, cashmere, catalog, clearance, crewneck, custom, custom made, shoe, dresses, flat-front, formalwear, jacket, jackets, loafer, merino, non-iron, outlet center, overcoat, penny pima, pleated, polo, polo seersucker, shoes, shopping, sock, sweater, tailored, wool>
//<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
//)


function checkIt(string)
{
	place = detect.indexOf(string) + 1;
	thestring = string;
	return place;
}


/***********************
* setFooterEmailTextToLongVersion - use long decr for email box 
* bottom of the page.
*************************/
function setFooterEmailTextToLongVersion()
{
	//change the footer email text
	var emailText = MM_findObj("emailSpecialsText", document);
	if( emailText != null )
	{
		emailText.innerHTML = "Sign up for our email specials:"
	}
}

function setFooterEmailTextToLongVersionWideBottomnav()
{
	//change the footer email text
	var emailText = MM_findObj("emailSpecialsText", document);
	if( emailText != null )
	{
		emailText.innerHTML = "<img src=/images/spacer.gif width=90 height=1>Sign-up for our email specials:"
	}
}

/***********************
* lightupTopNav - lights up a nav section
*************************/
function lightupTopNav()
{
	if ( currentSection == SECTION_MEN) MM_swapImage('navMen','', IMAGE_BASE + '/nav/images/topnav/nav-men1.gif',1)
	if ( currentSection == SECTION_WOMEN) MM_swapImage('navWomen','',IMAGE_BASE + '/nav/images/topnav/nav-women1.gif',1)
	if ( currentSection == SECTION_BOYS) MM_swapImage('navBoys','', IMAGE_BASE + '/nav/images/topnav/nav-boys1.gif',1)
	if ( currentSection == SECTION_BROOKSBUYS) MM_swapImage('navBuys','', IMAGE_BASE + '/nav/images/topnav/nav-brooks-buys1.gif',1)
	if ( currentSection == SECTION_GIFTCARD) MM_swapImage('navGift','', IMAGE_BASE + '/nav/images/topnav/nav-gift1.gif',1)
}

/***********************
* highlightOutfitImg
* used outfit pages to highlight the current outfit
*************************/
function highlightOutfitImg( outfitNum )
{
	pviiClassNew( MM_findObj("outfitImg" + outfitNum, document) ,'outfitImgHot');
	//pviiClassNew( MM_findObj("outfitTxt" + outfitNum, document) ,'outfitTxtHot');
}

/***********************
* unhighlightOutfitImg
* used outfit pages to unhighlight the current outfit
*************************/
function unhighlightOutfitImg( outfitNum )
{
	pviiClassNew( MM_findObj("outfitImg" + outfitNum, document) ,'outfitImgCold');
	//pviiClassNew( MM_findObj("outfitTxt" + outfitNum, document) ,'outfitTextCold');
}


/***********************
* highlightSectionImg
* used outfit pages to highlight the current outfit
*************************/
function highlightSectionImg( sectionNumber )
{
	pviiClassNew( MM_findObj("sectionImg" + sectionNumber, document) ,'sectionImgHot');
}

/***********************
* unhighlightSectionImg
* used outfit pages to unhighlight the current outfit
*************************/
function unhighlightSectionImg( sectionNumber )
{
	pviiClassNew( MM_findObj("sectionImg" + sectionNumber, document) ,'sectionImgCold');
}

/***********************
* highlightOutfit
* used item detail pages to highlight the current outfit
*************************/
function highlightOutfit( outfitNum )
{
	pviiClassNew( MM_findObj("outfitImg" + outfitNum, document) ,'hotOutfitImg');
	//pviiClassNew( MM_findObj("outfitName" + outfitNum, document) ,'hotOutfitName');
}

/***********************
* unhighlightOutfit
* used item detail pages to highlight the current outfit
*************************/
function unhighlightOutfit( outfitNum )
{
	pviiClassNew( MM_findObj("outfitImg" + outfitNum, document) ,'coldOutfitImg');
	//pviiClassNew( MM_findObj("outfitName" + outfitNum, document) ,'coldOutfitName');
}

/***********************
* highlightColorSwatch
* used item detail pages to highlight the current color
* !!! color drop down box must have an ID="colorDropDownBox" for this to work !!!
*************************/
function highlightColorSwatch( colorId )
{
	var colorTextDiv = MM_findObj("colorText", document);

  if (colorTextDiv != null)
  {
    if( colorId > 0 )
    {
      var colorDropDownBox = MM_findObj("AttributeValueId0", document);

      for (i=0; i<document.OrderByVariant.AttributeValueId0.length; i++)
      {
          if (colorId == document.OrderByVariant.AttributeValueId0[i].value)
          {
              colorTextDiv.innerHTML = document.OrderByVariant.AttributeValueId0.options[i].text;
          }
      }   
    }
    else
    {
      colorTextDiv.innerHTML = "";
    }
  }
}

/***********************
* chooseColor
* used item detail pages to select a color
* !!! color drop down box must have an ID="colorDropDownBox" for this to work !!!
*************************/
function chooseColor( colorId )
{

  var colorDropDownBox = MM_findObj("AttributeValueId0", document);
	var oColor;
	//unhightlight all the boxes
	for(i=1; i < (colorDropDownBox.options.length); i++)
	{
      oColor = MM_findObj("color" + colorDropDownBox.options[i].value, document);
      if (oColor != null)
      {
        pviiClassNew( oColor,'colorCold')
      }
	}	
  oColor = MM_findObj("color" + colorId, document);
  if (oColor != null)
  {
    pviiClassNew( oColor ,'colorHot')
  }
}



/***********************
* doShowOutfit - used on landing pages ( does swaping of outfits on rollover )
*************************/
function doShowOutfit( section, outfitNumber, outfit1Headline, outfit1Subheadline, outfit2Headline, outfit2Subheadline,  outfitLink )
{
	//get the div
	var destinationDiv = document.getElementById('outfitDetailsContainer');
	
	//create the new html
	var newContent = '<div  class="outfitHeadline">' + outfit1Headline + '</div>'
		newContent += outfit1Subheadline;
		newContent +='<div  class="outfitHeadline">' + outfit2Headline + '</div>'
		newContent += outfit2Subheadline;
		newContent +='<div><a href="'+ outfitLink + '"><img src="' + IMAGE_BASE + '/nav/images/buttons/button-shop-this-outfit.gif" width="141" height="18" border="0" style="margin-top:17px;"></a></div>'
	
	//write out the new html
	destinationDiv.innerHTML=newContent;

	//swap out the large picture
	MM_swapImage('mainImage','',IMAGE_BASE +  '/' + section + '/images/' + '/landing/main-large-' + outfitNumber + '.jpg',1);
	
	//turn all borders off on the thumbs
	for( i=0; i <= 3; i++ )
	{
		if( i != outfitNumber ) pviiClassNew( MM_findObj('outfit'+i, document),'featuredOutfitInactive')	
	}	
	
	//light up border on active outfit thumb
	pviiClassNew( MM_findObj('outfit'+outfitNumber, document),'featuredOutfit')	


    /*
	while (destinationDiv.firstChild)
		destinationDiv.removeChild(destinationDiv.firstChild)
	
	var newContents = document.createElement('div');
	newContents.setAttribute('style','color:red');
	newContents.appendChild(document.createTextNode('joe picc'));

	destinationDiv.appendChild(newContents);
	*/

}


var currentHeritageCol = 0;
/***********************
* writeHeritageYearTD
*************************/
function writeHeritageYearTD( headline, text, imgPath, columnNumber)
{
	//save the current col	
	currentHeritageCol = columnNumber;
	
	//unhighlight
	for(var i =1; i <=9 ; i++)
	{
		unhighlightYear(i);
	}
	
	highlightYear( columnNumber );
	
	//swap img
	MM_swapImage('timeLineImg','',imgPath,0);
	
	//set new text.
	var newContent = '<div class="timelineHeadline">' + headline + '</div>';
	newContent += '<p>' + text + '</p>';
	MM_findObj("timeLineText", document).innerHTML=newContent;
	
	
}

/***********************
* highlightYear
* *************************/
function highlightYear( columnNumber )
{
	pviiClassNew( MM_findObj("yearColumn" + columnNumber, document) ,'timeLineYearsTextHot');
}

/***********************
* unhighlightSectionImg
* used outfit pages to unhighlight the current outfit
*************************/
function unhighlightYear( columnNumber )
{
	//dont unhighlight the current col.
	if( columnNumber == currentHeritageCol ) return;
		
	pviiClassNew( MM_findObj("yearColumn" + columnNumber, document) ,'timeLineYearsTextCold');
}

/***********************
* highlightYear
* *************************/
function highlightYearHover( columnNumber )
{
	//dont unhighlight the current col.
	if( columnNumber == currentHeritageCol ) return;
	pviiClassNew( MM_findObj("yearColumn" + columnNumber, document) ,'timeLineYearsTextHover');
}




/***********************
* centerPopUp
*************************/
function centerPopUp(mypage, myname, w, h, scroll) 
{
var winl = (screen.width - w) / 2;
var wint = (screen.height - h) / 2;
winprops = 'height='+h+',width='+w+',top='+wint+',left='+winl+',scrollbars='+scroll+',resizable'

//win = window.open(mypage, myname, winprops)
win = window.open(mypage, myname, winprops)

if (parseInt(navigator.appVersion) >= 4) { win.window.focus(); }
}


function showMenu(menuImage, menuLayer)
{
	
	P7_autoLayers(0,menuLayer,'layerTopCloser','layerMenuCloser');
	P7_Snap(menuImage,menuLayer,0,10,menuImage,'layerMenuCloser',-10,13,'navImgFashion','layerTopCloser',-25,-23);
	//P7_Snap(menuImage,menuLayer,0,13, 'navImgFashion','layerTopCloser',-25,-23);
}

function hideAllMenues()
{
	P7_autoLayers(0);
}


function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

function pviiW3Cbg(obj, pviiColor) { //v1.1 by Project VII
	obj.style.backgroundColor=pviiColor
}


function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}


function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function P7_Snap() { //v2.63 by PVII
 var x,y,ox,bx,oy,p,tx,a,b,k,d,da,e,el,tw,q0,xx,yy,w1,pa='px',args=P7_Snap.arguments;a=parseInt(a);
 if(document.layers||window.opera){pa='';}for(k=0;k<(args.length);k+=4){
 if((g=MM_findObj(args[k]))!=null){if((el=MM_findObj(args[k+1]))!=null){
 a=parseInt(args[k+2]);b=parseInt(args[k+3]);x=0;y=0;ox=0;oy=0;p="";tx=1;
 da="document.all['"+args[k]+"']";if(document.getElementById){
 d="document.getElementsByName('"+args[k]+"')[0]";if(!eval(d)){
 d="document.getElementById('"+args[k]+"')";if(!eval(d)){d=da;}}
 }else if(document.all){d=da;}if(document.all||document.getElementById){while(tx==1){
 p+=".offsetParent";if(eval(d+p)){x+=parseInt(eval(d+p+".offsetLeft"));y+=parseInt(eval(d+p+".offsetTop"));
 }else{tx=0;}}ox=parseInt(g.offsetLeft);oy=parseInt(g.offsetTop);tw=x+ox+y+oy;
 if(tw==0||(navigator.appVersion.indexOf("MSIE 4")>-1&&navigator.appVersion.indexOf("Mac")>-1)){
  ox=0;oy=0;if(g.style.left){x=parseInt(g.style.left);y=parseInt(g.style.top);}else{
  w1=parseInt(el.style.width);bx=(a<0)?-5-w1:-10;a=(Math.abs(a)<1000)?0:a;b=(Math.abs(b)<1000)?0:b;
  x=document.body.scrollLeft+event.clientX+bx;y=document.body.scrollTop+event.clientY;}}
 }else if(document.layers){x=g.x;y=g.y;q0=document.layers,dd="";for(var s=0;s<q0.length;s++){
  dd='document.'+q0[s].name;if(eval(dd+'.document.'+args[k])){x+=eval(dd+'.left');y+=eval(dd+'.top');
  break;}}}e=(document.layers)?el:el.style;xx=parseInt(x+ox+a),yy=parseInt(y+oy+b);
 if(navigator.appVersion.indexOf("MSIE 5")>-1 && navigator.appVersion.indexOf("Mac")>-1){
  xx+=parseInt(document.body.leftMargin);yy+=parseInt(document.body.topMargin);}
 e.left=xx+pa;e.top=yy+pa;}}}
}

function P7_autoLayers() { //v1.5 by PVII
 var g,b,k,f,u,k,j,args=P7_autoLayers.arguments,a=parseInt(args[0]);if(isNaN(a))a=0;
 if(!document.p7setc){p7c=new Array();document.p7setc=true;for(u=0;u<10;u++){
 p7c[u]=new Array();}}for(k=0;k<p7c[a].length;k++){if((g=MM_findObj(p7c[a][k]))!=null){
 b=(document.layers)?g:g.style;b.visibility="hidden";}}for(k=1;k<args.length;k++){
 if((g=MM_findObj(args[k]))!=null){b=(document.layers)?g:g.style;b.visibility="visible";f=false;
 for(j=0;j<p7c[a].length;j++){if(args[k]==p7c[a][j]) {f=true;}}
 if(!f){p7c[a][p7c[a].length++]=args[k];}}}
}
 


function pviiClassNew(obj, new_style) { //v2.7 by PVII
  obj.className=new_style;
}

function P7_swapClass(){ //v1.4 by PVII
 var i,x,tB,j=0,tA=new Array(),arg=P7_swapClass.arguments;
 if(document.getElementsByTagName){for(i=4;i<arg.length;i++){tB=document.getElementsByTagName(arg[i]);
  for(x=0;x<tB.length;x++){tA[j]=tB[x];j++;}}for(i=0;i<tA.length;i++){
  if(tA[i].className){if(tA[i].id==arg[1]){if(arg[0]==1){
  tA[i].className=(tA[i].className==arg[3])?arg[2]:arg[3];}else{tA[i].className=arg[2];}
  }else if(arg[0]==1 && arg[1]=='none'){if(tA[i].className==arg[2] || tA[i].className==arg[3]){
  tA[i].className=(tA[i].className==arg[3])?arg[2]:arg[3];}
  }else if(tA[i].className==arg[2]){tA[i].className=arg[3];}}}}
}


// added for view larger image.
function openLargerView(ProdPage) {
  ProdInfo=window.open(ProdPage,'productinfo','width=665,height=685,resizable=yes,scrollbars=yes');
  ProdInfo.focus();
  // return false;
}

// added for view larger image.
function openPopupX(ProdPage, wid, hei) {
	//alert('ProdPage is - ' + ProdPage);
	alert('w and h are - ' + wid + ' & ' + hei);
	param = 'width=' + wid + ',height=' + hei + ',resizable=yes,scrollbars=yes'
	alert('param is - ' + param);
	
  ProdInfo=window.open(ProdPage,'productinfo', '+param+');
  ProdInfo.focus();
  // return false;
}

function openPopup(mypage, myname, w, h, scroll) 
{
	var winl = (screen.width - w) / 2;
	var wint = (screen.height - h) / 2;
	winprops = 'height='+h+',width='+w+',top='+wint+',left='+winl+',scrollbars='+scroll+',resizable'
	win = window.open(mypage, myname, winprops)
	win.window.focus(); 
}

function removeSpecialCharacters(str) {
  re = /\$|,|@|#|~|`|\%|\*|\ |\^|\&|\(|\)|\+|\=|\[|\-|\_|\]|\[|\}|\{|\;|\:|\'|\"|\<|\>|\?|\||\\|\!|\$|\./g;
  // remove special characters like "$" and "," etc...
  return str.replace(re, "");
}

function capitalize(val)
{
    val = val.toLowerCase();
    newVal = '';
    val = val.split(' ');
    for(var c=0; c < val.length; c++)
    {
        newVal += val[c].substring(0,1).toUpperCase() +
        val[c].substring(1,val[c].length) + ' ';
    }
    return newVal;
}

function setSelectValue(oSelectBox, sSelectValue)
{
  if (oSelectBox.type == "select-one")
  {
      for (i=0; i<oSelectBox.options.length; i++)
      {
        if (oSelectBox.options[i].value == sSelectValue)
        {
          oSelectBox.options[i].selected = true;
          return true;
        }
      }
      return false;
  }
}