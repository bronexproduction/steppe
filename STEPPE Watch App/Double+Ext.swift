//
//  Double+Ext.swift
//  STEPPE Watch App
//
//  Created by Artur on 16/11/2023.
//

extension Optional<Double> {
    
    var stepsToString: String {
        guard let self = self else {
            return "Loading..."
        }
        return self.isNaN ? "¯\\_(ツ)_/¯" : String(self)
    }
}
