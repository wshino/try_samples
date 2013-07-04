@Grab('org.apache.pdfbox:pdfbox:1.8.2')
@Grab('org.bouncycastle:bcprov-jdk15on:1.49')
import org.apache.pdfbox.pdmodel.*
import org.apache.pdfbox.util.PDFTextStripper

def doc = PDDocument.load(args[0])

// PDF の内容によっては日本語が文字化けする
println new PDFTextStripper().getText(doc)

doc.close()
