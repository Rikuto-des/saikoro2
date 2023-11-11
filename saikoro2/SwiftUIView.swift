//
//  SwiftUIView.swift
//  saikoro2
//
//  Created by user on 2023/11/12.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        TabView{
            DiceView() //1枚目の子ビュー
                .tabItem {
                    Text("Dice") //タブバーの①
                }
            TimerView() //2枚目の子ビュー
                .tabItem {
                    Text("Timer") //タブバーの①
                }
        }
        .padding()
    }
}

