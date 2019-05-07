
declare namespace xmi="http://xtl/xmi";
declare namespace uml="http://xtl/uml";
declare namespace fn="http://www.w3.org/2005/xpath-functions";
declare namespace xs="http://www.w3.org/2001/XMLSchema";
 
 

let $modelA := doc('/Users/jesusalmendros/Desktop/XTL-1.0/Modelos/model-A.xmi')/xmi:XMI/uml:Model

let $modelB:= doc('/Users/jesusalmendros/Desktop/XTL-1.0/Modelos/model-B.xmi')/xmi:XMI/uml:Model

let $new-modelB:= doc('/Users/jesusalmendros/Desktop/XTL-1.0/Modelos/new-model-B.xmi')/xmi:XMI/uml:Model

let $er := doc('/Users/jesusalmendros/Desktop/XTL-1.0/Modelos/er.tmp')

let $rl := doc('/Users/jesusalmendros/Desktop/XTL-1.0/Modelos/rl.tmp')

let $meta-meta := '/Users/jesusalmendros/Desktop/XTL-1.0/mm.xsd'

let $meta-A := '/Users/jesusalmendros/Desktop/XTL-1.0/mmA.xsd'

let $meta-B := '/Users/jesusalmendros/Desktop/XTL-1.0/mmB.xsd'

return

 

validate:xsd-info($new-modelB,$meta-meta)

 