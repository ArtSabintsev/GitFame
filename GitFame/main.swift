//
//  main.swift
//  GitFame
//
//  Created by Sabintsev, Arthur on 3/6/17.
//  Copyright © 2017 Arthur Ariel Sabintsev. All rights reserved.
//

import Foundation

// MARK: - GitFame

fileprivate struct GitFame {
    fileprivate typealias Repository = [String: Any]
    fileprivate typealias SlimRepository = (name: String, stars: Int, forks: Int)

    let username: String

    @discardableResult
    init(arguments: [String]) throws {
        print("... Welcome to GitFame! ...")
        guard arguments.count == 2 else {
            throw GFError.InvalidArguments
        }

        username = arguments[1]
        print("... Fetching Stars (\(GFConstants.starUnicode)) and Forks (\(GFConstants.forkUnicode)) for GitHub user (\(username)) on \(Date()) ...\n")
        fetch()
    }
}

private extension GitFame {
    func fetch() {
        fetchRepoCount { repoCount in
            self.fetchAllRepos(count: repoCount, completion: { repos in
                self.calculate(with: repos)
            })
        }
    }

    func fetchRepoCount(completion handler: @escaping (Int) -> Void) {
        let urlString = "https://api.github.com/users/\(username)"
        guard let url = URL(string: urlString) else {
            return GFError.log(error: .InvalidURL(urlString: urlString))
        }

        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                GFError.log(error: .FoundationError(error: error))
            }

            guard let data = data else {
                return GFError.log(error: .MissingJSON(urlString: urlString))
            }

            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                let repos = json,
                let repCount = repos[GFConstants.publicRepos] as? Int else {
                return GFError.log(error: .MalformedJSON(urlString: urlString))
            }

            handler(repCount)
        }.resume()
        GFSemaphore.wait()
    }

    func fetchAllRepos(count: Int, completion handler: @escaping ([Repository]) -> Void) {
        let urlString = "https://api.github.com/users/\(username)/repos?per_page=\(count)"
        guard let url = URL(string: urlString) else {
            return GFError.log(error: .InvalidURL(urlString: urlString))
        }

        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)
        URLSession.shared.dataTask(with: request) { (data, response, error) in

            if let error = error {
                GFError.log(error: .FoundationError(error: error))
            }

            guard let data = data else {
                return GFError.log(error: .MissingJSON(urlString: urlString))
            }

            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [Repository],
                let repos = json else {
                    return GFError.log(error: .MalformedJSON(urlString: urlString))
            }

            handler(repos)
        }.resume()
    }

    func calculate(with repos: [Repository]) {
        let slimRepos = repos.flatMap({ (repo) -> SlimRepository? in
            guard let name = repo[GFConstants.repoName] as? String else {
                return nil
            }

            guard let stars = repo[GFConstants.repoStarCount] as? Int else {
                return nil
            }

            guard let forks = repo[GFConstants.repoForkCount] as? Int else {
                return nil
            }

            return SlimRepository(name: name, stars: stars, forks: forks)
        }).sorted {
            $0.stars > $1.stars
        }

        let stars = slimRepos.flatMap({ $0.stars }).reduce(0, +)
        let forks = slimRepos.flatMap({ $0.forks }).reduce(0, +)

        print("\(username) has \(stars) \u{2605} and \(forks) \u{2442}\n")

        printAll(using: slimRepos)

        GFSemaphore.signal()
    }

    func printAll(using repos: [SlimRepository]) {
        let sortedRepos = repos.sorted(by: { $0.name.characters.count > $1.name.characters.count })

        guard let length = sortedRepos.first?.name.characters.count else {
            return
        }

        for repo in repos {
            var name = repo.name
            repeat { name.insert(" ", at: name.endIndex) } while name.characters.count < length + 10
            print("\(name)\(repo.stars) \u{2605} / \(repo.forks) \u{2442}")
        }
    }
}

// MARK: - GFError

fileprivate enum GFError: Error {
    case FoundationError(error: Error)
    case InvalidArguments
    case InvalidURL(urlString: String)
    case MissingJSON(urlString: String)
    case MalformedJSON(urlString: String)

    static func log(error: GFError) {
        let message = "[GitFame Error] "
        switch error {
        case FoundationError(let error):
            print(message + "\(error.localizedDescription)")
        case .InvalidArguments:
            print(message + "The GitHub username is missing. Example: 'gitfame myGitHubUsername'")
        case .InvalidURL(let urlString):
            print(message + "The following GitHub url could not be reached: \(urlString)")
        case .MissingJSON(let urlString):
            print(message + "Expected JSON was not returned for url: \(urlString)")
        case .MalformedJSON(let urlString):
            print(message + "The JSON could not be parsed for url: \(urlString)")
        }

        GFSemaphore.signal()
    }
}

fileprivate struct GFConstants {
    static let starUnicode = "\u{2605}"
    static let forkUnicode = "\u{2442}"
    static let publicRepos = "public_repos"
    static let repoName = "name"
    static let repoStarCount = "stargazers_count"
    static let repoForkCount = "forks_count"
}

// MARK: - Program Entry

fileprivate var GFSemaphore = DispatchSemaphore(value: 0)

do {
    try GitFame(arguments: CommandLine.arguments)
} catch let error as GFError {
    GFError.log(error: error)
}
