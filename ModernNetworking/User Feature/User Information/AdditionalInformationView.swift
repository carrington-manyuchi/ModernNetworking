//
//  AdditionalInformationView.swift
//  ModernNetworking
//
//  Created by Manyuchi, Carrington C on 2026/06/12.
//

import SwiftUI

struct AdditionalInformationView: View {
    @StateObject var viewModel: AdditionalInformationViewModel
    @State private var showColorPicker = false
    
    var body: some View {
        VStack {
            VStack {
                Text("Choose Gender")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Picker("Choose Gender", selection: Binding(
                    get: { viewModel.userData.gender },
                    set: { viewModel.updateGender($0) }
                )) {
                    ForEach(Gender.allCases, id: \.self) { gender in
                        Text(gender.rawValue).tag(gender)
                    }
                }
                .pickerStyle(.segmented)
            }
            .padding(.horizontal)
            .padding(.bottom, 60)
            
            VStack(alignment: .leading) {
                Text("Select Employee preferred color")
                    .fontWeight(.semibold)
                    .padding(.horizontal)
                Divider()
                Group {
                    HStack {
                        if let selectedColor = viewModel.selectedColor {
                            Circle()
                                .fill(Color(hex: selectedColor.color))
                                .frame(width: 40, height: 40)
                                .padding(.vertical, 8)
                            Text(selectedColor.name)  // 👈 Fixed: No optional needed
                                .font(.system(size: 16))
                        } else {
                            Image(systemName: "circle")
                                .foregroundStyle(.black)
                                .font(.largeTitle)
                                .padding(.vertical, 8)
                            Text("Tap to select color")
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Image(systemName: "chevron.forward")
                            .font(.title2)
                    }
                }
                .contentShape(Rectangle())
                .padding(.horizontal, 30)
                .onTapGesture {
                    showColorPicker = true
                }
                Divider()
            }
            
            VStack(alignment: .leading) {
                Text("Residential Address")
                    .font(.system(size: 18, weight: .semibold))
                    .padding(.bottom, 5)
                
                TextField("Enter Residential Address", text: Binding(
                    get: { viewModel.userData.residentialAddress },
                    set: { viewModel.updateAddress($0) }
                ))
                .font(.system(size: 15))
                .textInputAutocapitalization(.never)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.black.opacity(0.2))
            }
            .padding(.vertical, 50)
            .padding(.horizontal)
            
            Spacer()
            
            // Next Button
            Button {
                viewModel.navigateToReview = true
            } label: {
                Text("Review")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.bottom, 30)
        }
        .navigationTitle("Additional Info")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: $viewModel.navigateToReview) {
            ReviewView(viewModel: ReviewViewModel(userData: viewModel.userData))
        }
        .sheet(isPresented: $showColorPicker) {
            ColorPickerView(viewModel: viewModel)
        }
        .task {
            await viewModel.fetchColors()
        }
    }
}

// Color Picker Sheet
struct ColorPickerView: View {
    @ObservedObject var viewModel: AdditionalInformationViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            List(viewModel.colors, id: \.id) { color in  // 👈 viewModel.colors should be [ColorResponse]
                HStack {
                    Circle()
                        .fill(Color(hex: color.color))  // 👈 Fixed: Use hex initializer
                        .frame(width: 40, height: 40)
                    
                    VStack(alignment: .leading) {
                        Text(color.name)  // 👈 Fixed: No optional needed
                            .font(.headline)
                        Text("Year: \(color.year)")  // 👈 Fixed: No optional needed
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    if viewModel.selectedColor?.id == color.id {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.blue)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    viewModel.updatePreferredColor(color)
                    dismiss()
                }
            }
            .navigationTitle("Select Color")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}
