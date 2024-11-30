//
//  ContentView.swift
//  iBoardWatch Watch App
//
//  Created by feng on 11/30/24.
//

import SwiftUI

struct ContentView: View {
    @State private var backgroundColor: Color = .white  // 背景颜色

    var body: some View {
        ZStack {
            // 背景矩形，填充整个屏幕
            Rectangle()
                .fill(backgroundColor)
                .ignoresSafeArea()  // 忽略安全区域，确保背景填充整个屏幕
        }
        .onAppear {
            backgroundColor = .white
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice("Apple Watch Series 7")
                .previewDisplayName("watchOS Preview")
        }
    }
}
