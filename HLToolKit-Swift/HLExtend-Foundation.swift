//
//  HLExtend-Foundation.swift
//  HLToolKit-Swift
//
//  Created by Liang on 2019/5/23.
//

import Foundation


extension String {
    /// 使用下标截取字符串 例: "示例字符串"[0..<2] 结果是 "示例"
    subscript (r: Range<Int>) -> String {
        get {
            if (r.lowerBound > count) || (r.upperBound > count) { return "截取超出范围" }
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: r.upperBound)
            return String(self[startIndex..<endIndex])
        }
    }
    
    var floatValue:CGFloat {
        get {
            let strDouble = Double(self)
            let strFloat = CGFloat(strDouble ?? 0.0)
            return strFloat
        }
    }
}


extension Bundle {
    @objc func bundleVersion() -> String {
        return self.infoDictionary!["CFBundleShortVersionString"] as! String
    }
    
    @objc func bundleName() -> String {
        return self.infoDictionary!["CFBundleDisplayName"] as! String
    }
    
}

extension URL: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        guard let url = URL(string: "\(value)") else {
            preconditionFailure("This url: \(value) is not invalid")
        }
        self = url
    }
}
//public extension NSData {
//
//}
//
//extension Dictionary where Key: ExpressibleByStringLiteral, Value: Any {
//    var showJsonString: String {
//        do {
//            var dic: [String: Any] = [String: Any]()
//            for (key, value) in self {
//                dic["\(key)"] = value
//            }
//            let jsonData = try JSONSerialization.data(withJSONObject: dic, options: JSONSerialization.WritingOptions.prettyPrinted)
//
//            if let data = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) as String? {
//                return data
//            } else {
//                return "{}"
//            }
//        } catch {
//            return "{}"
//        }
//    }
//}
//
//extension NSDictionary {
//    open func description(withLocale locale: Any?) -> String {
//        return "2"
//    }
//}
//
////extension NSArray {
////    open func description(withLocale locale: Any?) -> String {
////        var str:NSMutableString = NSMutableString()
////
////        str.append("[\n")
////        return "1"
////    }
////}
//
//extension NSMutableArray {
//
//    open override func description(withLocale locale: Any?) -> String {
//        var str = "(\n"
//
//
//        self.enumerateObjects { (obj, i, stop) in
//            str += "\t\(obj), \n"
//        }
//
//        str += ")"
//
//        return str
//    }
//}
//
//extension Dictionary {
//
//}
