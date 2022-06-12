// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI
import UniversalTextEditor

struct RootView: View {
    typealias DisplayMode = UniversalTextView.DisplayMode

    enum RenderingMode {
        case nsAttributedString
        case attributedString
        case down
    }
    
    let markdown: String = "**Wow!!**"
    
    @State private(set) var text = NSAttributedString(string: Self.sampleText)
    @State private(set) var displayMode: DisplayMode = .stylizedMarkdown
    @State private(set) var theme: UniversalTextView.Theme = .debug

    var body: some View {
        VStack {
            Group {
                Text(markdown: "This is some **bold** and _italic_ text.")
            }
            
            Group {
                Text("**This is crazyyyy!!**")
                + Text(" Wow!")
                + Text(" · ")
                    .foregroundColor(.red)
                + Text(medlyMarkdown: "This is some **bold** and _italic_ text.")
                + Text(" And more text for good measure.")
            }
            
            Spacer()
            
//            Picker("Mode", selection: self.$displayMode) {
//                Text("Plain Text")
//                    .tag(DisplayMode.plainText)
//                Text("Stylized Markdown")
//                    .tag(DisplayMode.stylizedMarkdown)
//                Text("Stylized Hidden Markdown")
//                    .tag(DisplayMode.stylizedHiddenMarkdown)
//            }
//            .pickerStyle(SegmentedPickerStyle())
//            .padding()
//            .background(.secondary)
//            .frame(maxWidth: .infinity)
//
//            UniversalTextEditor(
//                text: self.$text,
//                displayMode: self.$displayMode,
//                theme: self.$theme
//            )
        }
    }
}

// MARK: - Previews

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(UniversalTextView.DisplayMode.allCases, id: \.self) { mode in
            RootView(text: .init(string: RootView.sampleText), displayMode: mode)
                .previewDisplayName(mode.rawValue)
                .frame(height: 2000)
        }
    }
}

// MARK: - Data

private extension RootView {
    static let sampleText = """
    # Heading 1
    
    Lorem ipsum dolor sit amet, consectetur adipiscing elit.
    
    ## Heading 2
    
    Lorem ipsum dolor sit amet, consectetur adipiscing elit.
    
    ### Heading 3
    
    Lorem ipsum dolor sit amet, consectetur adipiscing elit.
    
    ##### Heading 5
    
    Lorem ipsum dolor sit amet, consectetur adipiscing elit.
    
    ###### Heading 6
    
    Lorem ipsum dolor sit amet, consectetur adipiscing elit.
    
    **This is strong / bolded.**
    
    _This is emphasized / italicized._
    
    ~~This is strikethrough'd.~~
    
    [This is a link to my site.](https://briandrelling.com)
    
    `let message = "This is inline code."`
    
    ```swift
    let message = "This is a code block."
    print(message)
    ```
    
    > This is a blockquote. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc sit amet odio lectus. Nunc eget neque faucibus libero condimentum elementum vitae in est. Integer commodo, ante vel tristique imperdiet, tellus nunc imperdiet sapien, quis maximus elit lorem ut nunc.
    
    1. An ordered list.
    1. Lorem ipsum dolor sit amet.
        1. Nunc sit amet odio lectus.
        2. Nunc eget neque faucibus libero condimentum elementum vitae in est.
        3. Integer commodo, ante vel tristique imperdiet.
    1. Tellus nunc imperdiet sapien, quis maximus elit lorem ut nunc.
    
    - Blueberries
    - Apples
        - Macintosh
        - Honey crisp
        - Cortland
    - Banana
    
    # Additional Examples
    
    Nesting **an *[emphasized link](https://apolloapp.io)* inside strong text**!
    """
}
