//
//  UIViewController+UIAlertViewController.swift
//  MVVM-Example
//
//  Created by Pierre jonny cau on 03/07/2017.
//  Copyright © 2017 Pierre Jonny Cau. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlertMessage(titleStr:String, messageStr:String) {
        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
            print("Cancel")
        })
        self.present(alert, animated: true, completion: nil)
    }
}
