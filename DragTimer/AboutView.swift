//
//  AboutView.swift
//  DragTimer
//
//  Created by Jan Andrzejewski on 15/08/2022.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("About DragTimer")
                .font(.largeTitle)
            
            Text("Open-source app developed by Jan (Capslock)")
                .font(.title3)
                .foregroundColor(.secondary)
        
        
            Label("[See the source code on GitHub](https://github.com)", systemImage: "chevron.left.forwardslash.chevron.right")
            
            Label("[Follow me on Twitter](https://twitter.com/Capslockhuh)", systemImage: "person.fill")
        }
        
        Spacer()
        Spacer()
        Spacer()
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
