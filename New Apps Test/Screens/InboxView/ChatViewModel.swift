//
//  ChatViewModel.swift
//  New Apps Test
//
//  Created by The Sebag Company on 12/03/2024.
//

import Foundation

// NOTE: For mock simplicity, I did not add relations between models here
struct ChatMessage: Identifiable {
    let id = UUID()
    let body: String
    let image: URL?
    let user: String
    let sentByMe: Bool
    
    init(body: String, image: URL?, user: String, sentByMe: Bool = false) {
        self.body = body
        self.image = image
        self.user = user
        self.sentByMe = sentByMe
    }
}

class ChatViewModel: ObservableObject {
    // NOTE: I will not be using the ChatService for time reasons, but it would belongs in my current MVVM.
    @Published private(set) var messages: [ChatMessage] = []
    @Published var currentMessage: String = ""
    
    let chatAlbum: ChatAlbum
    
    init(chatAlbum: ChatAlbum) {
        self.messages = []
        self.chatAlbum = chatAlbum
        self.messages = makeMock()
    }
    
    func getRandomAlbumImage() -> URL {
        let randomIndex = Int.random(in: 0..<chatAlbum.images.count)
        return chatAlbum.images[randomIndex]
    }
    
    func sendMessage() {
        guard !currentMessage.isEmpty else { return }
        messages.append(
            ChatMessage(
                body: currentMessage,
                image: nil,
                user: "Me",
                sentByMe: true
            )
        )
        currentMessage = ""
    }
}

// MARK: - Mock method
private extension ChatViewModel {
    func makeMock() -> [ChatMessage] {
        [
            ChatMessage(
                body: "Checkout this pic",
                image: chatAlbum.images.first,
                user: "John"
            ),
            ChatMessage(
                body: "Wow looks so great",
                image: nil,
                user: "Me",
                sentByMe: true
            )
        ]
    }
}
