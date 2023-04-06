//
//  Extensions.swift
//  TestApp
//
//  Created by Dicka Reynaldi on 06/04/23.
//

import Foundation
import UIKit
import RxSwift
import Alamofire
import SwiftyJSON

extension Observable {
    func mapJSONResponse() -> Observable<APIResponse> {
        
        var message: String = ""
        var status: Int = 200
        var result: JSON = JSON()
        
        return map { (item) -> APIResponse in
            guard let json = item as? JSON else {
                fatalError("NOT A JSON!")
            }
            
            result = json
            
            //  MARK: IF CODE EXIST, THEN EXPECTING ERROR HAPPENED
            if json["code"].exists(), let code = json["code"].int, let msg = json["message"].string {
                status = code
                message = msg
            }
            
            //  MARK: IF STATUS EXIST, THEN EXPECTING NO ERROR HAPPENED
            if json["status"].exists(), let code = json["status"].int, let msg = json["msg"].string {
                status = code
                message = msg
                result = json
            }
            return APIResponse(code: status, message: message, result: result)
        }
    }
}

extension DataRequest {
    func rx_JSON(options: JSONSerialization.ReadingOptions = .allowFragments) -> Observable<JSON> {
        let observable = Observable<JSON>.create { observer in
            if let method = self.request?.httpMethod, let urlString = self.request?.url {
                print("[\(method)] \(urlString)")
                if let body = self.request?.httpBody {
                    print(NSString(data: body, encoding: String.Encoding.utf8.rawValue) as Any)
                }
            }
            
            self.responseJSON(options: options) { response in
                let success = 200...299
                
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let statusCode = response.response!.statusCode
                    if success.contains(statusCode){
                        if let error = json.error {
                            observer.onError(error)
                        } else {
                            observer.onNext(json)
                            observer.onCompleted()
                        }
                    } else {
                        if json["message"].exists() {
                            observer.onError(CustomError.expected(message: json["message"].string ?? ""))
                        } else {
                            observer.onError(CustomError.unexpected(code: statusCode))
                        }
                    }
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
        return Observable.deferred { return observable }
    }
}
