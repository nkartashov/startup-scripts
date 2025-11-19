#!/usr/bin/env swift

//  1. Compile:
//     swiftc toggle_japanese_input.swift -o toggle_japanese_input
//
//  2. Run:
//     ./toggle_japanese_input

import Carbon
import Foundation

let japaneseBundleIDToAdd = "com.apple.inputmethod.Kotoeri.RomajiTyping"
let japaneseBundleIDToSelect = "com.apple.inputmethod.Kotoeri.RomajiTyping.Japanese"

// --- Helpers ---

func getProperty<T>(_ source: TISInputSource, _ key: CFString) -> T? {
    guard let ptr = TISGetInputSourceProperty(source, key) else { return nil }
    return Unmanaged<AnyObject>.fromOpaque(ptr).takeUnretainedValue() as? T
}

func getSourceID(source: TISInputSource) -> String? {
    return getProperty(source, kTISPropertyInputSourceID)
}

func isSourceEnabled(source: TISInputSource) -> Bool {
    return getProperty(source, kTISPropertyInputSourceIsEnabled) ?? false
}

func isSourceSelectable(source: TISInputSource) -> Bool {
    return getProperty(source, kTISPropertyInputSourceIsSelectCapable) ?? false
}

func getLocalizedName(source: TISInputSource) -> String {
    return getProperty(source, kTISPropertyLocalizedName) ?? "Unknown"
}

func printActiveSources() {
    print("\n--- DEBUG: Current Active/Selectable Inputs ---")
    guard let sourceList = TISCreateInputSourceList(nil, false).takeRetainedValue() as? [TISInputSource] else { return }
    
    for source in sourceList {
        let id = getSourceID(source: source) ?? "nil"
        let name = getLocalizedName(source: source)
        let selectable = isSourceSelectable(source: source)
        if selectable {
            print(" [SELECTABLE] \(name) (\(id))")
        } else {
            print(" [  LOCKED  ] \(name) (\(id))")
        }
    }
    print("-----------------------------------------------\n")
}

func toggleJapanese() {
    // 1. Get all installed sources (Active + Inactive)
    guard let installedList = TISCreateInputSourceList(nil, true).takeRetainedValue() as? [TISInputSource] else {
        print("Error: Unable to access installed sources.")
        exit(1)
    }

    // 2. Find Japanese Source in the installed list
    guard let japaneseSource = installedList.first(where: { getSourceID(source: $0) == japaneseBundleIDToAdd }) else {
        print("Error: Japanese input method (Kotoeri) not found on system.")
        exit(1)
    }

    if isSourceEnabled(source: japaneseSource) {
        // --- DISABLE ---
        print("Status: Japanese is ENABLED. Disabling...")
        let status = TISDisableInputSource(japaneseSource)
        if status == noErr {
            print("Success: Japanese input disabled.")
        } else {
            print("Error: Failed to disable. OSStatus: \(status)")
        }
    } else {
        // --- ENABLE ---
        print("Status: Japanese is DISABLED. Enabling...")
        let enableStatus = TISEnableInputSource(japaneseSource)
        
        if enableStatus != noErr {
            print("Error: Failed to enable. OSStatus: \(enableStatus)")
            exit(1)
        }
        
        print("Success: Japanese input added.")
        
        Thread.sleep(forTimeInterval: 0.1)

        printActiveSources()
        
        guard let activeList = TISCreateInputSourceList(nil, false).takeRetainedValue() as? [TISInputSource],
              let activeJapaneseSource = activeList.first(where: { getSourceID(source: $0) == japaneseBundleIDToSelect }) else {
            print("Error: Enabled the source, but it did not appear in the Active list yet.")
            exit(1)
        }

        print("Attempting to select: \(getLocalizedName(source: activeJapaneseSource))...")
        
        if isSourceSelectable(source: activeJapaneseSource) {
            let selectStatus = TISSelectInputSource(activeJapaneseSource)
            if selectStatus == noErr {
                print("Success: Switched to Japanese input.")
            } else {
                print("Error: Failed to select. OSStatus: \(selectStatus)")
            }
        } else {
            print("Error: Input source is enabled but marked as 'Not Selectable'.")
        }
    }
}

toggleJapanese()