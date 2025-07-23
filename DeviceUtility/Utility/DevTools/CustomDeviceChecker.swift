//
//  CustomDeviceChecker.swift
//  DeviceUtility
//
//  Created by Tahir Anil Oghan on 23.07.2025.
//

import Foundation
import UIKit

// MARK: - Protocol
/// A protocol that defines a development-only device checker.
public protocol DeviceChecker {
    
    /// The current platform of the running device.
    var currentPlatform: DevicePlatform { get }
    
    /// Returns true if the device is an iPhone.
    var isIphone: Bool { get }
    
    /// Returns true if the device is an iPad.
    var isIpad: Bool { get }
    
    /// Returns true if the app is running on macOS (non-Catalyst).
    var isMac: Bool { get }
    
    /// Returns true if the app is running via Mac Catalyst.
    var isMacCatalyst: Bool { get }
    
    /// Returns true if the app is running on tvOS.
    var isTV: Bool { get }
    
    /// Returns true if the app is running on watchOS.
    var isWatch: Bool { get }
    
    /// Returns true if the app is running on visionOS.
    var isVision: Bool { get }
    
    /// Returns true if the app is running on the simulator.
    var isSimulator: Bool { get }
}

// MARK: - Helpers
/// This enum describes the platform of the current device.
public enum DevicePlatform: String {
    case iPhone
    case iPad
    case macCatalyst
    case mac
    case tv
    case watch
    case vision
    case unknown
}

// MARK: - Implementation
/// This class determines the device platform at runtime.
internal final class CustomDeviceChecker {
    
    /// Singleton instance.
    internal static let shared: CustomDeviceChecker = CustomDeviceChecker()
    
    /// Cached platform type for performance.
    private let platform: DevicePlatform
    
    /// Secured initializer to enforce `.shared` usage.
    private init() {
        #if targetEnvironment(macCatalyst)
        self.platform = .macCatalyst
        
        #elseif os(iOS)
        switch UIDevice.current.userInterfaceIdiom {
            case .phone:
                self.platform = .iPhone
            case .pad:
                self.platform = .iPad
            default:
                self.platform = .unknown
        }
        
        #elseif os(macOS)
        self.platform = .mac
        
        #elseif os(tvOS)
        self.platform = .tv
        
        #elseif os(watchOS)
        self.platform = .watch
        
        #elseif os(visionOS)
        self.platform = .vision
        
        #else
        self.platform = .unknown
        #endif
    }
    
    /// Convenience initializer to mock the instance.
    ///
    /// - Parameters:
    ///   - platform: The platform to simulate.
    private init(platform: DevicePlatform) {
        self.platform = platform
    }
}

// MARK: - Protocol Conformance
extension CustomDeviceChecker: DeviceChecker {
    
    internal var currentPlatform: DevicePlatform {
        platform
    }
    
    internal var isIphone: Bool {
        platform == .iPhone
    }
    
    internal var isIpad: Bool {
        platform == .iPad
    }
    
    internal var isMac: Bool {
        platform == .mac
    }
    
    internal var isMacCatalyst: Bool {
        platform == .macCatalyst
    }
    
    internal var isTV: Bool {
        platform == .tv
    }
    
    internal var isWatch: Bool {
        platform == .watch
    }
    
    internal var isVision: Bool {
        platform == .vision
    }
    
    internal var isSimulator: Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }
}

// MARK: - Factory Initializer
#if DEBUG
extension CustomDeviceChecker {
    
    /// Returns a new, isolated instance of `CustomDeviceChecker` for testing purposes.
    ///
    /// - Parameters:
    ///   - platform: The mocked platform to simulate.
    /// - Returns: A fresh `CustomDeviceChecker` instance, separate from the shared singleton.
    ///
    /// Use this method in unit tests.
    internal static func mock(platform: DevicePlatform) -> CustomDeviceChecker {
        CustomDeviceChecker(platform: platform)
    }
}
#endif
