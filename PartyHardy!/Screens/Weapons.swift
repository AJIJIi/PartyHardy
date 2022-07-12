//
//  ContentView.swift
//  SwiftUIJam
//
//  Created by Danil Masnaviev on 06/11/21.
//

import SwiftUI

//Screen where user choses menu positions
struct Weapons: View {
    @Binding var appData: AppData
    @Binding var isPrevScreenActive: Bool //A value indicating if previous Navigation link active.
    @State var isNavigationLinkActive = false
    
    var body: some View {
        
        ZStack {
            //MARK: - Background
            Color.grayMode
                .ignoresSafeArea()
            
            VStack {
                ZStack {
                    
                    //MARK: - lines for navigation
                    HStack {
                        Rectangle()
                            .foregroundColor(Color.tertiaryColor)
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
                                .background(Color.tertiaryColor)
                                .clipShape(Circle())
                            
                            Text("Fighters")
                                .font(.footnote).foregroundColor(Color(UIColor.lightGray))
                        }
                        
                        Spacer()
                        
                        VStack {
                            Image(uiImage: UIImage(named: "weapons")!)
                                .foregroundColor(.white)
                                .frame(width: 36, height: 36)
                                .padding(3)
                                .background(Color.secondaryColor)
                                .clipShape(Circle())
                            
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
                
                //MARK: - All menu positions
                Form {
                    
                    //MARK: - Basic menu positions
                    Section(header: Text("Basics")
                                .padding(.top, AppUtilities.topSectionPadding())) {
                        ForEach(Array(zip(appData.menuPositions.indices, appData.menuPositions)), id: \.0) { (index, item) in
                            if item.type == .basic {
                                HStack {
                                    Toggle(isOn: $appData.menuPositions[index].isIncluded) {
                                        Text(item.icon + " " + item.name)
                                            .font(.system(size: 17))
                                    }
                                }
                                .padding(.vertical, AppUtilities.sectionsPadding())
                            }
                        }
                    }
                    
                    //MARK: - Food menu positions
                    Section(header: Text("Food")) {
                        ForEach(Array(zip(appData.menuPositions.indices, appData.menuPositions)), id: \.0) { (index, item) in
                            if item.type == .meal {
                                HStack {
                                    Toggle(isOn: $appData.menuPositions[index].isIncluded) {
                                        Text(item.icon + " " + item.name)
                                            .font(.system(size: 17))
                                    }
                                    .disabled(appData.eatersCount == 0)
                                    .onAppear() {
                                        if appData.eatersCount == 0 {
                                            appData.menuPositions[index].isIncluded = false
                                        }
                                    }
                                }
                                .padding(.vertical, AppUtilities.sectionsPadding())
                            }
                        }
                    }
                    
                    //MARK: - Alcohol menu positions
                    Section(header: Text("Alcohol")) {
                        ForEach(Array(zip(appData.menuPositions.indices, appData.menuPositions)), id: \.0) { (index, item) in
                            if item.type == .alcoholDrink {
                                HStack {
                                    Toggle(isOn: $appData.menuPositions[index].isIncluded) {
                                        Text(item.icon + " " + item.name)
                                            .font(.system(size: 17))
                                    }
                                    .disabled(appData.drinkersCount == 0)
                                    .onAppear() {
                                        if appData.drinkersCount == 0 {
                                            appData.menuPositions[index].isIncluded = false
                                        }
                                    }
                                }
                                .padding(.vertical, AppUtilities.sectionsPadding())
                            }
                        }
                    }
                }
                
                //MARK: - Navigation buttons
                Section {
                    HStack {
                        Button(action: {
                            isPrevScreenActive = false
                        }) {
                            Text("Previous")
                                .foregroundColor(.accentColor)
                                .font(.system(size: 16).bold())
                                .frame(width: 133, height: 44)
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.accentColor, lineWidth: 1)
                        )
                        
                        Spacer()
                        
                        NavigationLink(isActive: $isNavigationLinkActive, destination: {Spells(appData: $appData, isPrevScreenActive: $isNavigationLinkActive, isFirstScreenActive: $isPrevScreenActive)}) {
                            Text("Next")
                                .foregroundColor(.white)
                                .font(.system(size: 16).bold())
                                .frame(width: 133, height: 44)
                                .background(Color.accentColor)
                                .cornerRadius(10)
                        }
                        .isDetailLink(false)
                        .disabled(!appData.menuPositions.contains(where: {$0.isIncluded}))
                    }
                    .padding(20)
                }
            }
            .background(Color.grayMode.ignoresSafeArea())
            .navigationTitle("Get your weapons")
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        appData.resetData(overallData: false, menuPositions: true)
                    }) {
                        Text("Reset")
                    }
                }
            }
        }
    }
}
