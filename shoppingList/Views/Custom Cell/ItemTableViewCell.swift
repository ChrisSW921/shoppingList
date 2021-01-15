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

    @IBOutlet weak var checkMarkButton: UIButton!
    
    @IBOutlet weak var itemLabel: UILabel!
    
    var item: Item? {
        didSet{
            updateView()
        }
    }
    
    var delegate: ItemTappedDelegate?
    
    @IBAction func checkButtonTapped(_ sender: Any) {
        delegate?.itemWasTapped(self)
    }
    
    func updateView(){
        guard let currentItem = item else{return}
        itemLabel.text = currentItem.title
        if currentItem.hasBought {
            checkMarkButton.setBackgroundImage(UIImage(named: "complete"), for: .normal)
        }else{
            checkMarkButton.setBackgroundImage(UIImage(named: "incomplete"), for: .normal)
        }
    }
    
    
}
