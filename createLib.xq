module namespace clib="Create Library for MOF elements";

declare namespace fn="http://www.w3.org/2005/xpath-functions";
declare namespace xs="http://www.w3.org/2001/XMLSchema";
 
 

declare function clib:create_id($ids as xs:string*)
{
  string-join(("id",string-join($ids)))
};

declare function clib:createitem($nameitem, $attributes, 
$values,$body as node()*)
{
   
  element {$nameitem}{ 
     
    (for $par_n in $attributes return(attribute {$par_n}{$values[index-of($attributes, $par_n)]})) , $body }
}; 

 
 


