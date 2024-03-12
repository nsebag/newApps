//
//  ImageViewControlsOverlay.swift
//  New Apps Test
//
//  Created by The Sebag Company on 12/03/2024.
//

import SwiftUI

struct ImageViewControlsOverlay: View {
    enum SelectedControl {
        case messages
        case send
        
        var iconName: String {
            switch self {
            case .messages:
                "bubble.left.and.bubble.right"
            case .send:
                "paperplane"
            }
        }
    }
    
    @Namespace
    private var viewAppearance
    
    @State
    private var showAlbums: Bool = false
    
    @State
    private var sendOpened: Bool = false
    
    let screenHeight: CGFloat
    
    var body: some View {
        ZStack {
            if !sendOpened {
                VStack {
                    Spacer()
                    HStack {
                        bigButtonBase(
                            isSelected: false,
                            icon: "bubble.left.and.bubble.right",
                            action: {
                                showAlbums.toggle()
                            }
                        )
                    
                        Spacer()
                        
                        bigButtonBase(
                            isSelected: sendOpened,
                            icon: sendOpened ? "xmark" : "paperplane",
                            action: {
                                withAnimation(.interpolatingSpring) {
                                    sendOpened.toggle()
                                }
                            }
                        )
                        .matchedGeometryEffect(
                            id: "sendView",
                            in: viewAppearance,
                            properties: .size,
                            anchor: .center,
                            isSource: !sendOpened
                        )
                    }
                }
                .padding(24)

            } else if sendOpened {
                sendViewContainer
                    .matchedGeometryEffect(
                        id: "sendView",
                        in: viewAppearance,
                        properties: .frame,
                        anchor: .center,
                        isSource: sendOpened
                    )
                    .padding(16)

            }
        }
        .fullScreenCover(
            isPresented: $showAlbums,
            content: {
                ChatAlbumsView()
            }
        )
        .transition(.slide)
    }
}

// MARK: - ViewBuilders

private extension ImageViewControlsOverlay {
    func bigButtonBase(isSelected: Bool, icon: String, action: @escaping () -> Void) -> some View {
        Circle()
            .fill(.white)
            .frame(width: 50, height: 50, alignment: .center)
            .overlay {
                Button(
                    action: action,
                    label: {
                        Image(systemName: icon)
                            .font(.system(size: 16, weight: .semibold))
                            .contentTransition(.symbolEffect(.replace))
                            .foregroundColor(.black)
                            .padding(16)
                            .scaledToFit()
                    }
                )
            }
    }
}

// MARK: - Views
private extension ImageViewControlsOverlay {
    var sendViewContainer: some View {
        VStack {
            Spacer()
            
            RoundedRectangle(cornerRadius: 32)
                .fill(.thinMaterial)
                .overlay {
                    VStack {
                        HStack {
                            Text("Add to album")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Button(
                                action: {
                                    withAnimation(.interpolatingSpring) {
                                        sendOpened.toggle()
                                    }
                                },
                                label: {
                                    Image(systemName: "xmark")
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundColor(.white)
                                        .padding(8)
                                        .scaledToFit()
                                }
                            )
                        }
                        
                        QuickSendView()
                    }
                    .padding()
                }
                .frame(maxHeight: screenHeight / 2)
        }
    }
}

#Preview {
    ImageViewControlsOverlay(screenHeight: UIScreen.main.bounds.height)
        .ignoresSafeArea()
        .environmentObject(ChatAlbumsViewModel())
}
