
var args = WScript.Arguments;

if (args.Count() < 2) {
	WScript.Echo("<machine name> <output file>");
	WScript.Quit();
}

var vb = WScript.CreateObject("VirtualBox.VirtualBox");
var sh = WScript.CreateObject("WScript.Shell");
var fs = WScript.CreateObject("Scripting.FileSystemObject");


// 仮想マシンの取得
var mc = vb.findMachine(args.Item(0));

var fileName = args.Item(1);

var ap = vb.createAppliance();

var des = mc.Export(ap, fs.GetBaseName(fileName));

WScript.Echo("export start");

var prog = ap.write("ovf-2.0", false, fs.BuildPath(sh.CurrentDirectory, fileName));

// 処理が完了するまで待機
prog.waitForCompletion(-1);

WScript.Echo("export end");
