//
//  ContentView.swift
//  iBoardWatch Watch App
//
//  Created by feng on 11/30/24.
//

import SwiftUI
import Vela

struct ContentView: View {
    @State private var selectedColor: Color = .white  // 初始化为白色
    @State private var isColorPickerPresented: Bool = false  // 控制是否显示颜色选择器

    var body: some View {
        VStack {
            // 显示颜色块
            Rectangle()
                .fill(selectedColor)  // 填充选中的颜色
                .frame(width: 150, height: 150)  // 设置方块大小
                .cornerRadius(10)  // 圆角
                .shadow(radius: 5)  // 添加阴影
                .padding()
                .onTapGesture {
                    // 点击颜色块时，弹出颜色选择器
                    isColorPickerPresented.toggle()
                }
            
            Spacer()
        }
        .navigationTitle("颜色选择器")  // 设置导航标题
        .sheet(isPresented: $isColorPickerPresented) {
            // 打开颜色选择器
            VelaPicker(
                color: $selectedColor,  // 绑定选中的颜色
                defaultColor: .white,  // 默认颜色
                allowOpacity: true,  // 允许修改透明度
                allowRGB: true,  // 允许RGB值编辑
                allowHSB: true,  // 允许HSB值编辑
                allowCMYK: false,  // 不显示CMYK选项
                HSB_primary: false,  // 不把HSB作为主选项
                label: { Text("Vela 颜色选择器") }  // 标签
            )
            .padding()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("Apple Watch Series 7 - 45mm")
            .previewDisplayName("watchOS Preview")
    }
}
