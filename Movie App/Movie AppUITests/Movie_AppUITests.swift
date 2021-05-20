//
//  Movie_AppUITests.swift
//  Movie AppUITests
//
//  Created by  protodimbo on 16.05.2021.
//

@testable import Movie_App
import XCTest

final class MovieAppUITests: XCTestCase {
    func testGoingTroughtTable() {
        let app = XCUIApplication()
        app.launch()

        for index in 0 ... 5 {
            app.tables.cells.element(boundBy: index).tap()
            sleep(2)
            app.navigationBars.buttons["Netflix"].tap()
        }
    }
}
