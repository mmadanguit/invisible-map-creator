//
//  AppController.swift
//  test
//
//  Created by Marion Madanguit on 2/26/21.
//

import Foundation
import ARKit
import Accelerate

class AppController {
    public static var shared = AppController()
    private var state = AppState.initialState
    var contentViewController: ContentViewController?
    var mapRecorder: MapRecorder?
    
    private init() {
        
    }
    
    func startRecordingRequested() {
        processCommands(commands: state.handleEvent(event: .StartRecordingRequested))
    }
    
    private func processCommands(commands: [AppState.Command]) {
        for command in commands {
            switch command {
            case .DisplayRecordingUI:
                contentViewController?.displayRecordingUI()
            case .DisplayMainScreen:
                contentViewController?.displayMainScreen()
            case .AddTag(let pose, let tagId):
                mapRecorder?.addTag(pose: pose, tagId: tagId)
            }
        }
    }
}

protocol ContentViewController {
    func displayRecordingUI()
    func displayMainScreen()
}

protocol MapRecorder {
    func addWaypoint(pose: simd_float4x4, poseId: Int)
    func addTag(pose: simd_float4x4, tagId: Int)
}
