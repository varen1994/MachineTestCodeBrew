//
//  ApiHandler.swift
//  MachineTestCodeBrew
//
//  Created by Varender Singh on 30/05/19.
//  Copyright © 2019 Varender Singh. All rights reserved.
//

import UIKit
import Network

class ApiHandler: NSObject {

    static let shared = ApiHandler()
    
    private override init() {
        
    }
    
    func hitApiAndGetResponse(completionHandler:@escaping (NSDictionary?,String?)->(Void)) {
       let urlString = baseURL+homeApi;
        var request = URLRequest.init(url: URL.init(string: urlString)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 120);
        request.httpMethod = "POST";
        request.allHTTPHeaderFields = ["Accept":"application/json"];
       let dataTask =  URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completionHandler(nil,error?.localizedDescription)
            }
            else {
                let httpResponse = response as! HTTPURLResponse
                if httpResponse.statusCode==200 {
                    do {
                        let jsonData = try JSONSerialization.jsonObject(with: data!, options: []);
                        completionHandler(jsonData as? NSDictionary,nil);
                    }
                    catch {
                         completionHandler(nil,error.localizedDescription);
                    }
                }
                else {
                  completionHandler(nil,"Some error occurred.")
                }
            }
        }
      dataTask.resume()
    }
    
}
