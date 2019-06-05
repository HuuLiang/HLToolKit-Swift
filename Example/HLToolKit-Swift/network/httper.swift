//
//  httper.swift
//  HLToolKit-Swift_Example
//
//  Created by Liang on 2019/6/3.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import HLToolKit_Swift
import HandyJSON
import Alamofire


enum HLReqAPI:String {
    case homedata = "http://106.14.127.126/myq-store/store/home"
    case userlogin = "http://106.14.127.126/myq-store/store/home1"
}

class HLReq{
    public class func fetchPurchaseCateList(_ completionHandler:@escaping HLCompletionHandler) -> Void {
        let xx:[String:Any] = ["channelType":"home"]
//        HttpRequest.request("http://106.14.127.126/myq-store/store/home", .post, xx, HomeData.self) { (responseObject, error) in
//
//            if let homedata = responseObject {
//                print(homedata)
//            }
//        }
        HttpRequest.request(HLReqAPI.homedata.rawValue, .post, xx ,HomeData.self) { (resp, error) in
            print(resp)
        }
    }
    
    
//
//    public class func fetchIndex(_ completionHandler:@escaping HLCompletionHandler) -> Void {
//        let url = URL.init(string: "http://localhost:8080")
//        HttpReq.defaultReq().fetchData(url!, .get, nil) { (responseObject, error) in
//            if let userModel = JSONDeserializer<HttpRespon<User>>.deserializeFrom(dict: responseObject as? Dictionary) {
//                if let userData = userModel.data {
//                    print(responseObject as Any)
//                    print(userModel)
//                    print(userData)
//                }
//            }
//            completionHandler(responseObject,error);
//        }
//    }
    
    
//    private final func OnRespon(_ responseObject:AnyObject ,_ completionHandler: HLCompletionHandler) {
//
//    }
}



