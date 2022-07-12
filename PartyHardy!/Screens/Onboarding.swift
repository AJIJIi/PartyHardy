//
//  OnBoarding.swift
//  Party Hardy!
//
//  Created by Alessia Saviano on 04/12/21.
//

import SwiftUI

//onboarding screen for first time using the app
struct Onboarding: View {
    @Binding var shouldShowOnboarding: Bool //when true this page is shown. Use to close the page
    
    var body: some View {
        
        ZStack {
            //MARK: - Background
            Color.grayMode
                .ignoresSafeArea()
            
            VStack {
                Section {
                    Spacer()
                    
                    //MARK: - Image
                    Image("onBoarding")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 330)
                        .padding(.top, 30).padding(.bottom, 20)
                    
                    //MARK: - Title
                    Text("Ready for your party?")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20).padding(.vertical, 10)
                    
                    //MARK: - Description
                    Text("Set all the party details and our team of nerd scientists will come up with the perfect amount of food and drinks to buy for the best experience!")
                        .font(.system(size: 17))
                        .foregroundColor(Color.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20).padding(.vertical, 5)
                    
                    Spacer()
                }
                
                //MARK: - Start button
                Section {
                    Button(action: {
                        shouldShowOnboarding.toggle()
                    }, label: {
                        Text("Start")
                            .font(.system(size: 16).bold())
                            .foregroundColor(Color.white)
                            .padding(15)
                            .frame(maxWidth: .infinity, maxHeight: 44)
                            .background(Color.accentColor)
                            .cornerRadius(10)
                    }).padding(.horizontal, 20).padding(.vertical, 30)
                }
            }
        }
    }
}
