//
//  DetailView.swift
//  RealmTODO
//
//  Created by 木村朋広 on 2024/03/04.
//

import Foundation
import SwiftUI

struct DetailView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss

    let item: TODOItem
    @State private var title = ""
    @State private var detail = ""

    var body: some View {
        List {
            HStack {
                Text("Title :").font(.caption).frame(width: 40)
                TextField("Title", text: $title)
                    .onAppear {
                        self.title = item.title
                    }
                    .textFieldStyle(.roundedBorder)
            }
            HStack {
                Text("Detail :").font(.caption).frame(width: 40)
                TextField("Detail", text: $detail)
                    .onAppear {
                        self.detail = item.detail
                    }
                    .textFieldStyle(.roundedBorder)
            }
            HStack {
                Spacer()
                Button(action: {
                    dismiss()
                }, label: {
                    Text("cancel").font(.title)
                })
                .buttonStyle(.borderless)
                Spacer()
                Button(action: {
                    if title != item.title {
                        viewModel.updateTODOItemTitle(item.id, newTitle: title)
                    }
                    if title != item.detail {
                        viewModel.updateTODOItemDetail(item.id, newDetail: detail)
                    }
                    dismiss()
                }, label: {
                    Text("update").font(.title)
                })
                .buttonStyle(.borderless)
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
