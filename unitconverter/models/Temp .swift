//
//  Temp .swift
//  unitconverter
//
//  Created by Jonathan Chanuka Gurusinghe on 2021-03-17.
//

import Foundation

class Temp{
    var celcius: Double
    var fahrenheit: Double
    var kelvin: Double
    
    init(celcius: Double, fahrenheit: Double, kelvin: Double) {
        self.celcius = celcius
        self.fahrenheit = fahrenheit
        self.kelvin = kelvin
    }
    
    //converting celcius to fahrenheit, kelvin
    var _celcius: Double{
        get{
            return self.celcius
        }set(_celcius){
            self.celcius = _celcius
            self.fahrenheit = _celcius * 9/5 + 32
            self.kelvin = _celcius+273.15
        }
    }
    
    //converting fahrenheit to celcius, kelvin
    var _fahrenheit: Double{
        get{
            return self.fahrenheit
        }set(_fahrenheit){
            self.celcius = _fahrenheit - 32 * 5/9
            self.fahrenheit = _fahrenheit
            self.kelvin = _fahrenheit - 32 * 5/9 + 273.15
        }
    }
    
    //converting kelvin to celcius, fahrenheit
    var _kelvin: Double{
        get{
            return self.kelvin
        }set(_kelvin){
            self.celcius = _kelvin - 273.15
            self.fahrenheit = _kelvin - 273.15 * 9/5 + 32
            self.kelvin = _kelvin
        }
    }
    
    //setting data to an array
    var _tempHistory: [String] {
        return [("celcius: \(celcius) \tfahrenheit: \(fahrenheit) \tkelvin: \(kelvin)")]
    
    }
    
    
    
    
    
    
}
