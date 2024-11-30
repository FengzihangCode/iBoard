//
//  ContentView.swift
//  iBoard
//
//  Created by feng on 11/30/24.
//

import SwiftUI

struct ContentView: View {
    @State private var backgroundColor: Color = .white  // 背景颜色
    @State private var text: String = "点击这里更改文字"  // 显示的文本
    @State private var isColorPickerPresented = false  // 控制颜色选择器的弹出
    @State private var isTextEditorPresented = false  // 控制文本编辑器的弹出
    @State private var newText: String = ""  // 用于保存用户编辑的文本

    var body: some View {
        VStack {
            Text(text)  // 显示的文本
                .font(.system(size: 24))
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
            ColorPicker("选择背景色", selection: $backgroundColor)
                .padding()
        }
        .sheet(isPresented: $isTextEditorPresented) {
            // 显示文本编辑框
            VStack {
                TextField("请输入新文本", text: $newText)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.title)
                
                Button("完成") {
                    text = newText  // 更新显示的文本
                    isTextEditorPresented = false  // 关闭文本编辑框
                }
                .padding()
            }
            .frame(width: 300, height: 150)
        }
        .ignoresSafeArea(.all)  // 确保背景矩形填充整个屏幕，去除底部空白
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("Mac")
            .previewDisplayName("macOS Preview")
    }
}
