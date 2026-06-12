//
//  EmployeesView.swift
//  ModernNetworking
//
//  Created by Manyuchi, Carrington C on 2026/06/12.
//

import SwiftUI

struct EmployeesView: View {
    var body: some View {
        VStack {
            List(1...12, id: \.self) { image in
                HStack {
                    Image(systemName: "person.circle.fill")
                        .foregroundStyle(.white)
                        .frame(width: 50, height: 50)
                        .background(.blue.opacity(0.5))
                        .clipShape(Circle())
                    
                    Text("carringtonmanyuchi263@gmail.com")
                        .font(.system(size: 14))
                    Spacer()
                }
                .padding(.horizontal)
            }
            
        }
        .navigationTitle("List of employees")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

#Preview {
    EmployeesView()
}
