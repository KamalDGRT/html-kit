//
// HTMLTextViewModel.swift
// HTMLKit
//

import SwiftUI

public enum LinkTextDecoration: String {
    case none
    case underline
    case strikeThrough = "line-through"
}

final class HTMLTextViewModel: ObservableObject {
    
    // Regular Content
    var content: String
    @Published var fontName: String
    @Published var fontSize: CGFloat
    @Published var fontColor: Color
    
    // Link Text
    @Published var linkTextFont: String
    @Published var linkTextSize: CGFloat
    @Published var linkTextColor: Color
    @Published var linkTextDecoration: LinkTextDecoration
    
    // Additional Properties
    @Published var characterSpacing: CGFloat
    @Published var lineSpacing: CGFloat
    @Published var alignment: Alignment
    
    init(
        content: String,
        fontName: String = "",
        fontSize: CGFloat = 12,
        fontColor: Color = .black,
        linkTextFont: String = "",
        linkTextSize: CGFloat = 12,
        linkTextColor: Color = .blue,
        linkTextDecoration: LinkTextDecoration = .underline,
        characterSpacing: CGFloat = .zero,
        lineSpacing: CGFloat = 1,
        alignment: Alignment = .leading
    ) {
        self.content = content
        self.fontName = fontName
        self.fontSize = fontSize
        self.fontColor = fontColor
        
        self.linkTextFont = linkTextFont
        self.linkTextSize = linkTextSize
        self.linkTextColor = linkTextColor
        self.linkTextDecoration = linkTextDecoration
        
        self.characterSpacing = characterSpacing
        self.lineSpacing = lineSpacing
        self.alignment = alignment
    }
}

extension HTMLTextViewModel {
    var htmlString: String {
        """
            <style>
               html * {
                   font-size: \(cssFontSize);
                   color: \(cssFontColor);
                   font-family: \(cssFontName) Helvetica;
               }
               a {
                 color: \(cssLinkTextColor);
                 font-size: \(cssLinkTextSize);
                 font-family: \(cssLinkTextFont) Helvetica;
                 text-decoration: \(cssLinkTextDecoration);
               }
            </style>
            \(content)
        """
    }
    var cssFontName: String {
        fontName.isEmpty ? "" : "'\(fontName)',"
    }
    
    var cssFontSize: String {
        String(format: "%.2f", fontSize) + "px"
    }
    
    var cssFontColor: String {
        fontColor.toHex()
    }
    
    var cssLinkTextFont: String {
        linkTextFont.isEmpty ? "" : "'\(linkTextFont)',"
    }
    
    var cssLinkTextSize: String {
        String(format: "%.2f", linkTextSize) + "px"
    }
    
    var cssLinkTextColor: String {
        linkTextColor.toHex()
    }
    
    var cssLinkTextDecoration: String {
        linkTextDecoration.rawValue
    }
    
    var attributedString: AttributedString {
        AttributedString(htmlString.nsAttributedString)
    }
}
