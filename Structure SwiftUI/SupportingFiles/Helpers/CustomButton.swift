//
//  CustomButton.swift
//
//  Created by Aakif Nadeem on 26/01/2023.
//

import Foundation
import SwiftUI

struct CustomButton: View
{
    var text: String
    var fontSize: CGFloat = 18
    var fontType: Font.Weight = .regular
    var backgroundColor: Color = .black
    var textColor: Color = .white
    var cornerRadius: CGFloat = 12
    
    var action: (()->Void)?
    
    var body: some View {
        Button {
            self.action?()
        } label: {
            CustomText(text: text, fontSize: fontSize, textColor: textColor, type: fontType)
                .frame(maxWidth: .infinity, minHeight: 48)
                .background(backgroundColor)
        }
        .buttonStyle(.plain)
        .cornerRadius(cornerRadius)
    }
}

struct CustomImageButton: View
{
    var text: String
    var fontSize: CGFloat = 18
    var fontType: Font.Weight = .regular
    var backgroundColor: Color = .black
    var textColor: Color = .white
    var preImage = ""
    var postImage = ""
    var imageTint: Color = .white
    var cornerRadius: CGFloat = 12
    
    var action: (()->Void)?
    
    var body: some View {
        Button {
            self.action?()
        } label: {
            HStack(alignment: .center) {
                if !(preImage.isEmpty) {
                    Image(self.preImage)
                        .foregroundColor(imageTint)
                }
                CustomText(text: text, fontSize: fontSize, textColor: textColor, type: fontType)
                if !(postImage.isEmpty) {
                    Image(self.postImage)
                        .foregroundColor(imageTint)
                }
            }
            .frame(maxWidth: .infinity, minHeight: 48)
            .background(backgroundColor)
        }
        .buttonStyle(.plain)
        .cornerRadius(cornerRadius)
    }
}
