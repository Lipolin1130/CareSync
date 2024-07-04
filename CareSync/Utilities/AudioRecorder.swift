//
//  AudioRecorder.swift
//  CareSync
//
//  Created by Mac on 2024/7/2.
//

import Foundation
import SwiftUI
import Combine
import AVFoundation

class AudioRecorder: NSObject, ObservableObject, AVAudioPlayerDelegate {
    let objectWillChange = PassthroughSubject<AudioRecorder, Never>()
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    
    @Published var recording = false {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    @Published var isPlaying = false {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    var audioFileURL: URL?
    
    func startRecording() {
        let recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            print("Failed to set up recording session")
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        
        let docPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let audioFileName = docPath.appendingPathComponent("\(dateFormatter.string(from: Date()))_Record.m4a")
        audioFileURL = audioFileName
        
        let settings: [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFileName, settings: settings)
            audioRecorder.record()
            
            recording = true
        } catch {
            print("Couldn't start recording")
        }
    }
    
    func stopRecording() {
        audioRecorder.stop()
        recording = false
    }
    
    func deleteRecording() {
        guard let url = audioFileURL else { return }
        
        do {
            try FileManager.default.removeItem(at: url)
            audioFileURL = nil
        } catch {
            print("Failed to delte recording")
        }
    }
    
    func startPlaying() {
        guard let url = audioFileURL else { return }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.delegate = self
            audioPlayer.play()
            isPlaying = true
        } catch {
            print("Couldn't start playing")
        }
    }
    
    func stopPlaying() {
        audioPlayer.stop()
        isPlaying = false
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        isPlaying = false
    }
    
    func playTestFile() {
        guard let assets = NSDataAsset(name: "testFile") else {
            print("Test audio file not found.")
            return
        }
        
        let temporaryDirectory = FileManager.default.temporaryDirectory
        let temporaryFileURL = temporaryDirectory.appendingPathComponent("testFile.m4a")
        
        do {
            try assets.data.write(to: temporaryFileURL)
            audioPlayer = try AVAudioPlayer(contentsOf: temporaryFileURL)
            audioPlayer.delegate = self
            audioPlayer.play()
            isPlaying = true
        } catch {
            print("Couldn't play test file")
        }
    }
    
    func getTestFileURL() -> URL? {
        guard let asset = NSDataAsset(name: "testFile") else {
            print("Test audio file not found.")
            return nil
        }
        
        let temporaryDirectory = FileManager.default.temporaryDirectory
        let temporaryFileURL = temporaryDirectory.appendingPathComponent("testFile.m4a")
        
        do {
            try asset.data.write(to: temporaryFileURL)
            return temporaryFileURL
        } catch {
            print("Couldn't create test file URL")
            return nil
        }
    }
}
