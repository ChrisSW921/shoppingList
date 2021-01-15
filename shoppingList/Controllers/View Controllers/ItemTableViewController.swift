//
//  ItemTableViewController.swift
//  shoppingList
//
//  Created by Chris Withers on 1/15/21.
//

import UIKit

class ItemTableViewController: UITableViewController {

    
    //MARK: - Properties
    var sections: [[Item]] = []
    
    var selectedItem: Item?
    
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        ItemController.shared.loadFromPersistenceStore()
        navigationItem.title = "Shopping List"
        setUpSections()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpSections()
    }
    
    
    //MARK: - Actions
    @IBAction func addButtonTapped(_ sender: Any) {
        
        var itemTextField: UITextField?
        
        let alertController = UIAlertController(title: "New Item", message: "Add new item", preferredStyle: .alert)
        
        let addAction = UIAlertAction(title: "Add", style: .default) { (UIAlertAction) in
            guard let newItemName = itemTextField?.text, !newItemName.isEmpty else {return}
            ItemController.shared.addItem(named: newItemName)
            self.setUpSections()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        alertController.addTextField { (newItemInput) in
            itemTextField = newItemInput
            itemTextField?.placeholder = "New Item here..."
        }
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
        
    }
    
    //MARK: - Helper functions
    func setUpSections(){
        sections = []
        let itemsBought = ItemController.shared.items.filter({$0.hasBought})
        let itemsNotBought = ItemController.shared.items.filter({!$0.hasBought})
        sections.append(itemsBought)
        sections.append(itemsNotBought)
        tableView.reloadData()
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = section == 0 ? "Already bought" : "Need to buy"
        label.backgroundColor = section == 0 ? .systemGreen : .systemRed
        return label
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return sections[section].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ItemTableViewCell else {return UITableViewCell()}
        
        cell.item = sections[indexPath.section][indexPath.row]
        cell.delegate = self
        return cell
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let itemToDelete = sections[indexPath.section][indexPath.row]
            ItemController.shared.deleteItem(item: itemToDelete)
            //remove from temporary array
            sections[indexPath.section].remove(at: indexPath.row)
            //delete from tableView
            tableView.deleteRows(at: [indexPath], with: .fade)
            //reload with new data
            setUpSections()
        }
    }
    
    //MARK: - Navigation Function
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItem = sections[indexPath.section][indexPath.row]
        performSegue(withIdentifier: "goToItem", sender: self)
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToItem" {
         let destination = segue.destination as? DetailViewController
         destination?.item = selectedItem
        }
    }
    
    
}

extension ItemTableViewController: ItemTappedDelegate{
    func itemWasTapped(_ sender: ItemTableViewCell) {
        guard let tappedItem = sender.item else {return}
        ItemController.shared.toggleHasBought(item: tappedItem)
        sender.updateView()
        setUpSections()
    }
    
    
}
