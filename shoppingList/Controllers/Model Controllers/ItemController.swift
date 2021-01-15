//
//  ItemController.swift
//  shoppingList
//
//  Created by Chris Withers on 1/15/21.
//

import Foundation

class ItemController: Codable {
    
    static var shared = ItemController()
    
    var items: [Item] = []
    
    func addItem(named: String){
        let newItem = Item(title: named)
        items.append(newItem)
        saveToPersistenceStore()
    }
    
    func deleteItem(item: Item){
        guard let index = items.firstIndex(of: item) else {return}
        items.remove(at: index)
        saveToPersistenceStore()
    }
    
    func toggleHasBought(item: Item){
        item.hasBought.toggle()
        saveToPersistenceStore()
    }
    
    //MARK:- Persistence functions
    func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent("shoppinglist.json")
        return fileURL
        
    }
    
    //save
    func saveToPersistenceStore() {
        do{
            let data = try JSONEncoder().encode(items)
            try data.write(to: fileURL())
        }catch{
            print("Error saving data: \(error.localizedDescription)")
        }
    }
    
    //load
    func loadFromPersistenceStore() {
        do{
            let data = try Data(contentsOf: fileURL())
            items = try JSONDecoder().decode([Item].self, from: data)
        }catch {
            print("Error loading data \(error.localizedDescription)")
        }
        
    }
    
}
