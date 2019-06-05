//
//  HLHttpClient.swift
//  Alamofire
//
//  Created by Liang on 2019/5/23.
//

import Alamofire
import HandyJSON
//import CodableAlamofire

public class HttpResponse<T:HandyJSON>:HandyJSON {
    var data:T? = nil
    var msg:String? = nil
    var code:Int? = nil
    required public init() {}
}

//struct HttpResponse<T:Decodable>:Decodable {
//    var data:T? = nil
//    var msg:String? = nil
//    var code:Int? = nil
//}


fileprivate let kHLNetworkClientErrorDomain = "com.httpclient.errordomain"


public enum HLHttpError : Error {
    case alamofireRequestFailed
}


class HLError {
    final class func initialize(errorCode:Int , desc:String) -> NSError {
        return NSError.init(domain: kHLNetworkClientErrorDomain, code: errorCode, userInfo: [NSLocalizedDescriptionKey: desc])
    }
}

public protocol DataProtectd {
    
    func encryptParams(_ params:AnyObject) -> AnyObject
    
    func decryptParams(_ params:AnyObject) -> AnyObject
}

open class HttpClient {
    private static var singleClient:HttpClient = {
        let client = HttpClient.init()
        Alamofire.SessionManager.default.session.configuration.timeoutIntervalForRequest = 10
        
        return client
    }()
    
    private init() {
    }
    
    open class func defaultClient() -> HttpClient {
        return singleClient
    }
    //这里处理网络访问层的结果
    public final func request(_ url:URL, _ requestMethod:HTTPMethod, _ params:[String : Any]? = nil , _ completionHandler:@escaping (_ anyObj :AnyObject? ,_ error :Error?) -> Void ) -> Void {
        if requestMethod != .get && requestMethod != .post {
            completionHandler(nil,HLError.initialize(errorCode: -1, desc: "This kind of Http method type is NOT supported"))
            return;
        }
        
        Alamofire.request(url, method: requestMethod, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            switch response.result {
            case .success:
                completionHandler(response.result.value as AnyObject?,nil)
            case .failure(let error):
                completionHandler(nil,error)
            }
        }
    }
}

//public protocol analyzeResponse {
//    var code:Int? {get set}
//    var msg:String? {get set}
//}

open class HttpRequest {
    public class func request<T:HandyJSON>(_ url:String,_ requestMethod:HTTPMethod,_ params:[String:Any]? = nil, _ structClass: T.Type, _ completionHandler:@escaping (_ anyObj:HttpResponse<T>? ,_ error:Error?) -> Void) -> Void {
        HttpClient.defaultClient().request(URL.init(string: url)!, requestMethod, params) { (anyObj, error) in
            if error != nil {
                completionHandler(nil,HLError.initialize(errorCode: (error! as NSError).code , desc: (error! as NSError).localizedDescription))
                return
            }
            if let responseModel = JSONDeserializer<HttpResponse<T>>.deserializeFrom(dict: anyObj as? Dictionary) {
                completionHandler(responseModel ,nil)
            } else {
                completionHandler(nil,HLError.initialize(errorCode: -1 , desc: "NO Response"))
            }
        }
    }
}
