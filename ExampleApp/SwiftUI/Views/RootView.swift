// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI
import UniversalTextEditor

struct RootView: View {
    typealias DisplayMode = UniversalTextView.DisplayMode
    
    @State private(set) var displayMode: DisplayMode = .plainText
    @State private(set) var text = "**Bold** _Italic_"

    var body: some View {
        VStack {
            Picker("Mode", selection: self.$displayMode) {
                Text("Plain Text")
                    .tag(DisplayMode.plainText)
                Text("Stylized Markdown")
                    .tag(DisplayMode.stylizedMarkdown)
                Text("Stylized Hidden Markdown")
                    .tag(DisplayMode.stylizedHiddenMarkdown)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            .background(.secondary)
            .frame(maxWidth: .infinity)
            
            UniversalTextEditor(displayMode: self.$displayMode, text: self.$text)
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        let message = """
        # This is a heading
        
        **This is bold**
        
        _This is italic_
        
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc sit amet odio lectus. Nunc eget neque faucibus libero condimentum elementum vitae in est. Integer commodo, ante vel tristique imperdiet, tellus nunc imperdiet sapien, quis maximus elit lorem ut nunc. Donec urna libero, lacinia vitae ligula ac, porttitor sagittis elit. Aliquam gravida lobortis eros, ac convallis mauris porta et. Phasellus hendrerit purus a velit rhoncus viverra. Ut tincidunt lorem in nisi cursus, id sagittis lacus laoreet. Morbi pellentesque, magna eget facilisis molestie, ante ligula tempus neque, ac imperdiet mi turpis accumsan nibh. Donec rhoncus nisl dolor. Maecenas accumsan dictum consectetur. Cras quis nibh non elit pharetra eleifend a non enim. Maecenas accumsan augue vel massa euismod semper. Nulla sapien eros, pharetra vitae iaculis lacinia, aliquet ac tortor.
        """

        ForEach(UniversalTextView.DisplayMode.allCases, id: \.self) { mode in
            RootView(displayMode: mode, text: message)
                .previewDisplayName(mode.rawValue)
        }
    }
}
