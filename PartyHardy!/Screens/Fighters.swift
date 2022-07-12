//
//  Fighters.swift
//  Prototype
//
//  Created by Lorenzo Aleksei Bochkov on 06/11/21.
//

import SwiftUI

//Screen where user sets party parameters
struct Fighters: View {
    @State private var appData = AppData() //parameters chosen by the user
    @State private var isNavigationLinkActive = false //pass to next screen and set false when you need to come back to this screen
    @AppStorage("shouldShowOnboarding") var shouldShowOnboarding: Bool = true //says if onboarding screen is should be shown
    
    //Settings for the whole project
    init() {
        UINavigationBar.setAnimationsEnabled(false)
        UITableView.appearance().contentInset.top = -15
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                //MARK: - Background
                Color.grayMode
                    .ignoresSafeArea()
                
                VStack {
                    ZStack {
                        
                        //MARK: - lines for navigation
                        HStack {
                            Rectangle()
                                .foregroundColor(Color(.systemGray4))
                                .frame(width: (UIScreen.main.bounds.width - 90) / 2, height: 1.5)
                            
                            Spacer()
                            
                            Rectangle()
                                .foregroundColor(Color(.systemGray4))
                                .frame(width: (UIScreen.main.bounds.width - 90) / 2, height: 1.5)
                        }
                        .padding(.vertical, -12)
                        .padding(.horizontal, 40)
                        
                        //MARK: - navigation items
                        HStack {
                            VStack {
                                Image(systemName: "person.3.fill")
                                    .foregroundColor(.white)
                                    .frame(width: 36, height: 36)
                                    .padding(3)
                                    .background(Color.secondaryColor)
                                    .clipShape(Circle())
                                
                                Text("Fighters")
                                    .font(.footnote).foregroundColor(Color(UIColor.lightGray))
                            }
                            
                            Spacer()
                            
                            VStack {
                                Image(uiImage: UIImage(named: "weapons")!)
                                    .frame(width: 36, height: 36)
                                    .foregroundColor(Color(UIColor.lightGray))
                                    .padding(3)
                                    .background(Color.grayMode)
                                    .overlay(Circle()
                                                .stroke(Color(.systemGray4), lineWidth: 1.5))
                                
                                Text("Weapons")
                                    .font(.footnote).foregroundColor(Color(UIColor.lightGray))
                            }
                            
                            Spacer()
                            
                            VStack {
                                Image(systemName: "book.fill")
                                    .foregroundColor(Color(UIColor.lightGray))
                                    .frame(width: 36, height: 36)
                                    .padding(3)
                                    .background(Color.grayMode)
                                    .overlay(Circle()
                                                .stroke(Color(.systemGray4), lineWidth: 1.5))
                                
                                Text("Spells")
                                    .font(.footnote).foregroundColor(Color(UIColor.lightGray))
                            }
                        }.padding()
                    }
                    
                    ScrollView {
                        //MARK: - Image with people
                        Section {
                            Image("people")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 370)
                                .padding(.horizontal, 20)
                                .padding(.top, 10).padding(.bottom, 30)
                        }
                        
                        //MARK: - Settigns parameters for a party
                        Section {
                            HStack {
                                Text("How long is your party?")
                                    .font(.title3.bold())
                                Spacer()
                                Text(appData.partyLength.getHoursFormat())
                                    .foregroundColor(Color.gray)
                                
                            }
                            Slider(value: $appData.partyLength, in: 0...10, step: 0.5)
                                .padding(.bottom, 10)
                            
                            HStack {
                                Text("How many eaters?")
                                    .font(.title3.bold())
                                Spacer()
                                Text("\(appData.eatersCount, specifier: "%.0f")")
                                    .foregroundColor(Color.gray)
                            }
                            Slider(value: $appData.eatersCount, in: 0...50, step: 1)
                                .padding(.bottom, 10)
                            
                            HStack {
                                Text("How many drinkers?")
                                    .font(.title3.bold())
                                Spacer()
                                Text("\(appData.drinkersCount, specifier: "%.0f")")
                                    .foregroundColor(Color.gray)
                            }
                            Slider(value: $appData.drinkersCount, in: 0...50, step: 1)
                                .padding(.bottom, 10)
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    //MARK: - next button
                    Section {
                        HStack {
                            Spacer()
                            
                            NavigationLink(isActive: $isNavigationLinkActive, destination: {Weapons(appData: $appData, isPrevScreenActive: $isNavigationLinkActive)}) {
                                Text("Next")
                                    .foregroundColor(.white)
                                    .font(.system(size: 16).bold())
                                    .frame(width: 133, height: 44)
                                    .background(Color.accentColor)
                                    .cornerRadius(10)
                            }
                            .isDetailLink(false)
                            .disabled((appData.eatersCount == 0 && appData.drinkersCount == 0) || appData.partyLength == 0)
                        }
                        .padding(20)
                    }
                    
                }
                .navigationBarTitle("Choose your fighters")
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            appData.resetData(overallData: true, menuPositions: false)
                        }) {
                            Text("Reset")
                        }
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $shouldShowOnboarding, content: {
            Onboarding(shouldShowOnboarding: $shouldShowOnboarding)
        })
    }
}
