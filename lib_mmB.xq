module namespace mmBl='http://xtl/mmB';
import module namespace rlib='Read Library for MOF elements' at './readLib.xq';
import module namespace clib='Create Library for MOF elements' at './createLib.xq';
declare namespace fn='http://www.w3.org/2005/xpath-functions';
declare namespace xs='http://www.w3.org/2001/XMLSchema';
declare namespace xsd='http://www.w3.org/2001/XMLSchema';

declare function mmBl:read_row_of_table($root as node()*, $attributes as xs:string*, $values as xs:string*){
                rlib:readsubitem($root,QName('http://xtl/mmB','mmB:row'), $attributes, $values)
};
 declare function mmBl:read_table_of_meta_model_B($root as node()*, $attributes as xs:string*, $values as xs:string*){
                rlib:readsubitem($root,QName('http://xtl/mmB','mmB:table'), $attributes, $values)
};
 declare function mmBl:read_key_of_row($root as node()*, $attributes as xs:string*, $values as xs:string*){
                rlib:readsubitem($root,QName('http://xtl/mmB','mmB:key'), $attributes, $values)
};
 declare function mmBl:read_foreign_of_row($root as node()*, $attributes as xs:string*, $values as xs:string*){
                rlib:readsubitem($root,QName('http://xtl/mmB','mmB:foreign'), $attributes, $values)
};
 declare function mmBl:read_column_of_row($root as node()*, $attributes as xs:string*, $values as xs:string*){
                rlib:readsubitem($root,QName('http://xtl/mmB','mmB:column'), $attributes, $values)
};
declare function mmBl:create_row($xmi_id as xs:string ,$xmi_value as xs:string ,$xmi_type as xs:string ,$name as xs:string ,$body as node()*)
                {
                  clib:createitem(QName('http://xtl/mmB','mmB:row'),(QName('http://xtl/xmi','xmi:id'),QName('http://xtl/xmi','xmi:value'),QName('http://xtl/xmi','xmi:type'),QName('','name')),($xmi_id,$xmi_value,$xmi_type,$name), $body)
};
 declare function mmBl:create_table($xmi_id as xs:string ,$xmi_value as xs:string ,$xmi_type as xs:string ,$name as xs:string ,$body as node()*)
                {
                  clib:createitem(QName('http://xtl/mmB','mmB:table'),(QName('http://xtl/xmi','xmi:id'),QName('http://xtl/xmi','xmi:value'),QName('http://xtl/xmi','xmi:type'),QName('','name')),($xmi_id,$xmi_value,$xmi_type,$name), $body)
};
 declare function mmBl:create_key($xmi_id as xs:string ,$xmi_value as xs:string ,$xmi_type as xs:string ,$name as xs:string ,$type as xs:string ,$body as node()*)
                {
                  clib:createitem(QName('http://xtl/mmB','mmB:key'),(QName('http://xtl/xmi','xmi:id'),QName('http://xtl/xmi','xmi:value'),QName('http://xtl/xmi','xmi:type'),QName('','name'),QName('','type')),($xmi_id,$xmi_value,$xmi_type,$name,$type), $body)
};
 declare function mmBl:create_foreign($xmi_id as xs:string ,$xmi_value as xs:string ,$xmi_type as xs:string ,$name as xs:string ,$type as xs:string ,$body as node()*)
                {
                  clib:createitem(QName('http://xtl/mmB','mmB:foreign'),(QName('http://xtl/xmi','xmi:id'),QName('http://xtl/xmi','xmi:value'),QName('http://xtl/xmi','xmi:type'),QName('','name'),QName('','type')),($xmi_id,$xmi_value,$xmi_type,$name,$type), $body)
};
 declare function mmBl:create_column($xmi_id as xs:string ,$xmi_value as xs:string ,$xmi_type as xs:string ,$name as xs:string ,$type as xs:string ,$body as node()*)
                {
                  clib:createitem(QName('http://xtl/mmB','mmB:column'),(QName('http://xtl/xmi','xmi:id'),QName('http://xtl/xmi','xmi:value'),QName('http://xtl/xmi','xmi:type'),QName('','name'),QName('','type')),($xmi_id,$xmi_value,$xmi_type,$name,$type), $body)
};
