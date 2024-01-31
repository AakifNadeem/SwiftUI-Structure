//
//  CustomText.swift
//
//  Created by Aakif Nadeem on 21/11/2023.
//

import Foundation
import SwiftUI

struct CustomText: View
{
    var text: String
    var fontSize: Double = 18
    var textColor: Color = .black
    var type: Font.Weight = .regular
    var alignment: TextAlignment = .leading
    
    var body: some View {
        Text(LocalizedStringKey(text))
            .font(.system(size: fontSize, weight: type))
            .foregroundColor(textColor)
            .multilineTextAlignment(alignment)
    }
}

struct CustomTextField: View
{
    @Binding var text: String
    let placeHolder: String
    
    var body: some View {
        TextField(LocalizedStringKey(placeHolder), text: self.$text)
            .font(.system(size: 14))
            .frame(height: 45)
            .textFieldStyle(PlainTextFieldStyle())
            .padding([.horizontal], 14)
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(Color.init(uiColor: .systemGray6), lineWidth: 2.0))
            .autocapitalization(.none)
            .disableAutocorrection(true)
    }
}

struct CustomEmailTextField: View
{
    @Binding var email: String
    var placeHolder = "Enter your email"
    
    var body: some View {
        TextField(LocalizedStringKey(placeHolder), text: self.$email)
            .frame(height: 50)
            .font(.system(size: 14))
            .textFieldStyle(PlainTextFieldStyle())
            .padding(.horizontal, 8)
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(
                    email == "" ?
                    Color.init(uiColor: .systemGray5) :
                        checkValidEmail(email) ?
                    Color.green :
                        Color.red
                    , lineWidth: 2.0))
            .autocapitalization(.none)
            .keyboardType(.emailAddress)
            .textContentType(.emailAddress)
            .disableAutocorrection(true)
    }
}

struct CustomPasswordTextField: View
{
    @Binding var text: String
    var placeHolder = "Enter your password"
    var validCount = 8
    
    var body: some View {
        VStack {
            SecureField(LocalizedStringKey(placeHolder), text: self.$text)
                .frame(height: 50)
                .font(.system(size: 14))
                .textFieldStyle(PlainTextFieldStyle())
                .padding([.horizontal], 8)
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(
                        text == "" ?
                        Color.init(uiColor: .systemGray5) :
                            checkValidTextSize(text, count: validCount) ?
                        Color.green :
                            Color.red
                        , lineWidth: 2.0))
                .autocapitalization(.none)
                .textContentType(.password)
                .disableAutocorrection(true)
            
            LeadingText(text: "Password length should be more than 8 characters", fontSize: 12, color: .red)
                .hidden(checkValidTextSize(text, count: validCount) || text.count == 0)
                .padding(.top, -4)
        }
    }
    
    func checkValidTextSize(_ string: String, count: Int) -> Bool {
        if (string.count >= count) {
            return true
        }else {
            return false
        }
    }
}


struct CustomPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(text: .constant(""), placeHolder: "please enter email")
    }
}
