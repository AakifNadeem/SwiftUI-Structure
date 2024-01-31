//
//  CustomToastView.swift
//
//  Created by Aakif Nadeem on 08/02/2023.
//

import Foundation
import SwiftUI
import ToastUI

func CustomErrorToast(message: String) -> some View {
    VStack {
        Spacer()
        
        HStack(alignment: .top) {
            Image("ic_error")
                .resizable()
                .frame(maxWidth: 20, maxHeight: 20)
                .padding([.top, .bottom, .leading])
            
            CustomText(text: message)
                .foregroundColor(.white)
                .padding([.vertical, .trailing], 14)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.errorRed)
        .cornerRadius(8.0)
        .addBorder(.red, cornerRadius: 8)
    }
    .padding()
}

func CustomSuccessToast(message: String) -> some View {
    VStack {
        Spacer()
        
        HStack(alignment: .top) {
            Image("ic_success")
                .resizable()
                .frame(maxWidth: 20, maxHeight: 20)
                .padding([.top, .bottom, .leading])
            
            CustomText(text: message)
                .foregroundColor(.white)
                .padding([.vertical, .trailing], 14)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.successGreen)
        .cornerRadius(8.0)
        .addBorder(.green, cornerRadius: 8)
    }
    .padding()
}

func CustomButtonToast(message: String, buttonText: String, onBtnTapped: @escaping () -> Void) -> some View {
    VStack {
        Spacer()
        
        HStack(alignment: .top) {
            Image("ic_error")
                .resizable()
                .frame(maxWidth: 20, maxHeight: 20)
                .padding([.vertical, .leading])
            
            VStack(alignment: .leading, spacing: 0) {
                CustomText(text: message)
                    .foregroundColor(.white)
                    .padding([.top, .trailing], 16)
                
                Button(action: onBtnTapped) {
                    CustomText(text: buttonText)
                        .foregroundColor(.white)
                        .underline()
                        .padding([.bottom, .trailing], 16)
                }
            }
            .padding(.top, -2)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.init(uiColor: .systemGray4))
        .cornerRadius(8.0)
        .addBorder(.gray, cornerRadius: 8)
    }
    .padding()
}

struct CustomToastView_Previews: PreviewProvider {
    static var previews: some View {
        CustomButtonToast(message: "Testing Some Data", buttonText: "") {
            print("Tapped")
        }
    }
}
