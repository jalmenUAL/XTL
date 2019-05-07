declare namespace er="Entity-Relation Metamodel";
declare namespace xmi="http://xtl/xmi";
declare namespace uml="http://xtl/uml";
declare namespace mmA="http://xtl/mmA";
declare namespace mmB="http://xtl/mmB";

import module namespace mmBl="http://xtl/mmB" at "./lib_mmB.xq";
import module namespace mmAl="http://xtl/mmA" at "./lib_mmA.xq";
import module namespace clib="Create Library for MOF elements" at "./createLib.xq";
import module namespace rlib="Read Library for MOF elements" at "./readLib.xq";


declare variable $file := "/Users/jesusalmendros/Desktop/XTL-1.0/Modelos/er.tmp";

declare function er:columns($attrs as node()*){
for $attr in $attrs 
return
let $idkey := clib:create_id(($attr/@xmi:id,"is_key"))
let $idcol := clib:create_id(($attr/@xmi:id,"is_col"))
return
if ($attr/@key="true") then mmBl:create_key($idkey,"","mmB:key",$attr/@name,$attr/@type,())
else  mmBl:create_column($idcol,"","mmB:is_col",$attr/@name,$attr/@type,())
};

declare function er:foreign_keys($model as node()*,$s as node()*,$p as node()*){
let $class :=mmAl:read_data_of_role($model,$p)
return
(
for $qualifier in  mmAl:read_role_qualifier_of_role($p,(),())
let $id_foreign := clib:create_id(($qualifier/@xmi:id,"is_foreign"))
return  mmBl:create_foreign($id_foreign,"","mmB:is_foreign",concat(concat($p/@name, $class/@name), $qualifier/@name),$qualifier/@type,())
)
union
(
for $q in mmAl:read_role_of_relation($s,(),())
where not ($q/@xmi:id=$p/@xmi:id)
return
for $qualifier in  mmAl:read_role_qualifier_of_role($q,(),())
let $id_foreign := clib:create_id(($q/@xmi:id,$qualifier/@xmi:id,"is_foreign"))
return  mmBl:create_foreign($id_foreign,"","mmB:is_foreign",concat(concat($p/@name, $class/@name), $qualifier/@name),$qualifier/@type,())
)
};

<meta_model_B xmlns="http://xtl/mmB" xmlns:xmi="http://xtl/xmi" xmlns:mmB="http://xtl/mmB">
{
let $model :=  doc($file)/mmA:meta_model_A
 
let $body :=
((
  for $s in mmAl:read_store_of_meta_model_A($model,(),()), 
  $p in mmAl:read_data_of_store($s,(),())
  return (
    let $attrs := mmAl:read_data_attribute_of_data($p,(),())
    let $columns := er:columns($attrs)
    let $id_has := clib:create_id(($s/@xmi:id,$p/@xmi:id, "has"))
    let $id_table := clib:create_id(($s/@xmi:id,$p/@xmi:id, "table"))
    let $r:= mmBl:create_row($id_has,"","mmB:has",                      
                      $p/@name, 
                       
                      $columns)
    let $t:= mmBl:create_table(   
                      $id_table,
                      "",
                      "mmB:table",                
                      $p/@container, 
                       
                      $r)
	  return $t  
  )
)
union
(	  
	 for $s in mmAl:read_relation_of_meta_model_A($model,(),()), 
  $p in mmAl:read_role_of_relation($s,(),())
	  where (($p/@navigable = "true") and ($p/@max = "*"))
    return (
    let $class := mmAl:read_data_of_role($model,$p)  
    let $columns := er:foreign_keys($model,$s,$p)
    let $id_has := clib:create_id(($s/@xmi:id,$p/@xmi:id, "has"))
    let $id_table := clib:create_id(($s/@xmi:id,$p/@xmi:id, "table"))
    let $r:= mmBl:create_row( 
                      $id_has,
                      "",
                      "mmB:has",                     
                      concat($p/@name, $class/@name), 
                      
                      $columns)
    let $t:= mmBl:create_table(
                      $id_table,
                      "",
                      "mmB:table",                       
                      $p/@name, 
                       
                      $r)   
	  return $t  
)
)
)
return $body
 
}
</meta_model_B>
