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

    func undo() {
        guard undoable else { return }
        objectWillChange.send()
        model.undo()
    }

    func redo() {
        guard redoable else { return }
        objectWillChange.send()
        model.redo()
    }

    var undoable: Bool {
        return model.undoable
    }
    var redoable: Bool {
        return model.redoable
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

extension ViewModel {
    func updateTODOItemTitle(_ id: TODOItem.ID, newTitle: String) {
//        let command = TODOModel.UpdateTODOItemTitle(id, newTitle: newTitle)
//        let command = TODOModel.UpdateTODOItemString(id, keyPath: \TODOItem.title, newValue: newTitle)
        let command = TODOModel.UpdateTODOItemProperty(id, keyPath: \TODOItem.title, newValue: newTitle)
        objectWillChange.send()
        model.executeCommand(command)
    }

    func updateTODOItemDetail(_ id: TODOItem.ID, newDetail: String) {
        let command = TODOModel.UpdateTODOItemProperty(id, keyPath: \TODOItem.title, newValue: newDetail)
        objectWillChange.send()
        model.executeCommand(command)
    }
}
