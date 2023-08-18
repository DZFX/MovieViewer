//
//  MainGridViewController.swift
//  MovieViewer
//
//  Created by Isaac Delgado on 17/08/23.
//

import UIKit

protocol MainGridPresenterProtocol {
    var title: String { get }
    var categoryTitles: [String] { get }
    var items: [MovieCellModel] { get }

    func fetch(for categoryIndex: Int)
}

class MainGridViewController: ViewController {

    let presenter: MainGridPresenterProtocol

    private lazy var segmentControl = {
        let view = UISegmentedControl(items: presenter.categoryTitles)
        view.selectedSegmentIndex = 0
        view.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        return view
    }()

    private lazy var collectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(cellType: MovieCell.self)
        return collectionView
    }()

    init(presenter: MainGridPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = presenter.title
        setupContent()
    }

    private func setupContent() {
        let contentView = UIStackView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .clear
        contentView.axis = .vertical
        contentView.distribution = .fill
        contentView.alignment = .center
        contentView.spacing = 20
        view.addSubview(contentView)
        contentView.alignEdgesWithSuperview()
        contentView.addArrangedSubview(segmentControl)
        segmentControl.addHorizontalPaddingWithSuperview(offset: 30)
        contentView.addArrangedSubview(collectionView)
        collectionView.addHorizontalPaddingWithSuperview(offset: 25)
    }

    @objc func fetchData() {
        presenter.fetch(for: segmentControl.selectedSegmentIndex)
    }
}

extension MainGridViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        do {
            let cell = try collectionView.dequeueReusableCell(ofType: MovieCell.self, for: indexPath)
            cell.configure(with: presenter.items[indexPath.row])
            return cell
        } catch {
            return UICollectionViewCell()
        }
    }
}

extension MainGridViewController: UICollectionViewDelegate {
}

extension MainGridViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return .zero }
        let emptySpace = flowLayout.minimumInteritemSpacing + flowLayout.sectionInset.left + flowLayout.sectionInset.right
        let cellWidth = (collectionView.bounds.width - emptySpace) / 2
        let height = cellWidth * 2
        return CGSize(width: cellWidth, height: height)
    }
}
