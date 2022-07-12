//
//  Summary.swift
//  Prototype
//
//  Created by Lorenzo Lins Mazzarotto on 07/11/21.
//

import SwiftUI

//Screen where user sees the result
struct Spells: View {
    @Binding var appData: AppData
    @Binding var isPrevScreenActive: Bool
    @Binding var isFirstScreenActive: Bool
    @State var showShareSheet = false //SHould be share screen shown
    
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
                            .foregroundColor(Color.tertiaryColor)
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
                                .background(Color.tertiaryColor)
                                .clipShape(Circle())
                            
                            Text("Weapons")
                                .font(.footnote).foregroundColor(Color(UIColor.lightGray))
                        }
                        
                        Spacer()
                        
                        VStack {
                            Image(systemName: "book.fill")
                                .foregroundColor(.white)
                                .frame(width: 36, height: 36)
                                .padding(3)
                                .background(Color.secondaryColor)
                                .clipShape(Circle())
                            
                            Text("Spells")
                                .font(.footnote).foregroundColor(Color(UIColor.lightGray))
                        }
                    }.padding()
                }
                
                //MARK: - Info about the party
                Form {
                    Section(header: Text("Fighters")
                                .padding(.top, AppUtilities.topSectionPadding())) {
                        List {
                            ForEach(appData.partyDescriptionLines, id:\.0) { line in
                                HStack {
                                    Text(line.title)
                                        .font(.system(size: 17))
                                    
                                    Spacer()
                                    
                                    Text(line.value)
                                        .font(.system(size: 17))
                                        .foregroundColor(.gray)
                                }
                                .listRowBackground(Color.clear)
                            }
                        }
                    }
                    
                    //MARK: - A section with results
                    Section(header: Text("Weapons\n(calculated randomly for NDA purposes.\nFor correct numbers use AppStore verison)")) {
                        ForEach(appData.resultLines, id: \.0) { line in
                            HStack {
                                Text(line.title)
                                    .font(.system(size: 17))
                                
                                Spacer()
                                
                                Text(line.amount)
                                    .font(.system(size: 17))
                                    .foregroundColor(.gray)
                            }
                            .padding(.vertical, AppUtilities.sectionsPadding())
                        }
                    }
                }
                
                //MARK: - Navigation button
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
                }
                .padding(20)
            }
            .navigationBarTitle("Let's have fun!")
            .navigationBarBackButtonHidden(true)
            //MARK: - Share screen
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        let activityVC = UIActivityViewController(activityItems: [appData.descriptionAndResult], applicationActivities: nil)
                        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
                    }) {
                        Image(systemName: "square.and.arrow.up")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        appData.resetData(overallData: true, menuPositions: true)
                        isPrevScreenActive = false
                        isFirstScreenActive = false
                    }) {
                        Text("Reset")
                    }
                }
            }
        }
    }
}
