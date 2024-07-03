//
//  PersonDashboard.swift
//  CareSync
//
//  Created by Mac on 2024/6/15.
//

import SwiftUI

struct PersonHealthView: View {
    @Binding var persons: [Person]
    @State var personSelect: Int = 0
    @StateObject private var backendService = BackendService()
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    Picker("Choose Member", selection: $personSelect) {
                        ForEach(persons.indices, id: \.self) {index in
                            Text(persons[index].name).tag(index)
                        }
                    }
                    .pickerStyle(.segmented)
                    VStack(spacing: 20) {
                            Button("Fetch Medicine Info") {
                                backendService.getMedicineInfo(prescription: "\n姓名：\n（Name）\n李文傑\n病歷號碼：\n5768007\n（Chart No.）\n科別：\nBeparim eanp腦血管科\n長庚紀念醫院\nCHANG GUNG MEMORIAL HOSPITAL\n網址：http://www.cgmh.org.™w\n生日：\n怎aeotBitb） 973/05/10\n年齡：\n（Age）\n醫師：\n（Doctor）\n性別：\n51\n張谷州\n男\n（Sex）\n體重：\n（Body Weighl）\n2024/05/15 10:3:00\nS519\n領藥號圖N0.\n11780\n調劑日期；\n（Dispensing Date）\n2024/05/15\n藥師：\n陳怡婷\n（Pharmacist）\n【藥名】\n273 aceta-MINOPHEN 500mg/tab\n56 PC\n1\n商品名：Acetal 愛舒疼錠\n廠牌：瑞安\n14#*4+0\n【藥品外觀】\n淡黃色•長圓柱形錠劑刻有\"PURZER\"，另一面有”07/07\"字樣\n【使用方法】\n內服藥，口服\n4-2\n每天2次，早、晚服用，每次1粒，28天份\n【臨床用途】1鎮痛2解熱\n【副作用】\n皮䓟瘙癢、便秘、噁心、嘔吐、失眠\n【注意事項】\n1.服藥期間應避免併用酒精性飲料\n2.如有同時服用非本院開立之解熱止痛藥或綜合感冒藥，請告知\n醫師或藥師\n【預約回診】\n2024/08/07星期三腦血管科張谷州醫師上午診28號\n本品建議在 2024/07/17 前用完\nAM\n姓名：\n（Name）\n李文傑\n病歷號碼：\n5768007\n（Chart No.）\n科別：\nBeparim eanp腦血管科\n長庚紀念醫院\nCHANG GUNG MEMORIAL HOSPITAL\n網址：http://www.cgmh.org.™w\n生日：\n怎aeotBitb） 973/05/10\n年齡：\n（Age）\n醫師：\n（Doctor）\n性別：\n51\n張谷州\n男\n（Sex）\n體重：\n（Body Weighl）\n2024/05/15 10:3:00\nS519\n領藥號圖N0.\n11780\n調劑日期；\n（Dispensing Date）\n2024/05/15\n藥師：\n陳怡婷\n（Pharmacist）\n【藥名】\n273 aceta-MINOPHEN 500mg/tab\n56 PC\n1\n商品名：Acetal 愛舒疼錠\n廠牌：瑞安\n14#*4+0\n【藥品外觀】\n淡黃色•長圓柱形錠劑刻有\"PURZER\"，另一面有”07/07\"字樣\n【使用方法】\n內服藥，口服\n4-2\n每天2次，早、晚服用，每次1粒，28天份\n【臨床用途】1鎮痛2解熱\n【副作用】\n皮䓟瘙癢、便秘、噁心、嘔吐、失眠\n【注意事項】\n1.服藥期間應避免併用酒精性飲料\n2.如有同時服用非本院開立之解熱止痛藥或綜合感冒藥，請告知\n醫師或藥師\n【預約回診】\n2024/08/07星期三腦血管科張谷州醫師上午診28號\n本品建議在 2024/07/17 前用完\n") { result in
                                    switch result {
                                    case .success(let response):
                                        print("Medicine Info Success: \(response)")
                                    case .failure(let error):
                                        print("Medicine Info Error: \(error.localizedDescription)")
                                    }
                                }
                            }
                            
                            Button("Fetch Record Summary") {
                                if let fileURL = Bundle.main.url(forResource: "ttsmaker-file-2024-6-28-20-52-44", withExtension: "m4a") {
                                    backendService.getRecordSummary(fileURL: fileURL) { result in
                                        switch result {
                                        case .success(let response):
                                            print("Record Summary Success: \(response)")
                                        case .failure(let error):
                                            print("Record Summary Error: \(error.localizedDescription)")
                                        }
                                    }
                                } else {
                                    print("Audio file not found")
                                }
                            }
                        }
                        .padding()
                    }
                    Image(persons[personSelect].imageName)
                        .resizable()
                        .frame(width: 200, height: 200)
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                }
                .padding(.horizontal)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        //TODO: edit Personal age
                    } label: {
                        Image(systemName: "gearshape.fill")
                    }
                }
            }
        }
    }


#Preview {
    NavigationStack {
        PersonHealthView(persons: .constant(getPersons()))
    }
}
