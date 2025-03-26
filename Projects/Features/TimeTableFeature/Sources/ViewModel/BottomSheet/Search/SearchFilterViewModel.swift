////
////  SearchFilterViewModel.swift
////  TimeTableFeature
////
////  Created by 류희재 on 3/24/25.
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
//public class SearchFilterViewModel: ObservableObject {
//    struct State {
//        var selectedLecture: SectionInfo? = nil
//        var isLoading: Bool = false
//    }
//    
//    enum Action {
//        case onAppear
//        case lectureCellDidTap(SectionInfo)
//        case searchButtonDidTap
//        case clearButtonDidTap
//        case addLectureButtonDidTap(SectionInfo)
//    }
//    
//    @Published var state = State()
//    @Published var departmentList: [String] = []
//    let levelList: [String] = ["1", "2", "3", "4", "5", "6"]
//    let semesterList: [String] = ["TERM_1", "TERM_2"]
//    @Published var searchText = ""
//    
//    private let cancelBag = CancelBag()
//    private let useCase: TimeTableUseCaseType
//    
//    public init(_ useCase: TimeTableUseCaseType) {
//        self.useCase = useCase
//    }
//    
//    func send(_ action: Action) {
//        switch action {
//        case .onAppear:
//            useCase.getLectureList(searchText)
//                .receive(on: RunLoop.main)
//                .assignLoading(to: \.state.isLoading, on: self)
//                .assign(to: \.lectureList, on: self)
//                .store(in: cancelBag)
//            
//        case .lectureCellDidTap(let lecture):
//            state.selectedLecture = lecture
//            guard let selectLecture = selectLectureClosure else { return }
//            selectLecture(lecture)
//            
//        case .searchButtonDidTap:
//            useCase.getLectureList(searchText)
//                .receive(on: RunLoop.main)
//                .handleEvents(receiveOutput: { _ in
//                    Analytics.shared.track(.moduleSearched)
//                })
//                .assign(to: \.lectureList, on: self)
//                .store(in: cancelBag)
//            
//        case .clearButtonDidTap:
//            searchText = ""
//            state.selectedLecture = nil
//            useCase.getLectureList(searchText)
//                .receive(on: RunLoop.main)
//                .assign(to: \.lectureList, on: self)
//                .store(in: cancelBag)
//            
//        case .addLectureButtonDidTap(let lecture):
//            guard let addLecture = addLectureClosure else { return }
//            addLecture(lecture)
//            state.selectedLecture = nil
//        }
//    }
//}
//
//
