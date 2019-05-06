import module namespace gen="Code Generator" at "./generator.xq";

declare variable $model := "/Users/jesusalmendros/Desktop/XTL-1.0/mmB.xsd";


gen:library("mmB","http://xtl/mmB",$model,"mm")


 