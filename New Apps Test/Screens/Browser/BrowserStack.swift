//
//  BrowserStack.swift
//  New Apps Test
//
//  Created by The Sebag Company on 14/04/2024.
//

import SwiftUI

struct BrowserStack: View {
    @Binding
    var currentDetent: PresentationDetent
    @StateObject
    private var coordinator: BrowserCoordinator = .init()
    
    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            BrowserView(currentDetent: $currentDetent)
                .navigationDestination(for: BrowserRoute.self) { route in
                    switch route {
                    case .imagePicker:
                        NewAlbumView()
                            .task {
                                currentDetent = .large
                            }
                    }
                }
                .environmentObject(coordinator)
        }
    }
}

#Preview {
    BrowserStack(currentDetent: .constant(.medium))
}
