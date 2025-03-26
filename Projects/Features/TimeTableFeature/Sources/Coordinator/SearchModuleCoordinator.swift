////
////  SearchModuleCoordinator.swift
////  TimeTableFeature
////
////  Created by 류희재 on 3/26/25.
////  Copyright © 2025 Heylets-iOS. All rights reserved.
////
//
//import Foundation
//import Combine
//import SwiftUI
//
//import BaseFeatureDependency
//import Domain
//import DSKit
//import Core
//
//public class SearchModuleCoordinator: ObservableObject, TimeTableCoordinator {
//    weak public var viewModel: TimeTableViewModel?
//    
//    private let useCase: TimeTableUseCaseType
//    private let cancelBag = CancelBag()
//    
//    @Published var searchResults: [SectionInfo] = []
//    @Published var searchQuery: String = ""
//    @Published var isSearching: Bool = false
//    
//    init(useCase: TimeTableUseCaseType) {
//        self.useCase = useCase
//    }
//    
//    func selectLecture(_ lecture: SectionInfo) {
//        viewModel?.send(.selectLecture(lecture))
//    }
//    
//    func addLecture(_ lecture: SectionInfo) {
//        viewModel?.send(.addLecture(lecture))
//    }
//    
//    func search(query: String) {
//        searchQuery = query
//        isSearching = true
//        
//        useCase.searchModules(query)
//            .receive(on: RunLoop.main)
//            .handleEvents(receiveCompletion: { [weak self] _ in
//                self?.isSearching = false
//            })
//            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] results in
//                self?.searchResults = results
//            })
//            .store(in: cancelBag)
//    }
//}
