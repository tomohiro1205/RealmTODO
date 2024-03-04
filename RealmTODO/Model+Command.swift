//
//  Model+Command.swift
//  RealmTODO
//
//  Created by 木村朋広 on 2024/0/04.
//

import Foundation

protocol TODOModelCommand: AnyObject {
    func execute(_ model: TODOModel)
    func undo(_ model: TODOModel)
}

extension TODOModel {
    class CreateTODOItemCommand: TODOModelCommand {
        var id: TODOItem.ID? = nil
        var title: String = ""
        var detail: String = ""

        init(_ title: String, detail: String = "") {
            self.title = title
            self.detail = detail
        }

        func execute(_ model: TODOModel) {
            let newItem = TODOItem()
            newItem.id = self.id ?? UUID()
            newItem.title = title
            newItem.detail = detail

            try! model.realm.write {
                model.realm.add(newItem)
            }
            id = newItem.id
        }
        func undo(_ model: TODOModel) {
            guard let id = self.id,
                  let item = model.itemFromID(id) else { return }
            try! model.realm.write {
                model.realm.delete(item)
            }
        }
    }
    class RemoveTODOItemCommand: TODOModelCommand {
        var id: UUID
        var title: String? = nil
        var detail: String? = nil

        init(_ id: TODOItem.ID) {
            self.id = id
        }

        func execute(_ model: TODOModel) {
            // save item info
            guard let itemToBeRemoved = model.itemFromID(self.id) else { return } // no item
            self.title = itemToBeRemoved.title
            self.detail = itemToBeRemoved.detail
            try! model.realm.write {
                model.realm.delete(itemToBeRemoved)
            }
        }
        func undo(_ model: TODOModel) {
            guard let title = self.title,
                  let detail = self.detail else { return }
            let item = TODOItem()
            item.id = self.id
            item.title = title
            item.detail = detail
            try! model.realm.write {
                model.realm.add(item)
                self.title = nil
                self.detail = nil
            }
        }
    }
    class UpdateTODOItemProperty<T>: TODOModelCommand {
        let id: TODOItem.ID
        let keyPath: ReferenceWritableKeyPath<TODOItem, T>
        let newValue: T
        var oldValue: T?

        init(_ id: TODOItem.ID, keyPath: ReferenceWritableKeyPath<TODOItem, T>, newValue: T) {
            self.id = id
            self.keyPath = keyPath
            self.newValue = newValue
            self.oldValue = nil
        }

        func execute(_ model: TODOModel) {
            guard let item = model.itemFromID(id) else { return }
            try! model.realm.write {
                self.oldValue = item[keyPath: keyPath]
                item[keyPath: keyPath] = newValue
            }
        }

        func undo(_ model: TODOModel) {
            guard let item = model.itemFromID(id) else { return }
            guard let oldValue = oldValue else { return } // not executed yet?
            try! model.realm.write {
                item[keyPath: keyPath]  = oldValue
            }
        }
    }
}
