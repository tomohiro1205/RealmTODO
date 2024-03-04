//
//  Model+Command.swift
//  RealmTODO
//
//  Created by 木村朋広 on 2024/03/04.
//

import Foundation

protocol TODOModelCommand: AnyObject {
    func execute(_ model: TODOModel)
}

extension TODOModel {
    class CreateTODOItemCommand: TODOModelCommand {
        var title: String = ""
        var detail: String = ""

        init(_ title: String, detail: String = "") {
            self.title = title
            self.detail = detail
        }

        func execute(_ model: TODOModel) {
            let newItem = TODOItem()
            newItem.id = UUID()
            newItem.title = title
            newItem.detail = detail

            try! model.realm.write {
                model.realm.add(newItem)
            }
        }
    }
    class RemoveTODOItemCommand: TODOModelCommand {
        var id: UUID

        init(_ id: TODOItem.ID) {
            self.id = id
        }

        func execute(_ model: TODOModel) {
            guard let itemToBeRemoved = model.itemFromID(self.id) else { return } // no item
            try! model.realm.write {
                model.realm.delete(itemToBeRemoved)
            }
        }
    }
}
