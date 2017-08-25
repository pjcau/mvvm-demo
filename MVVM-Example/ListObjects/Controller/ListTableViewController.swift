//
//  ListTableViewController.swift
//  MVVM-Example
//
//  Created by Pierre jonny cau on 30/06/2017.
//  Copyright © 2017 Pierre Jonny Cau. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController  {
    
    // MARK: Controller's Property
    
    var productsListViewModel: ProductsListViewModel!

    @IBOutlet weak var checkoutBarButton: UIBarButtonItem!

    
    // MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productsListViewModel = ProductsListViewModel(withProductsList:ProductsList())
        self.customLayout()
        self.bindUI()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    deinit {
        print("deinit ListTableViewController")
    }
    
    //MARK :Bind UI  Layout
    
    func bindUI()
    {
        self.productsListViewModel.tableViewListener.bind(listener: { value in
            if value.0 == .reloadAll
            {
                self.tableView.reloadData()
            }
            else if value.0 == .reloadIndex
            {
                self.updateCell(path:value.1)
            }
        })
        
        self.productsListViewModel.checkOutListener.bindAndFire(listener: { isEmptyValue in
            self.basketIsEmpty(onSuccess: isEmptyValue)
        })

    }
    
    //MARK :Draw Custom Layout
    
    func customLayout()  {
        self.title = "Basket List"
    }
    
    //MARK :TableView DataSource 's Methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productsListViewModel.numberOfRowInTableView()
    }
    
    //MARK :TableView Delegate 's Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.productsListViewModel.cellForRowAtIndexPath(tableView:tableView, indexPath:indexPath)
    }
    
    //MARK :Action's Methods

    
    @IBAction func checkOutaAction(_ sender: Any) {
        self.performSegue(withIdentifier: "goToCheckoutScreen", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToCheckoutScreen" {
            if let checkOutController = segue.destination as? CheckOutViewController{
                    checkOutController.checkOutViewModel = CheckOutViewModel(passProductlist:ProductsList(self.productsListViewModel.productsList.products))
                
            }
        }
    }
    
    func basketIsEmpty(onSuccess: Bool) {
        DispatchQueue.main.async {[weak self] in
            guard let strogSelf = self else {return}
            
            strogSelf.checkoutBarButton?.isEnabled = !onSuccess
            strogSelf.checkoutBarButton?.tintColor = onSuccess ? UIColor.clear : nil

        }
    }
    
    func updateCell(path:Int){
        let indexPath = IndexPath(row: path, section: 0)
        
        self.tableView?.beginUpdates()
        self.tableView?.reloadRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.fade) //try other animations
        self.tableView?.endUpdates()
    }
    
}
