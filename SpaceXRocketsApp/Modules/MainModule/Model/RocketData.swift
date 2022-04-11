//
//  RocketData.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 08.04.2022.
//

struct RocketData {
    let firstStage: FirstStage
    let secondStage: SecondStage
    let firstFlight: String
    let country: String
    let company: String
    let flickrImages: [String]
    
    struct FirstStage {
        let engines: Int
        let fuelAmountTons: Double
        let burnTimeSEC: Int?
    }
    
    struct SecondStage {
        let engines: Int
        let fuelAmountTons: Double
        let burnTimeSEC: Int?
    }
    
//    let firstStage: FirstStage
//    let secondStage: SecondStage
//    let firstFlight: FirstFlight
//    let country: Country
//    let company: Company
//    let flickrImages: [String]
//
//    struct FirstStage {
//        let engines: Engines
//        let fuelAmountTons: FuelAmountTons
//        let burnTimeSEC: BurnTimeSEC
//    }
//
//    struct SecondStage {
//        let engines: Engines
//        let fuelAmountTons: FuelAmountTons
//        let burnTimeSEC: BurnTimeSEC
//    }
//
//    struct Engines {
//        let key: String = "Количество двигателей"
//        let value: Int
//    }
//
//    struct FuelAmountTons {
//        let key: String = "Количество топлива"
//        let value: Double
//    }
//
//    struct BurnTimeSEC {
//        let key: String = "Время сгорания"
//        let value: Int?
//    }
//
//    struct FirstFlight {
//        let key: String = "Первый полет"
//        let value: String
//    }
//
//    struct Country {
//        let key: String = "Страна"
//        let value: String
//    }
//
//    struct Company {
//        let key: String = "Компания"
//        let value: String
//    }
}
//class FakeRocketInfoData: UIViewController {
//
//    override func viewDidLoad() {
//        let rocketData = RocketInfoData(rocket: Rocket(height: Diameter(meters: 1, feet: 1), diameter: Diameter(meters: 1, feet: 1), mass: Mass(kg: 1, lb: 1), firstStage: FirstStage(thrustSeaLevel: Thrust(kN: 1, lbf: 1), thrustVacuum: Thrust(kN: 1, lbf: 1), reusable: true, engines: 1, fuelAmountTons: 1, burnTimeSEC: 1), secondStage: SecondStage(thrust: Thrust(kN: 1, lbf: 1), payloads: Payloads(compositeFairing: CompositeFairing(height: Diameter(meters: 1, feet: 1), diameter: Diameter(meters: 1, feet: 1)), option1: ""), reusable: true, engines: 1, fuelAmountTons: 1, burnTimeSEC: 1), engines: Engines(isp: ISP(seaLevel: 1, vacuum: 1), thrustSeaLevel: Thrust(kN: 1, lbf: 1), thrustVacuum: Thrust(kN: 1, lbf: 1), number: 1, type: "", version: "", layout: "", engineLossMax: 1, propellant1: "", propellant2: "", thrustToWeight: 1), landingLegs: LandingLegs(number: 1, material: ""), payloadWeights: [PayloadWeight(id: "", name: "", kg: 1, lb: 1)], flickrImages: [""], name: "", type: "", active: true, stages: 1, boosters: 1, costPerLaunch: 1, successRatePct: 1, firstFlight: "", country: "", company: "", wikipedia: "", rocketModelDescription: "", id: ""))
//    }
//}
