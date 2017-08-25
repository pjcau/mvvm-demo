//
//  Int+HTTPStatusCode.swift
//  MVVM-Example
//
//  Created by Pierre jonny cau on 30/06/2017.
//  Copyright © 2017 Pierre Jonny Cau. All rights reserved.
//

extension Int {
  public var isSuccessHTTPCode: Bool {
    return 200 <= self && self < 300
  }
}
