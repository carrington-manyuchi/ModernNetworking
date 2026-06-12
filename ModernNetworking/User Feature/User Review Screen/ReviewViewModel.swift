//
//  ReviewViewModel.swift
//  ModernNetworking
//
//  Created by Manyuchi, Carrington C on 2026/06/12.
//

import Foundation
import SwiftUI
import Combine

final class ReviewViewModel: ObservableObject {
    @Published var userData: UserData
    @Published var isSubmitting = false
    @Published var submitSuccess = false
    @Published var errorMessage = ""
    @Published var showSuccessAlert = false  // 👈 Add this for the alert
    
    init(userData: UserData) {  // 👈 Fixed extra comma after userData
        self.userData = userData
    }
    
    // Computed property for formatted date of birth
    var formattedDateOfBirth: String {
        return formatDate(userData.dateOfBirth)
    }
    
    // Computed property for preferred color name
    var preferredColorName: String {
        if userData.preferredColor.isEmpty || userData.preferredColor == "#000000" {
            return "Not selected"
        }
        return "Selected Color"
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
    
    @MainActor
    func submitData() async {
        isSubmitting = true
        errorMessage = ""
        
        // Simulate API call or data processing
        try? await Task.sleep(nanoseconds: 1_000_000_000) // 1 second delay
        
        // Here you would send the data to your backend
        print("📤 Submitting user data:")
        print("Employee: \(userData.selectedEmployee?.firstName ?? "None") \(userData.selectedEmployee?.lastName ?? "")")
        print("DOB: \(formattedDateOfBirth)")
        print("Place of Birth: \(userData.placeOfBirth)")
        print("Gender: \(userData.gender.rawValue)")
        print("Preferred Color Hex: \(userData.preferredColor)")
        print("Address: \(userData.residentialAddress)")
        
        // Simulate success or failure (you can add error simulation if needed)
        isSubmitting = false
        submitSuccess = true
        showSuccessAlert = true  // 👈 Show the success alert
    }
}
