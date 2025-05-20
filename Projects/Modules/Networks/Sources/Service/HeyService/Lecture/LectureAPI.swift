//
//  LectureAPI.swift
//  Networks
//
//  Created by 류희재 on 1/8/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

import Domain

public enum LectureAPI {
    case getLectureDetailInfo(Int)
    case getLectureList(Parameters)
    case getLectureDepartment(String)
    case getKeyword
}

extension LectureAPI: BaseAPI {
    public var connectWebHook: Bool {
        return false
    }
    
    public var isWithInterceptor: Bool {
        return true
    }
    
    public var path: String? {
        switch self {
        case .getLectureDetailInfo(let lectureId):
            return Paths.getDetailLectureInfo.replacingOccurrences(of: "{lectureId}", with: "\(lectureId)")
        case .getLectureList:
            return Paths.getLectureList
        case .getLectureDepartment(let university):
            return Paths.getLectureDepartment.replacingOccurrences(of: "{university}", with: "\(university)")
        case .getKeyword:
            return Paths.getKeyword
        }
    }
    
    public var method: HTTPMethod {
        return .get
    }
    
    public var task: Task {
        switch self {
        case .getLectureDetailInfo:
            return .requestPlain
            
        case .getLectureList(let parameters):
            return .requestParameters(parameters)
            /*TODO: pageable 파라미터 추가 page=0&size=1&sort=%5B%22string%22%5D
             {
               "page": 0,
               "size": 1,
               "sort": [
                 "string"
               ]
             }
             
             */
            
        case .getLectureDepartment:
            return .requestParameters([
                "academicYear": "2024",
                "semester": "TERM_2"
            ])
            
        case .getKeyword:
            return .requestPlain
        }
    }
    
    
    public var headers: [String : String]? {
        return APIHeaders.headerWithAccessToken
    }
}



