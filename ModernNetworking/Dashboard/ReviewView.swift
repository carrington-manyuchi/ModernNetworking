//
//  ReviewView.swift
//  ModernNetworking
//
//  Created by Manyuchi, Carrington C on 2026/06/12.
//

import SwiftUI

struct ReviewView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Personal details")
                .font(.system(size: 18, weight: .semibold))
                .padding(.horizontal)
          
            Rectangle()
            .frame(height: 1)
            .foregroundStyle(.gray)
           .shadow(color: .black.opacity(0.5), radius: 1, x: 1, y: 1)
            
            
            HStack {
                Image(systemName: "person")
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .frame(width: 50, height: 50)
                    .background(.blue)
                    .clipShape(Circle())
                    .padding(.leading, 20)
                
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("carringtonmanyuchi263@gmail.com")
                        Text("January 23 1970")
                        Text("Male")
                    }
                    .padding()
                }
            }
            
            Rectangle()
            .frame(height: 1)
            .foregroundStyle(.gray)
           .shadow(color: .black.opacity(0.5), radius: 1, x: 1, y: -1)
            
            VStack(alignment: .leading, spacing: 15) {
                Text("Additional Information")
                    .font(.system(size: 18, weight: .semibold))
                
                Group {
                    Text("Nyanga")
                }
                .padding(.horizontal)
            }
            .padding()
            .padding(.vertical)
        }
    }
}

#Preview {
    ReviewView()
}
