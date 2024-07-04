//
//  BackendService.swift
//  CareSync
//
//  Created by Mac on 2024/7/3.
//

import Foundation

class BackendService: NSObject, ObservableObject {
    
    private let baseURL = "https://caresync-backend.bearbig.dev" // 替換為你的 API 基礎 URL
    private let session = URLSession.shared

    // Method to handle String request
    func getMedicineInfo(prescription: String, completion: @escaping (Result<MedicineNotify, Error>) -> Void) {
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
                let medicineInfo = jsonResponse.medicine_info
                let takeMedicineInfo = jsonResponse.take_medicine_info
                print(jsonResponse)
                
                let medicine = Medicine(name: medicineInfo.medicine_name ?? "",
                                        appearance: medicineInfo.appearance ?? "",
                                        instructions: medicineInfo.instruction ?? "",
                                        sideEffect: medicineInfo.side_effect ?? "",
                                        precautions: medicineInfo.precaution ?? "")
                
                let eatTimes = takeMedicineInfo.medicine_time.compactMap {timeString -> MealTime? in
                    return MealTime(rawValue: timeString ?? "")
                }
                print("eatTimes: \(eatTimes)")
                
                let medicineNotify = MedicineNotify(medicine: medicine,
                                                    person: getPersons()[0],
                                                    startDate: Date(),
                                                    notify: false,
                                                    duration: takeMedicineInfo.duration ?? 3,
                                                    intervalDays: takeMedicineInfo.intreval_days ?? 1,
                                                    eatTime: eatTimes)
                
                completion(.success(medicineNotify))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }

    // Method to handle .m4a file request
    func getRecordSummary(fileURL: URL, completion: @escaping (Result<getAudioSummaryResponse, Error>) -> Void) {
        let path = "ai-assistance/medical-process-summary/"
        guard let url = URL(string: "\(baseURL)/\(path)") else {
            completion(.failure(APIError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//        request.setValue("audio/m4a", forHTTPHeaderField: "Content-Type")

        let fileData: Data
        do {
            fileData = try Data(contentsOf: fileURL)
        } catch {
            completion(.failure(APIError.invalidFile))
            return
        }

        var body = Data()

        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"audio\"; filename=\"\(fileURL.lastPathComponent)\"\r\n")
        body.append("Content-Type: audio/m4a\r\n\r\n")
        body.append(fileData)
        body.append("\r\n")
        body.append("--\(boundary)--\r\n")

        request.httpBody = body

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
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                    print("Server response JSON: \(json)")
                }
                
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

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}

enum APIError: Error {
    case invalidURL
    case invalidBody
    case noData
    case invalidResponse
    case invalidFile
}

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
    let precautions: String?
}
