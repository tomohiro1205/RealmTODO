//
//  Model.swift
//  RealmTODO
//
//  Created by 木村朋広 on 2024/03/02.
//


import Foundation
import RealmSwift

class TODOModel: ObservableObject {
    var config: Realm.Configuration
    var undoStack: [TODOModelCommand] = []
    var redoStack: [TODOModelCommand] = []

    init() {
        config = Realm.Configuration()
    }

    var realm: Realm {
        return try! Realm(configuration: config)
    }

    var items: Results<TODOItem> {
        realm.objects(TODOItem.self)
    }

    func itemFromID(_ id: TODOItem.ID) -> TODOItem? {
        items.first(where: {$0.id == id})
    }

    func executeCommand(_ command: TODOModelCommand) {
        redoStack = []
        command.execute(self)
        undoStack.append(command)
    }

    var undoable: Bool {
        return !undoStack.isEmpty
    }
    var redoable: Bool {
        return !redoStack.isEmpty
    }

    func undo() {
        guard let undoCommand = undoStack.popLast() else { return }
        undoCommand.undo(self)
        redoStack.append(undoCommand)
    }

    func redo() {
        guard let redoCommand = redoStack.popLast() else { return }
        redoCommand.execute(self)
        undoStack.append(redoCommand)
    }
}


class TODOItem: Object, Identifiable {
    @Persisted(primaryKey: true) var id: UUID = UUID()
    @Persisted var title: String
    @Persisted var detail: String
}
