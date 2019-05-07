module namespace gen="Code Generator";

declare namespace fn="http://www.w3.org/2005/xpath-functions";
declare namespace xs="http://www.w3.org/2001/XMLSchema";
declare namespace xsd="http://www.w3.org/2001/XMLSchema";


 
declare function gen:parameters($first as xs:boolean,$parameters as node()*)
{
  
  if (empty($parameters)) 
  then 
        if ($first) 
        then "$body as node()*" 
        else ",$body as node()*"
  else 
        if ($first) 
        then 
            if ($parameters[1]/@name) 
            then
             concat(concat(concat("$",
             translate(data($parameters[1]/@name),':','_')),
             " as xs:string "),  
             gen:parameters(false(),tail($parameters))) 
            else if ($parameters[1]/@ref) 
                then 
                concat(concat(concat("$",
                translate(data($parameters[1]/@ref),':','_')),
                " as xs:string "),  
                    gen:parameters(false(),tail($parameters)))
                else gen:parameters(true(),tail($parameters))
        else 
            if ($parameters[1]/@name) 
            then
                concat(concat(concat(",$",
                translate(data($parameters[1]/@name),':','_')),
                " as xs:string "),  
                gen:parameters(false(),tail($parameters)))
             else if ($parameters[1]/@ref) 
                 then 
                 concat(concat(concat(",$",
                 translate(data($parameters[1]/@ref),':','_')),
                    " as xs:string "),  
                    gen:parameters(false(),tail($parameters)))
                 else gen:parameters(false(),tail($parameters))
};

declare function gen:calls($first as xs:boolean,$parameters as node()*,$name as xs:string,$model as xs:string,$description,$module)
{
  
  if (empty($parameters)) 
  then ""
  else 
    if ($first) 
    then 
       if ($parameters[1]/@name) 
       then 
       concat(concat(concat(concat(concat(
        "QName('",
           (if (contains(data($parameters[1]/@name),':')) 
            then 
            data(doc(concat(substring-before($parameters[1]/@name,':'),".xsd"))/xs:schema/@targetNamespace)    
            else 
              (if ($parameters[1]/@form="qualified")
              then 
                (if ($module="") 
                  then "" 
                  else data(doc(concat($module,".xsd"))/xs:schema/@targetNamespace))
              else "")))
        ,"','"),
           (if (contains(data($parameters[1]/@name),':')) 
            then data($parameters[1]/@name) 
            else 
              (if ($parameters[1]/@form="qualified") 
               then
                 (if ($module="") 
                  then data($parameters[1]/@name) 
                  else concat(concat($module,':'),data($parameters[1]/@name))) 
               else data($parameters[1]/@name))
               )),"')"),
               gen:calls(false(),tail($parameters),$name,$model,$description,$module)) 
       else 
         if ($parameters[1]/@ref) 
         then 
         concat(concat(concat(concat(concat(
          "QName('",
             (if (contains(data($parameters[1]/@name),':')) 
              then 
              data(doc(concat(substring-before($parameters[1]/@name,':'),".xsd"))/xs:schema/@targetNamespace)    
              else 
                (if ($parameters[1]/@form="qualified")
                 then 
                     (if ($module="") 
                      then "" 
                      else data(doc(concat($module,".xsd"))/xs:schema/@targetNamespace))
                 else "")))
          ,"','"),
             (if (contains(data($parameters[1]/@ref),':')) 
              then data($parameters[1]/@ref) 
              else 
                (if ($parameters[1]/@form="qualified") 
                 then
                   (if ($module="") 
                    then data($parameters[1]/@name) 
                    else concat(concat($module,':'),data($parameters[1]/@name))) 
                 else data($parameters[1]/@name))))
       ,"')"),
       gen:calls(false(),tail($parameters),$name,$model,$description,$module)) 
       else
       gen:calls(true(),tail($parameters),$name,$model,$description,$module)
    else 
       if ($parameters[1]/@name) 
       then 
       concat(concat(concat(concat(concat(
        ",QName('",
             (if (contains(data($parameters[1]/@name),':')) 
              then 
              data(doc(concat(substring-before($parameters[1]/@name,':'),".xsd"))/xs:schema/@targetNamespace)    
              else 
                (if ($parameters[1]/@form="qualified")
                then 
                  (if ($module="") 
                   then "" 
                   else data(doc(concat($module,".xsd"))/xs:schema/@targetNamespace))
                else "")))
       ,"','"),
           (if (contains(data($parameters[1]/@name),':')) 
            then data($parameters[1]/@name) 
            else 
                (if ($parameters[1]/@form="qualified") 
                 then
                   (if ($module="") 
                    then data($parameters[1]/@name) 
                    else concat(concat($module,':'),data($parameters[1]/@name))) 
                 else data($parameters[1]/@name))))
       ,"')"),
       gen:calls(false(),tail($parameters),$name,$model,$description,$module))
       else 
             if ($parameters[1]/@ref) 
             then 
               concat(concat(concat(concat(concat(
                ",QName('",
                 (if (contains(data($parameters[1]/@name),':')) 
                  then 
                  data(doc(concat(substring-before($parameters[1]/@name,':'),".xsd"))/xs:schema/@targetNamespace)    							 else 
                    (if ($parameters[1]/@form="qualified")
                     then 
                       (if ($module="") 
                        then "" 
                        else data(doc(concat($module,".xsd"))/xs:schema/@targetNamespace))
                     else "")))
       ,"','"),
           (if (contains(data($parameters[1]/@ref),':')) 
            then data($parameters[1]/@ref) 
            else 
              (if ($parameters[1]/@form="qualified") 
               then
                 (if ($module="") 
                  then data($parameters[1]/@name) 
                  else concat(concat($module,':'),data($parameters[1]/@name))) 
               else data($parameters[1]/@name))))
       ,"')"),
       gen:calls(false(),tail($parameters),$name,$model,$description,$module)) 
       else
       gen:calls(false(),tail($parameters),$name,$model,$description,$module)
};

declare function gen:values($first as xs:boolean,$parameters as node()*)
{
   
  if (empty($parameters)) 
  then ""
  else 
    if ($first) 
    then 
       if ($parameters[1]/@name) 
       then
       concat(concat("$",
       translate(data($parameters[1]/@name),':','_')),
       gen:values(false(),tail($parameters))) 
       else 
       if ($parameters[1]/@ref) then 
       concat(concat("$",
       translate(data($parameters[1]/@ref),':','_')),
       gen:values(false(),tail($parameters)))
       else
       gen:values(true(),tail($parameters))
    else 
       if ($parameters[1]/@name)      
       then
       concat(concat(concat(',',"$"),
       translate(data($parameters[1]/@name),':','_')),
       gen:values(false(),tail($parameters)))
       else 
       if ($parameters[1]/@ref) then 
       concat(concat(concat(',',"$"),
       translate(data($parameters[1]/@ref),':','_')),
       gen:values(false(),tail($parameters))) else
       gen:values(false(),tail($parameters))
};

declare function gen:module($name,$description){
concat(concat(concat(concat("module namespace ",concat($name,'l')),"='"),$description),"';")
};

declare function gen:head(){
  
let $declare :=
  
"
import module namespace rlib='Read Library for MOF elements' at './readLib.xq';
import module namespace clib='Create Library for MOF elements' at './createLib.xq';
declare namespace fn='http://www.w3.org/2005/xpath-functions';
declare namespace xs='http://www.w3.org/2001/XMLSchema';
declare namespace xsd='http://www.w3.org/2001/XMLSchema';

"
return $declare
};

 
declare function gen:getelementCT($name,$description,$model)
{
let $get2:=
(
for $elem in doc($model)/xs:schema/xs:element  
      for $subelement in $elem/xs:complexType/xs:choice/xs:element 
                  union $elem/xs:complexType/xs:complexContent/xs:extension/xs:choice/xs:element
return
let $namefunction := 
          concat(concat(concat(concat(concat(
          "declare function ",concat($name,'l')),":read_"),
          translate(data($subelement/@ref),':','_')),"_of_"),
          translate(data($elem/@name),':','_'))
let $signature := 
          "($root as node()*, $attributes as xs:string*, $values as xs:string*)"
let $body := 
          concat(concat(concat(concat(concat(concat(
              "{
                rlib:readsubitem($root,",concat("QName(",concat(concat("'",
                      (if (contains(data($subelement/@ref),':')) 
                       then 
                       data(doc(concat(substring-before($subelement/@ref,':'),
                       ".xsd"))/xs:schema/@targetNamespace)
                       else $description)
               ),"',"))),"'"),
              (if (contains(data($subelement/@ref),':')) 
               then data($subelement/@ref) 
               else concat($name,concat(':',data($subelement/@ref))))),"')"),
              ", $attributes, $values)"),"
};
")
return concat(concat($namefunction,$signature),$body)
)
return $get2
};

declare function gen:getLinks($name,$description,$model){
let $get3 :=
(
for $elem in doc($model)/xs:schema/xs:element
        for $atts in 
          $elem/xs:complexType/xs:attribute union 
          $elem/xs:complexType/xs:complexContent/xs:extension/xs:attribute
        where $atts/@type="xs:IDREF"
      return
           let $namefunction := 
						concat(concat(concat(concat(concat("declare function ",concat($name,'l')),":read_"),
						translate(data($atts/@name),':','_')),"_of_"),
						translate(data($elem/@name),':','_'))
           let $signature := "($root as node()*,$model as node())"
           let $body := concat(concat( 
							  "{
							    rlib:readlink($root, $model,'",data($atts/@name)),"')   
							};
							")
      return concat(concat($namefunction,$signature),$body)
)
return $get3
};
 
declare function gen:imports($elem,$model,$name)
{
let $base := data($elem/xs:complexType/xs:complexContent/xs:extension/@base)
return
      if (empty($base)) 
      then ()
      else
        let $import := concat(substring-before(data($base),':'),".xsd")
        let $type := substring-after(data($base),':')
        return 
            (for $att in doc($import)//xs:complexType[@name=$type]/xs:attribute
             return
             <xs:attribute name="{concat(concat(substring-before($base,':'),':'),$att/@name)}" 
             type="{$att/@type}" form="{$att/@form}"/> 
)  
}; 
 
declare function gen:create($name,$description,$model,$root){
  let $create:=
(
for $element in doc($model)/xs:schema/xs:element  
      for $link in $element/xs:complexType/xs:choice/xs:element
                    union $element/xs:complexType/xs:complexContent/xs:extension/xs:choice/xs:element
      return
          let $elem := doc($model)/xs:schema/xs:element[@name=data($link/@ref)]
                    union 
                      (if (not (substring-before(data($link/@ref),':')="")) 
                       then doc(concat(substring-before(data($link/@ref),':'),
                       '.xsd'))/xs:schema/xs:element[@name=substring-after(data($link/@ref),':')] 
                       else ()) 
          let $imports := gen:imports($elem,$model,$name)
          let $params := $elem/xs:complexType/xs:attribute 
                        union $elem/xs:complexType/xs:complexContent/xs:extension/xs:attribute union $imports 
          let $parameters := gen:parameters(true(),$params)
          let $signature := concat(concat("(",$parameters),")")
          let $calls := 
                gen:calls(true(),$params,$name,$model,$description,substring-before(data($link/@ref),':'))
          let $values := gen:values(true(),$params)
          let $namefunction := concat(concat(concat("declare function ",concat($name,'l')),":create_"),
                        translate(data($link/@ref),':','_'))
          return
              let $body :=concat(concat(concat(concat(concat(concat(concat("
                {
                  clib:createitem(",concat(
                      (if (contains(data($link/@ref),':'))
                       then
                          (if (not (substring-before(data($link/@ref),':')=$root)) 
                           then 
                                concat(
                                concat(concat(concat("QName('",
                                data(doc(concat(substring-before($link/@ref,':'),
                                ".xsd"))/xs:schema/@targetNamespace)
                                 ),"',"),concat(concat("'",data($link/@ref)),"'")),")")   
                            else concat(concat("'",substring-after(data($link/@ref),':')),"'"))
                       else 
                          if (not ($name=$root))
                          then
                              concat("QName('",concat($description,concat("','",
                              concat($name,concat(concat(":",data($link/@ref)),"')")))))
                          else concat(concat("'",data($link/@ref)),"'"))
          ,"")),""),","),"(",$calls),"),("),$values),"), $body)
};
")
return 

concat(concat($namefunction,$signature),$body)
 
)

return $create
};
 

declare function gen:library($name,$description,$model,$root){

let $module := gen:module($name,$description)

let $declare := gen:head()

let $get2 := gen:getelementCT($name,$description,$model)

let $get3 := gen:getLinks($name,$description,$model)

let $create := gen:create($name,$description,$model,$root)

return (<m> {$module} </m> union <d> {$declare} </d> union <ect> {$get2} </ect> union  <l> {$get3} </l> union <c> {$create} </c>)/text()
};
