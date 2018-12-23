//
//  MainViewController.swift
//  TopBarMenuDemo
//
//  Created by Min on 2018/12/2.
//  Copyright © 2018 Min. All rights reserved.
//

import UIKit

class MainViewController: ParentViewController {
    
    var titleList = [DemoTestViewModel]() {
        didSet {
            topBarMenuView.titleList = titleList
            mainCollectionView.reloadData()
        }
    }
    
    fileprivate var selectIndex: CGFloat = 0    //當前的頁數
    fileprivate var isTopBarSelect = false
    fileprivate var topBarSelectIndex: CGFloat = 0
    
    lazy private var topBarMenuView: TopBarMenuView = {
        return TopBarMenuView(y: naviHeight + statusBarHeigth, delegate: self)
    }()
    
    lazy private var mainCollectionView: UICollectionView = {
        let y = naviHeight + statusBarHeigth + 50
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - y)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        let view = UICollectionView(frame: CGRect(x: 0, y: y, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - y), collectionViewLayout: flowLayout)
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .clear
        view.isPagingEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUserInterface()
    }
    
    // MARK: - private Method
    
    private func setUserInterface() {
        navigationItem.title = "Demo"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "setData", style: .plain, target: self, action: #selector(leftButtonDidPressed))
        view.addSubview(topBarMenuView)
        view.addSubview(mainCollectionView)
    }
    
    private func getTopBarCell(item: Int) -> UICollectionViewCell {     //拿取TopBarCell
        return topBarMenuView.collectionView.dequeueReusableCell(withReuseIdentifier: TopBarMeunCollectionCell.identifier, for: IndexPath(item: item, section: 0))
    }
    
    fileprivate func didSelectTopBar(index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        mainCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    // MARK: - action Method
    
    @objc private func leftButtonDidPressed() {
        titleList = [.red, .green, .colorForBlue, .orange, .lightGray]
    }
}

    // MARK: - UICollectionViewDelegate

extension MainViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 低於0或是最後一頁超過最大值就不做動作
        guard scrollView.contentOffset.x > 0, (scrollView.contentOffset.x + UIScreen.main.bounds.width) < scrollView.contentSize.width else { return }
        
        let startX = scrollView.contentOffset.x / UIScreen.main.bounds.width    //拿到當前頁數
        
        let nextIndex = startX >= selectIndex ? selectIndex + 1 : selectIndex - 1   //取到下一頁頁數
        
        let startCell = getTopBarCell(item: Int(selectIndex))   //拿取當前Cell
        
        let nextCell = getTopBarCell(item: !isTopBarSelect ? Int(nextIndex) : Int(topBarSelectIndex))   //拿取下一個Cell(如果tabbar點擊的話就拿topBar的 不然就拿下一個index)
        
        let proportion = (startX - selectIndex) / ((topBarSelectIndex - selectIndex) > 0 ? (topBarSelectIndex - selectIndex) : (topBarSelectIndex - selectIndex) * -1)  //
        
        let xRation: CGFloat = !isTopBarSelect ? (startX - selectIndex) : proportion    //拿到目前的index到下一個index的間距數字
        
        if startCell.frame.origin.x >= nextCell.frame.origin.x {       //設定bottomView的x
            //往右滑
            topBarMenuView.bottomBarView.frame.origin.x = startCell.frame.origin.x - ((nextCell.frame.origin.x - startCell.frame.minX) * xRation)
        } else {
            //往左滑
            topBarMenuView.bottomBarView.frame.origin.x = startCell.frame.origin.x + ((nextCell.frame.origin.x - startCell.frame.minX) * xRation )
        }
        
        let widthRation = !isTopBarSelect ? ((startX - selectIndex) > 0 ? (startX - selectIndex) : (startX - selectIndex) * -1) : (xRation >= 0 ? xRation : xRation * -1)   //拿到目前的index到下一個index的間距數字
        
        if startCell.frame.width > nextCell.frame.width {   //設定bottomView的寬
            // 起始Cell寬大於下一個Cell的寬
            let width = startCell.frame.width - ((startCell.frame.width - nextCell.frame.width) * widthRation)
            topBarMenuView.bottomBarView.frame.size.width = width
        } else {
            // 起始Cell寬低於下一個Cell的寬
            let width = startCell.frame.width + ((nextCell.frame.width - startCell.frame.width) * widthRation)
            topBarMenuView.bottomBarView.frame.size.width = width
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // 滑動Cell結束的時候要做的事
        let index = scrollView.contentOffset.x / UIScreen.main.bounds.width     //最後的index
        let indexPath = IndexPath(item: Int(index), section: 0)
        
        topBarMenuView.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        let cell = getTopBarCell(item: Int(index))      //拿到停止Cell
        if topBarMenuView.bottomBarView.frame.minX != cell.frame.minX || topBarMenuView.bottomBarView.frame.size.width != cell.frame.width {    //只要x跟width不符合就執行
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.topBarMenuView.bottomBarView.frame.origin.x = cell.frame.minX
                self?.topBarMenuView.bottomBarView.frame.size.width = cell.frame.width
                
            }
        }
        selectIndex = index
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        //點擊TabBar滑動動畫結束後要做的事
        selectIndex = scrollView.contentOffset.x / UIScreen.main.bounds.width
        isTopBarSelect = false
        if topBarSelectIndex != 0 {
            topBarSelectIndex = 0
        }
    }
}

    // MARK: - UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as! MainCollectionViewCell
        switch titleList[indexPath.row] {
        case .red:
            cell.backgroundColor = .red
        case .orange:
            cell.backgroundColor = .orange
        case .colorForBlue:
            cell.backgroundColor = .blue
        case .green:
            cell.backgroundColor = .green
        case .lightGray:
            cell.backgroundColor = .lightGray
        }
        return cell
    }
}

    // MARK: - TopBarMeunDelegate

extension MainViewController: TopBarMeunDelegate {
    func topBarDidSelecrIndex(index: Int) {
        isTopBarSelect = true
        topBarSelectIndex = CGFloat(index)
        didSelectTopBar(index: index)
    }
}
