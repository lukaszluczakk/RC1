//
//  DataApiFactory.swift
//  FM
//
//  Created by Łukasz Łuczak on 05/09/2021.
//

import Foundation

struct RecruitmentTaskApiFactory {
    static func getInstance() -> ApiProtocol {
        if CommandLineHelper.isTestRunning() {
            return UITestRecruitmentTaskApi()
        }
        
        let networkManager = NetworkManager()
        return RecruitmentTaskApi(networkManager: networkManager)
    }
}
