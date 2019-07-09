//
//  InfiniteSequence.swift
//  Platform
//
//  Created by Krunoslav Zaher on 6/13/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

/// Sequence that repeats `repeatedValue` infinite number of times.
struct InfiniteSequence<Element>: Sequence {
    typealias Iterator = AnyIterator<Element>

    private let _repeatedValue: Element

    init(repeatedValue: Element) {
        self._repeatedValue = repeatedValue
    }

    func makeIterator() -> Iterator {
        let repeatedValue = self._repeatedValue
        return AnyIterator {
            repeatedValue
        }
    }
}
