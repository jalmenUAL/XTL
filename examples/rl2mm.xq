 
declare namespace xmi="http://xtl/xmi";
declare namespace uml="http://xtl/uml";
declare namespace mmA="http://xtl/mmA";
declare namespace mmB="http://xtl/mmB";


import module namespace mmBl="http://xtl/mmB" at "./lib_mmB.xq";
import module namespace mml="http://xtl/mm" at "./lib_mm.xq";
import module namespace mmAl="http://xtl/mmA" at "./lib_mmA.xq";
import module namespace clib="Create Library for MOF elements" at "./createLib.xq";
import module namespace rlib="Read Library for MOF elements" at "./readLib.xq";
import module namespace xmil="http://xtl/xmi" at "./lib_xmi.xq";
import module namespace umll="http://xtl/uml" at "./lib_uml.xq";




declare variable $file := "/Users/jesusalmendros/Desktop/XTL-1.0/Modelos/rl.tmp";

(: TRANSFORMATION :)

<xmi:XMI xmlns="http://xtl/mm" xmlns:xmi="http://xtl/xmi">
{
let $model :=  doc($file)/mmB:meta_model_B

let $body :=
(
	umll:create_mm_ownedMember("uml_table","","uml:Stereotype","table","false","false","false","public","false",())
	union
	umll:create_mm_ownedMember("uml_row","","uml:Stereotype","row","false","false","false","public","false",())
  union
  umll:create_mm_ownedMember("uml_column","","uml:Stereotype","column","false","false","false","public","false",())
  union
  umll:create_mm_ownedMember("String_id", "", "uml:DataType","String","false","false","false","public","false",())
  union
  umll:create_mm_ownedMember("int_id", "", "uml:DataType","int","false","false","false","public","false",())
  union
  umll:create_mm_ownedMember("float_id", "", "uml:DataType","float","false","false","false","public","false",())
  union
(
  
	   
  for $t in mmBl:read_table_of_meta_model_B($model, (),())
  let $id_as := clib:create_id(($t/@xmi:id,"stereotype"))
  let $t_appliedStereotype:= 
    xmil:create_mm_appliedStereotype($id_as,"uml_table","uml:Stereotype",())
  let $t_stereotype:= 
    (mml:create_xmi_Extension("Visual Paradigm for UML", $t_appliedStereotype))
   
  let $id_tb := clib:create_id(($t/@xmi:id, "ownedMember"))
  let $tb:= umll:create_mm_ownedMember($id_tb,"","uml:Class",
                      $t/@name, 
                       "false","false","false","public","false",
                       $t_stereotype)
  return $tb
)        
             
union                       
(   
    for $t in mmBl:read_table_of_meta_model_B($model, (),())                
    for $r in mmBl:read_row_of_table($t,(),())
    let $id_as := clib:create_id(($t/@xmi:id,$r/@xmi:id,"stereotype"))
    let $r_appliedStereotype:= 
    (xmil:create_mm_appliedStereotype($id_as,"uml_row","uml:Stereotype", ()))
    let $r_stereotype:= 
    (mml:create_xmi_Extension("Visual Paradigm for UML", $r_appliedStereotype))
    let $katts :=
    (for $k in mmBl:read_key_of_row($r,(),()) 
    return (
    let $id_as := clib:create_id(($t/@xmi:id,$r/@xmi:id,$k/@xmi:id,"stereotype"))
    let $c_appliedStereotype:= 
    (xmil:create_mm_appliedStereotype($id_as,"uml_column","uml:Stereotype",()))
    let $c_stereotype:= 
    (mml:create_xmi_Extension("Visual Paradigm for UML", $c_appliedStereotype))
    let $id_c := clib:create_id(($t/@xmi:id,$r/@xmi:id,$k/@xmi:id, "ownedAttribute"))
    let $c:= mml:create_ownedAttribute($id_c,"","uml:Property",
                      "type",$k/@type,
                      "instance","none",
                      ())
    let $id_cl := clib:create_id(($t/@xmi:id,$r/@xmi:id,$k/@xmi:id, "ownedMember"))
    let $cl := umll:create_mm_ownedMember($id_cl,"","uml:Class",$k/@name,"false","false","false","public","false",$c union $c_stereotype)
    return $cl))
    let $catts :=
    (for $k in mmBl:read_column_of_row($r,(),()) 
    return (
    let $id_as := clib:create_id(($t/@xmi:id,$r/@xmi:id,$k/@xmi:id,"stereotype"))
    let $c_appliedStereotype:= 
    (xmil:create_mm_appliedStereotype($id_as,"uml_column","uml:Stereotype",()))
    
    let $c_stereotype:= 
    (mml:create_xmi_Extension("Visual Paradigm for UML", $c_appliedStereotype))
    let $id_c := clib:create_id(($t/@xmi:id,$r/@xmi:id,$k/@xmi:id, "ownedAttribute"))
    let $c:= mml:create_ownedAttribute( $id_c,"","uml:Property",
                      "type",$k/@type,
                      "instance","none",
                       
                      ())
    let $id_cl := clib:create_id(($t/@xmi:id,$r/@xmi:id,$k/@xmi:id, "ownedMember"))
    let $cl := umll:create_mm_ownedMember($id_cl,"","uml:Class",$k/@name,"false","false","false","public","false",$c union $c_stereotype)
    return $cl))
    let $fatts :=
    (for $k in  mmBl:read_foreign_of_row($r,(),()) 
    return (
    let $id_as := clib:create_id(($t/@xmi:id,$r/@xmi:id,$k/@xmi:id,"stereotype"))
    let $c_appliedStereotype:= 
    (xmil:create_mm_appliedStereotype($id_as,"uml_column","uml:Stereotype", ()))
    let $c_stereotype:= 
    (mml:create_xmi_Extension("Visual Paradigm for UML", $c_appliedStereotype))
    let $id_c := clib:create_id(($t/@xmi:id,$r/@xmi:id,$k/@xmi:id, "ownedAttribute")) 
    let $c:= mml:create_ownedAttribute($id_c,"","uml:Property", 
                      "type",$k/@type,
                      "instance","none",
                      ())
    let $id_cl := clib:create_id(($t/@xmi:id,$r/@xmi:id,$k/@xmi:id,"ownedMember"))
    let $cl := umll:create_mm_ownedMember($id_cl,"","uml:Class",$k/@name,"false","false","false","public","false",$c union $c_stereotype)
    return $cl))
    let $id_row := clib:create_id(($t/@xmi:id,$r/@xmi:id, "ownedMember"))
    let $row := umll:create_mm_ownedMember(
	                        $id_row,"","uml:Class",
	                        $r/@name, 
	                         "false","false","false","public","false",
	                         $r_stereotype)
    return $row  union $katts union $catts union $fatts
)
union
(   
    for $t in mmBl:read_table_of_meta_model_B($model, (),())                
    for $r in mmBl:read_row_of_table($t,(),())
    let $id_composite_lc := clib:create_id(($t/@xmi:id,  "lowerValue1"))
    let $composite_lc:= 
    mml:create_lowerValue($id_composite_lc,"","uml:LiteralString","1", ())
    let $id_composite_uc := clib:create_id(($t/@xmi:id, "upperValue1"))
    let $composite_uc:= 
    mml:create_upperValue($id_composite_uc,"", "uml:LiteralString","1",())
    let $id_composite :=  clib:create_id(($t/@xmi:id, "ownedEnd1"))
    let $id_ass := clib:create_id(($t/@xmi:id,$r/@xmi:id, "Association"))
    let $id_member_1 := clib:create_id( ($t/@xmi:id, "ownedMember"))
    let $member_1 := mml:create_memberEnd($id_composite,())
		let $composite:=
    mml:create_ownedEnd($id_composite,"", "uml:Property","none",$id_ass,$id_member_1,"public","true",
        "",$composite_lc union $composite_uc)
    let $id_line_lc := clib:create_id(($t/@xmi:id, $r/@xmi:id, "lowerValue2"))
    let $line_lc:= 
    mml:create_lowerValue($id_line_lc,"", "uml:LiteralString","0",  ())
    let $id_line_uc := clib:create_id(($t/@xmi:id, $r/@xmi:id, "upperValue2"))
    let $line_uc:= 
    mml:create_upperValue($id_line_uc,"", "uml:LiteralString","*", ())
    
    let $id_member_2 := clib:create_id(($t/@xmi:id, $r/@xmi:id, "ownedMember"))
    let $id_ownedEnd := clib:create_id(($t/@xmi:id, $r/@xmi:id, "ownedEnd2"))
    let $member_2 := mml:create_memberEnd($id_ownedEnd,())
		let $line:= 
    mml:create_ownedEnd($id_ownedEnd,"","uml:Property", "composite",$id_ass,$id_member_2,  
     "public", "true","line",  $line_lc union $line_uc)
    let $ass := 
    umll:create_mm_ownedMember($id_ass,"","uml:Association","","false","false","false","public","false", $composite union $line union $member_1 union $member_2)
	  return $ass
)
union
(
for $t in mmBl:read_table_of_meta_model_B($model, (),())
for $r in mmBl:read_row_of_table($t,(),())
for $k in mmBl:read_key_of_row($r,(),())  
      let $id_composite_lc := clib:create_id(($t/@xmi:id,$r/@xmi:id, $k/@xmi:id, "lowerValue1"))
      let $composite_lc:= 
      mml:create_lowerValue($id_composite_lc,"","uml:LiteralString","1",())
      let $id_composite_uc := clib:create_id(($t/@xmi:id,$r/@xmi:id, $k/@xmi:id, "upperValue1"))
      let $composite_uc:= 
      mml:create_upperValue($id_composite_uc,"","uml:LiteralString","1", ())
      let $id_ass := clib:create_id(($t/@xmi:id,$r/@xmi:id, $k/@xmi:id, "Association"))
      let $id_owned_1 := clib:create_id(($t/@xmi:id,$r/@xmi:id, $k/@xmi:id, "ownedEnd1"))
      let $id_member_1 := clib:create_id(($t/@xmi:id,$r/@xmi:id, "ownedMember"))
      let $member_1 := mml:create_memberEnd($id_owned_1,())
		  let $composite:= 
      mml:create_ownedEnd($id_owned_1,"","uml:Property","none", $id_ass,$id_member_1,"public", 
      "true",   "",  $composite_lc union $composite_uc)
      let $id_key_lc := clib:create_id(($t/@xmi:id,$r/@xmi:id, $k/@xmi:id, "lowerValue2"))
      let $key_lc:= 
     mml:create_lowerValue($id_key_lc,"","uml:LiteralString","1", ())
     let $id_key_uc := clib:create_id(($t/@xmi:id,$r/@xmi:id, $k/@xmi:id, "upperValue2"))
      let $key_uc:= 
     mml:create_upperValue($id_key_uc,"","uml:LiteralString","1",  ())
      
     let $id_owned_2 := clib:create_id(($t/@xmi:id,$r/@xmi:id, $k/@xmi:id, "ownedEnd2"))
     let $id_member_2 := clib:create_id(($t/@xmi:id,$r/@xmi:id, $k/@xmi:id, "ownedMember"))
     let $member_2 := mml:create_memberEnd($id_owned_2,())
		  let $key:= mml:create_ownedEnd($id_owned_2,"","uml:Property","composite", $id_ass,$id_member_2,"public", 
      "true",   "key",  $key_lc union $key_uc)
      let $ass :=
     umll:create_mm_ownedMember($id_ass,"","uml:Association","","false","false","false","public","false",$composite union $key union $member_1 union $member_2)
	    return
      $ass
  )

union
(
for $t in mmBl:read_table_of_meta_model_B($model, (),())
for $r in mmBl:read_row_of_table($t,(),())
for $k in mmBl:read_column_of_row($r,(),())  
      let $id_composite_lc := clib:create_id(($t/@xmi:id,$r/@xmi:id, $k/@xmi:id, "lowerValue1"))
      let $composite_lc:= 
      mml:create_lowerValue($id_composite_lc,"","uml:LiteralString","1",())
      let $id_composite_uc := clib:create_id(($t/@xmi:id,$r/@xmi:id, $k/@xmi:id, "upperValue1"))
      let $composite_uc:= 
      mml:create_upperValue($id_composite_uc,"","uml:LiteralString","1", ())
      let $id_ass := clib:create_id(($t/@xmi:id,$r/@xmi:id, $k/@xmi:id, "Association"))
      let $id_owned_1 := clib:create_id(($t/@xmi:id,$r/@xmi:id, $k/@xmi:id, "ownedEnd1"))
      let $id_member_1 := clib:create_id(($t/@xmi:id,$r/@xmi:id, "ownedMember"))
      let $member_1 := mml:create_memberEnd($id_owned_1,())
		  let $composite:= 
      mml:create_ownedEnd($id_owned_1,"","uml:Property","none", $id_ass,$id_member_1,"public", 
      "true",   "",  $composite_lc union $composite_uc)
      let $id_key_lc := clib:create_id(($t/@xmi:id,$r/@xmi:id, $k/@xmi:id, "lowerValue2"))
      let $key_lc:= 
     mml:create_lowerValue($id_key_lc,"","uml:LiteralString","1", ())
     let $id_key_uc := clib:create_id(($t/@xmi:id,$r/@xmi:id, $k/@xmi:id, "upperValue2"))
      let $key_uc:= 
     mml:create_upperValue($id_key_uc,"","uml:LiteralString","1",  ())
      
     let $id_owned_2 := clib:create_id(($t/@xmi:id,$r/@xmi:id, $k/@xmi:id, "ownedEnd2"))
     let $id_member_2 := clib:create_id(($t/@xmi:id,$r/@xmi:id, $k/@xmi:id, "ownedMember"))
     let $member_2 := mml:create_memberEnd($id_owned_2,())
		  let $key:= mml:create_ownedEnd($id_owned_2,"","uml:Property","composite", $id_ass,$id_member_2,"public", 
      "true",   "col",  $key_lc union $key_uc)
      let $ass :=
     umll:create_mm_ownedMember($id_ass,"","uml:Association","","false","false","false","public","false",$composite union $key union $member_1 union $member_2)
	    return
      $ass
  )
union
(
for $t in mmBl:read_table_of_meta_model_B($model, (),())
for $r in mmBl:read_row_of_table($t,(),())
for $k in mmBl:read_foreign_of_row($r,(),())  
      let $id_composite_lc := clib:create_id(($t/@xmi:id,$r/@xmi:id, $k/@xmi:id, "lowerValue1"))
      let $composite_lc:= 
      mml:create_lowerValue($id_composite_lc,"","uml:LiteralString","1",())
      let $id_composite_uc := clib:create_id(($t/@xmi:id,$r/@xmi:id, $k/@xmi:id, "upperValue1"))
      let $composite_uc:= 
      mml:create_upperValue($id_composite_uc,"","uml:LiteralString","1", ())
      let $id_ass := clib:create_id(($t/@xmi:id,$r/@xmi:id, $k/@xmi:id, "Association"))
      let $id_owned_1 := clib:create_id(($t/@xmi:id,$r/@xmi:id, $k/@xmi:id, "ownedEnd1"))
      let $id_member_1 := clib:create_id(($t/@xmi:id,$r/@xmi:id, "ownedMember"))
      let $member_1 := mml:create_memberEnd($id_owned_1,())
		  let $composite:= 
      mml:create_ownedEnd($id_owned_1,"","uml:Property","none", $id_ass,$id_member_1,"public", 
      "true",   "",  $composite_lc union $composite_uc)
      let $id_key_lc := clib:create_id(($t/@xmi:id,$r/@xmi:id, $k/@xmi:id, "lowerValue2"))
      let $key_lc:= 
     mml:create_lowerValue($id_key_lc,"","uml:LiteralString","1", ())
     let $id_key_uc := clib:create_id(($t/@xmi:id,$r/@xmi:id, $k/@xmi:id, "upperValue2"))
      let $key_uc:= 
     mml:create_upperValue($id_key_uc,"","uml:LiteralString","1",  ())
      
     let $id_owned_2 := clib:create_id(($t/@xmi:id,$r/@xmi:id, $k/@xmi:id, "ownedEnd2"))
     let $id_member_2 := clib:create_id(($t/@xmi:id,$r/@xmi:id, $k/@xmi:id, "ownedMember"))
     let $member_2 := mml:create_memberEnd($id_owned_2,())
		  let $key:= mml:create_ownedEnd($id_owned_2,"","uml:Property","composite", $id_ass,$id_member_2,"public", 
      "true",   "foreign",  $key_lc union $key_uc)
      let $ass :=
     umll:create_mm_ownedMember($id_ass,"","uml:Association","","false","false","false","public","false",$composite union $key union $member_1 union $member_2)
	    return
      $ass
  )

)

return xmil:create_uml_Model("modelB","","uml:Model","modelB",$body)


}</xmi:XMI>
