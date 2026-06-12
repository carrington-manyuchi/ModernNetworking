//
//  View +Extension.swift
//  ModernNetworking
//
//  Created by Manyuchi, Carrington C on 2026/06/11.
//

import Foundation
import SwiftUI

extension View {
    
//    func poppins(_ font: Poppins, _ size: CGFloat = 14) -> some View {
//        self.font(.custom(font.fontName, size: size))
//    }
    
    func aligned(_ alignment: Alignment) -> some View {
        frame(maxWidth: .infinity, alignment: alignment)
    }
    
    func centerHorizontally() -> some View {
        HStack {
            Spacer()
            self
            Spacer()
        }
    }

    @ViewBuilder
    func visible(_ value: Bool) -> some View {
        switch value {
        case true:
            self
        case false:
            EmptyView()
        }
    }
    
    func cornerRadius(_ radius: CGFloat, corner:  UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corers: corner))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corers: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corers, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
