//
//  Product.swift
//  MVVM-Example
//
//  Created by Pierre jonny cau on 30/06/2017.
//  Copyright © 2017 Pierre Jonny Cau. All rights reserved.
//


protocol ProductProtocol {
    
     func changeQuantity(quantity: UInt32) -> Product
    
}


enum QuantityContainer {
    case bag
    case dozen
    case bottle
    case can
}

public enum Goods {
    case peas
    case eggs
    case milk
    case beans
}

public class Product {
    
    public let name: String?
    public let price: Float32?
    internal let quantityContainer: QuantityContainer?
    public let good: Goods?
    public let quantity: Int32?
    
    
    init(price: Float32, good:Goods,quantity:Int32 = 0) {
        
        self.price = price
        self.good = good
        self.quantity = quantity
        
        switch good {
            
        case .peas:
            self.name = "peas"
            self.quantityContainer = .bag
            
        case .eggs:
            self.name = "eggs"
            self.quantityContainer = .dozen
            
        case .milk:
            self.name = "milk"
            self.quantityContainer = .bottle
            
        case .beans:
            self.name = "beans"
            self.quantityContainer = .can
        }
        print("Product are this element: name is \(String(describing: self.name!)), quantityContainer is \(String(describing: self.quantityContainer!)), good is \(String(describing: self.good!)), price is \(String(describing: self.price!)), quantity is  \(String(describing: self.quantity!))")
        
    }

    
    public static func ==(lhs: Product, rhs: Product) -> Bool{
        return  lhs.name == rhs.name &&
            lhs.price == rhs.price &&
            lhs.quantityContainer == rhs.quantityContainer
    }

    
    
}


extension Product : ProductProtocol {
    
    public  func changeQuantity(quantity: UInt32) -> Product {
        return Product(price:price! , good: good!, quantity: Int32(quantity))
    }
    
}
