//
//  ViewModel.swift
//  RealmTODO
//
//  Created by 木村朋広 on 2024/03/02.
//

import Foundation
import SwiftUI
import RealmSwift

class ViewModel: ObservableObject {
    @Published var model: TODOModel = TODOModel()

    var todoItems: Results<TODOItem> {
        model.items
    }

    func addTODOItem(_ title: String, detail: String = "") {
        objectWillChange.send()
        model.addTODOItem(title, detail: detail)
    }
}

