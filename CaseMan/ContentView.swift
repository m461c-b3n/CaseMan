//
//  ContentView.swift
//  CaseMan
//
//  Created by Benjamin Ludwig on 18.12.19.
//  Copyright © 2019 nerdoc & codinger GmbH. All rights reserved.
//

import SwiftUI
import StringExtensions

fileprivate typealias StringToSingleWordsTransformer = (String) -> String

struct ContentView: View {
    
    private static let captionColor = Color.gray
    
    @State var singleWords: String = ""
    @State var upperCamelCase: String = ""
    @State var lowerCamelCase: String = ""
    @State var lowerSnakeCase: String = ""
    @State var upperSnakeCase: String = ""
    @State var upperCase: String = ""
    @State var lowerCase: String = ""
    
    private let camelCaseToSingleWords: StringToSingleWordsTransformer = { $0.camelCaseToWords().lowercased() }
    private let snakeCaseToSingleWords: StringToSingleWordsTransformer = { $0.lowercased().replacingOccurrences(of: "_", with: " ") }
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                createEditableBlock(header: "Single Words", content: $singleWords, tranformer: { $0.lowercased() })
                
                createEditableBlock(header: "UpperCamelCase", content: $upperCamelCase, tranformer: camelCaseToSingleWords)
                createEditableBlock(header: "lowerCamelCase", content: $lowerCamelCase, tranformer: camelCaseToSingleWords)
                
                createEditableBlock(header: "lower_snake_case", content: $lowerSnakeCase, tranformer: snakeCaseToSingleWords)
                createEditableBlock(header: "UPPER_SNAKE_CASE", content: $upperSnakeCase, tranformer: snakeCaseToSingleWords)
            }
            
            Group {
                createStaticBlock(header: "CAPITALCASE", content: $upperCase)
                createStaticBlock(header: "lowercase", content: $lowerCase)
            }
        }.padding()
    }
    
    private func createEditableBlock(header: String, content: Binding<String>, tranformer: @escaping StringToSingleWordsTransformer = { $0 }) -> some View {
        Group {
            Text("\(header):")
                .modifier(CaptionTextFieldStyle())
            TextField(header, text: content, onCommit: {
                self.setCases(with: tranformer(content.wrappedValue))
            })
                .padding()
                .copyOnTap(content)
                .modifier(ContentTextFieldStyle())
        }
    }
    
    private func createStaticBlock(header: String, content: Binding<String>) -> some View {
        Group {
            Text("\(header):")
                .modifier(CaptionTextFieldStyle())
            Text("\(content.wrappedValue)")
                .padding()
                .copyOnTap(content)
        }
    }
    
    // neutralized String is lowercased words seperated by single spaces
    private func setCases(with singleWordString: String) {
        logDebug("signle word string: %{PUBLIC}@", singleWordString)
        singleWords = singleWordString
        lowerSnakeCase = singleWordString.replacingOccurrences(of: " ", with: "_")
        upperSnakeCase = lowerSnakeCase.uppercased()
        upperCamelCase = singleWordString.split(separator: " ").compactMap { $0.capitalized }.joined(separator: "")
        lowerCamelCase = upperCamelCase.lowercasedFirstLetter()
        upperCase = singleWordString.replacingOccurrences(of: " ", with: "").uppercased()
        lowerCase = upperCase.lowercased()
    }
}

struct CaptionTextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.gray)
    }
}

struct ContentTextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.white)
    }
}

extension View {
    public func copyOnTap(_ text: Binding<String>) -> some View {
        return self.onTapGesture {
            UIPasteboard.general.string = text.wrappedValue
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
