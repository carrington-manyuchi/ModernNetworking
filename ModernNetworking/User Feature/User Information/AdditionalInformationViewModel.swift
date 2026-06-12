//
//  AdditionalInformationViewModel.swift
//  ModernNetworking
//
//  Created by Manyuchi, Carrington C on 2026/06/12.
//

import Foundation
import SwiftUI
import Combine

final class AdditionalInformationViewModel: ObservableObject {
    @Published var userData: UserData
    @Published var isLoading = false
    @Published var navigateToReview = false
    
    @Published var colors: [ColorResponse] = []
    @Published var selectedColor: ColorResponse?
    
    @Published var selectedGender: Gender = .male  // Changed from @State to @Published for ObservableObject
    @Published var address: String = ""  // Changed from @State to @Published
    @Published var showColorPicker = false  // Changed from @State to @Published
    
    private let repository: NetworkServiceRepository
    
    init(userData: UserData, repository: NetworkServiceRepository? = nil) {
        self.userData = userData
        
        if let repository = repository {
            self.repository = repository
        } else {
            let networkService = NetworkServiceImplementation()
            self.repository = NetworkServiceRepositoryImplementation(networkService: networkService)
        }
    }
    
    @MainActor
    func fetchColors() async {
        isLoading = true
        
        do {
            let userColorResponse = try await repository.fetchColors()  // This returns UserColor
            self.colors = userColorResponse.data
            self.isLoading = false
        } catch {
            print("Failed to fetch colors: \(error)")
            self.isLoading = false
        }
    }
    
    func updateGender(_ gender: Gender) {
        userData.gender = gender
    }
    
    func updatePreferredColor(_ color: ColorResponse) {
        self.selectedColor = color
        userData.preferredColor = color.color  // 👈 Store the hex string, not the whole ColorResponse object
    }
    
    func updateAddress(_ address: String) {
        userData.residentialAddress = address
    }
}
