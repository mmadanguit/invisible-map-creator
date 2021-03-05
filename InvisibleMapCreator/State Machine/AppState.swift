//
//  AppState.swift
//  InvisibleMapCreator
//
//  Created by Marion Madanguit on 3/5/21.
//

import Foundation
import ARKit

enum AppState: StateType {
    // Higher level app states
    case MainScreen
    case RecordMap(RecordMapState)
    case OptionsMenu(OptionsMenuState)
    
    // Initial state upon opening the app
    static let initialState = AppState.MainScreen
    
    // All the effectual inputs from the app which the state can react to
    enum Event {
        // MainScreen events
        case StartRecordingRequested
        case StopRecordingRequested(mapName: String)
        case OptionsMenuRequested
        case MainScreenRequested
        // RecordMap events
        case NewTagFound(pose: simd_float4x4, tagId: Int)
        case AddWaypointRequested(pose: simd_float4x4, poseId: Int, waypointName: String)
        case ViewWaypointsRequested
        // OptionsMenu events
        case PrintTagsRequested
        case ManageMapsRequested
        case SettingsRequested
        case VideoWalkthroughRequested
        case GiveFeedbackRequested
    }
    
    // All the effectful outputs which the state desires to have performed on the app
    enum Command {
        // MainScreen commands
        case DisplayRecordingUI
        case DisplayOptionsMenu
        // RecordMap commands
        case AddTag(pose: simd_float4x4, tagId: Int)
        case AddWaypoint(pose: simd_float4x4, poseId: Int, waypointName: String)
        case DisplayWaypointsUI
        case SaveMap(mapName: String)
        // OptionsMenu commands
        case DisplayTagsPDF
        case DisplayManageMapsUI
        case DisplaySettingsUI
        case DisplayVideoWalkthrough
        case DisplayGiveFeedbackUI
        // RecordMap and OptionsMenu commands
        case DisplayMainScreen
    }
    
    // In response to an event, a state may transition to a new state, and it may emit a command
    mutating func handleEvent(event: Event) -> [Command] {
        switch (self, event) {
        case (.MainScreen, .StartRecordingRequested):
            self = .RecordMap(.RecordMap)
            return [.DisplayRecordingUI]
        case (.MainScreen, .OptionsMenuRequested):
            self = .OptionsMenu(.OptionsMenu)
            return [.DisplayOptionsMenu]
        case (.RecordMap, .StopRecordingRequested(let mapName)):
            self = .MainScreen
            return [.DisplayMainScreen, .SaveMap(mapName: mapName)]
        case (.RecordMap(let state), _) where RecordMapState.Event(event) != nil:
            var newState = state
            let commands = newState.handleEvent(event: RecordMapState.Event(event)!)
            self = .RecordMap(newState)
            return commands
        case(.OptionsMenu, .MainScreenRequested):
            self = .MainScreen
            return [.DisplayMainScreen]
        case (.OptionsMenu(let state), _) where OptionsMenuState.Event(event) != nil:
            var newState = state
            let commands = newState.handleEvent(event: OptionsMenuState.Event(event)!)
            self = .OptionsMenu(newState)
            return commands
            
        default: break
        }
        return []
    }
}

enum RecordMapState: StateType {
    // Lower level app states nested within RecordMapState
    case RecordMap
    case ViewWaypoints
        
    // Initial state upon transitioning into the RecordMapState
    static let initialState = RecordMapState.RecordMap
    
    // All the effectual inputs from the app which RecordMapState can react to
    enum Event {
        case NewTagFound(pose: simd_float4x4, tagId: Int)
        case AddWaypointRequested(pose: simd_float4x4, poseId: Int, waypointName: String)
        case ViewWaypointsRequested
    }
    
    // Refers to commands defined in AppState
    typealias Command = AppState.Command
    
    // In response to an event, RecordMapState may emit a command
    mutating func handleEvent(event: Event) -> [Command] {
        switch (self, event) {
        case(.RecordMap, .NewTagFound(let pose, let tagId)):
            return [.AddTag(pose: pose, tagId: tagId)]
        case(.RecordMap, .AddWaypointRequested(let pose, let poseId, let waypointName)):
            return [.AddWaypoint(pose: pose, poseId: poseId, waypointName: waypointName)]
        case(.RecordMap, .ViewWaypointsRequested):
            self = .ViewWaypoints
            return [.DisplayWaypointsUI]
            
        default: break
        }
        return []
    }
}

extension RecordMapState.Event {
    init?(_ event: AppState.Event) {
        switch event {
        case .NewTagFound(let pose, let tagId):
            self = .NewTagFound(pose: pose, tagId: tagId)
        case .AddWaypointRequested(let pose, let poseId, let waypointName):
            self = .AddWaypointRequested(pose: pose, poseId: poseId, waypointName: waypointName)
        case .ViewWaypointsRequested:
            self = .ViewWaypointsRequested
            
        default: return nil
        }
    }
}

enum OptionsMenuState: StateType {
    // Lower level app states nested within RecordMapState
    case OptionsMenu
    case PrintTags
    case ManageMaps
    case Settings
    case VideoWalkthrough
    case GiveFeedback
        
    // Initial state upon transitioning into the OptionsMenuState
    static let initialState = OptionsMenuState.OptionsMenu
    
    // All the effectual inputs from the app which RecordMapState can react to
    enum Event {
        case OptionsMenuRequested
        case PrintTagsRequested
        case ManageMapsRequested
        case SettingsRequested
        case VideoWalkthroughRequested
        case GiveFeedbackRequested
    }
    
    // Refers to commands defined in AppState
    typealias Command = AppState.Command
    
    // In response to an event, RecordMapState may emit a command
    mutating func handleEvent(event: Event) -> [Command] {
        switch (self, event) {
        case(.OptionsMenu, .PrintTagsRequested):
            self = .PrintTags
            return [.DisplayTagsPDF]
        case(.OptionsMenu, .ManageMapsRequested):
            self = .ManageMaps
            return [.DisplayManageMapsUI]
        case(.OptionsMenu, .SettingsRequested):
            self = .Settings
            return [.DisplaySettingsUI]
        case(.OptionsMenu, .VideoWalkthroughRequested):
            self = .VideoWalkthrough
            return [.DisplayVideoWalkthrough]
        case(.OptionsMenu, .GiveFeedbackRequested):
            self = .GiveFeedback
            return [.DisplayGiveFeedbackUI]
        case(_, .OptionsMenuRequested):
            self = .OptionsMenu
            return [.DisplayOptionsMenu]
            
        default: break
        }
        return []
    }
}

extension OptionsMenuState.Event {
    init?(_ event: AppState.Event) {
        switch event {
        case .OptionsMenuRequested:
            self = .OptionsMenuRequested
        case .PrintTagsRequested:
            self = .PrintTagsRequested
        case .ManageMapsRequested:
            self = .ManageMapsRequested
        case .SettingsRequested:
            self = .SettingsRequested
        case .VideoWalkthroughRequested:
            self = .VideoWalkthroughRequested
        case .GiveFeedbackRequested:
            self = .GiveFeedbackRequested
            
        default: return nil
        }
    }
}
