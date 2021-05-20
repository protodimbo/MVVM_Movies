//
//  MainModuleTests.swift
//  Movie AppUnitTests
//
//  Created by  protodimbo on 15.05.2021.
//

@testable import Movie_App
import XCTest

final class MainModuleTests: XCTestCase {
    private var networkService: MockNetworkService!
    private var viewModel: MainViewModelType!
    private var film: Film!
    private var filmResults: [FilmResult]!
    private var posters: [Posters]!

    override func setUpWithError() throws {
        networkService = MockNetworkService()
        viewModel = MainViewModel(networkService: networkService, coreDataService: CoreDataService())
        filmResults = []
        posters = []
        film = Film(page: 0, results: [], totalPages: 0, totalResults: 0)
    }

    override func tearDownWithError() throws {
        networkService = nil
        viewModel = nil
        filmResults = nil
        posters = nil
        film = nil
    }

    func testSuccessGettingFilm() {
        filmResults.append(FilmResult(
            backdropPath: "Baz",
            id: 0,
            originalTitle: "Bar",
            overview: "Baz",
            releaseDate: "Bar",
            title: "Baz",
            voteAverage: 0.0
        ))
        film.results = filmResults
        networkService = MockNetworkService(film: film)
        var catchFilmResult: FilmResult?

        networkService.getFilms(category: .nowPlaying) { result in
            switch result {
            case let .success(film):
                catchFilmResult = film.results.first
            case let .failure(error):
                print(error.localizedDescription)
            }
        }

        XCTAssertNotNil(catchFilmResult)
    }

    func testSuccessGettingImage() {
        posters.append(Posters(aspectRatio: 0.0, filePath: "Baz"))
        networkService = MockNetworkService(posters: posters)
        var catchPostersResult: Posters?

        networkService.getImages(for: "baz") { result in
            switch result {
            case let .success(posters):
                catchPostersResult = posters?.first
            case let .failure(error):
                print(error.localizedDescription)
            }
        }

        XCTAssertNotNil(catchPostersResult)
    }
}
