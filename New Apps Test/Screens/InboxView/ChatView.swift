//
//  ChatView.swift
//  New Apps Test
//
//  Created by The Sebag Company on 12/03/2024.
//

import SwiftUI

struct ChatView: View {
    @StateObject
    private var viewModel: ChatViewModel
    
    @FocusState
    private var isFocused: Bool
    
    init(chatAlbum: ChatAlbum) {
        _viewModel = StateObject(wrappedValue: ChatViewModel(chatAlbum: chatAlbum))
    }
    
    var body: some View {
        chatView
            .navigationTitle(viewModel.chatAlbum.title)
            .toolbarTitleDisplayMode(.inline)
            .toolbar {
                Button(
                    action: {
                        // TODO: Route to full album
                    },
                    label: {
                        Image(systemName: "photo.stack")
                    }
                )
            }
            .background {
                AsyncImage(url: viewModel.chatAlbum.images[viewModel.randomIndex]) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .overlay {
                            Rectangle()
                                .fill(.black.opacity(0.9))
                        }
                } placeholder: {
                    Rectangle()
                        .fill(.thickMaterial)
                }
                .ignoresSafeArea()
            }
    }
}

// MARK: - ViewBuilders
private extension ChatView {
    var chatView: some View {
        VStack(spacing: 0) {
            chatMessages
                .onTapGesture {
                    guard isFocused else { return }
                    isFocused.toggle()
                }
            
            chatInput
        }
    }
    
    var chatMessages: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 24) {
                ForEach(viewModel.messages) { message in
                    HStack {
                        if message.sentByMe {
                            Spacer()
                        }
                        
                        messageBody(from: message)
                        
                        if !message.sentByMe {
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 16)
                    .id(message.id)
                }
            }
            .scrollTargetLayout()
            .padding(.vertical, 16)
        }
        .defaultScrollAnchor(.bottom)
        .scrollIndicators(.hidden)
    }
    
    func messageBody(from message: ChatMessage) -> some View {
        VStack(spacing: 8) {
            if let url = message.image {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 250)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                } placeholder: {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.ultraThickMaterial)
                }
                .padding(4)
            }
            
            Text(message.body)
                .font(.body)
                .foregroundStyle(message.sentByMe ? .white : .black)
                .frame(
                    maxWidth: message.image == nil ? nil : 250,
                    alignment: message.sentByMe ? .trailing : .leading
                )
                .multilineTextAlignment(message.sentByMe ? .trailing : .leading)
                .padding(4)
        }
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(message.sentByMe ? .blue : .white)
        }
    }
    
    var chatInput: some View {
        HStack(spacing: 8) {
            chatTextField
            
            Button(
                action: {
                    withAnimation(.spring) {
                        viewModel.sendMessage()
                    }
                },
                label: {
                    Image(systemName: "paperplane")
                }
            )
            .disabled(viewModel.currentMessage == "")
        }
        .padding([.top, .horizontal], 8)
        .background(.black, ignoresSafeAreaEdges: .bottom)
    }
    
    var chatTextField: some View {
        TextField(text: $viewModel.currentMessage, axis: .vertical) {
            Text("Type message here..")
                .font(.body)
        }
        .textFieldStyle(.roundedBorder)
        .lineLimit(4)
        .focused($isFocused)
        .padding(.vertical, 4)
        .padding(.horizontal, 8)
    }
}

#Preview {
    NavigationStack {
        ChatView(
            chatAlbum: ChatAlbum(
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
            )
        )
    }
}
