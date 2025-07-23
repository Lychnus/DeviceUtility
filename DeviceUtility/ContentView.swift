//
//  ContentView.swift
//  DeviceUtility
//
//  Created by Tahir Anil Oghan on 23.07.2025.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        List {
            Section("Platform") {
                Label("Current: \(DevTools.device.currentPlatform.rawValue)", systemImage: "iphone")
            }
            
            Section("Flags") {
                LabeledContent("isIphone", value: DevTools.device.isIphone.description)
                LabeledContent("isIpad", value: DevTools.device.isIpad.description)
                LabeledContent("isMac", value: DevTools.device.isMac.description)
                LabeledContent("isMacCatalyst", value: DevTools.device.isMacCatalyst.description)
                LabeledContent("isTV", value: DevTools.device.isTV.description)
                LabeledContent("isWatch", value: DevTools.device.isWatch.description)
                LabeledContent("isVision", value: DevTools.device.isVision.description)
                LabeledContent("isSimulator", value: DevTools.device.isSimulator.description)
            }
        }
        .navigationTitle("Device Checker")
    }
}

#Preview {
    NavigationStack {
        ContentView()
    }
}
