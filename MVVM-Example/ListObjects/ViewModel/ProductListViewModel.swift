//
//  ProductListViewModel.swift
//  MVVM-Example
//
//  Created by Pierre jonny cau on 11/07/2017.
//  Copyright © 2017 Pierre Jonny Cau. All rights reserved.
//

import Foundation
import UIKit

enum ReloadType {
    case reloadAll
    case reloadIndex
}


class ProductsListViewModel  {
    
    
    let productsList: ProductsList
    
    typealias eventTupleType = (Event,  Bool,  Any)

    var  tableViewListener = DynamicBind<(ReloadType,Int)>(.reloadAll,-1)
    var  checkOutListener = DynamicBind<Bool>(false)

    // MARK - Initialization
    
    init(withProductsList productsList: ProductsList) {
        self.productsList = productsList
        self.productsList.productListListener.bind(listener: { [weak self] (eventTuple: eventTupleType) in
            self?.operation(operation: eventTuple.0,onSuccess: eventTuple.1,value: eventTuple.2)
        })
        
        self.productsList.basketEmptyListener.bindAndFire(listener: {  [weak self] (isEmpty: Bool ) in
            self?.checkOutListener.value = isEmpty
        })
        
        self.productsList.checkBasketIsEmpty()
    }
    
    
    // MARK: Table Data Source Method's

    func numberOfRowInTableView() -> Int {
        return self.productsList.products.count
    }
    
    // MARK: Table Delegate Method's

    
    func cellForRowAtIndexPath(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"Cell", for: indexPath as IndexPath) as? ListTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configurateTheCell(product: self.productsList.products[indexPath.row] )
        
        cell.addElementOnProducts.bind(listener: { [weak self] (changeValue:Int32) in
            guard let indexPath :IndexPath = tableView.indexPath(for: cell)  else { return}
            print("indexPath.row is \(indexPath.row)")
            self?.productsList.modifyProduct(product: (self?.productsList.products[indexPath.row])!, quantity:UInt32(changeValue))
        })
                
        return cell
    }
   
    
    
    func operation(operation: Event, onSuccess: Bool, value: Any) {
        
        DispatchQueue.main.async {[weak self] in
            
            self?.productsList.checkBasketIsEmpty()
            
            switch operation {
                
            case .getElement:
                self?.tableViewListener.value = (type:.reloadAll,index:-1)
                
            case .addProduct, .removeProduct,.removeAll:
                if onSuccess {
                    self?.tableViewListener.value = (type:.reloadAll,index:-1)
                }
                
            case .modifyProduct:
                if onSuccess {
                    let (_, indexValue) = value as! ([Product], Int)
                    self?.tableViewListener.value = (type:.reloadIndex,index:indexValue)
                }
            case .initObject:
                break
            default:
                print("operation is default")
            }
        }
    }
    
   
    
    
}
