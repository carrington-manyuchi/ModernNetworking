//
//  RoundButton.swift
//  ModernNetworking
//
//  Created by Manyuchi, Carrington C on 2026/06/12.
//

import Foundation
import SwiftUI

struct RoundButton: View {
    
    @State var title: String = "Title"
    var didTap: (() -> ())?
    var body: some View {
        
        Button {
            didTap?()
        } label: {
            Text(title)
                .font(.system(size: 15))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
                .background(.green)
                .cornerRadius(30)
        }
        

    }
}

#Preview {
    RoundButton()
        .padding()
}
