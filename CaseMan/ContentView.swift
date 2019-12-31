//
//  ContentView.swift
//  CaseMan
//
//  Created by Benjamin Ludwig on 18.12.19.
//  Copyright © 2019 nerdoc & codinger GmbH. All rights reserved.
//

import SwiftUI
import StringExtensions
import Combine

struct ContentView: View {

    @State var singleWords: String = ""
    @State var lowerCamelCase: String = ""
    @State var upperCamelCase: String = ""
    @State var lowerSnakeCase: String = ""
    @State var upperSnakeCase: String = ""
    @State var lowerKebabCase: String = ""
    @State var upperKebabCase: String = ""
    @State var upperCase: String = ""
    @State var lowerCase: String = ""
    
    var body: some View {
        VStack() {
            
            Image("case-man")
                .padding()
            Spacer()
            
            ScrollView(.vertical) {
                VStack(alignment: .leading) {

                    Group {
                        
                        createEditableBlock(header: "single words", content: $singleWords, variableNameCase: .words)
                        
                        createEditableBlock(header: "lowerCamelCase", content: $lowerCamelCase, variableNameCase: .lowerCamel)
                        createEditableBlock(header: "UpperCamelCase", content: $upperCamelCase, variableNameCase: .upperCamel)
                        
                        createEditableBlock(header: "lower_snake_case", content: $lowerSnakeCase, variableNameCase: .lowerSnake)
                        createEditableBlock(header: "UPPER_SNAKE_CASE", content: $upperSnakeCase, variableNameCase: .upperSnake)
                        
                        createEditableBlock(header: "lower-kebab-case", content: $lowerKebabCase, variableNameCase: .lowerKebab)
                        createEditableBlock(header: "UPPER-KEBAB-CASE", content: $upperKebabCase, variableNameCase: .upperKebab)
                    }
                    
                    Group {
                        createStaticBlock(header: "lowercase (tap to copy)", content: $lowerCase)
                        createStaticBlock(header: "CAPITALCASE (tap to copy)", content: $upperCase)
                    }
                }.padding()
            }
        }
    }
    
    private func createEditableBlock(header: String, content: Binding<String>, variableNameCase: String.VariableNameCase) -> some View {
        Group {
            Text("\(header):")
                .modifier(CaptionTextStyle())
            HStack() {
                TextField(header, text: content) {
                    self.setCases(with: content.wrappedValue, variableNameCase: variableNameCase)
                }
                    .padding()
                    .modifier(ContentTextFieldStyle())
                Button(action: {
                    UIPasteboard.general.string = content.wrappedValue
                }) {
                    Text("copy").foregroundColor(Color("ContentTextColor"))
                }
            }
        }
    }
    
    private func createStaticBlock(header: String, content: Binding<String>) -> some View {
        Group {
            Text("\(header):")
                .modifier(CaptionTextStyle())
            Text("\(content.wrappedValue)")
                .padding()
                .copyOnTap(content)
                .modifier(ContentTextStyle())
        }
    }
    
    private func setCases(with string: String, variableNameCase: String.VariableNameCase) {

        singleWords = string.transforming(from: variableNameCase, to: .words)
        lowerCamelCase = string.transforming(from: variableNameCase, to: .lowerCamel)
        upperCamelCase = string.transforming(from: variableNameCase, to: .upperCamel)
        lowerSnakeCase = string.transforming(from: variableNameCase, to: .lowerSnake)
        upperSnakeCase = string.transforming(from: variableNameCase, to: .upperSnake)
        lowerKebabCase = string.transforming(from: variableNameCase, to: .lowerKebab)
        upperKebabCase = string.transforming(from: variableNameCase, to: .upperKebab)
        
        upperCase = singleWords.replacingOccurrences(of: " ", with: "").uppercased()
        lowerCase = upperCase.lowercased()
    }
}

struct CaptionTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.gray)
            .font(.system(.caption, design: .monospaced))
    }
}

struct ContentTextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.white)
            .background(RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color.black))
            .font(.system(.headline, design: .monospaced))
    }
}

struct ContentTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color("ContentTextColor"))
            .font(.system(.headline, design: .monospaced))
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
        Group {
            ContentView(singleWords: "my fancy var")
                .environment(\.colorScheme, .dark)
        
            ContentView(singleWords: "my fancy var")
                .environment(\.colorScheme, .light)
        }
    }
}
