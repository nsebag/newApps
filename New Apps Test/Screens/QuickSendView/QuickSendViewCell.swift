//
//  QuickSendViewCell.swift
//  New Apps Test
//
//  Created by The Sebag Company on 12/03/2024.
//

import SwiftUI

struct QuickSendViewCell: View {
    @State
    private var sent: Bool = false
    let chatAlbum: ChatAlbum
    
    var body: some View {
        HStack {
            Text(chatAlbum.title)
                .font(.headline)
            
            Spacer()
            
            Button(
                action: { 
                    sent = true
                },
                label: {
                    Image(systemName: sent ? "checkmark" : "paperplane")
                        .font(.callout)
                        .contentTransition(.symbolEffect(.replace))
                }
            )
        }
    }
}

#Preview {
    QuickSendViewCell(
        chatAlbum: ChatAlbum(
            title: "Desert",
            images: [
                URL(string: "https://images.unsplash.com/photo-1509316785289-025f5b846b35?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8ZGVzZXJ0fGVufDB8fDB8fHww")!,
                URL(string: "https://images.unsplash.com/photo-1547235001-d703406d3f17?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8ZGVzZXJ0fGVufDB8fDB8fHww")!                ],
            users: [
                .init(
                    name: "Lea",
                    picture: URL(string: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=400&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")!
                )
            ]
        )
    )
}
