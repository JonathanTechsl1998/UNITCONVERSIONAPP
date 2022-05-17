//
//  Weight.swift
//  unitconverter
//
//  Created by Jonathan Chanuka Gurusinghe on 2021-03-17.
//

import Foundation

class Weight{
    var kg: Double
    var grams: Double
    var ounces: Double
    var pounds: Double
    var stone: Double
    var weightHistory: [String]
    var dataHistory: [String] = [String]()
    var data: Double = 0.0
    
    init(kg: Double, grams: Double, ounces: Double, pounds: Double, stone: Double) {
        self.kg = kg
        self.grams = grams
        self.ounces = ounces
        self.pounds = pounds
        self.stone = stone
        self.weightHistory = [String]()
    }
    
    
    //converting kg to grams, ounces, pounds, stone
    var _kg: Double{
        get{
            return self.kg
        }set(_kg){
            self.kg = _kg
            self.grams = _kg*1000
            self.ounces = _kg*35.274
            self.pounds = _kg*2.20462
            self.stone = _kg*0.157473
        }
    }
    
    //converting grams to kg, ounces, pound, stone
    var _grams: Double{
        get{
            return self.grams
        }set(_grams){
            self.kg = _grams/1000
            self.grams = _grams
            self.ounces = _grams*0.035274
            self.pounds = _grams*0.00220462
            self.stone = _grams*0.000157473
        }
    }
    
    //converting ounces to kg, grams, pounds, stone
    var _ounces: Double{
        get{
            return self.ounces
        }set(_ounces){
            self.kg = _ounces*0.0283495
            self.grams = _ounces*28.3495
            self.ounces = _ounces
            self.pounds = _ounces*0.0625
            self.stone = _ounces*0.00446429
        }
    }
    
    //converting pounds to kg, gram, ounces, stone
    var _pounds: Double{
        get{
            return self.pounds
        }set(_pounds){
            self.kg = _pounds*0.453592
            self.grams = _pounds*453.592
            self.ounces = _pounds*16
            self.pounds = _pounds
            self.stone = _pounds*0.0714286
        }
    }
    
    //converting stone to kg, gram, ounces, pounds
    var _stone: Double{
        get{
            return self.pounds
        }set(_stone){
            self.kg = _stone*6.35029
            self.grams = _stone*6350.29
            self.ounces = _stone*224
            self.pounds = _stone*14
            self.stone = _stone
        }
    }
    
    //accessing userdef key
    func loadData(_ key:String){
        let arrWeight = UserDefaults.standard
        dataHistory = arrWeight.object(forKey: key) as? [String] ?? [String]()
        
    }
    
    
    //setting data to an array
    var _weightHistory: [String] {
        print(dataHistory)
        return [("kg: \(kg) \tgram: \(grams) \tounces: \(ounces) \tpounds: \(pounds) \tstone \(stone))")]
    }
    
    
    
    

    
    
    
    
    
}



