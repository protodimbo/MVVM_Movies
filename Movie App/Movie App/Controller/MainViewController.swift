// MainViewController.swift

import UIKit

/// Main screen of the app
final class MainViewController: UITableViewController {
    private var films: [Result] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureMainScreen()
    }

    private func configureMainScreen() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FilmTableViewCell.self, forCellReuseIdentifier: FilmTableViewCell.identifier)
        fetchData()
        title = "Netflix"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func fetchData() {
        let jsonURLString =
            "https://api.themoviedb.org/3/movie/top_rated?api_key=aca367d31340b3ecdf8975e6a8071834&language=ru&page=1"

        guard let url = URL(string: jsonURLString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            do {
                let filmResponse = try JSONDecoder().decode(Film.self, from: data)
                self.films.append(contentsOf: filmResponse.results)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("Error serialization json", error)
            }
        }.resume()

        // Seconds request
        let secondJsonURLString =
            "https://api.themoviedb.org/3/movie/now_playing?api_key=aca367d31340b3ecdf8975e6a8071834&language=ru&page=2"

        guard let newURL = URL(string: secondJsonURLString) else { return }
        URLSession.shared.dataTask(with: newURL) { data, _, error in
            guard let data = data else { return }
            do {
                let filmResponse = try JSONDecoder().decode(Film.self, from: data)
                self.films.append(contentsOf: filmResponse.results)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("Error serialization json", error)
            }
        }.resume()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        films.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FilmTableViewCell.identifier,
            for: indexPath
        ) as? FilmTableViewCell else { return UITableViewCell() }
        let currentFilm = films[indexPath.row]
        // check rating image
        var ratingImage = ""

        switch currentFilm.voteAverage {
        case 0 ..< 0.5:
            ratingImage = "0"
        case 0.5 ..< 1:
            ratingImage = "0.5"
        case 1 ..< 1.5:
            ratingImage = "1"
        case 1.5 ..< 2:
            ratingImage = "1.5"
        case 2 ..< 2.5:
            ratingImage = "2"
        case 2.5 ..< 3:
            ratingImage = "2.5"
        case 3 ..< 3.5:
            ratingImage = "3"
        case 3.5 ..< 4:
            ratingImage = "3.5"
        case 4 ..< 4.5:
            ratingImage = "4"
        case 4.5 ..< 5:
            ratingImage = "4.5"
        case 5 ..< 5.5:
            ratingImage = "5"
        case 5.5 ..< 6:
            ratingImage = "5.5"
        case 6 ..< 6.5:
            ratingImage = "6"
        case 6.5 ..< 7:
            ratingImage = "6.5"
        case 7 ..< 7.5:
            ratingImage = "7"
        case 7.5 ..< 8:
            ratingImage = "7.5"
        case 8 ..< 8.5:
            ratingImage = "8"
        case 8.5 ..< 9:
            ratingImage = "8.5"
        case 9 ..< 9.5:
            ratingImage = "9"
        case 9.5 ..< 10:
            ratingImage = "9.5"
        case 10:
            ratingImage = "10"
        default:
            ratingImage = "0"
        }

        cell.configureCell(
            filmImageLink: currentFilm.posterPath,
            filmName: currentFilm.title,
            starText: ratingImage,
            ratingText: String(currentFilm.voteAverage),
            dateString: currentFilm.releaseDate
        )
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        190
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        let currentFilm = films[indexPath.row]
        detailVC.configure(posterName: currentFilm.posterPath, title: currentFilm.title, info: currentFilm.overview)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
