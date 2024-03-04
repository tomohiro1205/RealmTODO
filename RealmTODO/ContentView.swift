//
//  ContentView.swift
//  RealmTODO
//
//  Created by 木村朋広 on 2024/03/02.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewModel: ViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.todoItems.freeze()) { item in
                    Text("\(item.title)")
                }
                // onDelete 内で、削除処理
                .onDelete { indexSet in
                    if let index = indexSet.first {
                        // viewModel には、removeTODOItem メソッドを作成予定
                        viewModel.removeTODOItem(viewModel.todoItems[index].id)
                    }
                }
            }
            .navigationTitle("RealmTODO")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
#if os(iOS)
                        EditButton()
#endif

                        Text("#: \(viewModel.todoItems.count)")
                    }
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateStyle = .short
                        dateFormatter.timeStyle = .long
                        let itemName = dateFormatter.string(from: Date())
                        viewModel.addTODOItem(itemName)
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(ViewModel())
    }
}
