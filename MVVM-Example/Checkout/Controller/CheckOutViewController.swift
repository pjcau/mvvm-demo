//
//  CheckOutViewController.swift
//  MVVM-Example
//
//  Created by Pierre jonny cau on 03/07/2017.
//  Copyright © 2017 Pierre Jonny Cau. All rights reserved.
//

import UIKit


class CheckOutViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{

    // MARK: Controller's Property

    @IBOutlet weak var totalPriceLabel: UILabel!
        
    @IBOutlet weak var convertCurrrencyPickerView: UIPickerView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var checkOutViewModel:CheckOutViewModel? = nil
 
 
    // MARK: Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupModelView()
        self.settingUI()
        self.bindUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.checkOutViewModel?.getTotalPrice()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
 
    }
    
    deinit {
        print("deinit CheckOutViewController")
    }
    
    // MARK: Private methods
    
    func setupModelView() {
        self.checkOutViewModel?.getCurrentCurrency(from:.Dollar)
    }
    
    // MARK: Bind UI
    
    func bindUI() {
        self.checkOutViewModel?.totalValueListener.bind(listener: {  [weak self] value in
            self?.totalPriceLabel.text = value
        })

        self.checkOutViewModel?.failureAlertListener.bind(listener: {  [weak self]
            (title, message) in
            if !(title?.isEmpty)! && !(message?.isEmpty)! {
                self?.showAlertMessage(titleStr: title!, messageStr: message!)
            }
        })
        
        self.checkOutViewModel?.pickerLoadedListener.bind(listener: {  [weak self] value in
            if value {
                self?.convertCurrrencyPickerView?.delegate = self
                self?.convertCurrrencyPickerView?.dataSource = self
                self?.convertCurrrencyPickerView?.isHidden = false
            }
            self?.activityIndicator?.stopAnimating()
        })

        self.checkOutViewModel?.activityIndicatorShowedListener.bind(listener: {  [weak self] value in
            self?.activityIndicator?.stopAnimating()
        })

    }
    
    // MARK: Draw UI

    func settingUI()  {
        self.title = "Checkout"
        self.convertCurrrencyPickerView?.isHidden = true
     }
    
    // MARK: UIPicker Data Source 's Methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.checkOutViewModel!.currencySupported!.allCurrencies().count
    }
    
    // MARK: UIPicker Delegate's Methods
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    
        return self.checkOutViewModel?.pickerViewFromVMfromTitle(row)
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.checkOutViewModel?.pickerViewFromVMFromSelected(row)

    }
    
    
 
}
