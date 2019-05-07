declare namespace tl="Transformation for MOF elements";
declare namespace xmi="http://xtl/xmi";
declare namespace uml="http://xtl/uml";
declare namespace mmA="http://xtl/mmA";
declare namespace mm="http://xtl/mm";
 

import module namespace mml="http://xtl/mm" at "./lib_mm.xq";
import module namespace mmAl="http://xtl/mmA" at "./lib_mmA.xq";
import module namespace xmil="http://xtl/xmi" at "./lib_xmi.xq";
import module namespace umll="http://xtl/uml" at "./lib_uml.xq";
import module namespace clib="Create Library for MOF elements" at "./createLib.xq";
import module namespace rlib="Read Library for MOF elements" at "./readLib.xq";
 


declare variable $file := "./Modelos/model-A.xmi";

declare function tl:container($model as node()*,$r as node()*) as xs:string*{
  for $a in umll:read_mm_ownedMember_of_Model($model,("xmi:type"),("uml:Association")) 
  let $ownedEnds := mml:read_ownedEnd_of_ownedMember($a,(),()) 
  let $q := $ownedEnds[1]
  let $p := $ownedEnds[2]       
  where ($p/@aggregation = "composite") and ($p/@type = $r/@type)
  return clib:create_id(($a/@xmi:id,$p/@xmi:id, "contains"))
  
};

declare function tl:attr_of($ptype as node()*) as node()*{
  let $ownedAttributes := mml:read_ownedAttribute_of_ownedMember($ptype,(),())
  for $attr in $ownedAttributes
  let $e := mml:read_xmi_Extension_of_ownedAttribute($attr,(),())
  let $unique := xmil:read_mm_unique_of_Extension($e,(),())
  let $id := clib:create_id(($attr/@xmi:id,"attr_of"))
  return 
  mmAl:create_data_attribute($id,"","mmA:attr_of",$attr/@name,$attr/@type,$unique/@xmi:value,())
};

declare function tl:is($p as node()*) as node()*{ 
  for $r in xmil:read_mm_qualifier_of_Extension($p,(),())
      let $id := clib:create_id(($r/@xmi:id, "is"))
      return  mmAl:create_role_qualifier($id,"","mmA:is",$r/@name,$r/@type,())
};

 

 


<meta_model_A xmlns="http://xtl/mmA" xmlns:xmi="http://xtl/xmi" xmlns:mmA="http://xtl/mmA">
{
let $model :=  xmil:read_uml_Model_of_XMI(doc($file)/xmi:XMI,(),())

let $body :=
((	 
  for $a in umll:read_mm_ownedMember_of_Model($model,("xmi:type"),("uml:Association")) 
  let $ownedEnds := mml:read_ownedEnd_of_ownedMember($a,(),()) 
  let $q := $ownedEnds[1]
  let $p := $ownedEnds[2]
  where ($p/@aggregation = "composite")  
  
  return(
      let $ptype :=  mml:read_type_of_ownedEnd($model,$p)        
      let $qtype :=   mml:read_type_of_ownedEnd($model,$q) 
      let $attr_of := tl:attr_of($ptype)
      let $idcontains := clib:create_id(($a/@xmi:id,$p/@xmi:id, "contains"))
      let $idstore := clib:create_id(($a/@xmi:id,$q/@xmi:id, "store"))
      let $d:=  mmAl:create_data($idcontains,"","mmA:contains",$ptype/@name,$p/@name,$attr_of)
      let $s:=  mmAl:create_store($idstore,"","mmA:store",$qtype/@name,$d)
      return $s
  )
)
union
( 
  for $a in umll:read_mm_ownedMember_of_Model($model,("xmi:type"),("uml:Association"))   
  let $ownedEnds := mml:read_ownedEnd_of_ownedMember($a,(),()) 
  let $q := $ownedEnds[1]
  let $p := $ownedEnds[2]
  where ($p/@aggregation = "none")
  return(
      let $lowerValuep := mml:read_lowerValue_of_ownedEnd($p,(),())  
      let $upperValuep := mml:read_upperValue_of_ownedEnd($p,(),()) 
      let $lowerValueq := mml:read_lowerValue_of_ownedEnd($q,(),())  
      let $upperValueq :=  mml:read_upperValue_of_ownedEnd($q,(),())  
      let $isp := tl:is($p)
      let $is_datap := tl:container($model,$p)
      let $idr1 := clib:create_id(($a/@xmi:id,$p/@xmi:id, "role"))
      let $r1:= 
    mmAl:create_role($idr1,"","mmA:is_role",$p/@name,"true",$lowerValuep/@value,$upperValuep/@value,$is_datap,
    $isp)
      let $isq := tl:is($q)
      let $is_dataq := tl:container($model,$q)
      let $idr2 := clib:create_id(($a/@xmi:id,$q/@xmi:id, "role"))
      let $r2:= 
    mmAl:create_role($idr2,"","mmA:is_role",$q/@name,"false",$lowerValueq/@value,$upperValueq/@value,$is_dataq,
    $isq)
      let $idr := clib:create_id(($a/@xmi:id, "relation"))
      let $rl:= mmAl:create_relation($idr,"","mmA:relation",$a/@name,$r1 union $r2)
      return $rl   
  )
  
 
)
)
return $body

}
</meta_model_A>
