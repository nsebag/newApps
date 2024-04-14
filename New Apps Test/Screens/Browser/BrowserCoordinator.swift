//
//  BrowserCoordinator.swift
//  New Apps Test
//
//  Created by The Sebag Company on 14/04/2024.
//

import Foundation
import SwiftUI

enum BrowserRoute: Hashable {
    case imagePicker
}

class BrowserCoordinator: ObservableObject {
    @Published
    var navigationPath: NavigationPath = .init()
    
    func routeTo(_ route: BrowserRoute) {
        navigationPath.append(route)
    }
}
