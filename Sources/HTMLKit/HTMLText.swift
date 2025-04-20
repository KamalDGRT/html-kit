//
// HTMLText.swift
// HTMLKit
//

#if !os(macOS)
import SwiftUI

public struct HtmlText: View {
    @ObservedObject private var viewModel: HTMLTextViewModel
    
    private let content: String
    private let handleURL: (URL) -> Void
    
    public init(
        content: String,
        handleURL: @escaping (URL) -> Void = {_ in }
    ) {
        self.content = content
        self.handleURL = handleURL
        self.viewModel = HTMLTextViewModel(content: content)
    }
    
    /// Body of the Text that renders the HTML content
    public var body: some View {
        Text(viewModel.attributedString)
            .frame(
                maxWidth: .infinity,
                alignment: viewModel.alignment
            )
            .lineSpacing(viewModel.lineSpacing)
            .tracking(viewModel.characterSpacing)
            .environment(\.openURL, OpenURLAction { url in
                handleURL(url)
                return .handled
            })
    }
}

public extension HtmlText {
    func font(
        name: String,
        size: CGFloat,
        color: Color = .black
    ) -> Self {
        viewModel.fontName = name
        viewModel.fontSize = size
        viewModel.fontColor = color
        
        viewModel.linkTextFont = name
        viewModel.linkTextSize = size
        return self
    }
    
    func alignment(_ alignment: Alignment) -> Self {
        viewModel.alignment = alignment
        return self
    }
    
    func foregroundColor(_ color: Color) -> Self {
        viewModel.fontColor = color
        return self
    }
    
    func linkStyle(_ style: LinkTextDecoration) -> Self {
        viewModel.linkTextDecoration = style
        return self
    }
    
    func linkFont(
        name: String,
        size: CGFloat,
        color: Color
    ) -> Self {
        viewModel.linkTextFont = name
        viewModel.linkTextSize = size
        viewModel.linkTextColor = color
        return self
    }
    
    func lineSpacing(_ lineHeight: CGFloat) -> Self {
        viewModel.lineSpacing = lineHeight
        return self
    }
    
    func characterSpacing(_ spacing: CGFloat) -> Self {
        viewModel.characterSpacing = spacing
        return self
    }
}

#Preview {
    VStack(alignment: .leading, spacing: .zero) {
        HtmlText(
            content: "hiii Kamal adfadf a a dfdasf as hey <a href=\"https://www.google.com/\">google</a>"
        ) { url in
            // Handle URL Actions Here
            print(url)
        }
        .font(name: "", size: 24, color: .red)
        .background(Color.yellow)
        
        HtmlText(
            content: "hiii Kamal <a href=\"https://www.google.com/\">google</a>"
        ) { url in
            // Handle URL Actions Here
            print(url)
        }
        .font(name: "", size: 49, color: .cyan)
        .linkStyle(.underline)
        
        .background(Color.gray)
    }
    
}

#endif
