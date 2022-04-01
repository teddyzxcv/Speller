//
//  ViewController.swift
//  Speller
//
//  Created by ZhengWu Pan on 01.04.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private let searchBar = UISearchBar()
    
    private let wordsTableView = UITableView()
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)

    private var spellResults = [SpellResult]()
    
    private var wordPresentView: WordPresentView!
    
    private let stringChecker: StringChecker = StringChecker()
    
    
    
    private var allSWords = [String]()
    
    override func viewDidLoad() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        wordsTableView.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: wordsTableView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: wordsTableView.centerYAnchor)
        ])
        super.viewDidLoad()
        wordPresentView = WordPresentView(frame: CGRect(x: 0, y: 70, width: view.frame.width, height: view.frame.height / 2 - 40))
        view.addSubview(searchBar)
        view.addSubview(wordPresentView)
        view.addSubview(wordsTableView)
        wordsTableView.delegate = self
        wordsTableView.dataSource = self
        wordsTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            wordsTableView.topAnchor.constraint(equalTo:view.centerYAnchor),
            wordsTableView.leadingAnchor.constraint(equalTo:view.leadingAnchor),
            wordsTableView.trailingAnchor.constraint(equalTo:view.trailingAnchor),
            wordsTableView.bottomAnchor.constraint(equalTo:view.bottomAnchor)
        ])
        wordsTableView.register(WordCell.self, forCellReuseIdentifier: WordCell.identifier)
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = "Check..."
        searchBar.frame = CGRect(x: 0, y: 30, width: view.frame.width, height: 40)
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        view.backgroundColor = .systemBackground
        
        // Do any additional setup after loading the view.
    }
}
extension ViewController : UITableViewDelegate {
    
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allSWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WordCell.identifier, for: indexPath) as! WordCell
        cell.setText(text: allSWords[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return
    }
}

extension ViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard
            let text = searchBar.text
        else { return }
        DispatchQueue.global(qos: .background).async { [weak self] in
            DispatchQueue.main.async {
                self!.activityIndicator.startAnimating()
            }
            self!.stringChecker.loadChecks(text: text) { results in
                self!.spellResults = results
                var words = [String]()
                for result in results {
                    for s in result.s {
                        words.append(s)
                        print(s)
                    }
                }
                self?.allSWords = words
                DispatchQueue.main.async {
                    self?.wordsTableView.reloadData()
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
        wordsTableView.reloadData()
        let stringArr = searchBar.text!.components(separatedBy: " ")
        var wordsButton = [UIButton]()
        for str in stringArr {
            for w in spellResults {
                let wordBlock = UIButton()
                wordBlock.setTitle(str, for: .normal)
                if (str == w.word) {
                    wordBlock.backgroundColor = .red
                } else {
                    wordBlock.backgroundColor = .blue
                }
                wordsButton.append(wordBlock)
            }
        }
        wordPresentView.configUI(buttons: wordsButton)
    }
}

