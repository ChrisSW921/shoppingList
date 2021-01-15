//
//  ItemTableViewCell.swift
//  shoppingList
//
//  Created by Chris Withers on 1/15/21.
//

import UIKit

protocol ItemTappedDelegate: AnyObject {
    func itemWasTapped(_ sender: ItemTableViewCell)
}

class ItemTableViewCell: UITableViewCell {

    
    //MARK: - Outlets
    @IBOutlet weak var checkMarkButton: UIButton!
    @IBOutlet weak var itemLabel: UILabel!
    
    //MARK: - Properties
    var item: Item? {
        didSet{
            updateView()
        }
    }
    
    var delegate: ItemTappedDelegate?
    
    //MARK: - Actions
    @IBAction func checkButtonTapped(_ sender: Any) {
        delegate?.itemWasTapped(self)
    }
    
    //MARK: - Helper functions
    func updateView(){
        guard let currentItem = item else{return}
        itemLabel.text = "\(currentItem.title) - \(currentItem.amount)"
        if currentItem.hasBought {
            checkMarkButton.setBackgroundImage(UIImage(named: "complete"), for: .normal)
        }else{
            checkMarkButton.setBackgroundImage(UIImage(named: "incomplete"), for: .normal)
        }
    }
    
    
    
}
