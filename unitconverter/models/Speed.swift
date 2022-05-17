//
//  Speed.swift
//  unitconverter
//
//  Created by Jonathan Chanuka Gurusinghe on 2021-03-17.
//

import Foundation

class Speed{
    var msec: Double
    var kmh: Double
    var mlh: Double
    var nmlh: Double

    init(msec: Double, kmh: Double, mlh: Double, nmlh: Double) {
        self.msec = msec
        self.kmh = kmh
        self.mlh = mlh
        self.nmlh = nmlh
    }
    
    //converting msec to kmh, mlh, nmlh
    var _msec: Double{
        get{
            return self.msec
        }set(_msec){
            self.msec = _msec
            self.kmh = _msec/3.6
            self.mlh = _msec*2.237
            self.nmlh = _msec*1.944
        }
    }
    
    //converting kmh to msec, mlh, nmlh
    var _kmh: Double{
        get{
            return self.kmh
        }set(_kmh){
            self.msec = _kmh/3.6
            self.kmh = _kmh
            self.mlh = _kmh/1.609
            self.nmlh = _kmh/1.852
        }
    }
    
    //converting mlh to kmh, msec, nmlh
    var _mlh: Double{
        get{
            return self.mlh
        }set(_mlh){
            self.msec = _mlh/2.237
            self.kmh = _mlh
            self.mlh = _mlh*1.609
            self.nmlh = _mlh/1.151
        }
    }
    
    //converting nmlh to kmh, mlh, msec
    var _nmlh: Double{
        get{
            return self.nmlh
        }set(_nmlh){
            self.msec = _nmlh/1.944
            self.kmh = _nmlh*1.852
            self.mlh = _nmlh*1.151
            self.nmlh = _nmlh
        }
    }
    
    //setting data to an array
    var _speedHistory: [String] {
        return [("msec: \(msec) \tkmh: \(kmh) \tmlh: \(mlh) \tnmlh: \(nmlh) ")]
    
    }
    
    
    
    
}
