//
//  ProductViewModel.swift
//  Catberries
//
//  Created by Илья Черницкий on 30.07.23.
//

struct Item {
    let name: String
}

class ProductViewModel {
    var items: [Item] = [
        Item(name: "Item 1"),
        Item(name: "Item 2"),
        Item(name: "Item 3"),
        Item(name: "Item 4"),
        Item(name: "Item 5"),
        Item(name: "Item 6"),
        Item(name: "Item 7"),
        Item(name: "Item 8"),
        Item(name: "Item 9"),
        Item(name: "Item 10"),
        Item(name: "Item 11"),
        Item(name: "Item 12"),
        Item(name: "Item 13"),
        Item(name: "Item 14"),
        Item(name: "Item 1"),
        Item(name: "Item 2"),
        Item(name: "Item 3"),
        Item(name: "Item 4"),
        Item(name: "Item 5"),
        Item(name: "Item 6"),
        Item(name: "Item 7"),
        Item(name: "Item 8"),
        Item(name: "Item 9"),
        Item(name: "Item 10"),
        Item(name: "Item 11"),
        Item(name: "Item 12"),
        Item(name: "Item 13"),
        Item(name: "Item 14"),
        Item(name: "Item 1"),
        Item(name: "Item 2"),
        Item(name: "Item 3"),
        Item(name: "Item 4"),
        Item(name: "Item 5"),
        Item(name: "Item 6"),
        Item(name: "Item 7"),
        Item(name: "Item 8"),
        Item(name: "Item 9"),
        Item(name: "Item 10"),
        Item(name: "Item 11"),
        Item(name: "Item 12"),
        Item(name: "Item 13"),
        Item(name: "Item 14")
    ]
    
    var filteredItems: [Item] = []
    
    func filterItems(with searchText: String) {
        filteredItems = items.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }
}

