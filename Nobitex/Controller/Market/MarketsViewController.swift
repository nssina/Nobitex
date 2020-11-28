//
//  MarketsViewController.swift
//  Nobitex
//
//  Created by Sina Rabiei on 11/25/20.
//

import UIKit

class MarketsViewController: UIViewController {
    
    private let network = NetworkManager.shared
    private let marketState = MarketStateModel.shared
    private let symbolInfo = SymbolInfoViewController.shared
    private let segment: UISegmentedControl = UISegmentedControl(items: ["USDT", "IRT"])
    
    private lazy var marketsTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(MarketsCell.self, forCellReuseIdentifier: "marketsCell")
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(marketsTableView)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setMarketsTableViewConstraints()
        
        addSegmentedControl()
        
        sendUsdtCoinsRequests()
    }
}

extension MarketsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return marketState.symbol.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "marketsCell", for: indexPath) as! MarketsCell
        
        if marketState.symbol.count > 0 {
            if marketState.dayChange[indexPath.row].contains("-") {
                cell.dayChangeView.backgroundColor = .systemRed
            } else {
                cell.dayChangeView.backgroundColor = .systemGreen
            }
            cell.coinIcon.image = UIImage(named: marketState.symbol[indexPath.row])
            cell.coinIcon.layer.cornerRadius = (cell.coinIcon.frame.width) / 2
            cell.dayChangePercent.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            cell.dayChangePercent.text = marketState.dayChange[indexPath.row]
            cell.symbol.text = marketState.symbol[indexPath.row]
            cell.latestPriceLabel.text = marketState.latestPrice[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let symbolVc = self.storyboard?.instantiateViewController(withIdentifier: "SymbolInfoVC") as? SymbolInfoViewController else { print("check"); return }
        
        switch segment.selectedSegmentIndex {
        case 0:
            let symbol = "\(marketState.symbol[indexPath.row]) / USDT"
            network.getTrades(symbol: "\(marketState.symbol[indexPath.row])USDT") { (success, response) in
                if success {
                    symbolVc.symbolName = symbol
                    symbolVc.tradesModel = response
                    DispatchQueue.main.async {
                        self.navigationController?.present(symbolVc, animated: true, completion: nil)
                    }
                }
            }
        case 1:
            let symbol = "\(marketState.symbol[indexPath.row]) / IRT"
            network.getTrades(symbol: "\(marketState.symbol[indexPath.row])IRT") { (success, response) in
                if success {
                    symbolVc.symbolName = symbol
                    symbolVc.tradesModel = response
                    DispatchQueue.main.async {
                        self.navigationController?.present(symbolVc, animated: true, completion: nil)
                    }
                }
            }
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
}

extension MarketsViewController {
    
    func sendUsdtCoinsRequests() {
        network.getMarketStats(srcCurrency: "btc", dstCurrency: "usdt") { (success) in
            if success {
                self.network.getMarketStats(srcCurrency: "eth", dstCurrency: "usdt") { (success) in
                    if success {
                        self.network.getMarketStats(srcCurrency: "ltc", dstCurrency: "usdt") { (success) in
                            if success {
                                self.network.getMarketStats(srcCurrency: "xrp", dstCurrency: "usdt") { (success) in
                                    if success {
                                        self.network.getMarketStats(srcCurrency: "bnb", dstCurrency: "usdt") { (success) in
                                            if success {
                                                self.network.getMarketStats(srcCurrency: "bch", dstCurrency: "usdt") { (seccess) in
                                                    if success {
                                                        self.network.getMarketStats(srcCurrency: "eos", dstCurrency: "usdt") { (seccess) in
                                                            if success {
                                                                self.network.getMarketStats(srcCurrency: "trx", dstCurrency: "usdt") { (seccess) in
                                                                    if success {
                                                                        self.network.getMarketStats(srcCurrency: "xlm", dstCurrency: "usdt") { (seccess) in
                                                                            if success {
                                                                                DispatchQueue.main.async {
                                                                                    self.marketsTableView.reloadData()
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func sendRlsCoinsRequests() {
        network.getMarketStats(srcCurrency: "btc", dstCurrency: "rls") { (success) in
            if success {
                self.network.getMarketStats(srcCurrency: "eth", dstCurrency: "rls") { (success) in
                    if success {
                        self.network.getMarketStats(srcCurrency: "ltc", dstCurrency: "rls") { (success) in
                            if success {
                                self.network.getMarketStats(srcCurrency: "xrp", dstCurrency: "rls") { (success) in
                                    if success {
                                        self.network.getMarketStats(srcCurrency: "bnb", dstCurrency: "rls") { (success) in
                                            if success {
                                                self.network.getMarketStats(srcCurrency: "bch", dstCurrency: "rls") { (seccess) in
                                                    if success {
                                                        self.network.getMarketStats(srcCurrency: "eos", dstCurrency: "rls") { (seccess) in
                                                            if success {
                                                                self.network.getMarketStats(srcCurrency: "trx", dstCurrency: "rls") { (seccess) in
                                                                    if success {
                                                                        DispatchQueue.main.async {
                                                                            self.marketsTableView.reloadData()
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func setMarketsTableViewConstraints() {
        NSLayoutConstraint.activate([
            marketsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            marketsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            marketsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            marketsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func addSegmentedControl() {
        segment.setWidth((view.frame.width / 2) - 10, forSegmentAt: 0)
        segment.setWidth((view.frame.width / 2) - 10, forSegmentAt: 1)
        segment.selectedSegmentIndex = 0
        self.navigationItem.titleView = segment
        segment.selectedSegmentTintColor = .systemGreen
        segment.addTarget(self, action: #selector(segmentValueChanged), for: .allEvents)
    }
    
    @objc func segmentValueChanged() {
        
        marketState.dayChange.removeAll()
        marketState.latestPrice.removeAll()
        marketState.symbol.removeAll()
        marketsTableView.reloadData()
        
        switch segment.selectedSegmentIndex {
        case 0:
            sendUsdtCoinsRequests()
        case 1:
            sendRlsCoinsRequests()
        default:
            break
        }
    }
    
    func presentVc(id: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: id)
        present(vc, animated: true, completion: nil)
    }
}
