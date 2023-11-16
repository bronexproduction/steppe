//
//  StepsProvider.swift
//  STEPPE Watch App
//
//  Created by Artur on 16/11/2023.
//

import HealthKit

class StepsProvider: ObservableObject {
    
    private let healthStore = HKHealthStore()
    
    @Published var steps: Double? = nil {
        didSet {
            print(steps)
        }
    }
}

extension StepsProvider {
    
    func reloadStepsCount() {
        healthStore.requestAuthorization(toShare: nil, read: [.quantityType(forIdentifier: .stepCount)!]) { [weak self] success, error in
            guard success, error == nil else {
                self?.steps = .nan
                return
            }
            
            self?.requestStepCount()
        }
    }
    
    private func requestStepCount() {
        let quantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        let predicate = {
            let now = Date()
            let startOfDay = Calendar.current.startOfDay(for: now)
            return HKQuery.predicateForSamples(
                withStart: startOfDay,
                end: now,
                options: .strictStartDate
            )
        }()
        
        let query = HKStatisticsQuery(
            quantityType: quantityType,
            quantitySamplePredicate: predicate,
            options: .cumulativeSum
        ) { [weak self] _, result, error in
            guard error == nil, let sum = result?.sumQuantity() else {
                self?.steps = .nan
                return
            }
            self?.steps = sum.doubleValue(for: HKUnit.count())
        }
        
        healthStore.execute(query)
    }
}
