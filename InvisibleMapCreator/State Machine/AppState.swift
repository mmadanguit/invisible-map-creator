//
//  AppState.swift
//  test
//
//  Created by Marion Madanguit on 2/26/21.
//

import Foundation
import ARKit

enum AppState: StateType {
    case MainScreen
    case RecordMap(RecordMapState)
    case OptionsMenu
    
    static let initialState = AppState.MainScreen
    
    enum Event {
        case StartRecordingRequested
        case StopRecordingRequested
    }
    
    enum Command {
        case DisplayRecordingUI
        case DisplayMainScreen
        case AddTag(pose: simd_float4x4, tagId: Int)
    }
    
    mutating func handleEvent(event: Event) -> [Command] {
        switch (self, event) {
        case (.MainScreen, .StartRecordingRequested):
            self = .RecordMap(<#T##RecordMapState#>)
            return [.DisplayRecordingUI]
        case (.RecordMap, .StopRecordingRequested):
            self = .MainScreen
            return [.DisplayMainScreen]
        case (.RecordMap(let state), _) where RecordMapState.Event(event) != nil:
            var newState = state
            let commands = state.handleEvent(RecordMapState.Event(event)!)
            self = .RecordMap(newState)
            return commands

        default: break
        }
        return []
    }
}

enum RecordMapState: StateType {
    case ShowInstructions
    case RecordMap
    
    static let initialState = RecordMapState.RecordMap
        
    enum Event {
        case NewTagFound
    }
    
    typealias Command = AppState.Command
    
    mutating func handleEvent(event: Event) -> [Command] {
        switch (self, event) {
        case(.RecordMap, .NewTagFound):
            return [.AddTag(let pose, let tagId)]
            
        default: break
        }
        return []
    }
}
