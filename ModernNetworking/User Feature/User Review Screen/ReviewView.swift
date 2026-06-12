//
//  ReviewView.swift
//  ModernNetworking
//
//  Created by Manyuchi, Carrington C on 2026/06/12.
//

import SwiftUI

struct ReviewView: View {
    @StateObject var viewModel: ReviewViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Personal Details")
                        .font(.system(size: 18, weight: .semibold))
                        .padding(.horizontal)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(.gray.opacity(0.3))
                    
                    HStack {
                        if let avatarURL = viewModel.userData.selectedEmployee?.avatar {
                            AsyncImageView(
                                url: avatarURL,
                                placeholder: Image(systemName: "person.circle.fill"),
                                size: CGSize(width: 60, height: 60),
                                isCircular: true
                            )
                        } else {
                            Image(systemName: "person.circle.fill")
                                .font(.system(size: 60))
                                .foregroundColor(.blue)
                        }
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("\(viewModel.userData.selectedEmployee?.firstName ?? "") \(viewModel.userData.selectedEmployee?.lastName ?? "")")
                                .font(.system(size: 16, weight: .medium))
                            Text(viewModel.userData.selectedEmployee?.email ?? "")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                            Text(viewModel.formattedDateOfBirth)  // 👈 Changed: Use computed property
                                .font(.system(size: 12))
                            Text(viewModel.userData.placeOfBirth)
                                .font(.system(size: 12))
                        }
                        .padding(.leading, 10)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(.gray.opacity(0.3))
                }
                
                // Additional Information Section
                VStack(alignment: .leading, spacing: 15) {
                    Text("Additional Information")
                        .font(.system(size: 18, weight: .semibold))
                        .padding(.horizontal)
                    
                    Group {
                        InfoRow(title: "Gender", value: viewModel.userData.gender.rawValue)
                        InfoRow(title: "Preferred Color", value: viewModel.preferredColorName)  // 👈 Changed: Use computed property
                        if !viewModel.userData.preferredColor.isEmpty {
                            HStack {
                                Text("Color Preview:")
                                    .font(.system(size: 14))
                                Circle()
                                    .fill(Color(hex: viewModel.userData.preferredColor))  // 👈 Fixed: Use hex string directly
                                    .frame(width: 20, height: 20)
                            }
                            .padding(.horizontal)
                        }
                        InfoRow(title: "Residential Address", value: viewModel.userData.residentialAddress)
                    }
                }
                .padding(.top, 20)
                
                Spacer(minLength: 30)
                
                // Submit Button
                Button {
                    Task {
                        await viewModel.submitData()
                    }
                } label: {
                    if viewModel.isSubmitting {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    } else {
                        Text("Submit")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                .disabled(viewModel.isSubmitting)
                
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
        .navigationTitle("Review Information")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Success", isPresented: $viewModel.showSuccessAlert) {  // 👈 Changed: Use separate state
            Button("OK") {
                dismiss()  // Dismiss ReviewView on success
            }
        } message: {
            Text("Your information has been submitted successfully!")
        }
    }
}

struct InfoRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text(title + ":")
                .font(.system(size: 14, weight: .medium))
                .frame(width: 130, alignment: .leading)
            
            Text(value.isEmpty ? "Not provided" : value)
                .font(.system(size: 14))
                .foregroundColor(value.isEmpty ? .gray : .primary)
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview {
    NavigationStack {
        let userData = UserData()
        ReviewView(viewModel: ReviewViewModel(userData: userData))
    }
}
