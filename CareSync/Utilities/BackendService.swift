//
//  BackendService.swift
//  CareSync
//
//  Created by Mac on 2024/7/3.
//

import Foundation


struct getMedicineInfoRequest: Encodable {
    let prescription: String
}

struct getMedicineInfoResponse: Decodable {
    let medicine_info: getMedicineInfoMedicineDetailResponse
    let take_medicine_info: getMedicineInfoTakeMedicineDetailResponse
}

struct getMedicineInfoMedicineDetailResponse: Decodable {
    let medicine_name: String?
    let appearance: String?
    let instruction: String?
    let precaution: String?
    let side_effect: String?
}

struct getMedicineInfoTakeMedicineDetailResponse: Decodable {
    let start_date: String?
    let intreval_days: Int?
    let duration: Int?
    let medicine_time: [String?]
}

struct getAudioSummaryRequest: Encodable {
    let audio: Data
}

struct getAudioSummaryResponse: Decodable {
    let symptom: String?
    let precautions: [String?]
}


class BackendService: ObservableObject {
    //TODO: Here
    private let baseURL = "https://caresync-backend.bearbig.dev" // 替換為你的 API 基礎 URL
    private let session = URLSession.shared

    // Method to handle String request
    func getMedicineInfo(prescription: String, completion: @escaping (Result<getMedicineInfoResponse, Error>) -> Void) {
        let path = "ai-assistance/medicine-info/"
        guard let url = URL(string: "\(baseURL)/\(path)") else {
            completion(.failure(APIError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let requestBody = getMedicineInfoRequest(prescription: prescription)
        guard let httpBody = try? JSONEncoder().encode(requestBody) else {
            completion(.failure(APIError.invalidBody))
            return
        }
        request.httpBody = httpBody

        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.noData))
                return
            }

            do {
                let jsonResponse = try JSONDecoder().decode(getMedicineInfoResponse.self, from: data)
                completion(.success(jsonResponse))
                print(jsonResponse)
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }

    // Method to handle .m4a file request
    func getRecordSummary(fileURL: URL, completion: @escaping (Result<getAudioSummaryResponse, Error>) -> Void) {
        var path = "ai-assistance/medical-process-summary/"
        guard let url = URL(string: "\(baseURL)/\(path)") else {
            completion(.failure(APIError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("audio/m4a", forHTTPHeaderField: "Content-Type")

        do {
            let fileData = try Data(contentsOf: fileURL)
            let requestBody = getAudioSummaryRequest(audio: fileData)
            request.httpBody = try JSONEncoder().encode(requestBody)
        } catch {
            completion(.failure(APIError.invalidFile))
            return
        }

        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.noData))
                return
            }
            
            do {
                let jsonResponse = try JSONDecoder().decode(getAudioSummaryResponse.self, from: data)
                completion(.success(jsonResponse))
                print(jsonResponse)
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

enum APIError: Error {
    case invalidURL
    case invalidBody
    case noData
    case invalidResponse
    case invalidFile
}

