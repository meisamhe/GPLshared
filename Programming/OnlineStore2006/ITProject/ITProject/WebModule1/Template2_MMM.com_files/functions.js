function launchthawte() {
	thawteWin = window.open("https://www.thawte.com/core/process?process=public-site-seal-cert-details&public-site-seal-cert-details.referer=https://secure.angusrobertson.com.au","thawteWin","top=0,left=0,width=498,height=567,status=1,scrollbars=0");
	thawteWin.focus();
}

function termsofuse() {
	termsofuseWin = window.open("/system/termsofuse.asp","termsofuseWin","top=0,left=0,width=500,height=500,status=0,scrollbars=1");
	termsofuseWin.focus();
}

function privacypolicy() {
	privacypolicyWin = window.open("/system/privacypolicy.asp","privacypolicyWin","top=0,left=0,width=500,height=500,status=0,scrollbars=1");
	privacypolicyWin.focus();
}

function shippingcharge() {
	shippingchargeWin = window.open("/system/shippingcharge.asp","shippingchargeWin","top=0,left=0,width=400,height=400,status=0,scrollbars=1");
	shippingchargeWin.focus();
}

function welcome() {
	welcome = window.open("/welcome.asp","welcome","top=0,left=0,width=400,height=200,status=0,scrollbars=1");
	welcome.focus();
}

function bookformat()
{
	var screen_height=parent.screen.availHeight;
	var screen_width=parent.screen.availWidth;
	var main_height=parent.window.innerHeight;
		
	h = ((screen_height/2)-250);
	w = ((screen_width/2)-295);
	
	//Book Format Window Pop-Up

	window.open("http://www.angusrobertson.com.au/include/bookformat.asp","bookformatpage",'scrollbars=yes, top='+h+'%,left='+w+'%, width=590,height=400,resizable=no,toolbar=no');
}

function top100info(origin)
{
	window.open("/products/top100info.asp?origin="+origin,"Top100"+origin,'top=0,left=0,width=498,height=567,status=1,scrollbars=0');
}


