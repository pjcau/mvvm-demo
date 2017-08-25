//
//  NetworkClient.swift
//  MVVM-Example
//
//  Created by Pierre jonny cau on 30/06/2017.
//  Copyright © 2017 Pierre Jonny Cau. All rights reserved.
//

import Foundation


typealias DataTaskResult = (NSData?, URLResponse?, NSError?) -> Void


public final class NetworkClient {
    
    let APIKey = "0de207e976dc832d85465ed064b11c0e"
    let baseUrl = URL(string: "http://apilayer.net/api/")!

    
    // MARK: - Instance Properties
    private let baseURL: URL?
    private let session: URLSession
    typealias completeClosure = ( _ data: [String: Any]?, _ error: Error?)->Void

    // MARK: - Object Lifecycle
    init(session: URLSession = Config.urlSession) {
        self.session = session
        self.baseURL = baseUrl
    }
    
    // MARK: - Functions

    func get( url: URL, callback: @escaping completeClosure ) {
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        let task = session.dataTask(with: url as URL) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode.isSuccessHTTPCode,
                let data = data,
                let jsonObject = try? JSONSerialization.jsonObject(with: data as Data),
                let json = jsonObject as? [String: Any] else {
                    if let error = error {
                        return callback(nil, NetworkError(error: error))
                    } else {
                        return callback(nil, NetworkError(response: response))
                    }
            }
             callback(json, error)

        }
        task.resume()
    }
    
    func getList(fromCurrent from:ConversionType,
                 success _success: @escaping ([String: String]) -> Void,
                 failure _failure: @escaping (NetworkError) -> Void) {
        let success: ([String: Any]) -> Void = { list in
            DispatchQueue.main.async { _success(list as! [String : String]) }
        }
        let failure: (NetworkError) -> Void = { error in
            DispatchQueue.main.async { _failure(error) }
        }
        
        var urlString = baseURL?.absoluteString.appending("list?")
        
        urlString = urlString?.appending("access_key=\(APIKey)&prettyprint=1")
        
        let url = URL(string: urlString!)
        
        NetworkClient(session: self.session).get(url: url!){  (data, response) in
            
            if (response != nil) {
                failure(response as! NetworkError)
            }
            
            guard let list = data?["currencies"] as? [String : String] else
            {
                let errorKeyJson = NSError(domain:"", code:3000, userInfo:nil)
                
                return failure (NetworkError.init(error: errorKeyJson))
            }
            success(list)
        }
       
    }
    
    func loadConversion(fromType from:ConversionType,
                            toTypes to:String,
        success _success: @escaping ([String: Float]) -> Void,
        failure _failure: @escaping (NetworkError) -> Void) {
        
        let success: ( [String : Float]) -> Void = { listQuotes in
            DispatchQueue.main.async { _success(listQuotes) }
        }
        let failure: (NetworkError) -> Void = { error in
            DispatchQueue.main.async { _failure(error) }
        }
        
        var urlString : String? = baseURL?.absoluteString.appending("live?")
        
        urlString = urlString?.appending("access_key=\(APIKey)&source=\(from.value)&currencies=\(to)")
        
        let url = URL(string: urlString!)!
        
        NetworkClient(session: self.session).get(url: url){  (data, response) in
            
            if (response != nil) {
                failure(response as! NetworkError)
            }
            
            guard let listQuotes = data?["quotes"] as? [String : Float] else
            {
                let errorKeyJson = NSError(domain:"", code:3000, userInfo:nil)

                return failure (NetworkError.init(error: errorKeyJson))
            }
            success(listQuotes)
        }
        
    }
    
    
    
    
}
