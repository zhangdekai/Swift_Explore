//
//  SwiftUIViewTest1.swift
//  RXSwift_Explore
//
//  Created by zhang dekai on 2025/1/9.
//  Copyright © 2025 mr dk. All rights reserved.
//

import SwiftUI

/// SwiftUI can add into UIKIt Viewcontroller

struct SwiftUIViewTest1: View {
    
    init() {
        
        /// 导航条 style  set
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.blue.withAlphaComponent(0.2) // 设置背景色
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white] // 大标题文字颜色
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white] // 小标题文字颜色
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        
        
        
        NavigationView {
                            
                VStack(alignment: .center, spacing: 0) {
                    
                    
                    Text("Text").font(.title).foregroundColor(.black).padding(EdgeInsets(top: 5, leading: 5, bottom: 30, trailing: 5)).background(Color.gray, alignment: .center)
                    
                    
                    /// 横向布局
                    HStack.init(alignment: .center, spacing: 4) {
                        
                        Image(systemName: "triangle.fill").foregroundColor(.blue)
                        
                        Text("HStack").font(.title).foregroundColor(.red)
                        
                        Text("横向布局").font(.title3).foregroundColor(.gray)
                        
                        
                        Image(systemName: "star.fill").frame(width: 15,height: 15)
                        
                    }.padding()
                    
                    /// 垂直布局
                    VStack(alignment: .leading, spacing: 8) {
                        
                        
                        Text("VStack").font(.largeTitle).foregroundColor(.black)
                        
                        Text("垂直布局").font(.title2)
                        
                        Text("desc").font(.title3)
                        
                    }.padding().background(Color.gray, alignment: .center)
                    
                    
                    
                    /// 叠放布局-Z
                    ZStack(alignment: .center) {
                        
                        Rectangle()
                            .fill(Color.blue.opacity(0.3))
                            .frame(width: 200, height: 200)
                        
                        Circle().fill(Color.yellow).frame(width: 50,height: 50,alignment: .center)
                        
                        Text("叠放布局-Z").font(.title)
                            .foregroundColor(.white)
                    }
                    
                    
                    
                    
                }.navigationTitle("SwiftUI").toolbar {
                    
                    
                    // 添加右侧按钮
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("编辑") {
                            print("右侧按钮点击")
                            
                            
                        }
                    }
                    
                    // 添加zuo侧按钮
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            print("zuo侧按钮点击")
                            
                            
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                }.navigationBarTitleDisplayMode(.inline)
                    .navigationBarBackButtonHidden(false)
                    .background(Color.yellow.opacity(0.5))
                    .frame(maxWidth: .infinity, maxHeight: .infinity) // 确保填满屏幕
                
            }
            

        
        
        
    }
}

#Preview {
    SwiftUIViewTest1()
}
