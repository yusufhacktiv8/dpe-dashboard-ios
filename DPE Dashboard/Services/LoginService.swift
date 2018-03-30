//
//  LoginService.swift
//  DPE Dashboard
//
//  Created by Muhammad Yusuf on 12/26/17.
//  Copyright © 2017 Department Power Plant & Energy. All rights reserved.
//

import Foundation
import Alamofire

public struct LoginService {
    
    public static func login(username: String, password: String, myResponse: @escaping (Int) -> ()) {
        let urlString = DashboardConstant.BASE_URL + "/security/signin"
        let parameters: Parameters = [
            "username": username,
            "password": password
        ]
        
        Alamofire.request(urlString, method: .post, parameters: parameters)
            .validate()
            .responseJSON { response in
                let statusCode = response.response?.statusCode
                if (statusCode == 200) {
                    if let data = response.result.value {
                        guard let json = data as? [String : AnyObject] else {
                            print("Failed to get expected response from webserver.")
                            return
                        }
                        
                        let token = json["token"] as? String ?? ""
                        UserVar.token = token
                    }
                }
                
                if let tempStatusCode = statusCode {
                    myResponse(tempStatusCode)
                } else {
                    myResponse(-1)
                }
                
//                let headers = ["Authorization": "Basic \(token)"]
                
        }
        
    }
    
    
}
