import UIKit
import SnapKit



class OnBoardVC: UIViewController {
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    private let onBoardItems: [OnBoardModel] = [
        OnBoardModel(image: "onBoardImage1", title: "Welcome to The Note", description: "Welcome to The Note – your new companion for tasks, goals, health – all in one place. Let's get started!"
        ),
        OnBoardModel(image: "onBoardImage2", title: "Set Up Your Profile", description: "Now that you're with us, let's get to know each other better. Fill out your profile, share your interests, and set your goals."
        ),
        OnBoardModel(image: "onBoardImage3", title: "Dive into The Note", description: "You're fully equipped to dive into the world of The Note. Remember, we're here to assist you every step of the way. Ready to start? Let's go!"
        )
    ]
    
    private lazy var onBoardCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: screenWidth, height: screenHeight)
        layout.minimumLineSpacing = 0
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.dataSource = self
        view.delegate = self
        view.register(OnBoardCell.self, forCellWithReuseIdentifier: OnBoardCell.reuseId)
        view.isPagingEnabled = true
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    private lazy var skipButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Skip", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        view.setTitleColor(UIColor(hex: "#FF3D3D"), for: .normal)
        return view
    }()
    
    private lazy var nextButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Next", for: .normal)
        view.backgroundColor = UIColor(hex: "#FF3D3D")
        view.layer.cornerRadius = 20
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        view.titleLabel?.textAlignment = .center
        return view
    }()
    
    private lazy var onBoardPageControll: UIPageControl = {
        let view = UIPageControl()
        view.direction = .leftToRight
        view.numberOfPages = onBoardItems.count
        view.currentPage = 0
        view.pageIndicatorTintColor = .lightGray
        view.currentPageIndicatorTintColor = .black

        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    private func initUI() {
        view.backgroundColor = .white
        setupOnBoardCW()
        setupOnBoardPageControll()
        setupSkipButton()
        setupNextButton()
    }
    
    private func setupOnBoardCW() {
        view.addSubview(onBoardCollectionView)
        
        onBoardCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupOnBoardPageControll() {
        view.addSubview(onBoardPageControll)
        
        onBoardPageControll.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-266)
            make.centerX.equalToSuperview()
            make.width.equalTo(173)
            make.height.equalTo(42)
        }
        
        onBoardPageControll.addTarget(self, action: #selector(pageControlValueChanged), for: .valueChanged)
    }
    
    private func setupSkipButton() {
        view.addSubview(skipButton)
        
        skipButton.snp.makeConstraints { make in
            make.top.equalTo(onBoardPageControll.snp.bottom).offset(130)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(173)
            make.height.equalTo(42)
        }
        
        skipButton.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
    }
    
    private func setupNextButton() {
        view.addSubview(nextButton)
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(skipButton.snp.top)
            make.leading.equalTo(skipButton.snp.trailing).offset(16)
            make.width.equalTo(173)
            make.height.equalTo(42)
        }
        
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    private func scrollViewDidScroll(_ collectionView: UICollectionView) {
        let pageIndex = round(collectionView.contentOffset.x / collectionView.frame.width)
        onBoardPageControll.currentPage = Int(pageIndex)
    }
    
    @objc func skipButtonTapped(_ sender: UIButton) {
        let vc = HomeViewVC()
        UserDefaults.standard.set(true, forKey: "isOnBoardShow")
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func pageControlValueChanged() {
        let currentPage = onBoardPageControll.currentPage
        let newOffset = CGPoint(x: CGFloat(currentPage) * onBoardCollectionView.frame.width, y: -95)
        onBoardCollectionView.setContentOffset(newOffset, animated: true)
    }
    
    @objc func nextButtonTapped(_ sender: UIButton) {
        let currentPage = onBoardPageControll.currentPage
        
        if currentPage == 2 {
            let vc = HomeViewVC()
            UserDefaults.standard.set(true, forKey: "isOnBoardShow")
            navigationController?.pushViewController(vc, animated: true)
        }
        else {
            onBoardPageControll.currentPage += 1
            
            let newCurrentPage = onBoardPageControll.currentPage
            let newOffset = CGPoint(x: CGFloat(newCurrentPage) * onBoardCollectionView.frame.width, y: -95)
            onBoardCollectionView.setContentOffset(newOffset, animated: true)
        }
    }
    
}

extension OnBoardVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        onBoardItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnBoardCell.reuseId, for: indexPath) as! OnBoardCell
        let item = onBoardItems[indexPath.row]
        cell.setupCell(image: item.image, title: item.title, description: item.description)
        return cell
    }
    
}

extension OnBoardVC: UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOfSet = scrollView.contentOffset.x
        let page = contentOfSet / screenWidth
        
        onBoardPageControll.currentPage = Int(page)
        
        if Int(page) == onBoardItems.count - 1 {
            UserDefaults.standard.set(true, forKey: "isOnBoardShow")
        }
    }
    
}
