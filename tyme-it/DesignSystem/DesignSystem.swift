//
//  DesignSystem.swift
//  tyme-it
//
//  Created by Akhilesh Amle on 14/12/25.
//

import SwiftUI

public enum DSColor {
    public static let background = Color.orange
    public static let charcoal = Color(.sRGB, red: 0.13, green: 0.13, blue: 0.13, opacity: 1.0)
    public static let surfaceTranslucent = Color.white.opacity(0.2)
    public static let surfaceStroke = Color.white.opacity(0.35)
}

public enum DSTypography {
    public static func timeLarge() -> Font { .system(size: 56, weight: .bold, design: .rounded) }
    public static func button() -> Font { .headline }
}

public struct PrimaryFilledButtonStyle: ButtonStyle {
    public init() {}
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(DSTypography.button())
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(DSColor.surfaceTranslucent)
            )
            .foregroundStyle(DSColor.charcoal)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
    }
}

public struct SecondaryStrokeButtonStyle: ButtonStyle {
    public init() {}
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(DSTypography.button())
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(DSColor.surfaceStroke, lineWidth: 1)
            )
            .foregroundStyle(DSColor.charcoal)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
    }
}
