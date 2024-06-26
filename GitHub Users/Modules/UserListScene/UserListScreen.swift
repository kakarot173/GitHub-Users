import UIKit

protocol UserListDisplayProtocol: AnyObject {
    func displayData(_ userList: [UserViewModel])
    func displayError()
}

final class UserListScreen: UIViewController {
    // MARK: - Properties
    let interactor: UserListInteractorProtocol
    let router: UserListRouterProtocol
    var modelList = [UserViewModel]()

    // MARK: - Views
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.reuseIdentifier)
        tableView.register(LoadingTableViewCell.self, forCellReuseIdentifier: LoadingTableViewCell.reuseIdentifier)
        tableView.register(ErrorTableViewCell.self, forCellReuseIdentifier: ErrorTableViewCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Life cycle
    init(interactor: UserListInteractorProtocol, router: UserListRouterProtocol) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        configureNavigationBar()
        interactor.fetchList()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - ViewCodeProtocol
extension UserListScreen: ViewCodeProtocol {
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

// MARK: - Navigation Bar
extension UserListScreen {
    private func configureNavigationBar() {
        title = "Users"
        navigationItem.largeTitleDisplayMode = .always
    }
}
// MARK: - UITableViewDelegate, UITableViewDataSource
extension UserListScreen: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        modelList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < modelList.count {
            switch modelList[indexPath.row] {
            case let .success(model):
                return dequeueUserCell(tableView, indexPath, model)
            case .loading:
                interactor.fetchList()
                return dequeueLoadingCell(tableView, indexPath)
            case .error:
                return dequeueErrorCell(tableView, indexPath)
            }
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard indexPath.row < modelList.count else {
            return
        }
        switch modelList[indexPath.row] {
        case let .success(model):
            router.openDetails(userName: model.userName, reposUrl: model.reposUrl)
        case .error:
            replaceLastState(with: .loading)
            interactor.fetchList()
        default:
            break
        }
    }

    private func dequeueUserCell(
        _ tableView: UITableView,
        _ indexPath: IndexPath,
        _ model: UserSuccess
    ) -> UITableViewCell {
        guard let viewCell = tableView.dequeueReusableCell(
            withIdentifier: UserTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? UserTableViewCell else {
            return UITableViewCell()
        }
        viewCell.setup(model)
        return viewCell
    }
}

// MARK: - UserListDisplayProtocol
extension UserListScreen: UserListDisplayProtocol {
    func displayData(_ userList: [UserViewModel]) {
        let size = modelList.count
        _ = modelList.popLast()
        modelList.append(contentsOf: userList)
        if size == 0 {
            tableView.reloadData()
        } else {
            let loadingIndex = IndexPath(row: size-1, section: .zero)
            let newRows = (size-1..<modelList.count).map { row in
                IndexPath(row: row, section: 0)
            }
            tableView.beginUpdates()
            tableView.deleteRows(at: [loadingIndex], with: .top)
            tableView.insertRows(at: newRows, with: .top)
            tableView.endUpdates()
        }
    }

    func displayError() {
        if modelList.count == 0 {
            let alert = UIAlertController(
                title: "Something went wrong",
                message: nil,
                preferredStyle: .alert
            )
            let action = UIAlertAction(
                title: "Something went wrong",
                style: .default
            ) { [weak self] _ in
                self?.interactor.fetchList()
            }
            alert.addAction(action)
            router.present(alert)
        } else {
            replaceLastState(with: .error)
        }
    }

    private func replaceLastState(with model: UserViewModel) {
        _ = modelList.popLast()
        modelList.append(model)
        let lastIndex = IndexPath(row: modelList.count-1, section: .zero)
        tableView.reloadRows(at: [lastIndex], with: .top)
    }
}
