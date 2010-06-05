
import groovy.xml.StreamingMarkupBuilder

def doc = new XmlSlurper().parse(new File(args[0]))

//要素の追加 <data id="3"><details>added</details></data>
doc.appendNode {
	data(id: "3") {
		details("added")
	}
}



//文字列でXMLを取得して出力
println new StreamingMarkupBuilder().bind{
	mkp.yield doc
}
