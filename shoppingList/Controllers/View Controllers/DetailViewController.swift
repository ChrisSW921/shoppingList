//
//  DetailViewController.swift
//  shoppingList
//
//  Created by Chris Withers on 1/15/21.
//

import UIKit

class DetailViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var itemTitleLabel: UILabel!
    
    @IBOutlet weak var itemQuantityLabel: UILabel!
    
    @IBOutlet weak var itemStepper: UIStepper!
    
    //MARK: - Properties
    var item: Item? {
        didSet{
            loadViewIfNeeded()
            updateView()
            
        }
    }
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Actions
    @IBAction func stepperTapped(_ sender: Any) {
        
        guard let selectedItem = item else {return}
        ItemController.shared.editAmount(forItemWithTitle: selectedItem.title, newValue: Int(itemStepper.value))
        updateView()
    }
    
    //MARK: - Helper functions
    func updateView(){
        guard let selectedItem = item else {print("No!")
            return}
        itemTitleLabel.text = selectedItem.title
        itemQuantityLabel.text = String(selectedItem.amount)
        itemStepper.value = Double(selectedItem.amount)
    }
    
    
    

}
