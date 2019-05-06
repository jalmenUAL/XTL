module namespace xmil='http://xtl/xmi';
import module namespace rlib='Read Library for MOF elements' at './readLib.xq';
import module namespace clib='Create Library for MOF elements' at './createLib.xq';
declare namespace fn='http://www.w3.org/2005/xpath-functions';
declare namespace xs='http://www.w3.org/2001/XMLSchema';
declare namespace xsd='http://www.w3.org/2001/XMLSchema';

declare function xmil:read_mm_unique_of_Extension($root as node()*, $attributes as xs:string*, $values as xs:string*){
                rlib:readsubitem($root,QName('http://xtl/mm','mm:unique'), $attributes, $values)
};
 declare function xmil:read_mm_qualifier_of_Extension($root as node()*, $attributes as xs:string*, $values as xs:string*){
                rlib:readsubitem($root,QName('http://xtl/mm','mm:qualifier'), $attributes, $values)
};
 declare function xmil:read_mm_appliedStereotype_of_Extension($root as node()*, $attributes as xs:string*, $values as xs:string*){
                rlib:readsubitem($root,QName('http://xtl/mm','mm:appliedStereotype'), $attributes, $values)
};
 declare function xmil:read_mm_ordered_of_Extension($root as node()*, $attributes as xs:string*, $values as xs:string*){
                rlib:readsubitem($root,QName('http://xtl/mm','mm:ordered'), $attributes, $values)
};
 declare function xmil:read_mm_isVisble_of_Extension($root as node()*, $attributes as xs:string*, $values as xs:string*){
                rlib:readsubitem($root,QName('http://xtl/mm','mm:isVisble'), $attributes, $values)
};
 declare function xmil:read_mm_attribute_of_Extension($root as node()*, $attributes as xs:string*, $values as xs:string*){
                rlib:readsubitem($root,QName('http://xtl/mm','mm:attribute'), $attributes, $values)
};
 declare function xmil:read_mm_isRoot_of_Extension($root as node()*, $attributes as xs:string*, $values as xs:string*){
                rlib:readsubitem($root,QName('http://xtl/mm','mm:isRoot'), $attributes, $values)
};
 declare function xmil:read_mm_modelType_of_Extension($root as node()*, $attributes as xs:string*, $values as xs:string*){
                rlib:readsubitem($root,QName('http://xtl/mm','mm:modelType'), $attributes, $values)
};
 declare function xmil:read_mm_businessModel_of_Extension($root as node()*, $attributes as xs:string*, $values as xs:string*){
                rlib:readsubitem($root,QName('http://xtl/mm','mm:businessModel'), $attributes, $values)
};
 declare function xmil:read_mm_associationEnd_of_Extension($root as node()*, $attributes as xs:string*, $values as xs:string*){
                rlib:readsubitem($root,QName('http://xtl/mm','mm:associationEnd'), $attributes, $values)
};
 declare function xmil:read_uml_Model_of_XMI($root as node()*, $attributes as xs:string*, $values as xs:string*){
                rlib:readsubitem($root,QName('http://xtl/uml','uml:Model'), $attributes, $values)
};
 declare function xmil:read_Documentation_of_XMI($root as node()*, $attributes as xs:string*, $values as xs:string*){
                rlib:readsubitem($root,QName('http://xtl/xmi','xmi:Documentation'), $attributes, $values)
};
declare function xmil:create_mm_unique($xmi_id as xs:string ,$xmi_value as xs:string ,$xmi_type as xs:string ,$body as node()*)
                {
                  clib:createitem('unique',(QName('http://xtl/xmi','xmi:id'),QName('http://xtl/xmi','xmi:value'),QName('http://xtl/xmi','xmi:type')),($xmi_id,$xmi_value,$xmi_type), $body)
};
 declare function xmil:create_mm_qualifier($xmi_id as xs:string ,$xmi_value as xs:string ,$xmi_type as xs:string ,$name as xs:string ,$aggregation as xs:string ,$ownerScope as xs:string ,$type as xs:string ,$body as node()*)
                {
                  clib:createitem('qualifier',(QName('http://xtl/xmi','xmi:id'),QName('http://xtl/xmi','xmi:value'),QName('http://xtl/xmi','xmi:type'),QName('','name'),QName('','aggregation'),QName('','ownerScope'),QName('','type')),($xmi_id,$xmi_value,$xmi_type,$name,$aggregation,$ownerScope,$type), $body)
};
 declare function xmil:create_mm_appliedStereotype($xmi_id as xs:string ,$xmi_value as xs:string ,$xmi_type as xs:string ,$body as node()*)
                {
                  clib:createitem('appliedStereotype',(QName('http://xtl/xmi','xmi:id'),QName('http://xtl/xmi','xmi:value'),QName('http://xtl/xmi','xmi:type')),($xmi_id,$xmi_value,$xmi_type), $body)
};
 declare function xmil:create_mm_ordered($xmi_id as xs:string ,$xmi_value as xs:string ,$xmi_type as xs:string ,$body as node()*)
                {
                  clib:createitem('ordered',(QName('http://xtl/xmi','xmi:id'),QName('http://xtl/xmi','xmi:value'),QName('http://xtl/xmi','xmi:type')),($xmi_id,$xmi_value,$xmi_type), $body)
};
 declare function xmil:create_mm_isVisble($xmi_id as xs:string ,$xmi_value as xs:string ,$xmi_type as xs:string ,$body as node()*)
                {
                  clib:createitem('isVisble',(QName('http://xtl/xmi','xmi:id'),QName('http://xtl/xmi','xmi:value'),QName('http://xtl/xmi','xmi:type')),($xmi_id,$xmi_value,$xmi_type), $body)
};
 declare function xmil:create_mm_attribute($body as node()*)
                {
                  clib:createitem('attribute',(),(), $body)
};
 declare function xmil:create_mm_isRoot($xmi_id as xs:string ,$xmi_value as xs:string ,$xmi_type as xs:string ,$body as node()*)
                {
                  clib:createitem('isRoot',(QName('http://xtl/xmi','xmi:id'),QName('http://xtl/xmi','xmi:value'),QName('http://xtl/xmi','xmi:type')),($xmi_id,$xmi_value,$xmi_type), $body)
};
 declare function xmil:create_mm_modelType($value as xs:string ,$body as node()*)
                {
                  clib:createitem('modelType',(QName('','value')),($value), $body)
};
 declare function xmil:create_mm_businessModel($xmi_id as xs:string ,$xmi_value as xs:string ,$xmi_type as xs:string ,$body as node()*)
                {
                  clib:createitem('businessModel',(QName('http://xtl/xmi','xmi:id'),QName('http://xtl/xmi','xmi:value'),QName('http://xtl/xmi','xmi:type')),($xmi_id,$xmi_value,$xmi_type), $body)
};
 declare function xmil:create_mm_associationEnd($body as node()*)
                {
                  clib:createitem('associationEnd',(),(), $body)
};
 declare function xmil:create_uml_Model($xmi_id as xs:string ,$xmi_value as xs:string ,$xmi_type as xs:string ,$name as xs:string ,$body as node()*)
                {
                  clib:createitem(QName('http://xtl/uml','uml:Model'),(QName('http://xtl/xmi','xmi:id'),QName('http://xtl/xmi','xmi:value'),QName('http://xtl/xmi','xmi:type'),QName('','name')),($xmi_id,$xmi_value,$xmi_type,$name), $body)
};
 declare function xmil:create_Documentation($Exporter as xs:string ,$ExporterVersion as xs:string ,$body as node()*)
                {
                  clib:createitem(QName('http://xtl/xmi','xmi:Documentation'),(QName('','Exporter'),QName('','ExporterVersion')),($Exporter,$ExporterVersion), $body)
};
