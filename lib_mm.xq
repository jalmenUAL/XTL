module namespace mml='http://xtl/mm';
import module namespace rlib='Read Library for MOF elements' at './readLib.xq';
import module namespace clib='Create Library for MOF elements' at './createLib.xq';
declare namespace fn='http://www.w3.org/2005/xpath-functions';
declare namespace xs='http://www.w3.org/2001/XMLSchema';
declare namespace xsd='http://www.w3.org/2001/XMLSchema';

declare function mml:read_ownedEnd_of_ownedMember($root as node()*, $attributes as xs:string*, $values as xs:string*){
                rlib:readsubitem($root,QName('http://xtl/mm','mm:ownedEnd'), $attributes, $values)
};
 declare function mml:read_ownedAttribute_of_ownedMember($root as node()*, $attributes as xs:string*, $values as xs:string*){
                rlib:readsubitem($root,QName('http://xtl/mm','mm:ownedAttribute'), $attributes, $values)
};
 declare function mml:read_xmi_Extension_of_ownedMember($root as node()*, $attributes as xs:string*, $values as xs:string*){
                rlib:readsubitem($root,QName('http://xtl/xmi','xmi:Extension'), $attributes, $values)
};
 declare function mml:read_memberEnd_of_ownedMember($root as node()*, $attributes as xs:string*, $values as xs:string*){
                rlib:readsubitem($root,QName('http://xtl/mm','mm:memberEnd'), $attributes, $values)
};
 declare function mml:read_xmi_Extension_of_ownedAttribute($root as node()*, $attributes as xs:string*, $values as xs:string*){
                rlib:readsubitem($root,QName('http://xtl/xmi','xmi:Extension'), $attributes, $values)
};
 declare function mml:read_memberEnd_of_ownedEnd($root as node()*, $attributes as xs:string*, $values as xs:string*){
                rlib:readsubitem($root,QName('http://xtl/mm','mm:memberEnd'), $attributes, $values)
};
 declare function mml:read_upperValue_of_ownedEnd($root as node()*, $attributes as xs:string*, $values as xs:string*){
                rlib:readsubitem($root,QName('http://xtl/mm','mm:upperValue'), $attributes, $values)
};
 declare function mml:read_lowerValue_of_ownedEnd($root as node()*, $attributes as xs:string*, $values as xs:string*){
                rlib:readsubitem($root,QName('http://xtl/mm','mm:lowerValue'), $attributes, $values)
};
 declare function mml:read_xmi_Extension_of_ownedEnd($root as node()*, $attributes as xs:string*, $values as xs:string*){
                rlib:readsubitem($root,QName('http://xtl/xmi','xmi:Extension'), $attributes, $values)
};
 declare function mml:read_qualifier_of_ownedEnd($root as node()*, $attributes as xs:string*, $values as xs:string*){
                rlib:readsubitem($root,QName('http://xtl/mm','mm:qualifier'), $attributes, $values)
};
 declare function mml:read_xmi_Extension_of_qualifier($root as node()*, $attributes as xs:string*, $values as xs:string*){
                rlib:readsubitem($root,QName('http://xtl/xmi','xmi:Extension'), $attributes, $values)
};
declare function mml:read_association_of_ownedEnd($root as node()*,$model as node()){
							    rlib:readlink($root, $model,'association')   
							};
							 declare function mml:read_type_of_ownedEnd($root as node()*,$model as node()){
							    rlib:readlink($root, $model,'type')   
							};
							declare function mml:create_ownedEnd($xmi_id as xs:string ,$xmi_value as xs:string ,$xmi_type as xs:string ,$aggregation as xs:string ,$association as xs:string ,$type as xs:string ,$visibility as xs:string ,$isNavigable as xs:string ,$name as xs:string ,$body as node()*)
                {
                  clib:createitem('ownedEnd',(QName('http://xtl/xmi','xmi:id'),QName('http://xtl/xmi','xmi:value'),QName('http://xtl/xmi','xmi:type'),QName('','aggregation'),QName('','association'),QName('','type'),QName('','visibility'),QName('','isNavigable'),QName('','name')),($xmi_id,$xmi_value,$xmi_type,$aggregation,$association,$type,$visibility,$isNavigable,$name), $body)
};
 declare function mml:create_ownedAttribute($xmi_id as xs:string ,$xmi_value as xs:string ,$xmi_type as xs:string ,$name as xs:string ,$type as xs:string ,$ownerScope as xs:string ,$aggregation as xs:string ,$body as node()*)
                {
                  clib:createitem('ownedAttribute',(QName('http://xtl/xmi','xmi:id'),QName('http://xtl/xmi','xmi:value'),QName('http://xtl/xmi','xmi:type'),QName('','name'),QName('','type'),QName('','ownerScope'),QName('','aggregation')),($xmi_id,$xmi_value,$xmi_type,$name,$type,$ownerScope,$aggregation), $body)
};
 declare function mml:create_xmi_Extension($Extender as xs:string ,$body as node()*)
                {
                  clib:createitem(QName('http://xtl/xmi','xmi:Extension'),(QName('http://xtl/xmi','xmi:Extender')),($Extender), $body)
};
 declare function mml:create_memberEnd($xmi_idref as xs:string ,$body as node()*)
                {
                  clib:createitem('memberEnd',(QName('http://xtl/xmi','xmi:idref')),($xmi_idref), $body)
};
 
  
 declare function mml:create_upperValue($xmi_id as xs:string ,$xmi_value as xs:string ,$xmi_type as xs:string ,$value as xs:string ,$body as node()*)
                {
                  clib:createitem('upperValue',(QName('http://xtl/xmi','xmi:id'),QName('http://xtl/xmi','xmi:value'),QName('http://xtl/xmi','xmi:type'),QName('','value')),($xmi_id,$xmi_value,$xmi_type,$value), $body)
};
 declare function mml:create_lowerValue($xmi_id as xs:string ,$xmi_value as xs:string ,$xmi_type as xs:string ,$value as xs:string ,$body as node()*)
                {
                  clib:createitem('lowerValue',(QName('http://xtl/xmi','xmi:id'),QName('http://xtl/xmi','xmi:value'),QName('http://xtl/xmi','xmi:type'),QName('','value')),($xmi_id,$xmi_value,$xmi_type,$value), $body)
};
 
 declare function mml:create_qualifier($xmi_id as xs:string ,$xmi_value as xs:string ,$xmi_type as xs:string ,$name as xs:string ,$aggregation as xs:string ,$ownerScope as xs:string ,$type as xs:string ,$body as node()*)
                {
                  clib:createitem('qualifier',(QName('http://xtl/xmi','xmi:id'),QName('http://xtl/xmi','xmi:value'),QName('http://xtl/xmi','xmi:type'),QName('','name'),QName('','aggregation'),QName('','ownerScope'),QName('','type')),($xmi_id,$xmi_value,$xmi_type,$name,$aggregation,$ownerScope,$type), $body)
};
 
