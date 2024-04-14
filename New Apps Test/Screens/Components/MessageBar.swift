//
//  MessageBar.swift
//  New Apps Test
//
//  Created by The Sebag Company on 14/04/2024.
//

import SwiftUI

private struct ViewWithMessageBar: ViewModifier {
    @FocusState
    private var isFocused
    @State
    private var messageBody: String = ""
    
    private let isVisible: Bool
    private let onSend: (String) -> Void
    private let onFocusChange: ((Bool) -> Void)?
    
    init(
        isVisible: Bool,
        onSend: @escaping (String) -> Void,
        onFocusChange: ((Bool) -> Void)? = nil
    ) {
        self.isVisible = isVisible
        self.onSend = onSend
        self.onFocusChange = onFocusChange
    }
    
    func body(content: Content) -> some View {
        content
            .safeAreaInset(edge: .bottom) {
                if isVisible {
                    messageBar
                        .onChange(of: isFocused) {
                            onFocusChange?(isFocused)
                        }
                        .transition(.move(edge: .bottom))
                }
            }
    }
}

// MARK: - ViewBuilders
private extension ViewWithMessageBar {
    var messageBar: some View {
        HStack {
            TextField("New Message", text: $messageBody)
                .textFieldStyle(.roundedBorder)
                .focused($isFocused)
            
            Spacer()
            
            Button("", systemImage: "paperplane") {
                onSend(messageBody)
                messageBody = ""
                isFocused = false
            }
        }
        .padding(8)
        .background(Material.ultraThickMaterial)
    }
}

extension View {
    func withMessageBar(
        isVisible: Bool,
        onSend: @escaping (String) -> Void,
        onFocusChange: ((Bool) -> Void)? = nil
    ) -> some View {
        modifier(
            ViewWithMessageBar(
                isVisible: isVisible,
                onSend: onSend,
                onFocusChange: onFocusChange
            )
        )
    }
}

#Preview {
    Text("Hello world")
        .withMessageBar(isVisible: true) { _ in
            
        }
}
