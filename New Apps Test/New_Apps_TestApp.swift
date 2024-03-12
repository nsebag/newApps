//
//  New_Apps_TestApp.swift
//  New Apps Test
//
//  Created by Michel-André Chirita on 06/03/2024.
//

import SwiftUI

@main
struct New_Apps_TestApp: App {
    var body: some Scene {
        WindowGroup {
            ImagesView()
                /*
                 * NOTE: Sending environment viewmodel to comply with a more "real-life" pattern
                 * In a real life scenario, the chat would be initialized at some post-login navigation root, to ensure that websockets/webhooks used for chat are kept alive 
                 */
                .environmentObject(ChatAlbumsViewModel())
        }
    }
}
