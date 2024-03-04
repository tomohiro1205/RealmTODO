//
//  coordinator.swift
//  RealmTODO
//
//  Created by 木村朋広 on 2024/03/04.
//

import Foundation
import SwiftUI

class Coordinator: ObservableObject {
    @ViewBuilder
    func nextView(_ item: TODOItem) -> some View {
        DetailView(item: item)
    }
}
