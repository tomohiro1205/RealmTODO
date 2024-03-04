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

    var todoItems: Results <TODOItem>{
        model.items
    }

    func addTODOItem(_ title: String, detail: String = "") {
        let command = TODOModel.CreateTODOItemCommand(title, detail: detail)
        objectWillChange.send()
        model.executeCommand(command)
    }
    func removeTODOItem(_ id: TODOItem.ID) {
           // (1) RemoveTODOItemCommand を用意
           let command = TODOModel.RemoveTODOItemCommand(id)
           // (2) Model が変更されることを通知
           objectWillChange.send()
           // (3) Command を実行
           model.executeCommand(command)
       }
}

