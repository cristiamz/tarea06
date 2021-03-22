//
//  ContentView.swift
//  Tarea06
//
//  Created by Cristian Zuniga on 21/3/21.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            GetView()
                .tabItem { Label("Get", systemImage: "list.dash") }
            PostView()
                .tabItem { Label("Post", systemImage: "list.dash") }
        }    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
