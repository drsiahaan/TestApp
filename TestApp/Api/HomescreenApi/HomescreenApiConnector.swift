//
//  HomescreenApi.swift
//  TestApp
//
//  Created by Dicka Reynaldi on 06/04/23.
//

import Foundation
import RxSwift
import Alamofire

class HomescreenApiConnector: ApiConnector {
    static let instance = HomescreenApiConnector()
    
    private let URL = "/posts"
    
    func getTitle() -> Observable<[ModelData]?>{
        let request = manager.request(URL, method: .get)
        var result: [ModelData] = []

        

        return request.rx_JSON().mapJSONResponse().map{ response in
            if response.result.exists() {
                for data in response.result.arrayValue {
                    if let item = ModelData.with(json: data) {
                        result.append(item)
                    }
                }
            }
            return result
        }
        
    }
}
