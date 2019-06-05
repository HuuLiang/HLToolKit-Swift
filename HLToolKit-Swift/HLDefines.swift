//
//  HLDefines.swift
//  HLToolKit-Swift
//
//  Created by Liang on 2019/5/21.
//

import UIKit

public let kScreenHeight = UIScreen.main.bounds.size.height
public let kScreenWidth  = UIScreen.main.bounds.size.width


public func kColor(_ hexColor:String) -> UIColor! {
    return UIColor(hexColor)
}

public func kFont(_ font:CGFloat) -> UIFont! {
    return UIFont.systemFont(ofSize: font)
}

public func kFont(_ fontName:String,_ font:CGFloat) ->UIFont! {
    return UIFont.init(name: fontName, size: font)
}

public typealias HLAction = (_ obj:AnyObject) -> Void
public typealias HLCompletionHandler = (_ obj:AnyObject?,_ error:Error?) -> Void

