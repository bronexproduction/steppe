//
//  ContentView.swift
//  STEPPE Watch App
//
//  Created by Artur on 16/11/2023.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var stepsProvider = StepsProvider()
    
    var body: some View {
        NavigationView {
            Text(stepsProvider.steps.stepsToString)
        }.onAppear {
            stepsProvider.reloadStepCount()
        }
    }
}

#Preview {
    ContentView()
}
