//
//  NetworkResultType'.swift
//  Networks
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

public typealias NetworkVoidResponse = AnyPublisher<Void, HeyNetworkError>
public typealias NetworkDecodableResponse<T: Decodable> = AnyPublisher<T, HeyNetworkError>
