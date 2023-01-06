//
//  ContentView.swift
//  WidgetTest
//
//  Created by Quentin Deschamps on 06/01/2023.
//

import SwiftUI

struct ContentView: View {
    private let contentManager = ContentManager()
    @State var linkActive = false
    
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world!")
                NavigationLink("", destination: DeepLinkView(), isActive: $linkActive).hidden()
            }
            .onAppear {
                contentManager.contents = [ContentList(name: "iOS Widget Test", cardViewSubtitle: "Widget 1/?", descriptionPlainText: "It's a test of populate a widget with different data", releasedAtDateTimeString: "01/01/2000"), ContentList(name: "iOS Widget Test", cardViewSubtitle: "Widget 2/?", descriptionPlainText: "It's a test of populate a widget with different data", releasedAtDateTimeString: "01/01/2000"), ContentList(name: "iOS Widget Test", cardViewSubtitle: "Widget 3/?", descriptionPlainText: "It's a test of populate a widget with different data", releasedAtDateTimeString: "01/01/2000")]
            }
            // Triggered when the app is open by the Widget link.
            .onOpenURL { url in
                guard url.scheme == "widget" else { return }
                linkActive = true
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
