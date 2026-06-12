//
//  SuccessView.swift
//  ModernNetworking
//
//  Created by Manyuchi, Carrington C on 2026/06/12.
//

import SwiftUI

struct SuccessView: View {
    var body: some View {
        VStack {
            VStack {
                Image(systemName: "checkmark.circle")
                    .resizable()
                    .scaledToFill()
                    .foregroundStyle(.green)
                    .padding(.bottom, 40)
            }
            .frame(width: 100, height: 100)
            .padding()
            
            Text("Successful")
                .font(.system(size: 28, weight: .semibold))
                .padding(.bottom)
            
            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since 1966, when designers at Letraset and James Mosley, the librarian at St Bride Printing")
                .font(.system(size: 17))
        }
        .padding()
    }
}

#Preview {
    SuccessView()
}
