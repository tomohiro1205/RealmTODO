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
            }
            .navigationTitle("RealmTODO")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("#: \(viewModel.todoItems.count)")
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
