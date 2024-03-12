//
//  AlbumsViewModel.swift
//  New Apps Test
//
//  Created by The Sebag Company on 12/03/2024.
//

import Foundation

// NOTE: A real life scenario would have optionals here
struct User: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let picture: URL
}

// NOTE: A real life scenario would have optionals here
struct ChatAlbum: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let images: [URL]
    let users: [User]
}

class ChatAlbumsViewModel: ObservableObject {
    @Published
    private(set) var chatAlbums: [ChatAlbum]
    
    init() {
        self.chatAlbums = []
        self.chatAlbums = makeMock()
    }
}


// MARK: This extension is used to create mock data for this part of the app
private extension ChatAlbumsViewModel {
    func makeMock() -> [ChatAlbum] {
        [
            ChatAlbum(
                title: "California",
                images: [
                    URL(string: "https://images.unsplash.com/photo-1594365458706-6fab3472f681?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8Y2FsaWZvcm5pYXxlbnwwfHwwfHx8MA%3D%3D")!,
                    URL(string: "https://images.unsplash.com/photo-1458777455172-e3f6e7805b80?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fHRvcGFuZ2ElMjBjYW55b258ZW58MHx8MHx8fDA%3D")!,
                    URL(string: "https://images.unsplash.com/photo-1609623279016-698dc83c2841?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8c2FudGElMjBiYXJiYXJhfGVufDB8fDB8fHww")!
                ],
                users: [
                    .init(
                        name: "John",
                        picture: URL(string: "https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?q=80&w=400&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")!
                    ),
                    .init(
                        name: "Lea",
                        picture: URL(string: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=400&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")!
                    ),
                    .init(
                        name: "Paul",
                        picture: URL(string: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=400&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")!
                    ),
                    .init(
                        name: "Michel",
                        picture: URL(string: "https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?q=80&w=400&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")!
                    ),
                    .init(
                        name: "Clementine",
                        picture: URL(string: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=400&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")!
                    ),
                ]
            ),
            ChatAlbum(
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
            ),
            ChatAlbum(
                title: "Planes",
                images: [
                    URL(string: "https://images.unsplash.com/photo-1604251204948-22773e22a03d?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjR8fHBsYW5lc3xlbnwwfHwwfHx8MA%3D%3D")!
                ],
                users: [
                    .init(
                        name: "John",
                        picture: URL(string: "https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?q=80&w=400&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")!
                    ),
                    .init(
                        name: "Paul",
                        picture: URL(string: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=400&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")!
                    )
                ]
            ),
            ChatAlbum(
                title: "Space",
                images: [
                    URL(string: "https://images.unsplash.com/photo-1551871812-10ecc21ffa2f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fHJvY2tldHxlbnwwfHwwfHx8MA%3D%3D")!,
                    URL(string: "https://images.unsplash.com/photo-1457364887197-9150188c107b?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8cm9ja2V0fGVufDB8fDB8fHww")!,
                    URL(string: "https://images.unsplash.com/photo-1454789548928-9efd52dc4031?q=80&w=400&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")!,
                    URL(string: "https://images.unsplash.com/photo-1446776811953-b23d57bd21aa?q=80&w=400&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")!,
                    URL(string: "https://images.unsplash.com/photo-1610296669228-602fa827fc1f?q=80&w=400&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")!
                ],
                users: [
                    .init(
                        name: "John",
                        picture: URL(string: "https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?q=80&w=400&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")!
                    ),
                    .init(
                        name: "Lea",
                        picture: URL(string: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=400&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")!
                    ),
                    .init(
                        name: "Paul",
                        picture: URL(string: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=400&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")!
                    )
                ]
            )
        ]
    }
}
