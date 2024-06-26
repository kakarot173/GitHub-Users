//
//  WebViewController.swift
//  GithubUserListApp
//
//  Created by Animesh Mohanty on 26/06/24.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    // MARK: - Properties
    let url: String

    // MARK: - Views
    lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()

    // MARK: Life cycle
    init(url: String) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        guard let url = URL(string: url) else {
            return dismiss(animated: true)
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

// MARK: - ViewCodeProtocol
extension WebViewController: ViewCodeProtocol {
    func setupHierarchy() {
        view.addSubview(webView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
