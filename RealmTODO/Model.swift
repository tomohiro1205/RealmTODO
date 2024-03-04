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
        command.execute(self)
    }
}


class TODOItem: Object, Identifiable {
    @Persisted(primaryKey: true) var id: UUID = UUID()
    @Persisted var title: String
    @Persisted var detail: String
}
