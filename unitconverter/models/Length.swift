//
//  Length.swift
//  unitconverter
//
//  Created by Jonathan Chanuka Gurusinghe on 2021-03-17.
//

import Foundation

class Length{
    var m: Double
    var km: Double
    var mile: Double
    var cm: Double
    var mm: Double
    var yard: Double
    var inch: Double
    
    init(m: Double, km: Double, mile: Double, cm: Double, mm: Double, yard: Double, inch: Double) {
        self.m = m
        self.km = km
        self.mile = mile
        self.cm = cm
        self.mm = mm
        self.yard = yard
        self.inch = inch
    }
    
    //converting m to km, mile, cm, mm, yard, inch
    var _m: Double{
        get{
            return self.m
        }set(_m){
            self.m = _m
            self.km = _m/1000
            self.mile = _m/1609
            self.cm = _m*100
            self.mm = _m*1000
            self.yard = _m*1.094
            self.inch = _m*39.37
        }
    }
    
    //converting km to mm, mile, cm, mm, yard, inch
    var _km: Double{
        get{
            return self.km
        }set(_km){
            self.m = _km*1000
            self.km = _km
            self.mile = _km/1.609
            self.cm = _km*100000
            self.mm = _km*1000000
            self.yard = _km*1094
            self.inch = _km*39370
        }
    }
    
    //converting mile to mm, km, cm, mm, yard, inch
    var _mile: Double{
        get{
            return self.mile
        }set(_mile){
            self.m = _mile*1609
            self.km = _mile*1.609
            self.mile = _mile
            self.cm = _mile*160934
            self.mm = _mile*1.609e+6
            self.yard = _mile*1760
            self.inch = _mile*63360
        }
    }
    
    //converting cm to mm, km, mile, mm, yard, inch
    var _cm: Double{
        get{
            return self.cm
        }set(_cm){
            self.m = _cm/100
            self.km = _cm/100000
            self.mile = _cm/160934
            self.cm = _cm
            self.mm = _cm*10
            self.yard = _cm/91.44
            self.inch = _cm/2.54
        }
    }
    
    //converting mm to cm, km, mile, m, yard, inch
    var _mm: Double{
        get{
            return self.mm
        }set(_mm){
            self.m = _mm/1000
            self.km = _mm/1e+6
            self.mile = _mm/1.609e+6
            self.cm = _mm/10
            self.mm = _mm
            self.yard = _mm/914
            self.inch = _mm/25.4
        }
    }
    
    //converting yard to cm, km, mile, m, mm, inch
    var _yard: Double{
        get{
            return self.yard
        }set(_yard){
            self.m = _yard/1.094
            self.km = _yard/1094
            self.mile = _yard/1760
            self.cm = _yard*91.44
            self.mm = _yard*914
            self.yard = _yard
            self.inch = _yard*36
        }
    }
    
    //converting inch to cm, km, mile, m, mm, yard
    var _inch: Double{
        get{
            return self.inch
        }set(_inch){
            self.m = _inch/39.37
            self.km = _inch/39370
            self.mile = _inch/63360
            self.cm = _inch*2.54
            self.mm = _inch*25.4
            self.yard = _inch/36
            self.inch = _inch
        }
    }
    
    //setting data to an array
    var _lengthHistory: [String] {
        return [("m: \(m) \tkm: \(km) \tmile: \(mile) \tcm: \(cm) \tmm: \(mm) \tyard: \(yard) \tinch: \(inch)")]
    
    }
    
    
    
    
    
    
    

}
