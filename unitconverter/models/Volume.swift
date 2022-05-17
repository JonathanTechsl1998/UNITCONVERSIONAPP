//
//  Volume.swift
//  unitconverter
//
//  Created by Jonathan Chanuka Gurusinghe on 2021-03-17.
//

import Foundation

class Volume{
    var gallon: Double
    var litre: Double
    var pint: Double
    var ounce: Double
    var ml: Double
    
    init(gallon: Double, litre: Double, pint: Double, ounce: Double, ml: Double) {
        self.gallon = gallon
        self.litre = litre
        self.pint = pint
        self.ounce = ounce
        self.ml = ml
    }
    
    //converting gallon to litre, pint, ounce, ml
    var _gallon: Double{
        get{
            return self.gallon
        }set(_gallon){
            self.gallon = _gallon
            self.litre = _gallon*3.785
            self.pint = _gallon*8
            self.ounce = _gallon*128
            self.ml = _gallon*3785
        }
    }
    
    //converting litre to gallon, pint, ounce, ml
    var _litre: Double{
        get{
            return self.litre
        }set(_litre){
            self.gallon = _litre/3.785
            self.litre = _litre
            self.pint = _litre*2.113
            self.ounce = _litre*33.814
            self.ml = _litre*1000
        }
    }
    
    //converting pint to gallon, litre, ounce, ml
    var _pint: Double{
        get{
            return self.pint
        }set(_pint){
            self.gallon = _pint/8
            self.litre = _pint/2.113
            self.pint = _pint
            self.ounce = _pint*16
            self.ml = _pint*473
        }
    }
    
    //converting ounce to gallon, litre, pint, ml
    var _ounce: Double{
        get{
            return self.ounce
        }set(_ounce){
            self.gallon = _ounce/128
            self.litre = _ounce/33.814
            self.pint = _ounce/16
            self.ounce = _ounce
            self.ml = _ounce*29.574
        }
    }
    
    //converting ml to gallon, litre, pint, ounce
    var _ml: Double{
        get{
            return self.ml
        }set(_ml){
            self.gallon = _ml/3785
            self.litre = _ml/1000
            self.pint = _ml/473
            self.ounce = _ml/29.574
            self.ml = _ml
        }
    }
    
    //setting data to an array
    var _volumeHistory: [String] {
        return [("gallon: \(gallon) \tlitre: \(litre) \tpint: \(pint) \tounce: \(ounce) \tml: \(ml)")]
    
    }
    
    
    
    
    
    
    
    
    
    
    
}
