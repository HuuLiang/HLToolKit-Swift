//
//  HLExtend-UIkit.swift
//  HLToolKit-Swift
//
//  Created by Liang on 2019/5/23.
//

import UIKit
import Aspects

public extension UIButton {
    @objc enum HLButtonEdgeInsetsStyle:Int {
        case Top
        case Left
        case Bottom
        case Right
    }
    
    
    @objc final func layoutButton(_ insetsStyle:HLButtonEdgeInsetsStyle,_ imageTitleSpace:CGFloat) -> Void {
        let imageWidth:CGFloat = (self.imageView?.frame.size.width)!
        let imageHeigth:CGFloat = (self.imageView?.frame.size.height)!
        
        var labelWidth:CGFloat!
        var labelHeight:CGFloat!
        labelWidth = 0.0
        labelHeight = 0.0
        
        if UIDevice.current.systemVersion.floatValue >= 8.0 {
            labelWidth = self.titleLabel?.intrinsicContentSize.width
            labelHeight = self.titleLabel?.intrinsicContentSize.height
        } else {
            labelWidth = self.titleLabel?.frame.size.width
            labelHeight = self.titleLabel?.frame.size.height
        }
        
        var imageEdgeInsets:UIEdgeInsets = UIEdgeInsets.zero
        var labelEdgeInsets:UIEdgeInsets = UIEdgeInsets.zero
        
        switch insetsStyle {
        case .Top:
            imageEdgeInsets = UIEdgeInsets(top: -labelHeight - imageTitleSpace/2.0, left: 0, bottom: 0, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth, bottom: -imageWidth - imageTitleSpace/2.0, right: 0)
        case .Left:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -imageTitleSpace/2.0, bottom: 0, right: imageTitleSpace/2.0);
            labelEdgeInsets = UIEdgeInsets(top: 0, left: imageTitleSpace/2.0, bottom: 0, right: -imageTitleSpace/2.0);
        case .Bottom:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight-imageTitleSpace/2.0, right: -labelWidth);
            labelEdgeInsets = UIEdgeInsets(top: -imageHeigth-imageTitleSpace/2.0, left: -imageWidth, bottom: 0, right: 0);
        case .Right:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth+imageTitleSpace/2.0, bottom: 0, right: -labelWidth-imageTitleSpace/2.0);
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth-imageTitleSpace/2.0, bottom: 0, right: imageWidth+imageTitleSpace/2.0);
        }
        
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
    }
}



public extension UIColor {
    
    var toHexString:String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return String(
            format:"%02X%02X%02X",
            Int(r * 0xff),
            Int(g * 0xff),
            Int(b * 0xff)
        )
    }
    
    convenience init(_ hex:String) {
        self.init(hex, 1.0)
    }
    
    convenience init(_ hex:String,_ alpha:CGFloat) {
        
        assert(hex.hasPrefix("#"), "hex must has '#' at the beginning")
        assert(hex.count == 7, "hex has 7 chars ,e.g. #efefef ")
        
        var red_:UInt32 = 0
        var green_:UInt32 = 0
        var blue_:UInt32 = 0
        
        
        let redStr = hex[1..<3]
        let greenStr = hex[3..<5]
        let blueStr = hex[5..<7]
        
        Scanner.init(string: redStr).scanHexInt32(&red_)
        Scanner.init(string: greenStr).scanHexInt32(&green_)
        Scanner.init(string: blueStr).scanHexInt32(&blue_)
        
        self.init(red: CGFloat(red_)/255.0, green: CGFloat(green_)/255.0, blue: CGFloat(blue_)/255.0, alpha: alpha)
    }
    
    @objc static func hex(_ hex:String) -> UIColor? {
        return UIColor(hex)
    }
    
    @objc static func hex(_ hex:String,_ alpha:CGFloat) -> UIColor? {
        return UIColor(hex,alpha)
    }
    
}



public extension UIImage {
    @objc static func color(_ color:UIColor) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
}

public extension UIView {
    
    var GM_width:CGFloat {
        get {
            return self.bounds.size.width
        }
    }
    
    var GM_height:CGFloat {
        get {
            return self.bounds.size.height
        }
    }
    
    var GM_size:CGSize {
        get {
            return self.bounds.size
        }
    }
    
    var GM_left:CGFloat {
        get {
            return self.frame.origin.x;
        }
    }
    
    var GM_right:CGFloat {
        get {
            return self.frame.maxX
        }
    }
    
    var GM_top:CGFloat {
        get {
            return self.frame.origin.y;
        }
    }
    
    var GM_bottom:CGFloat {
        get {
            return self.frame.maxY
        }
    }
    
    var GM_centerX:CGFloat {
        get {
            return self.GM_left + self.GM_width/2;
        }
    }
    
    var GM_centerY:CGFloat {
        get {
            return self.GM_top + self.GM_height/2;
        }
    }
    
    var GM_boundsCenter:CGPoint {
        get {
            return CGPoint(x: self.bounds.origin.x + self.GM_width/2, y: self.bounds.origin.y + self.GM_height/2)
        }
    }
    
    
    private struct AssociatedKeys {
        static var forceRoundCorner:Bool?
        static var rectCorner:UIRectCorner?
        static var layoutSubviewsKey:String? = "kLayoutSubViewsKey"
    }
    
    
    
    
    
    
    var forceRoundCorner:Bool {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.forceRoundCorner) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.forceRoundCorner, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
            let block: @convention(block) (AnyObject?) -> Void = {
                info in
                let aspectInfo = info as! AspectInfo
                let thisView:UIView = aspectInfo.instance() as! UIView
                thisView.layer.cornerRadius = CGFloat(ceilf(Float(thisView.bounds.height/2.0)))
                thisView.layer.masksToBounds = true
            }
            let wrappedObject: AnyObject = unsafeBitCast(block, to: AnyObject.self)
            var aspectToken:AspectToken? = objc_getAssociatedObject(self, &AssociatedKeys.layoutSubviewsKey) as? AspectToken
            if newValue && aspectToken == nil {
                do {
                    try aspectToken = self.aspect_hook(#selector(layoutSubviews), with: .positionInstead, usingBlock: wrappedObject)
                } catch {
                    print("Error = \(error)")
                }
                objc_setAssociatedObject(self, &AssociatedKeys.layoutSubviewsKey, aspectToken, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            } else if !newValue {
                aspectToken!.remove()
                objc_setAssociatedObject(self, &AssociatedKeys.layoutSubviewsKey, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
            self.setNeedsLayout()
        }
    }
    
    var rectCorner:UIRectCorner {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.rectCorner) as? UIRectCorner ?? UIRectCorner.topLeft
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.rectCorner, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
            let block: @convention(block) (AnyObject?) -> Void = { info in
                let aspectInfo = info as! AspectInfo
                let thisView:UIView = aspectInfo.instance() as! UIView
                let maskPath:UIBezierPath = UIBezierPath.init(roundedRect: thisView.bounds, byRoundingCorners: [.topRight], cornerRadii: CGSize.init(width: thisView.layer.cornerRadius, height: thisView.layer.cornerRadius))
                thisView.layer.cornerRadius = 0
                let layer:CAShapeLayer = CAShapeLayer()
                layer.frame = maskPath.bounds
                layer.path = maskPath.cgPath
                thisView.layer.mask = layer
            }
            let warppedObject:AnyObject = unsafeBitCast(block, to: AnyObject.self)
            var aspectToken:AspectToken? = objc_getAssociatedObject(self, &AssociatedKeys.layoutSubviewsKey) as? AspectToken
            
            if aspectToken == nil {
                do {
                    try aspectToken = self.aspect_hook(#selector(layoutSubviews), with:[], usingBlock: warppedObject)
                } catch {
                    print("Error = \(error)")
                }
                objc_setAssociatedObject(self, &AssociatedKeys.layoutSubviewsKey, aspectToken, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            } else {
                aspectToken!.remove()
                objc_setAssociatedObject(self, &AssociatedKeys.layoutSubviewsKey, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
            self.setNeedsLayout()
        }
    }
}

