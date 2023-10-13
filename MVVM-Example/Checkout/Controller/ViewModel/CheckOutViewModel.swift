//
//  CheckOutViewModel.swift
//  MVVM-Example
//
//  Created by Pierre jonny cau on 31/07/2017.
//  Copyright © 2017 Pierre Jonny Cau. All rights reserved.
//

import Foundation
import UIKit


class CheckOutViewModel : NSObject {
    
    let productsList: ProductsList
    
    let titleString:String = "The Total Price is: %@ %@"
    
    typealias eventTupleType = (Event,  Bool,  Any)
    
    internal var networkClient = NetworkClient(session:URLSession.shared)
    
    var currencySupported : ConvertedObject?
    
    var valueInDollar : Float32?
        
    var  activityIndicatorShowedListener = DynamicBind<Bool>(true)
    
    var  pickerLoadedListener = DynamicBind<Bool>(false)
    
    var  totalValueListener = DynamicBind<String>("")
    
    var  failureAlertListener = DynamicBind<(String?, String?)>(("",""))

    
    init(passProductlist productsList: ProductsList) {
        
        self.productsList = productsList
    }
    
    func getTotalPrice()  {
        self.productsList.productListListener.bind(listener: { [weak self] (eventTuple: eventTupleType) in
            self?.operation(operation: eventTuple.0,onSuccess: eventTuple.1,value: eventTuple.2)
        })
        
        self.productsList.totalPrice()
    }
    
    
    open func operation(operation: Event, onSuccess: Bool, value: Any) {
        
        DispatchQueue.main.async {[weak self] in
            
            switch operation {
                
            case .totalPrice:
                if onSuccess {
                    let stringLabel = self?.titleString
                    self?.valueInDollar = value as? Float32
                    self?.totalValueListener.value =  String(format:stringLabel!,String(describing: value),"$" )
                }
            default:
                print("operation is default")
            }
        }
    }
    
    
    // MARK: Networking 's Methods
    
    internal func getCurrentCurrency(from fromType:ConversionType)
    {
        networkClient.getList(fromCurrent: fromType, success: { [weak self] list in
            print("list is \(list)")
            self?.currencySupported = ConvertedObject.init(currencyList: list)
            self?.convert(fromType: .Dollar)
            
            }, failure: { [weak self] error in
                self?.failureAlertListener.value = (titleStr: "Error", messageStr: "This errorcode is \(error.statusCode). Try again after")
                self?.activityIndicatorShowedListener.value = false
        })
    }
    
    internal func convert(fromType from:ConversionType) {
        networkClient.loadConversion(fromType: from, toTypes:(self.currencySupported?.allCurrenciesToString())!, success: {  [weak self] quotes in
            print("quotes is \(quotes)")
            self?.currencySupported = self?.currencySupported?.getWithQuote(quotes)
            self?.pickerLoadedListener.value = true
            
            
            }, failure: { [weak self] error in
                self?.failureAlertListener.value = (titleStr: "Error", messageStr: "This errorcode is \(error.statusCode). Try again after")
                self?.activityIndicatorShowedListener.value = false
                
        })
    }
    
    
    // MARK: UIPicker Utilities Methods
    
    func pickerViewFromVMfromTitle(_ row: Int) -> String? {
        let key = self.currencySupported?.allCurrencies()[row]
        
        let value =  self.currencySupported?.listCurrency?[(key!)]
        
        return "\(key!) - \(value!)"
    }
    
    func pickerViewFromVMFromSelected(_ row: Int) {
        
        let key = "USD" + (self.currencySupported?.allCurrencies()[row])!
        guard let factor = self.currencySupported?.listCurrencyWithquotes?[key] else {
            return
        }
        let valueConverted = factor * self.valueInDollar!
        
        var stringLabel = String(format: "%@",self.titleString)
        stringLabel =  String(format:stringLabel,String(describing:  self.valueInDollar!),"$" )
        
        self.totalValueListener.value =  stringLabel.appending(" and cost \(valueConverted) \(String(describing:( self.currencySupported?.allCurrencies()[row])!))")
        
    }
 
}
