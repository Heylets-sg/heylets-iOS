//
//  LectureReviewTaxonomy.swift
//  BaseFeatureDependency
//
//  Created by 류희재 on 3/14/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Core

extension AnalyticsTaxonomy {
    static let clickLectureReview = AnalyticsTaxonomy(
        eventName: "click_lecture_review"
    )

    static let clickSubmitLectureReview = AnalyticsTaxonomy(
        eventName: "click_submit_lecture_review"
    )

    static let lectureReviewSubmitted = AnalyticsTaxonomy(
        eventName: "lecture_review_submitted"
    )
}

