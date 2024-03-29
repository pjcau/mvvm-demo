 
 //
 //  NetworkError.swift
 //  MVVM-Example
 //
 //  Created by Pierre jonny cau on 30/06/2017.
 //  Copyright © 2017 Pierre Jonny Cau. All rights reserved.
 //

 
import Foundation

public enum NetworkError: Error {
  
  case forbidden
  case notFound
  
  case networkProblem(Error)
  case unknown(HTTPURLResponse?)
  case userCancelled
  
  public init(error: Error) {
    self = .networkProblem(error)
  }
  
  public init(response: URLResponse?) {
    guard let response = response as? HTTPURLResponse else {
      self = .unknown(nil)
      return
    }
    switch response.statusCode {
    case NetworkError.forbidden.statusCode: self = .forbidden
    case NetworkError.notFound.statusCode: self = .notFound
    default: self = .unknown(response)
    }
  }
  
 
  
  public var statusCode: Int {
    switch self {
    case .forbidden:        return 403
    case .notFound:         return 404

    case .networkProblem(_): return 10001
    case .unknown(_):        return 10002
    case .userCancelled:  return 99999
    }
  }
}

// MARK: - Equatable
extension NetworkError: Equatable {
  public static func ==(lhs: NetworkError, rhs: NetworkError) -> Bool {
    return lhs.statusCode == rhs.statusCode
  }
}
