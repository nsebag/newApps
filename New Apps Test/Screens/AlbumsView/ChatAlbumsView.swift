//
//  AlbumsView.swift
//  New Apps Test
//
//  Created by The Sebag Company on 12/03/2024.
//

import SwiftUI

struct ChatAlbumsView: View {
    @Environment(\.dismiss)
    private var dismiss
    
    @EnvironmentObject
    private var chatAlbumsViewModel: ChatAlbumsViewModel
    
    @State
    private var selectedAlbum: ChatAlbum?
    
    var body: some View {
        NavigationStack {
            listView
                .navigationTitle("Albums")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(
                            action: dismiss.callAsFunction,
                            label: {
                                Image(systemName: "xmark")
                                    .font(.system(size: 16, weight: .bold))
                                    .contentTransition(.symbolEffect(.replace))
                                    .foregroundColor(.white)
                                    .padding(8)
                                    .scaledToFit()
                            }
                        )
                    }
                }
                .navigationDestination(item: $selectedAlbum) { album in
                    ChatView(chatAlbum: album)
                }
        }
        .tint(.white)
    }
}

// MARK: - ViewBuilders
private extension ChatAlbumsView {
    
    var listView: some View {
        List(chatAlbumsViewModel.chatAlbums) { chatAlbum in
            Button(
                action: {
                    selectedAlbum = chatAlbum
                },
                label: {
                    listCell(for: chatAlbum)
                }
            )
            .listRowInsets(
                EdgeInsets(
                    top: 8,
                    leading: 16,
                    bottom: 8,
                    trailing: 16
                )
            )
            .listRowSeparator(.hidden)
            .scaledToFit()
        }
        .listStyle(.plain)
    }
    
    
    func listCell(for chatAlbum: ChatAlbum) -> some View {
        VStack {
            HStack {
                Text(chatAlbum.title)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
             
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
            }
                
            imageLayout(for: chatAlbum)
                .frame(maxHeight: 300)
            
            friendsScrollView(for: chatAlbum.users)
        }
    }
    
    // NOTE: A Layout struct would be better to handle this, for time reasons, we will hack it around
    func imageLayout(for chatAlbum: ChatAlbum) -> some View {
        HStack {
            asyncImage(for: chatAlbum.images.first)
                .scaledToFill()
                .frame(maxHeight: 300)
                .clipShape(RoundedRectangle(cornerRadius: 16))

            if chatAlbum.images.count > 1 {
                VStack {
                    ForEach(1..<3) { idx in
                        if idx < chatAlbum.images.count {
                            asyncImage(for: chatAlbum.images[idx])
                                .scaledToFill()
                                .frame(maxHeight: 150)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                        }
                    }
                }
            }
        }
    }
    
    func friendsScrollView(for users: [User]) -> some View {
        ScrollView(.horizontal) {
            HStack(spacing: 8) {
                ForEach(users) { user in
                    HStack(spacing: 8) {
                        asyncImage(for: user.picture)
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(width: 42, height: 42, alignment: .center)
                        
                        Text(user.name)
                            .font(.subheadline)
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
    }
    
    func asyncImage(for url: URL?) -> some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
        } placeholder: {
            Rectangle()
                .fill(.thickMaterial)
        }

    }
}

#Preview {
    ChatAlbumsView()
        .environmentObject(ChatAlbumsViewModel())
}
