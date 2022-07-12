//
//  Utilities.swift
//  PartyHardy!
//
//  Created by Aleksei Bochkov on 08/12/21.
//

import SwiftUI

extension Double {
    //for showing beatiful result
    func roundUp() -> Int {
        return Int(self) + (self.truncatingRemainder(dividingBy: 1.0) == 0 ? 0 : 1)
    }
    
    //to round shown hours
    func getHoursFormat() -> String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? "\(Int(self)) h" : "\(Int(self)).5 h"
    }
}

//custom colors
extension Color {
    static let secondaryColor = Color("SecondaryColor")
    static let tertiaryColor = Color("TertiaryColor")
    static let grayMode = Color("GrayMode")
}

class AppUtilities {
    static func topSectionPadding() -> CGFloat {
        if #available(iOS 15.0, *) {
            return 0
        } else {
            return 30
        }
    }
    
    static func sectionsPadding() -> CGFloat {
        return UIScreen.main.bounds.height == 844 ? 2.5 : 0
    }
}
