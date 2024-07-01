//
//  TextRecognizer.swift
//  CareSync
//
//  Created by Mac on 2024/7/2.
//

import Foundation
import Vision
import VisionKit

final class TextRecognizer {
    
    let cameraScan: VNDocumentCameraScan
    
    init(cameraScan:VNDocumentCameraScan) {
        self.cameraScan = cameraScan
    }
    
    private let queue = DispatchQueue(label: "scan-codes",qos: .default,attributes: [],autoreleaseFrequency: .workItem)
    
    func recognizeText(withCompletionHandler completionHandler:@escaping ([String])-> Void) {
        
        queue.async {
            let images = (0..<self.cameraScan.pageCount).compactMap({
                self.cameraScan.imageOfPage(at: $0).cgImage
            })
            
            print("Number of images to process: \(images.count)")
            
            let imagesAndRequests = images.map({(image: $0, request:VNRecognizeTextRequest())})
            
            let textPerPage = imagesAndRequests.map{ image, request-> String in
                
                request.recognitionLanguages = ["zh-Hant"]
                
                let handler = VNImageRequestHandler(cgImage: image, options: [:])
                
                do{
                    try handler.perform([request])
                    guard let observations = request.results as? [VNRecognizedTextObservation] else {
                        print("No recognized text observations")
                        return ""
                    }
                    let recognizedText = observations.compactMap { $0.topCandidates(1).first?.string }.joined(separator: "\n")
                    
                    print("Recognized text for one page: \(recognizedText)")
                    return recognizedText
                }
                catch{
                    print("Error during text recognition:\(error)")
                    return ""
                }
            }
            
            DispatchQueue.main.async {
                completionHandler(textPerPage)
            }
        }
    }
}

