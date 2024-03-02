//
//  RealmTODOApp.swift
//  RealmTODO
//
//  Created by 木村朋広 on 2024/03/02.
//

import SwiftUI

@main
struct RealmTODOApp: App {
    @StateObject var viewModel = ViewModel()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(viewModel)
        }
    }
}
