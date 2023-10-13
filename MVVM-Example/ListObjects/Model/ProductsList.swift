//
//  ProductsList.swift
//  MVVM-Example
//
//  Created by Pierre jonny cau on 11/07/2017.
//  Copyright © 2017 Pierre Jonny Cau. All rights reserved.
//

import Foundation


protocol ProductsListProtocol {
    
    func checkBasketIsEmpty()
    func getElement()
    func totalPrice()
    func getTotalPrice() -> Float32
}


 enum Event {
    case initObject
    case getElement
    case addProduct
    case removeProduct
    case removeAll
    case modifyProduct
    case totalPrice
}


class ProductsList {
    
    private(set) public var products = [Product]()
    
    let dispatchQueue = DispatchQueue(label: "com.jonnycau.MVVM-Example.SerialQueue", attributes: .concurrent)
    
    var productListListener  = DynamicBind<( Event,  Bool,  Any)>((.initObject,false, ""))
    
    var basketEmptyListener  = DynamicBind<  Bool>(false)
    
    init() {
        //Add Product to default to ProductLit
        self.products.append(Product(price: 0.95,good: .peas))
        self.products.append(Product(price: 2.10,good: .eggs))
        self.products.append(Product(price: 1.30,good: .milk))
        self.products.append(Product(price: 0.73,good: .beans))
  
     }
    
    init(_ products:[Product]) {
        self.products.append(contentsOf: products)
     }
    
    /// Add Object to array
    ///
    /// - Parameter product: Product to add
    func addProduct(product:Product)  {
        dispatchQueue.async(flags: .barrier) {
            self.products.append(product)
            self.productListListener.value = (operation: .addProduct, onSuccess: true, value: product)
        }
    }
    
    
    /// Remove Object from array
    ///
    /// - Parameter product: Product to remove
    func removeProduct(product:Product)   {
        dispatchQueue.async(flags: .barrier) {
            guard let index = self.products.index(where: { $0 == product }) else {
                self.productListListener.value = (operation: .removeProduct, onSuccess: false, value: "")
                
                return
            }
            
            self.products.remove(at: index)
            self.productListListener.value = (operation: .removeProduct, onSuccess: true, value: "")
            
        }
    }
    
    
    /// Remove all products
    func removeAll() -> Void {
        dispatchQueue.async(flags: .barrier) {
            self.products.removeAll()
            self.productListListener.value = (operation: .removeAll, onSuccess: true, value: "")
        }
    }
    
    
    /// Update Product on Array
    ///
    /// - Parameter product: product updated
    public  func modifyProduct(product:Product, quantity:UInt32)  {
        dispatchQueue.async(flags: .barrier) {
            guard let index = self.products.index(where: { $0 == product }) else {
                self.productListListener.value = (operation: .modifyProduct, onSuccess: false, value:"")
                
                return
            }
            let newProduct = product.changeQuantity(quantity: quantity)
            self.products.remove(at: index)
            self.products.insert(newProduct, at: index)
            self.productListListener.value = (operation: .modifyProduct, onSuccess: true, value: (self.products,index))
            
        }
    }
    
}


extension ProductsList : ProductsListProtocol {
    
    func checkBasketIsEmpty() {
        dispatchQueue.async(flags: .barrier) {
            let products = self.products.filter{ $0.quantity! > 0 }            
             self.basketEmptyListener.value = (products.count == 0)
        }
    }
    
    /// Get Elements From self.products elements
    ///
    /// - Returns: Products Array
    func getElement() {
        dispatchQueue.async(flags: .barrier) {
            self.productListListener.value = (operation: .getElement, onSuccess: true, value: self.products)
        }
    }
    
    func totalPrice() {
        dispatchQueue.async(flags: .barrier) {
             self.productListListener.value = (operation: .totalPrice, onSuccess: true, value:  self.getTotalPrice())
        }
    }
   
    func getTotalPrice() -> Float32 {
        var totalPrice:Float32 = 0.0
        
        for product:Product in self.products {
            totalPrice = totalPrice + (Float32(product.quantity!) * product.price!)
        }
        return totalPrice
    }

}
