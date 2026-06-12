//
//  AdditionalInformationView.swift
//  ModernNetworking
//
//  Created by Manyuchi, Carrington C on 2026/06/12.
//

import SwiftUI

import SwiftUI

struct AdditionalInformationView: View {
    @State private var selectedGender: Gender = .male
    @State private var address: String = ""
    
    enum Gender: String, CaseIterable {
        case male = "Male"
        case female = "Female"
        case other = "Other"
    }
    
    var body: some View {
        VStack {
            VStack {
                Text("Choose Gender")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Picker("Choose Gender", selection: $selectedGender) {
                    ForEach(Gender.allCases, id: \.self) { gender in
                        Text(gender.rawValue).tag(gender)
                    }
                }
                .pickerStyle(.segmented)
            }
            .padding(.horizontal)
            .padding(.bottom, 60)
            
            VStack(alignment: .leading) {
                Text("Select Employee prefered color")
                    .fontWeight(.semibold)
                    .padding(.horizontal)
                Divider()
                Group {
                    HStack {
                        Image(systemName: "circle")
                            .foregroundStyle(.black)
                            .font(.largeTitle)
                            .padding(.vertical, 8)
                        Spacer()
                        Image(systemName: "chevron.forward")
                            .font(.title2)
                    }
                }
                .padding(.horizontal, 30)
                Divider()
            }
            
            VStack(alignment: .leading) {
                Text("Residential Address")
                    .font(.system(size: 18, weight: .semibold))
                    .padding(.bottom, 5)
                
                
                TextField("Enter Residential Address", text: $address)
                    .font(.system(size: 15))
                    .textInputAutocapitalization(.never)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.black.opacity(0.2))
            }
            .padding(.vertical, 50)
            .padding(.horizontal)
        }
    }
}

#Preview {
    AdditionalInformationView()
}
