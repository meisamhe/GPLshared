function hbxStrip(a) 
{
   a = a.split("|").join("");
   a = a.split("/").join("");
   a = a.split("!").join("");
   a = a.split("&").join(" and ");
   a = a.split("'").join("");
   a = a.split("#").join("");
   a = a.split("$").join(" dollars ");
   a = a.split("%").join(" percent ");
   a = a.split("^").join("");
   a = a.split("*").join("");
   a = a.split(":").join("");
   a = a.split("~").join("");
   a = a.split(";").join("");
 //a = a.split(" ").join("+");
   a = a.toLowerCase();
   return a;  
}

function hbxstripproductpage(a) 
{
   a = a.split("|").join("");
   a = a.split("/").join("");
   a = a.split("!").join("");
   a = a.split("&").join(" and ");
   a = a.split("'").join("");
   a = a.split("#").join("");
   a = a.split("$").join(" dollars ");
   a = a.split("%").join(" percent ");
   a = a.split("^").join("");
   a = a.split("*").join("");
   a = a.split(":").join("");
   a = a.split("~").join("");
   a = a.split(";").join("");
 //a = a.split(" ").join("+");
   a = a.split(",").join(" ");
   a = a.toLowerCase();
   return a;
  
}

function hbxstripcustom(a) 
{  
   a = a.split("/").join("");
   a = a.split("!").join("");
   a = a.split("&").join(" and ");
   a = a.split("'").join("");
   a = a.split("#").join("");
   a = a.split("$").join(" dollars ");
   a = a.split("%").join(" percent ");
   a = a.split("^").join("");
   a = a.split("*").join("");
   a = a.split(":").join("");
   a = a.split("~").join("");
   a = a.split(";").join("");
  // a = a.split(" ").join("+");
   a = a.split(",").join("");
   a = a.toLowerCase();
   return a;  
}



function hbxStripCustomCat(a) 
{  
   //a = a.split("/").join("");
   a = a.split("!").join("");
   a = a.split("&").join(" and ");
   a = a.split("'").join("");
   a = a.split("#").join("");
   a = a.split("$").join(" dollars ");
   a = a.split("%").join(" percent ");
   a = a.split("^").join("");
   a = a.split("*").join("");
   a = a.split(":").join("");
   a = a.split("~").join("");
   a = a.split(";").join("");
   a = a.split("BrooksBr...irectory/").join("");
   a = a.split("/brooksbr...irectory").join("");
   a = a.split("/countryc...tsshorts").join("");
   a = a.split("/CountryC...tsshorts").join("");
   a = a.split("...").join("");   
  // a = a.split(" ").join("+");
   a = a.split(",").join(""); // remove commas
   a = a.toLowerCase();
   return a;  
}

function hbxCategory(a) 
{  
   //a = a.split("/").join("");
   a = a.split("!").join("");
   a = a.split("&").join(" and ");
   a = a.split("'").join("");
   a = a.split("#").join("");
   a = a.split("$").join(" dollars ");
   a = a.split("%").join(" percent ");
   a = a.split("^").join("");
   a = a.split("*").join("");
   a = a.split(":").join("");
   a = a.split("~").join("");
   a = a.split(";").join("");
   a = a.split("BrooksBr...irectory/").join("");
   a = a.split("/brooksbr...irectory").join("");
   a = a.split("/countryc...tsshorts").join("");
   a = a.split("/CountryC...tsshorts").join("");   
   a = a.split("...").join("");   
   //a = a.split(",").join(" ");  don't remove comma
  a = a.toLowerCase();
  return a;
  
}


