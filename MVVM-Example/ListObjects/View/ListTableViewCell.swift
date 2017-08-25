//
//  ListTableViewCell.swift
//  MVVM-Example
//
//  Created by Pierre jonny cau on 01/07/2017.
//  Copyright © 2017 Pierre Jonny Cau. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabelProduct: UILabel!
    @IBOutlet weak var stepperProduct: UIStepper!
    @IBOutlet weak var countLabelProduct: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var addElementOnProducts  = DynamicBind<Int32>(-1)
    // MARK: Cell Configuration
    func configurateTheCell(product: Product) {
        self.titleLabelProduct.text = product.name!
        self.descriptionLabel.text = "This product is \(String(describing: product.name!)) and cost it \(String(describing: product.price!))"
        self.countLabelProduct.text = "numbers is \(String(describing: product.quantity!))"
        self.stepperProduct.value = Double(product.quantity!)
     }
    
    @IBAction func actionStepper(_ sender: Any) {
        addElementOnProducts.value = Int32((sender as! UIStepper).value)
     }
 
}
