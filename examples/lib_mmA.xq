module namespace mmAl='http://xtl/mmA';
import module namespace rlib='Read Library for MOF elements' at './readLib.xq';
import module namespace clib='Create Library for MOF elements' at './createLib.xq';
declare namespace fn='http://www.w3.org/2005/xpath-functions';
declare namespace xs='http://www.w3.org/2001/XMLSchema';
declare namespace xsd='http://www.w3.org/2001/XMLSchema';

declare function mmAl:read_data_of_store($root as node()*, $attributes as xs:string*, $values as xs:string*){
                rlib:readsubitem($root,QName('http://xtl/mmA','mmA:data'), $attributes, $values)
};
 declare function mmAl:read_relation_of_meta_model_A($root as node()*, $attributes as xs:string*, $values as xs:string*){
                rlib:readsubitem($root,QName('http://xtl/mmA','mmA:relation'), $attributes, $values)
};
 declare function mmAl:read_store_of_meta_model_A($root as node()*, $attributes as xs:string*, $values as xs:string*){
                rlib:readsubitem($root,QName('http://xtl/mmA','mmA:store'), $attributes, $values)
};
 declare function mmAl:read_role_of_relation($root as node()*, $attributes as xs:string*, $values as xs:string*){
                rlib:readsubitem($root,QName('http://xtl/mmA','mmA:role'), $attributes, $values)
};
 declare function mmAl:read_role_qualifier_of_role($root as node()*, $attributes as xs:string*, $values as xs:string*){
                rlib:readsubitem($root,QName('http://xtl/mmA','mmA:role_qualifier'), $attributes, $values)
};
 declare function mmAl:read_data_attribute_of_data($root as node()*, $attributes as xs:string*, $values as xs:string*){
                rlib:readsubitem($root,QName('http://xtl/mmA','mmA:data_attribute'), $attributes, $values)
};
declare function mmAl:read_data_of_role($root as node()*,$model as node()){
							    rlib:readlink($root, $model,'data')   
							};
							declare function mmAl:create_data($xmi_id as xs:string ,$xmi_value as xs:string ,$xmi_type as xs:string ,$name as xs:string ,$container as xs:string ,$body as node()*)
                {
                  clib:createitem(QName('http://xtl/mmA','mmA:data'),(QName('http://xtl/xmi','xmi:id'),QName('http://xtl/xmi','xmi:value'),QName('http://xtl/xmi','xmi:type'),QName('','name'),QName('','container')),($xmi_id,$xmi_value,$xmi_type,$name,$container), $body)
};
 declare function mmAl:create_relation($xmi_id as xs:string ,$xmi_value as xs:string ,$xmi_type as xs:string ,$name as xs:string ,$body as node()*)
                {
                  clib:createitem(QName('http://xtl/mmA','mmA:relation'),(QName('http://xtl/xmi','xmi:id'),QName('http://xtl/xmi','xmi:value'),QName('http://xtl/xmi','xmi:type'),QName('','name')),($xmi_id,$xmi_value,$xmi_type,$name), $body)
};
 declare function mmAl:create_store($xmi_id as xs:string ,$xmi_value as xs:string ,$xmi_type as xs:string ,$name as xs:string ,$body as node()*)
                {
                  clib:createitem(QName('http://xtl/mmA','mmA:store'),(QName('http://xtl/xmi','xmi:id'),QName('http://xtl/xmi','xmi:value'),QName('http://xtl/xmi','xmi:type'),QName('','name')),($xmi_id,$xmi_value,$xmi_type,$name), $body)
};
 declare function mmAl:create_role($xmi_id as xs:string ,$xmi_value as xs:string ,$xmi_type as xs:string ,$name as xs:string ,$navigable as xs:string ,$min as xs:string ,$max as xs:string ,$data as xs:string ,$body as node()*)
                {
                  clib:createitem(QName('http://xtl/mmA','mmA:role'),(QName('http://xtl/xmi','xmi:id'),QName('http://xtl/xmi','xmi:value'),QName('http://xtl/xmi','xmi:type'),QName('','name'),QName('','navigable'),QName('','min'),QName('','max'),QName('','data')),($xmi_id,$xmi_value,$xmi_type,$name,$navigable,$min,$max,$data), $body)
};
 declare function mmAl:create_role_qualifier($xmi_id as xs:string ,$xmi_value as xs:string ,$xmi_type as xs:string ,$name as xs:string ,$type as xs:string ,$body as node()*)
                {
                  clib:createitem(QName('http://xtl/mmA','mmA:role_qualifier'),(QName('http://xtl/xmi','xmi:id'),QName('http://xtl/xmi','xmi:value'),QName('http://xtl/xmi','xmi:type'),QName('','name'),QName('','type')),($xmi_id,$xmi_value,$xmi_type,$name,$type), $body)
};
 declare function mmAl:create_data_attribute($xmi_id as xs:string ,$xmi_value as xs:string ,$xmi_type as xs:string ,$name as xs:string ,$type as xs:string ,$key as xs:string ,$body as node()*)
                {
                  clib:createitem(QName('http://xtl/mmA','mmA:data_attribute'),(QName('http://xtl/xmi','xmi:id'),QName('http://xtl/xmi','xmi:value'),QName('http://xtl/xmi','xmi:type'),QName('','name'),QName('','type'),QName('','key')),($xmi_id,$xmi_value,$xmi_type,$name,$type,$key), $body)
};
