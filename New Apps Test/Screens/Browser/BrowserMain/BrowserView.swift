//
//  BrowserView.swift
//  New Apps Test
//
//  Created by The Sebag Company on 13/04/2024.
//

import SwiftUI

struct BrowserView: View {
    @EnvironmentObject
    private var viewModel: BrowserViewModel
    @EnvironmentObject
    private var coordinator: BrowserCoordinator
    
    @State
    private var messageBody: String = ""
    @FocusState
    private var isFocused: Bool

    @Binding
    var currentDetent: PresentationDetent
    
    var body: some View {
        ScrollViewReader { scrollProxy in
            contentList
                .animation(.spring, value: viewModel.selectedAlbumId)
                .animation(.spring, value: viewModel.selectedFriendId)
                .withMessageBar(
                    isVisible: viewModel.selectedAlbumId != nil,
                    onSend: { body in
                        viewModel.sendMessage(body)
                    },
                    onFocusChange: { isFocused in
                        if isFocused {
                            self.currentDetent = .large
                            withAnimation(.spring) {
                                scrollProxy.scrollTo("chatSection", anchor: .bottom)
                            }
                        }
                    }
                )
        }
    }
}

// MARK: ViewBuilders
private extension BrowserView {
    
    var contentList: some View {
        List {
            Group {
                friendsSection
                    .id("friendsSection")
                
                if let album = viewModel.albums.first(where: { $0.id == viewModel.selectedAlbumId }) {
                    albumDetails(for: album)
                        .id("albumDetails")
                    
                    chatSection(for: album)
                        .id("chatSection")
                } else {
                    albumsSection
                        .id("albumsSection")
                    
                    createAlbum
                        .id("createAlbum")
                }
            }
            .listRowInsets(EdgeInsets())
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
        .environment(\.defaultMinListHeaderHeight, 0)
        .frame(maxHeight: UIScreen.main.bounds.height)
    }
    
}

// MARK: Albums Section Builder
private extension BrowserView {
    var albumsSection: some View {
        Section {
            ScrollView(.horizontal) {
                HStack(spacing: 16) {
                    allAlbumsStack
                }
                .padding(.horizontal, 16)

            }
            .scrollIndicators(.hidden)
        } header: {
            makeSectionTitle(with: "Albums")
        }
        .listSectionSpacing(0)
    }
    
    @ViewBuilder
    var allAlbumsStack: some View {
        ForEach(viewModel.albums) { album in
            Button(
                action: {
                    viewModel.selectAlbum(from: album.id)
                },
                label: {
                    albumButton(for: album)
                }
            )
        }
    }

    func albumButton(for album: Album) -> some View {
        VStack {
            AsyncImage(url: album.photos.first?.image) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .overlay {
                        if viewModel.selectedAlbumId == album.id {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.white, lineWidth: 4)
                        }
                    }
                    .overlay {
                        Color.black.opacity(0.4)
                    }
                    
            } placeholder: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Material.thin)
            }
            .frame(width: 150, height: 100, alignment: .center)
            .mask(RoundedRectangle(cornerRadius: 8))
            .overlay {
                Text(album.name)
                    .font(.title2.bold())
                    .foregroundStyle(.white)
            }
        }
    }
}

// MARK: Albums Details Builder
private extension BrowserView {
    func albumDetails(for album: Album) -> some View {
        Section {
            VStack {
                albumCaroussel(for: album)
            }
        } header: {
            HStack {
                Text(album.name)
                    .font(.title.bold())
                    .foregroundStyle(.white)

                Spacer()
                
                Button("Clear") {
                    currentDetent = .medium
                    viewModel.selectAlbum(from: nil)
                }
            }
            
            .padding(.horizontal, 16)

        }
    }
    
    func albumCaroussel(for album: Album) -> some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 16) {
                ForEach(album.photos) { photo in
                    Button(
                        action: {
                            viewModel.focusedPhoto = photo
                        },
                        label: {
                            PlacemarkedPhoto(photo: photo)
                        }
                    )
                    .id("image_detail_\(album.id)_\(photo.id)")
                }
                
                Button(
                    action: { },
                    label: {
                        VStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Material.thin)
                                .overlay {
                                    Text("Add +")
                                        .font(.title.bold())
                                }
                                .frame(height: 100)
                            
                            Spacer()
                        }
                    }
                )
                .frame(width: UIScreen.main.bounds.width  / 2)
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
        .scrollPosition(id: $viewModel.selectedImageId, anchor: .leading)
        .safeAreaPadding(.horizontal, 16)
        .padding(.vertical, 8)
        .scrollIndicators(.hidden)
        .id("carousselOfAlbum\(album.id)")
    }
    
    func albumPhoto(for photo: PhotoItem) -> some View {
        AsyncImage(url: photo.image) { image in
            image
                .resizable()
                .scaledToFit()
                .clipped()
            
        } placeholder: {
            RoundedRectangle(cornerRadius: 8)
                .fill(Material.thin)
        }
        .frame(maxWidth: UIScreen.main.bounds.width - 32, alignment: .center)
        .frame(maxHeight: 120)
        .mask(RoundedRectangle(cornerRadius: 8))
    }
}

// MARK: Friends Section Builder
private extension BrowserView {
    
    var friendsSection: some View {
        Section {
            ScrollView(.horizontal) {
                friendsStack
            }
            .scrollIndicators(.hidden)
        } header: {
            HStack {
                makeSectionTitle(with: "Friends")
                Spacer()
                if viewModel.selectedFriendId != nil {
                    Button("Clear") {
                        viewModel.selectFriend(from: nil)
                    }
                    .padding(.trailing, 16)
                }
            }
        }
    }
    
    var friendsStack: some View {
        HStack(spacing: 16) {
            ForEach(viewModel.friends) { friend in
                Button(
                    action: {
                        viewModel.selectFriend(from: friend.id)
                    },
                    label: {
                        VStack {
                            friendProfile(for: friend.profilePic)
                                .frame(width: 60, height: 60, alignment: .center)
                                .mask(Circle())

                            Text(friend.username)
                                .font(.footnote)
                                .foregroundStyle(.white)
                        }
                    }
                )
                .id("profilePic_\(friend.username)")
            }
        }
        .padding(.horizontal, 16)
    }
    
    func friendProfile(for url: URL?) -> some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            Circle()
                .fill(Material.thin)
        }
        .id(url)
    }
}

// MARK: Chat Section Builder
private extension BrowserView {
    func chatSection(for album: Album) -> some View {
        Section {
            ScrollView {
                chatScrollView(for: album)
            }
            .defaultScrollAnchor(.bottom)
        } header: {
            VStack(spacing: 4) {
                Text("Messages")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Divider()
            }
        }
        .padding(.horizontal, 16)
    }
    
    func chatScrollView(for album: Album) -> some View {
        VStack {
            Spacer()
            ForEach(album.messages) { message in
                if message.sender == viewModel.currentUser {
                    userChatCell(for: message)
                } else {
                    chatCell(for: message)
                }
            }
        }
    }
    
    func userChatCell(for message: Message) -> some View {
        HStack(alignment: .top, spacing: 16) {
            Spacer()

            Text(message.body)
                .font(.body)
                .padding(8)
                .foregroundStyle(.black)
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.white.opacity(0.8))
                }
                .frame(
                    maxWidth: UIScreen.main.bounds.width * 2/3,
                    alignment: .trailing
                )
            
            friendProfile(for: message.sender.profilePic)
                .mask(Circle())
                .frame(width: 40, height: 40)
        }
        .padding(.top, 16)
    }
    
    func chatCell(for message: Message) -> some View {
        HStack(alignment: .top, spacing: 16) {
            friendProfile(for: message.sender.profilePic)
                .mask(Circle())
                .frame(width: 40, height: 40)
            
            Text(message.body)
                .font(.body)
                .padding(8)
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.blue)
                }
                .frame(
                    maxWidth: UIScreen.main.bounds.width * 2/3,
                    alignment: .leading
                )
            
            Spacer()
        }
        .padding(.top, 16)
    }

}

// MARK: Common ViewBuilders
private extension BrowserView {
    var createAlbum: some View {
        Button(
            action: {
                withAnimation(.spring, completionCriteria: .logicallyComplete) {
                    currentDetent = .large
                } completion: {
                    coordinator.routeTo(.imagePicker)
                }
            },
            label: {
                Text("Create new Album")
                    .font(.title3.bold())
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(.white)
                    .padding(.vertical, 8)
            }
        )
        .buttonStyle(.bordered)
        .overlay(content: {
            NavigationLink(value: BrowserRoute.imagePicker) { }
                .opacity(0)
        })
        .frame(maxWidth: .infinity)
        .padding(24)
    }
        
    func makeSectionTitle(with text: String) -> some View {
        Text(text)
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
    }
}


#Preview {
    BrowserStack(currentDetent: .constant(.medium))
        .environmentObject(BrowserViewModel())
        .environmentObject(BrowserCoordinator())
}
