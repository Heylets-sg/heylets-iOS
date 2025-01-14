////
////  MultipartFormDataHandler.swift
////  Networks
////
////  Created by 류희재 on 1/11/25.
////  Copyright © 2025 Heylets-iOS. All rights reserved.
////
//
//import Foundation
//
//public enum MultipartFormData {
//    case text(String, String)
//    case file(name: String, filename: String, mimeType: String, fileData: Data)
//}
//
//public class MultipartFormDataHandler {
//
//    public static func createMultipartData<T: Encodable>(from request: T) -> [MultipartFormData] {
////        var multipartData: [MultipartFormData] = []
//
//        // request 객체를 Mirror를 통해 열어 해당 프로퍼티에 대해 멀티파트로 변환
////        let mirror = Mirror(reflecting: request)
////
////        for child in mirror.children {
////            guard let propertyName = child.label else { continue }
////
////            if let value = child.value as? String {
////                // 문자열인 경우 text로 추가
////                multipartData.append(.text(propertyName, value))
////            } else if let file = child.value as? File {
////                // 파일인 경우 file로 추가
////                multipartData.append(.file(name: propertyName, filename: file.name, mimeType: file.mimeType, fileData: file.data))
////            }
////        }
//        
//        var multipartData: [MultipartFormData] = [
//               .text(name: "request", value: try! encodeToJSONString(request)) // JSON 문자열로 변환
//           ]
//           
//           if let profileImage = profileImg {
//               multipartData.append(.file(
//                   name: "profileImage",
//                   filename: "profile.jpg",
//                   mimeType: "image/jpeg",
//                   fileData: profileImage
//               ))
//           }
//           
//           // MultipartBodyBuilder로 요청 생성
//           return builder.buildRequest(urlRequest, UUID().uuidString, with: multipartData)
//       }
//
//        return multipartData
//    }
//}
//
//public struct File {
//    let name: String
//    let mimeType: String
//    let data: Data
//}
//
