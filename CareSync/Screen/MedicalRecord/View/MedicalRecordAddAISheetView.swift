//
//  MedicalRecordAddAISheetView.swift
//  CareSync
//
//  Created by Mac on 2024/7/2.
//

import SwiftUI

struct MedicalRecordAddAISheetView: View {
    @ObservedObject var medicalRecordViewModel: MedicalRecordViewModel
    @ObservedObject var audioRecorder: AudioRecorder
    @State var backendService: BackendService = BackendService()
    @Binding var medicalAISheet: Bool
    
    @State var opacityRecord: CGFloat = 1.0
    @State var opacityStop: CGFloat = 0.0
    @State var opacityWave1: CGFloat = 0.0
    @State var opacityWave2: CGFloat = 0.0
    @State var timerWave: Timer?
    @State var circleSize: CGFloat = 0.0
    @State var seconds: Int = 0
    @State var minutes: Int = 0
    @State var timeString = "00:00"
    @State var timerRecord: Timer?
    
    var body: some View {
        
        ZStack {
            VStack {
                HStack {
                    Button {
                        medicalAISheet.toggle()
                        audioRecorder.deleteRecording()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title)
                            .foregroundStyle(.gray)
                    }
                    .padding(.bottom, 60)
                    
                    Spacer()
                }
                .padding()
                
                Spacer()
                
                //MARK: - Record Button
                
                if audioRecorder.audioFileURL != nil {
                    VStack {
                        Button {
                            //TODO: send audio to server
                            
                            // END OF:
                            // audioRecorder.deleteRecording()
                        } label: {
                            Label("Summarize", systemImage: "sparkles")
                                .fontWeight(.bold)
                                .padding(15)
                                .foregroundStyle(.white)
                                .background(LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
                                .cornerRadius(10)
                        }
                        .padding(.bottom, 30)
                        
                        HStack(spacing: 25) {
                            if audioRecorder.isPlaying {
                                Button {
                                    audioRecorder.stopPlaying()
                                } label: {
                                    ZStack {
                                        Circle()
                                            .fill(.red)
                                            .frame(width: 50, height: 50)
                                        
                                        Image(systemName: "pause.fill")
                                            .foregroundStyle(.white)
                                            .font(.system(size: 20))
                                    }
                                }
                            } else {
                                Button {
                                    audioRecorder.startPlaying()
                                } label: {
                                    ZStack {
                                        Circle()
                                            .fill(.green)
                                            .frame(width: 50, height: 50)
                                        
                                        Image(systemName: "play.fill")
                                            .foregroundStyle(.white)
                                            .font(.system(size: 20))
                                    }
                                }
                            }
                            
                            Button {
                                audioRecorder.deleteRecording()
                                onDecreasedCircle()
                                onIncreaseCircle()
                                audioRecorder.startRecording()
                            } label: {
                                ZStack {
                                    Circle()
                                        .fill(.blue)
                                        .frame(width: 50, height: 50)
                                    
                                    Image(systemName: "arrow.counterclockwise")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 20))
                                }
                            }
                        }
                    }
                } else {
                    ZStack {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 50, height: 50)
                        
                        Image(systemName: "mic.fill")
                            .foregroundStyle(.white)
                            .font(.system(size: 20))
                    }
                    .opacity(opacityRecord)
                    .onTapGesture {
                        onIncreaseCircle()
                        audioRecorder.startRecording()
                    }
                    .padding(.bottom, 20)
                }
            }
            .frame(height: 250)
            
            ZStack {
                VStack {
                    //MARK: - Circle Animation
                    
                    Spacer()
                    
                    Circle()
                        .fill(.red)
                        .frame(width: circleSize, height: circleSize)
                }
                .frame(height: 250)
                
                if circleSize > 0.0 {
                    //MARK: - Main View
                    
                    VStack {
                        Image(systemName: "mic.fill")
                            .foregroundStyle(.white)
                            .font(.system(size: 30))
                            .padding(.top, 100)
                        
                        Text(timeString)
                            .padding(.top, 10)
                            .foregroundStyle(.white)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        //MARK: - Stop Button
                        
                        ZStack {
                            Circle()
                                .fill(.white)
                                .frame(width: 80, height: 80)
                                .opacity(opacityWave1)
                            
                            Circle()
                                .fill(.white)
                                .frame(width: 65, height: 65)
                                .opacity(opacityWave2)
                            
                            Circle()
                                .fill(.white)
                                .frame(width: 50, height: 50)
                            
                            Image(systemName: "stop.fill")
                                .foregroundStyle(.red)
                                .font(.system(size: 20))
                        }
                        .opacity(opacityStop)
                        .onTapGesture {
                            onDecreasedCircle()
                            
                            audioRecorder.stopRecording()
                        }
                    }
                    .frame(height: 250)
                }
            }
        }
    }
    
    private func onIncreaseCircle() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            
            withAnimation(.spring) {
                circleSize += 250.0
                opacityRecord -= 0.3
                opacityStop -= 0.3
                
                if circleSize >= 1200.0 {
                    opacityRecord = 0.0
                    opacityStop = 1.0
                    timer.invalidate()
                }
            }
        }
        timerWave = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true, block: { timer in
            withAnimation(.spring()) {
                opacityWave1 += 0.04
                opacityWave2 += 0.04
                
                if opacityWave1 >= 0.4 {
                    opacityWave1 = 0.08
                }
                
                if opacityWave2 >= 0.6 {
                    opacityWave2 = 0.08
                }
            }
        })
        
        timerRecord = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
            seconds += 1
            if seconds == 60 {
                seconds = 0
                minutes += 1
            }
            let timeString = String(format: "%02d:%02d", minutes, seconds)
            self.timeString = timeString
        })
    }
    
    private func onDecreasedCircle() {
        timerWave?.invalidate()
        timerRecord?.invalidate()
        seconds = 0
        minutes = 0
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            withAnimation(.spring) {
                
                circleSize -= 250.0
                opacityRecord += 0.3
                opacityStop += 0.3
                if circleSize <= 0.0 {
                    opacityRecord = 1.0
                    opacityStop = 0.0
                    timeString = "00:00"
                    opacityWave1 = 0.0
                    opacityWave2 = 0.0
                    timer.invalidate()
                }
            }
        }
    }
    
    private func uploadFile() {
        //TODO: use backendService
        if let fileUrl = audioRecorder.audioFileURL {
            self.backendService.getRecordSummary(fileURL: fileUrl) { result in
                switch result {
                case .success(let response):
                    print("Record Summary Success: \(response)")
                case .failure(let error):
                    print("Record Summary Error: \(error.localizedDescription)")
                }
            }
        } else {
            print("No found file")
        }
    }
}

#Preview {
    MedicalRecordAddAISheetView(medicalRecordViewModel: MedicalRecordViewModel(persons: getPersons()),
                                audioRecorder: AudioRecorder(),
                                medicalAISheet: .constant(false))
}
