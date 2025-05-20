//
//  WebHookHandler.swift
//  Networks
//
//  Created by 류희재 on 4/16/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation


public final class WebHookHandler {
    nonisolated(unsafe) static public let shared = WebHookHandler()
    
    private init() {}
    
    public func sendErrorToSlack(
        error: HeyNetworkError,
        fullURL: String,
        method: String,
        headers: String,
        taksDesc: String
    ) {
        guard let url = URL(string: "https://hooks.slack.com/services/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") else { return }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let timestamp = ISO8601DateFormatter().string(from: Date())
        
        let payload: [String: Any] = [
            "blocks": [
                [
                    "type": "header",
                    "text": [
                        "type": "plain_text",
                        "text": "🚨 네트워크 에러 발생!",
                        "emoji": true
                    ]
                ],
                [
                    "type": "section",
                    "fields": [
                        [
                            "type": "mrkdwn",
                            "text": "*에러 메시지:*\n\(error.description)"
                        ],
                        [
                            "type": "mrkdwn",
                            "text": "*시간:*\n\(timestamp)"
                        ]
                    ]
                ],
                [
                    "type": "section",
                    "text": [
                        "type": "mrkdwn",
                        "text": "*🔗 요청 정보*"
                    ]
                ],
                [
                    "type": "section",
                    "fields": [
                        [
                            "type": "mrkdwn",
                            "text": "*Method:*\n\(method)"
                        ],
                        [
                            "type": "mrkdwn",
                            "text": "*URL:*\n\(fullURL)"
                        ]
                    ]
                ],
                [
                    "type": "section",
                    "fields": [
                        [
                            "type": "mrkdwn",
                            "text": "*Headers:*\n\(headers)"
                        ],
                        [
                            "type": "mrkdwn",
                            "text": "*Task:*\n\(taksDesc)"
                        ]
                    ]
                ],
                [
                    "type": "divider"
                ],
                [
                    "type": "context",
                    "elements": [
                        [
                            "type": "mrkdwn",
                            "text": "_앱에서 자동 전송된 네트워크 에러 리포트입니다._"
                        ]
                    ]
                ]
            ]
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: payload, options: [])
        } catch {
            print("슬랙 JSON 변환 실패: \(error)")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("슬랙 전송 실패: \(error)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("슬랙 응답 코드: \(httpResponse.statusCode)")
            }
        }
        
        task.resume()
    }
}

