//
//  ContentView.swift
//  Shared
//
//  Created by Yang Xu on 2020/6/30.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store:Store
    var body: some View {
        VStack{
            #if os(iOS)
            Picker("", selection: $store.selection){
                Text("one").tag(Store.Selection.one)
                Text("two").tag(Store.Selection.two)
                Text("three").tag(Store.Selection.three)
            }
            .pickerStyle(SegmentedPickerStyle())
            .labelsHidden()
            #endif
            Text("Hello, world!")
                .help("help text")
                .padding()
            switch store.selection{
            case .one:
                Text("one")
            case .two:
                Text("two")
            case .three:
            Text("three")
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
