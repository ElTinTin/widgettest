//
//  EntryView.swift
//  WidgetStaticTestExtension
//
//  Created by Quentin Deschamps on 06/01/2023.
//

import SwiftUI

struct EntryView: View {
    let model: WidgetContent
    
    // You can build your Widget like you want BUT don't forget there is 4 size (small, medium, large and extra large) and it's not scrollable.
    // For example this widget contains too much information for the small size.
    // Don't work in Widget : Video, Animated Images (Lottie, SwiftUI Animation).
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack {
                    Text(model.name)
                        .font(.title3)
                        .lineLimit(2)
                        .fontWeight(.bold)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding([.trailing], 15)
                        .foregroundColor(.orange)
                    
                    Text(model.cardViewSubtitle)
                        .font(.caption)
                        .lineLimit(nil)
                        .foregroundColor(.gray)
                }
                Image(systemName: "rectangle.inset.filled.and.person.filled")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
            }
            
            Text(model.descriptionPlainText)
                .font(.caption)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(2)
                .lineSpacing(3)
                .foregroundColor(.black)
            
            // Deeplinking like this only work on medium and more Widgets. For small widgets use: .widgetURL(URL(string: "widget://deeplink")!).
            Link(destination: URL(string: "widget://deeplink")!) {
                VStack {
                    Text("Let's go to the deeplinked view.")
                }
            }
            
            Text(model.releasedAtDateTimeString)
                .font(.caption)
                .lineLimit(1)
                .foregroundColor(.gray)
        }
        .background(Color.white)
        .padding()
        .cornerRadius(6)
    }
}
