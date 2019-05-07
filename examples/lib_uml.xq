module namespace umll='http://xtl/uml';
import module namespace rlib='Read Library for MOF elements' at './readLib.xq';
import module namespace clib='Create Library for MOF elements' at './createLib.xq';
declare namespace fn='http://www.w3.org/2005/xpath-functions';
declare namespace xs='http://www.w3.org/2001/XMLSchema';
declare namespace xsd='http://www.w3.org/2001/XMLSchema';

declare function umll:read_mm_ownedMember_of_Model($root as node()*, $attributes as xs:string*, $values as xs:string*){
                rlib:readsubitem($root,QName('http://xtl/mm','mm:ownedMember'), $attributes, $values)
};
declare function umll:create_mm_ownedMember($xmi_id as xs:string ,$xmi_value as xs:string ,$xmi_type as xs:string ,$name as xs:string ,$isAbstract as xs:string ,$isActive as xs:string ,$isLeaf as xs:string ,$visibility as xs:string ,$isDerived as xs:string ,$body as node()*)
                {
                  clib:createitem('ownedMember',(QName('http://xtl/xmi','xmi:id'),QName('http://xtl/xmi','xmi:value'),QName('http://xtl/xmi','xmi:type'),QName('','name'),QName('','isAbstract'),QName('','isActive'),QName('','isLeaf'),QName('','visibility'),QName('','isDerived')),($xmi_id,$xmi_value,$xmi_type,$name,$isAbstract,$isActive,$isLeaf,$visibility,$isDerived), $body)
};
