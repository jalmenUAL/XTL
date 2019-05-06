

declare namespace xmi="http://xtl/xmi";
declare namespace uml="http://xtl/uml";
declare namespace mmA="http://xtl/mmA";
declare namespace mmB="http://xtl/mmB";
import module namespace mmBl="http://xtl/mmB" at "./lib_mmB.xq";
import module namespace mmAl="http://xtl/mmA" at "./lib_mmA.xq";

declare variable $file := "./Modelos/er.tmp";
declare variable $file2 := "./Modelos/rl.tmp";

 

(: All attribute names of a data are distinct :)

(:
let $model :=  doc($file)/mmA:meta_model_A
return
every $stores in mmAl:read_store_of_meta_model_A($model,(),())
satisfies
(every $data in mmAl:read_data_of_store($stores,(),())
satisfies (let $attr := mmAl:read_data_attribute_of_data($data,(),())
return (count(distinct-values($attr/@name))=count($attr/@name)))
)
:)

(: Each data has a unique key attribute :)

(:
let $model :=  doc($file)/mmA:meta_model_A
return
every $stores in mmAl:read_store_of_meta_model_A($model,(),())
satisfies
(every $data in mmAl:read_data_of_store($stores,(),())
satisfies (let $attr := mmAl:read_data_attribute_of_data($data,(),())
let $keys := $attr[@key="true"]
return
(count($keys) = 1))
)
:)

(: All data have distinct names :)

(:
let $model :=  doc($file)/mmA:meta_model_A
return
let $stores := mmAl:read_store_of_meta_model_A($model,(),())
let $data := mmAl:read_data_of_store($stores,(),())
return (count(distinct-values($data/@name))=count($data/@name))
:)

(: All data have distinct containers :)
(:
let $model :=  doc($file)/mmA:meta_model_A
return
let $stores := mmAl:read_store_of_meta_model_A($model,(),())
let $data := mmAl:read_data_of_store($stores,(),())
return (count(distinct-values($data/@container))=count($data/@container))
:)

(: All qualifier names of a relation are distinct :)
(:
let $model :=  doc($file)/mmA:meta_model_A
return
every $relations in mmAl:read_relation_of_meta_model_A($model,(),())
satisfies
(every $roles in mmAl:read_role_of_relation($relations,(),())
satisfies (let $qualifiers := mmAl:read_role_qualifier_of_role($roles,(),())
return (count(distinct-values($qualifiers/@name) = count($qualifiers/@name))))
)
:)

(: All qualifiers are key attributes :)

(:
let $model :=  doc($file)/mmA:meta_model_A
return
every $relations in mmAl:read_relation_of_meta_model_A($model,(),())
satisfies
(every $roles in mmAl:read_role_of_relation($relations,(),())
satisfies 
(every $role_qualifier in  mmAl:read_role_qualifier_of_role($roles,(),())
satisfies let $data := mmAl:read_data_of_role($model,$roles)
return 
(some $attributes in mmA:read_data_attribute_of_data($data,(),())
satisfies $attributes/@name=$role_qualifier/@name)))
:)

 

(: All role names of a data are distinct :)
(:
let $model :=  doc($file)/mmA:meta_model_A
return
every $stores in mmAl:read_store_of_meta_model_A($model,(),())
satisfies
(every $data in mmAl:read_data_of_store($stores,(),())
satisfies (let $relations := mmAl:read_relation_of_meta_model_A($model,(),())
let $roles := mmAl:read_role_of_relation($relations,("data"),($data/@xmi:id))
return (count(distinct-values($roles/@name))=count($roles/@name)))
)
:)

(: All column names of a row are distinct :)
 
(:
let $model :=  doc($file2)/mmB:meta_model_B
return
every $table in mmBl:read_table_of_meta_model_B($model,(),())
satisfies
(every $row in mmBl:read_row_of_table($table,(),())
satisfies ( 
let $column := mmBl:read_column_of_row($row,(),())
let $key := mmBl:read_key_of_row($row,(),())
let $foreign := mmBl:read_foreign_of_row($row,(),())
let $all := $column union $key union $foreign
return (count(distinct-values($all/@name))=count($all/@name))))
:)

(: All foreign keys of a row are keys of another row :)
(:
let $model :=  doc($file2)/mmB:meta_model_B
return
every $table in mmBl:read_table_of_meta_model_B($model,(),())
satisfies
(every $row in mmBl:read_row_of_table($table,(),())
satisfies ( 
every $foreign in mmBl:read_foreign_of_row($row,(),())
satisfies
(some $table2 in mmBl:read_table_of_meta_model_B($model,(),())
satisfies
(some $row2 in mmBl:read_row_of_table($table2,(),())
satisfies ( 
some $key in mmBl:read_key_of_row($row2,(),())  
satisfies $foreign/@name=concat($row/@name,$key/@name))))))
:)

(: All table names are distinct :)
(:
let $model :=  doc($file2)/mmB:meta_model_B
let $table := mmBl:read_table_of_meta_model_B($model,(),())
return
(count(distinct-values($table/@name))=count($table/@name))
:)

(: All row names are distinct :)

(:
let $model :=  doc($file2)/mmB:meta_model_B
let $table := mmBl:read_table_of_meta_model_B($model,(),())
let $row := mmBl:read_row_of_table($table,(),())
return
(count(distinct-values($row/@name))=count($row/@name))
:)

(: All rows have either all keys and columns or all foreign keys :)
(:
let $model :=  doc($file2)/mmB:meta_model_B
return
every $table in mmBl:read_table_of_meta_model_B($model,(),())
satisfies
(every $row in mmBl:read_row_of_table($table,(),())
satisfies 
(empty(mmBl:read_foreign_of_row($row,(),()))) or 
(empty(mmBl:read_column_of_row($row,(),())) and empty(mmBl:read_key_of_row($row,(),()))))
:)

(: Key and column names and types are names and types of data attributes :)
(:
let $modelB :=  doc($file2)/mmB:meta_model_B
let $modelA :=  doc($file)/mmA:meta_model_A
return
every $table in mmBl:read_table_of_meta_model_B($modelB,(),())
satisfies
(every $row in mmBl:read_row_of_table($table,(),())
satisfies ( 
every $keycol in mmBl:read_key_of_row($row,(),()) union mmBl:read_column_of_row($row,(),())
satisfies
(some $store in mmAl:read_store_of_meta_model_A($modelA,(),())
satisfies
(some $data in mmAl:read_data_of_store($store,(),())
satisfies ( 
some $data_attribute in mmAl:read_data_attribute_of_data($data,(),())  
satisfies $data_attribute/@name=$keycol/@name and $data_attribute/@type=$keycol/@type)))))
:)

(: Table names are either container names or role names :)
(:
let $modelB :=  doc($file2)/mmB:meta_model_B
let $modelA :=  doc($file)/mmA:meta_model_A
return
every $table in mmBl:read_table_of_meta_model_B($modelB,(),())
satisfies
(some $store in mmAl:read_store_of_meta_model_A($modelA,(),())
satisfies
(some $data in mmAl:read_data_of_store($store,(),())
satisfies ($data/@container=$table/@name)))
or 
(
some $relation in mmAl:read_relation_of_meta_model_A($modelA,(),())
satisfies
(some $role in mmAl:read_role_of_relation($relation,(),())
satisfies ($role/@name=$table/@name))
)
:)

(: Row names are either data names or concatenations of role and data names :)
(:
let $modelB :=  doc($file2)/mmB:meta_model_B
let $modelA :=  doc($file)/mmA:meta_model_A
return
every $table in mmBl:read_table_of_meta_model_B($modelB,(),())
satisfies
every $row in mmBl:read_row_of_table($table,(),())
satisfies
(some $store in mmAl:read_store_of_meta_model_A($modelA,(),())
satisfies
(some $data in mmAl:read_data_of_store($store,(),())
satisfies 
$data/@name=$row/@name
or 
(some $relation in mmAl:read_relation_of_meta_model_A($modelA,(),())
satisfies
(some $role in mmAl:read_role_of_relation($relation,(),())
satisfies 
concat($role/@name,$data/@name)=$row/@name))))
:)

(: Foreign key names are concatenations of role, data and key names :)
(:let $modelB :=  doc($file2)/mmB:meta_model_B
let $modelA :=  doc($file)/mmA:meta_model_A
return
every $table in mmBl:read_table_of_meta_model_B($modelB,(),())
satisfies
every $row in mmBl:read_row_of_table($table,(),())
satisfies  
every $foreign in mmBl:read_foreign_of_row($row,(),())  
satisfies
some $store in mmAl:read_store_of_meta_model_A($modelA,(),())
satisfies
some $data in mmAl:read_data_of_store($store,(),())
satisfies 
some $data_attribute in mmAl:read_data_attribute_of_data($data,(),())  
satisfies 
some $relation in mmAl:read_relation_of_meta_model_A($modelA,(),())
satisfies
some $role in mmAl:read_role_of_relation($relation,(),())
satisfies
some $datarole in mmAl:read_data_of_role($modelA,$role)
satisfies
($data_attribute/@key="true" and concat($role/@name,concat($datarole/@name,$data_attribute/@name))=$foreign/@name)
:)