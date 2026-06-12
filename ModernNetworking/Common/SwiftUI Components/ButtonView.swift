////
////  ButtonView.swift
////  ModernNetworking
////
////  Created by Manyuchi, Carrington C on 2026/06/12.
////
//
//import Foundation
//import SwiftUI
//
//struct ButtonView: View {
//    
//    let buttonTitle: String
//    let buttonTextColor: Color
//    let buttonTextFont: Font?
//    let buttonWidth: CGFloat?
//    let buttonHeight: CGFloat?
//    let buttonBackgroundColor: Color?
//    let action: (() -> Void)?  // Added action parameter
//    
//    // Optional: Add loading state
//    var isLoading: Bool = false
//    
//    // Optional: Add disabled state
//    var isDisabled: Bool = false
//    
//    init(
//        buttonTitle: String,
//        buttonTextColor: Color = .white,
//        buttonTextFont: Font? = .subheadline,
//        buttonWidth: CGFloat? = nil,
//        buttonHeight: CGFloat? = 48,
//        buttonBackgroundColor: Color? = .blue,
//        isLoading: Bool = false,
//        isDisabled: Bool = false,
//        action: (() -> Void)? = nil
//    ) {
//        self.buttonTitle = buttonTitle
//        self.buttonTextColor = buttonTextColor
//        self.buttonTextFont = buttonTextFont
//        self.buttonWidth = buttonWidth
//        self.buttonHeight = buttonHeight
//        self.buttonBackgroundColor = buttonBackgroundColor
//        self.isLoading = isLoading
//        self.isDisabled = isDisabled
//        self.action = action
//    }
//    
//    var body: some View {
//        Button {
//            action?()  // Call the provided action
//        } label: {
//            ZStack {
//                if isLoading {
//                    ProgressView()
//                        .progressViewStyle(CircularProgressViewStyle(tint: buttonTextColor))
//                } else {
//                    Text(buttonTitle)
//                        .foregroundStyle(buttonTextColor)
//                        .font(buttonTextFont)
//                        .fontWeight(.semibold)
//                }
//            }
//            .frame(width: buttonWidth, height: buttonHeight)
//            .frame(maxWidth: buttonWidth == nil ? .infinity : nil)  // Allow full width if nil
//            .background(buttonBackgroundColor)
//            .clipShape(RoundedRectangle(cornerRadius: 8))
//            .opacity(isDisabled ? 0.6 : 1.0)  // Visual feedback for disabled state
//        }
//        .disabled(isDisabled || isLoading)  // Disable button when loading or disabled
//    }
//}
//
//#Preview {
//    VStack(spacing: 20) {
//        ButtonView(buttonTitle: "Log in")
//        
//        ButtonView(
//            buttonTitle: "Sign Up",
//            buttonTextColor: .white,
//            buttonTextFont: .headline,
//            buttonWidth: 200,
//            buttonHeight: 50,
//            buttonBackgroundColor: .green
//        )
//        
//        ButtonView(
//            buttonTitle: "Loading Button",
//            buttonBackgroundColor: .pink,
//            isLoading: true
//        )
//        
//        ButtonView(
//            buttonTitle: "Disabled Button",
//            buttonBackgroundColor: .gray,
//            isDisabled: true
//        )
//    }
//    .padding()
//}
