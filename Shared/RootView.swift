//
//  RootView.swift
//  NewSwiftUI
//
//  Created by Yang Xu on 2020/6/30.
//

import SwiftUI

struct RootView: View {
    @ViewBuilder var body: some View {
        #if os(macOS)
        ContentView()
            .frame(width:300,height: 300)
//            .frame(minWidth: .infinity,  maxWidth: .infinity)
        #else
        ContentView()
        #endif
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
