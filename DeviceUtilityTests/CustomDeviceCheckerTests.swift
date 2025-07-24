//
//  CustomDeviceCheckerTests.swift
//  DeviceUtilityTests
//
//  Created by Tahir Anil Oghan on 23.07.2025.
//

import Foundation
import Testing
@testable import DeviceUtility

@Suite("CustomDeviceChecker Tests")
struct CustomDeviceCheckerTests {
    
    // MARK: - DeviceCheckerDevicePlatform Tests

    @Test("DevicePlatform rawValue returns correct string.")
    func testDevicePlatformRawValue() {
        #expect(DeviceCheckerDevicePlatform.iPhone.rawValue == "iPhone")
        #expect(DeviceCheckerDevicePlatform.iPad.rawValue == "iPad")
        #expect(DeviceCheckerDevicePlatform.macCatalyst.rawValue == "macCatalyst")
        #expect(DeviceCheckerDevicePlatform.mac.rawValue == "mac")
        #expect(DeviceCheckerDevicePlatform.tv.rawValue == "tv")
        #expect(DeviceCheckerDevicePlatform.watch.rawValue == "watch")
        #expect(DeviceCheckerDevicePlatform.vision.rawValue == "vision")
        #expect(DeviceCheckerDevicePlatform.unknown.rawValue == "unknown")
    }

    // MARK: - CustomDeviceChecker Tests

    @Test("Mock returns correct platform flags for iPhone.")
    func testMockIphone() {
        let mock = CustomDeviceChecker.mock(platform: .iPhone)

        #expect(mock.currentPlatform == .iPhone)
        #expect(mock.isIphone)
        #expect(mock.isIpad == false)
        #expect(mock.isMac == false)
        #expect(mock.isMacCatalyst == false)
        #expect(mock.isTV == false)
        #expect(mock.isWatch == false)
        #expect(mock.isVision == false)
    }

    @Test("Mock returns correct platform flags for iPad.")
    func testMockIpad() {
        let mock = CustomDeviceChecker.mock(platform: .iPad)

        #expect(mock.currentPlatform == .iPad)
        #expect(mock.isIpad)
        #expect(mock.isIphone == false)
    }

    @Test("Mock returns correct platform flags for mac.")
    func testMockMac() {
        let mock = CustomDeviceChecker.mock(platform: .mac)

        #expect(mock.currentPlatform == .mac)
        #expect(mock.isMac)
        #expect(mock.isMacCatalyst == false)
    }

    @Test("Mock returns correct platform flags for Mac Catalyst.")
    func testMockMacCatalyst() {
        let mock = CustomDeviceChecker.mock(platform: .macCatalyst)

        #expect(mock.currentPlatform == .macCatalyst)
        #expect(mock.isMacCatalyst)
        #expect(mock.isMac == false)
    }

    @Test("Mock returns correct platform flags for tvOS.")
    func testMockTvOS() {
        let mock = CustomDeviceChecker.mock(platform: .tv)

        #expect(mock.currentPlatform == .tv)
        #expect(mock.isTV)
    }

    @Test("Mock returns correct platform flags for watchOS.")
    func testMockWatchOS() {
        let mock = CustomDeviceChecker.mock(platform: .watch)

        #expect(mock.currentPlatform == .watch)
        #expect(mock.isWatch)
    }

    @Test("Mock returns correct platform flags for visionOS.")
    func testMockVisionOS() {
        let mock = CustomDeviceChecker.mock(platform: .vision)

        #expect(mock.currentPlatform == .vision)
        #expect(mock.isVision)
    }

    @Test("Mock returns correct platform flags for unknown.")
    func testMockUnknown() {
        let mock = CustomDeviceChecker.mock(platform: .unknown)

        #expect(mock.currentPlatform == .unknown)
        #expect(mock.isIphone == false)
        #expect(mock.isIpad == false)
        #expect(mock.isMac == false)
        #expect(mock.isMacCatalyst == false)
        #expect(mock.isTV == false)
        #expect(mock.isWatch == false)
        #expect(mock.isVision == false)
    }

    // MARK: - Simulator Detection

    @Test("Simulator detection returns correctly for build target.")
    func testSimulatorDetection() {
        let deviceChecker = CustomDeviceChecker.mock(platform: .iPhone)

        #if targetEnvironment(simulator)
        #expect(deviceChecker.isSimulator == true)
        #else
        #expect(deviceChecker.isSimulator == false)
        #endif
    }
    
    // MARK: - Shared Instance Check

    @Test("Shared instance returns a valid and consistent platform.")
    func testSharedInstance() {
        let shared = CustomDeviceChecker.shared

        // Ensure the reported platform is not unknown.
        #expect(shared.currentPlatform != .unknown)

        // At least one of the platform flags must be true.
        let platformFlags = [
            shared.isIphone,
            shared.isIpad,
            shared.isMac,
            shared.isMacCatalyst,
            shared.isTV,
            shared.isWatch,
            shared.isVision
        ]
        
        #expect(platformFlags.contains(true))
    }
}
