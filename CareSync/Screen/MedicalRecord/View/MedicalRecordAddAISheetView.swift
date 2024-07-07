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
    @StateObject var backendService: BackendService = BackendService()
    @Binding var medicalAISheet: Bool
    @Environment(\.presentationMode) var presentationMode
    
    @State private var opacityRecord: CGFloat = 1.0
    @State private var opacityStop: CGFloat = 0.0
    @State private var opacityWave1: CGFloat = 0.0
    @State private var opacityWave2: CGFloat = 0.0
    @State private var timerWave: Timer?
    @State private var circleSize: CGFloat = 0.0
    @State private var seconds: Int = 0
    @State private var minutes: Int = 0
    @State private var timeString = "00:00"
    @State private var timerRecord: Timer?
    @State private var isLoading: Bool = false
    
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
                    .padding(.bottom, 30)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: 70)
                .padding()
                
                
                //MARK: - Record Button
                
                if audioRecorder.audioFileURL != nil {
                    VStack {
                        Button {
                            //TODO: send audio to server
                            uploadFile()
                            
                            // END OF:
                            audioRecorder.deleteRecording()
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
                    HStack(spacing: 30) {
                        
                        ZStack {
                            Circle()
                                .fill(.gray)
                                .frame(width: 50, height: 50)
                            Image(systemName: "hammer.fill")
                                .foregroundStyle(.white)
                                .font(.system(size: 20))
                        }
                        .onTapGesture {
                            uploadTestFile()
                        }
                        
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
                    }
                }
                
                Spacer()
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
                        Spacer()
                        
                        Image(systemName: "mic.fill")
                            .foregroundStyle(.white)
                            .font(.system(size: 30))
                            .padding(.top, 100)
                        
                        Text(timeString)
                            .padding(.top, 10)
                            .foregroundStyle(.white)
                            .font(.title)
                            .fontWeight(.bold)
                        
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
                        .padding(.bottom, 20)
                        
                        Spacer()
                    }
                    .frame(height: 250)
                }
            }
            
            if isLoading {
                CustomProgressView()
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
        if let fileUrl = audioRecorder.audioFileURL {
            
            self.isLoading = true
            self.backendService.getRecordSummary(fileURL: fileUrl) { result in
                switch result {
                case .success(let response):
                    print("Record Summary Success: \(response)")
                    
                    DispatchQueue.main.async {
                        self.medicalRecordViewModel.medicalRecordAdd.symptomDescription = response.symptom ?? ""
                        self.medicalRecordViewModel.medicalRecordAdd.doctorOrder = response.precautions ?? ""
                        self.medicalRecordViewModel.objectWillChange.send()
                        self.isLoading = false
                        self.medicalAISheet.toggle()
                    }
                    
                case .failure(let error):
                    print("Record Summary Error: \(error.localizedDescription)")
                }
            }
        } else {
            print("No file found")
        }
    }
    
    private func uploadTestFile() {
        if let testFileURL = audioRecorder.getTestFileURL() {
            audioRecorder.audioFileURL = testFileURL
            self.isLoading = true
            self.backendService.getRecordSummary(fileURL: testFileURL) { result in
                switch result {
                case .success(let response):
                    print("Record Summary Success: \(response)")
                    
                    DispatchQueue.main.async {
                        self.medicalRecordViewModel.medicalRecordAdd.symptomDescription = response.symptom ?? ""
                        self.medicalRecordViewModel.medicalRecordAdd.doctorOrder = response.precautions ?? ""
                        self.medicalRecordViewModel.objectWillChange.send()
                        self.isLoading = false
                        self.medicalAISheet.toggle()
                    }
                case .failure(let error):
                    print("Record Summary Error: \(error.localizedDescription)")
                    self.isLoading = false
                }
            }
            
        } else {
            print("Test file not found")
        }
    }
}

#Preview {
    MedicalRecordAddAISheetView(medicalRecordViewModel: MedicalRecordViewModel(persons: getPersons()),
                                audioRecorder: AudioRecorder(),
                                medicalAISheet: .constant(false))
}
