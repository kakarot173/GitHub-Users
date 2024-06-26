//
//  UserDetailsScreen.swift
//  GithubUserListApp
//
//  Created by Animesh Mohanty on 26/06/24.
//

import UIKit

protocol UserDetailsDisplayProtocol: AnyObject {
    func displayUserDetails(_ details: UserDetailsViewModel)
    func displayRepoList(_ model: [UserRepoViewModel])
}

final class UserDetailsScreen: UIViewController {
    // MARK: - Properties
    let interactor: UserDetailsInteractorProtocol
    let router: UserDetailsRouterProtocol
    var detailsModel: UserDetailsViewModel?
    var repoList = [UserRepoViewModel]()

    // MARK: - Views
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserDetailsViewCell.self, forCellReuseIdentifier: UserDetailsViewCell.reuseIdentifier)
        tableView.register(UserRepoViewCell.self, forCellReuseIdentifier: UserRepoViewCell.reuseIdentifier)
        tableView.register(LoadingTableViewCell.self, forCellReuseIdentifier: LoadingTableViewCell.reuseIdentifier)
        tableView.register(ErrorTableViewCell.self, forCellReuseIdentifier: ErrorTableViewCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Life cycle
    init(interactor: UserDetailsInteractorProtocol, router: UserDetailsRouterProtocol) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    override func viewDidLoad() {
        configureNavigationBar()
        interactor.fetchUserDetails()
        interactor.fetchRepoList()
    }
}
// MARK: - Navigation Bar
extension UserDetailsScreen {
    private func configureNavigationBar() {
        title = "Profile"
    }
}
// MARK: - ViewCodeProtocol
extension UserDetailsScreen: ViewCodeProtocol {
    func setupHierarchy() {
        view.addSubview(tableView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension UserDetailsScreen: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        Sections.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case Sections.details.rawValue:
            return detailsModel != nil ? 1 : 0
        case Sections.repos.rawValue:
            return repoList.count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case Sections.details.rawValue:
            return loadUserDetails(tableView, indexPath)
        case Sections.repos.rawValue:
            return loadRepoList(tableView, indexPath)
        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == Sections.details.rawValue, case .error = detailsModel {
            interactor.fetchUserDetails()
        } else if indexPath.section == Sections.repos.rawValue {
            guard indexPath.row < repoList.count else {
                return
            }
            switch repoList[indexPath.row] {
            case let .success(model):
                router.openRepo(model.url)
            case .error:
                replaceLastState(with: .loading)
                interactor.fetchRepoList()
            default:
                break
            }
        }
    }

    private func loadUserDetails(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        switch detailsModel {
        case let .success(details):
            let userCell = tableView.dequeueReusableCell(
                withIdentifier: UserDetailsViewCell.reuseIdentifier,
                for: indexPath
            ) as? UserDetailsViewCell
            userCell?.setup(details)
            userCell?.selectionStyle = .none
            cell = userCell
        case .loading:
            cell = dequeueLoadingCell(tableView, indexPath)
        case .error:
            cell = dequeueErrorCell(tableView, indexPath)
        default:
            break
        }
        return cell ?? UITableViewCell()
    }

    func loadRepoList(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        if indexPath.row < repoList.count {
            switch repoList[indexPath.row] {
            case let .success(model):
                let repoCell = tableView.dequeueReusableCell(
                    withIdentifier: UserRepoViewCell.reuseIdentifier,
                    for: indexPath
                ) as? UserRepoViewCell
                repoCell?.setup(model)
                cell = repoCell
            case .loading:
                interactor.fetchRepoList()
                cell = dequeueLoadingCell(tableView, indexPath)
            case .error:
                cell = dequeueErrorCell(tableView, indexPath)
            }
        }
        return cell ?? UITableViewCell()
    }

    private func replaceLastState(with model: UserRepoViewModel) {
        if repoList.popLast() != nil {
            repoList.append(model)
            let lastIndex = IndexPath(row: repoList.count-1, section: Sections.repos.rawValue)
            tableView.reloadRows(at: [lastIndex], with: .top)
        } else {
            repoList.append(model)
            let lastIndex = IndexPath(row: .zero, section: Sections.repos.rawValue)
            tableView.insertRows(at: [lastIndex], with: .top)
        }
    }
}

// MARK: - UserDetailsDisplayProtocol
extension UserDetailsScreen: UserDetailsDisplayProtocol {
    func displayUserDetails(_ details: UserDetailsViewModel) {
        detailsModel = details
        tableView.reloadSections(.init(integer: Sections.details.rawValue), with: .fade)
    }

    func displayRepoList(_ repoList: [UserRepoViewModel]) {
        let size = self.repoList.count
        _ = self.repoList.popLast()
        self.repoList.append(contentsOf: repoList)
        if size == .zero {
            tableView.reloadSections(.init(integer: Sections.repos.rawValue), with: .top)
        } else {
            let loadingIndex = IndexPath(row: size-1, section: Sections.repos.rawValue)
            let newRows = (size-1..<self.repoList.count).map { row in
                IndexPath(row: row, section: Sections.repos.rawValue)
            }
            tableView.beginUpdates()
            tableView.deleteRows(at: [loadingIndex], with: .top)
            tableView.insertRows(at: newRows, with: .top)
            tableView.endUpdates()
        }
    }
}

// MARK: - Sections
extension UserDetailsScreen {
    enum Sections: Int, CaseIterable {
        case details
        case repos
    }
}
