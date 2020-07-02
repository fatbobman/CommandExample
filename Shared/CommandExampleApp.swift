//
//  CommandExampleApp.swift
//  Shared
//
//  Created by Yang Xu on 2020/6/30.
//

import SwiftUI

@main
struct CommandExampleApp: App {
    @StateObject var store = Store()
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(store)
        }
        .commands{
            #if os(macOS)
            MyCommand(store: store)
            OtherMenu()
            #endif
        }
    }
}

#if os(macOS)
struct MyCommand:Commands{
    @ObservedObject var store:Store
    @CommandsBuilder var body: some Commands{
        CommandMenu("Test"){
            Section{
                Button(action:{test1()}){
                    Text("test1").foregroundColor(.black)
                }
                .keyboardShortcut("1", modifiers: [.command,.shift])
                .help("help test1")
                
                Button("test2", action: test2)
                    .keyboardShortcut("2", modifiers: .command)
            }
            
            switch store.selection{
            case .one:
                Text("one")
            case .two:
                Text("two")
            case .three:
                Text("three")
            }
            
            Divider().padding(.horizontal, 10)
            
            Button("other window"){
                print("other command")
                let contentView =
                    VStack{
                        Text("New Window").padding(.all, 10)
                    }.frame(minWidth: 200, minHeight: 200, alignment: .center)
                

                var window: NSWindow!
                // Create the window and set the content view.
                window = NSWindow(
                    contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
                    styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
                    backing: .buffered, defer: false)
                window.isReleasedWhenClosed = false
                window.center()
                window.setFrameAutosaveName("Main Window")
                window.contentView = NSHostingView(rootView: contentView)
                window.makeKeyAndOrderFront(nil)
            }
            
            Button("open panel"){
                let panel = NSOpenPanel()
                      panel.nameFieldLabel = "open test:"
                      panel.begin { response in
                          if response == NSApplication.ModalResponse.OK, let fileUrl = panel.url {
                              print(fileUrl)
                          }
                      }
            }
            
            ForEach(0..<3){ i in
                Button("button\(i)"){
                    print("button\(i)")
                }
            }
            
            #if os(macOS)
            Menu("Switch Selection"){
                Button("one"){
                    store.changeState(.one)
                }
                Button("two"){
                    store.changeState(.two)
                }
                Button("three"){
                    store.changeState(.three)
                }
            }
            #endif
        }
        
        CommandMenu("Menu2"){
            Button(action: {}){
                Text("😃Button")
            }
        }
        
        //向现有的菜单项中增加功能
        CommandGroup(after: CommandGroupPlacement.help, addition: {
            Button("new help button"){
                print("new help")
            }
        })
        

    }
    
    private func test1(){
        print("test1 command")
    }
    
    private func test2(){
        print("test2 command")
    }
}
#endif

struct OtherMenu:Commands{
    var body: some Commands{
        CommandMenu("otherMenu"){
            Button("abc"){
                print("abc")
            }
        }
    }
}


class Store:ObservableObject{
    enum Selection{
        case one,two,three
    }
    @Published var selection:Selection = .one
    
    
    func changeState(_ selection:Selection){
        self.selection = selection
    }
}



