//
//  Feedback.swift
//  CupcakeCorner
//
//  Created by itsjagnezi on 20/10/22.
//

import Foundation
import CoreHaptics

class Feedback {
	
	init() {}
	
	func vibrate() {
		var supportsHaptics: Bool = false
		
		let hapticCapability = CHHapticEngine.capabilitiesForHardware()
		supportsHaptics = hapticCapability.supportsHaptics
		
		if supportsHaptics {
			var engine: CHHapticEngine!
			
			do {
				engine = try CHHapticEngine()
				
				engine.resetHandler = {
					print("Reset Handler: Restarting the engine.")
					
					do {
						try engine.start()
						
					} catch {
						fatalError("Failed to restart the engine: \(error)")
					}
				}
				
				engine.stoppedHandler = { reason in
					print("Stop Handler: The engine stopped for reason: \(reason.rawValue)")
					switch reason {
					case .audioSessionInterrupt: print("Audio session interrupt")
					case .applicationSuspended: print("Application suspended")
					case .idleTimeout: print("Idle timeout")
					case .systemError: print("System error")
					@unknown default:
						print("Unknown error")
					}
				}
				
				let hapticDict = [
					CHHapticPattern.Key.pattern: [
						[CHHapticPattern.Key.event: [
							CHHapticPattern.Key.eventType: CHHapticEvent.EventType.hapticTransient,
							CHHapticPattern.Key.time: 0.0,
							CHHapticPattern.Key.eventDuration: 1.0,
							CHHapticPattern.Key.eventParameters: [
								[
									CHHapticPattern.Key.parameterID: "HapticIntensity",
									CHHapticPattern.Key.parameterValue: 1
								]
							]
						]
						]
					]
				]
				
				let pattern = try CHHapticPattern(dictionary: hapticDict)
				
				let player = try engine.makePlayer(with: pattern)
				
				engine.notifyWhenPlayersFinished { error in
					return .stopEngine
				}
				
				try engine.start()
				try player.start(atTime: 0)
				
				
			} catch let error {
				fatalError("Engine Creation Error: \(error)")
			}
		}
		
	}
}
