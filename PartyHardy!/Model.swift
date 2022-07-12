//
//  PartyHardy_App.swift
//  PartyHardy!
//
//  Created by Aleksei Bochkov on 08/12/21.
//

import Foundation

//What category the position is in
enum MenuPositionType {
    case meal
    case alcoholDrink
    case basic
}

struct Measurement {
    let name: String
    let meterMeasurement: String?
    let imperialMeasurement: String?
    let meterConversionRate: Double? //amount of this measurement in 1 name
    let imperialConversionRate: Double? //amount of this measurement in 1 name
    
    init(name: String, meterMeasurement: String? = nil, imperialMeasurement: String? = nil, meterConversionRate: Double? = nil, imperialConversionRate: Double? = nil) {
        self.name = name
        self.meterMeasurement = meterMeasurement
        self.imperialMeasurement = imperialMeasurement
        self.meterConversionRate = meterConversionRate
        self.imperialConversionRate = imperialConversionRate
    }
}

struct MenuPosition {
    let name: String
    let icon: String //emoji
    let type: MenuPositionType
    let measurement: Measurement
    let singleAmountPerHour: Double //for one person in one hour
    let maxAmount: Double? //maxinun amount for one person for a party (used only for alcohol)
    var isIncluded: Bool
    
    init(name: String, icon: String, type: MenuPositionType, measurement: Measurement, singleAmountPerHour: Double, maxAmount: Double? = nil) {
        self.name = name
        self.icon = icon
        self.type = type
        self.measurement = measurement
        self.singleAmountPerHour = singleAmountPerHour
        self.maxAmount = maxAmount
        self.isIncluded = false
    }
    
    //calculates amount (with measurements) of this position user need to buy based on chosen parameters (appData)
    func calculateAmount(appData: AppData) -> String? {
        guard isIncluded else { return nil }
        
        //Amount calculated randomly in order not to break NDA
        //For real calculations try this app on the AppStore
        let amount = Double.random(in: 0...10)
        
        var measurements = measurement.name
        if let meterMeasurement = measurement.meterMeasurement, let meterConversionRate = measurement.meterConversionRate, Locale.current.regionCode != "US" {
            measurements += " = \((amount * meterConversionRate).roundUp())" + meterMeasurement
        } else if let imperialMeasurement = measurement.imperialMeasurement, let imperialConversionRate = measurement.imperialConversionRate, Locale.current.regionCode == "US" {
            measurements += " = \((amount * imperialConversionRate).roundUp())" + imperialMeasurement
        }
        
        return amount == 0 ? nil : String(amount.roundUp()) + measurements
    }
}

//parameters chosen by the user
struct AppData {
    var eatersCount: Double = 0
    var drinkersCount: Double = 0
    var partyLength: Double = 0
    
    var partyDescriptionLines: [(title: String, value: String)] {
        return [("Party Duration", partyLength.getHoursFormat()), ("Eaters", String(Int(eatersCount))), ("Drinkers", String(Int(drinkersCount)))]
    }
    
    var resultLines: [(title: String, amount: String)] {
        return menuPositions.filter({$0.isIncluded}).compactMap({menuPosition in
            return (menuPosition.icon + " " + menuPosition.name, menuPosition.calculateAmount(appData: self) ?? "")})
    }
    
    var descriptionAndResult: String {
        var result = ""
        for line in partyDescriptionLines {
            result += line.title + ": " + line.value + "\n"
        }
        result += "\n"
        for line in resultLines {
            result += line.title + ": " + line.amount + "\n"
        }
        result += "\nAmount of food and drinks for your amazing event was calculated in the PartyHardy! https://apps.apple.com/us/app/partyhardy/id1609635868"
        return result
    }

    //all the positions used in the app
    var menuPositions = [
        MenuPosition(name: "Pizza", icon: "🍕", type: .meal, measurement: Measurement(name: " pizzas (30 cm)"), singleAmountPerHour: 1),
        MenuPosition(name: "Burger", icon: "🍔", type: .meal, measurement: Measurement(name: " burgers"), singleAmountPerHour: 1),
        MenuPosition(name: "Sushi", icon: "🍣", type: .meal, measurement: Measurement(name: " rolls", meterMeasurement: " pieces", imperialMeasurement: " pieces", meterConversionRate: 8, imperialConversionRate: 8), singleAmountPerHour: 2),
        MenuPosition(name: "Wok", icon: "🍝", type: .meal, measurement: Measurement(name: " boxes"), singleAmountPerHour: 1),
        MenuPosition(name: "Snacks", icon: "🍟", type: .basic, measurement: Measurement(name: " medium bags", meterMeasurement: " g", imperialMeasurement: " oz", meterConversionRate: 150, imperialConversionRate: 5.3), singleAmountPerHour: 0.5),
        MenuPosition(name: "Wine", icon: "🍷", type: .alcoholDrink, measurement: Measurement(name: " bottles", meterMeasurement: " L", imperialMeasurement: " fl oz", meterConversionRate: 0.75, imperialConversionRate: 25.36), singleAmountPerHour: 0.4, maxAmount: 1.5),
        MenuPosition(name: "Beer", icon: "🍺", type: .alcoholDrink, measurement: Measurement(name: " bottles", meterMeasurement: " L", imperialMeasurement: " pt", meterConversionRate: 0.47, imperialConversionRate: 1), singleAmountPerHour: 1, maxAmount: 6),
        MenuPosition(name: "Liquor", icon: "🥃", type: .alcoholDrink, measurement: Measurement(name: " bottles", meterMeasurement: " L", imperialMeasurement: " fl oz", meterConversionRate: 0.7, imperialConversionRate: 23.7), singleAmountPerHour: 9/70, maxAmount: 1),
        MenuPosition(name: "Water", icon: "💧", type: .basic, measurement: Measurement(name: " small bottles", meterMeasurement: " L", imperialMeasurement: " fl oz", meterConversionRate: 0.5, imperialConversionRate: 33.8), singleAmountPerHour: 0.6),
        MenuPosition(name: "Soda", icon: "🥤", type: .basic, measurement: Measurement(name: " big bottles", meterMeasurement: " L", imperialMeasurement: " fl oz", meterConversionRate: 1.5, imperialConversionRate: 50.72), singleAmountPerHour: 0.3),
        MenuPosition(name: "Juice", icon: "🧃", type: .basic, measurement: Measurement(name: " big packs", meterMeasurement: " L", imperialMeasurement: " fl oz", meterConversionRate: 1.5, imperialConversionRate: 33.8), singleAmountPerHour: 0.25)]
    
    mutating func resetData(overallData: Bool, menuPositions: Bool) {
        if overallData {
            drinkersCount = 0
            eatersCount = 0
            partyLength = 0
        }
        if menuPositions {
            for index in self.menuPositions.indices {
                self.menuPositions[index].isIncluded = false
            }
        }
    }
}
