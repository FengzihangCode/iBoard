//
//  ContentView.swift
//  iBoard
//
//  Created by feng on 11/30/24.
//

import SwiftUI

struct ContentView: View {
    @State private var backgroundColor: Color = .white  // 背景颜色
    @State private var textColor: Color = .black  // 文字颜色
    @State private var text: String = "点击这里更改文字"  // 显示的文本
    @State private var fontSize: CGFloat = 24  // 字体大小
    @State private var isColorPickerPresented = false  // 控制颜色选择器的弹出
    @State private var isTextEditorPresented = false  // 控制文本编辑器的弹出
    @State private var newText: String = ""  // 用于保存用户编辑的文本
    
    // 适应深色模式设置默认颜色
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ZStack {
            // 背景矩形，填充整个屏幕并忽略安全区域
            Rectangle()
                .fill(backgroundColor)
                .ignoresSafeArea()  // 忽略安全区域，确保背景填充整个屏幕

            VStack {
                Text(text)  // 显示的文本
                    .font(.system(size: fontSize))
                    .foregroundColor(textColor)  // 设置文本颜色
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity) // 背景填充整个区域
                    .background(backgroundColor)  // 背景颜色
                    .cornerRadius(10)
                    .gesture(
                        // 点击文字时弹出文本编辑框
                        TapGesture().onEnded {
                            isTextEditorPresented.toggle()
                            newText = text  // 传递当前文本给输入框
                        }
                    )

                Spacer()
            }
            .toolbar {
                // 在macOS顶部工具栏添加颜色选择器图标
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        // 打开颜色选择器
                        isColorPickerPresented.toggle()
                    }) {
                        Image(systemName: "paintpalette")
                            .imageScale(.large)
                    }
                }
            }
            .sheet(isPresented: $isColorPickerPresented) {
                // 显示颜色选择器
                VStack{
                    ColorPicker("BackgroundColor.Select", selection: $backgroundColor)
                        .padding()
                    
                    ColorPicker("TextColor.Select", selection: $textColor)
                        .padding()

                    Button("Button.Finish") {
                        isColorPickerPresented = false  // 关闭颜色选择器
                    }
                    .padding()
                }
                .frame(width: 300, height: 250)
            }
            .sheet(isPresented: $isTextEditorPresented) {
                VStack {
                    // 文本编辑框
                    VStack{
                        Text("Text.Edit")
                        TextField("Text.Enter", text: $newText)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    // 字号调整滑块
                    VStack {
                        Text("FontSize.Adjust")
                        Slider(value: $fontSize, in: 10...100, step: 1)
                            .padding()
                            .accentColor(.blue)
                    }
                    
                    Button("Button.Finish") {
                        text = newText  // 更新显示的文本
                        isTextEditorPresented = false  // 关闭文本编辑框
                    }
                    .padding()
                }
                .frame(width: 300, height: 300)
            }
        }
        // 根据外观模式设置背景色和文字颜色
        .onAppear {
            if colorScheme == .dark {
                backgroundColor = .black
                textColor = .white
            } else {
                backgroundColor = .white
                textColor = .black
            }
        }
        // 仅在iOS和iPadOS中添加右上角的“完成”按钮
        #if os(iOS)
        .navigationBarItems(trailing: Button("Button.Finish") {
            // 关闭设置界面
        })
        #endif
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice("Mac")
                .previewDisplayName("macOS Preview")
                .preferredColorScheme(.light) // Light mode
            ContentView()
                .previewDevice("Mac")
                .previewDisplayName("macOS Preview")
                .preferredColorScheme(.dark) // Dark mode
            ContentView()
                .previewDevice("iPhone 14")
                .previewDisplayName("iPhone Preview")
            ContentView()
                .previewDevice("iPad Pro (11-inch) (3rd generation)")
                .previewDisplayName("iPad Preview")
        }
    }
}
