import sys.io.*;
import hxd.fmt.fbx.Data;
import hxd.fmt.fbx.*;
import polygonal.Printf.format as format;

class Test {
    static var r1 = ~/\x00/g;
    static var r2 = ~/\x01/g;
    static function buildProps(props:Array<FbxProp>):String {
        var s = "";
        for (prop in props) {
            switch (prop) {
            case PInt(v):
                s+='${v}, ';
            case PFloat(v):
                s+='${format("%.6f", [v])}, ';
            case PString(v):
                var z = r1.replace(v, "\\x00");
                z = r2.replace(z, "\\x01");
                s+='"${z}", ';
            case PIdent(i):
                s+='Ident<${i}>, ';
            case PInts(v):
                var z = new Array<String>();
                var i = 0;
                for (y in v) {
                    z.push(format("%d", [y]));
                    if (++i > 4) {
                        z.push("...");
                        break;
                    }
                }
                s+='Int32${z}, ';
            case PFloats(v):
                var z = new Array<String>();
                var i = 0;
                for (y in v) {
                    z.push(format("%.6f", [y]));
                    if (++i > 4) {
                        z.push("...");
                        break;
                    }
                }
                s+='Float32${z}, ';
            case PBinary(v):
                var z = v.toHex();  
                if (z.length > 20) {
                    z = z.substr(0,20)+"...";
                }
                s+='Bytes[${z}], ';
            default:
                throw "unknown property type";
            }
        }
        return s.substr(0,s.length-2);
    }
    static function printNodes(nodes:Array<FbxNode>, prefix:String) {
        for (node in nodes) {
            Sys.println('${prefix}node "${node.name}" (props: ${node.props.length} children: ${node.childs.length!=0})');
            if (node.props.length != 0) {
                var s = buildProps(node.props);
                Sys.println('${prefix} props: ${s}');
            }
            printNodes(node.childs, prefix+" ");
        }
    }
    static function main() {
        var b = File.getBytes("testdata/source/Shuffling.fbx");
        var node = Parser.parse(b);
        printNodes(node.childs, "");
    }
}
