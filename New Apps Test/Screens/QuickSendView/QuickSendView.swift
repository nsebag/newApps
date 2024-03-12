//
//  QuickSendView.swift
//  New Apps Test
//
//  Created by The Sebag Company on 12/03/2024.
//

import SwiftUI

struct QuickSendView: View {
    @EnvironmentObject
    private var chatAlbumsViewModel: ChatAlbumsViewModel
    
    var body: some View {
        List(chatAlbumsViewModel.chatAlbums) { chatAlbum in
            QuickSendViewCell(chatAlbum: chatAlbum)
                .listRowInsets(
                    EdgeInsets(
                        top: 4,
                        leading: 4,
                        bottom: 4,
                        trailing: 4
                    )
                )
                .listRowBackground(Color.clear)
        }
        .buttonStyle(.plain)
        .listStyle(.plain)
    }
}

#Preview {
    QuickSendView()
}
