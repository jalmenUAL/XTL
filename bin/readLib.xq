module namespace rlib="Read Library for MOF elements";

 
declare namespace fn="http://www.w3.org/2005/xpath-functions";
declare namespace xs="http://www.w3.org/2001/XMLSchema";
declare namespace xmi="http://xtl/xmi";
 

 

declare function rlib:cond($model as node(),$attribute as xs:string, $value as xs:string)
{
 some $att in $model/@* satisfies name($att)=$attribute and data($att)=$value
};

 
declare function rlib:readsubitem($model as node()*,$nameitem as xs:QName,$attributes as xs:string*,$values as xs:string*){
for $elements in $model/*
      where node-name($elements)=$nameitem
            and 
            (every $att in $attributes satisfies 
            rlib:cond($elements,$att,$values[index-of($attributes, $att)]))
return $elements
};

declare function rlib:readlink($model as node()*,$element as node()*,$nameatt as xs:string){
  for $pointer in (for $atts in $element/@* where name($atts)=$nameatt return data($atts))
  return
  for $items in $model//* where data($items/@xmi:id)=$pointer 
  return $items
};


 
 


 
 

 

 

 


 

 