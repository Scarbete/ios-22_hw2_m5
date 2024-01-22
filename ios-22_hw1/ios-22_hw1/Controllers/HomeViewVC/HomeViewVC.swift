import UIKit
import SnapKit



class HomeViewVC: UIViewController {
    
    private var notes: [String] = []
    private var controller: HomeController?
//    private var isColorWhite = ColorTheme.isColorWhite
//    var isColorWhite = UserDefaults.standard.bool(forKey: "colorTheme")
    
    private lazy var leftBarLabel: UILabel = {
        let view = UILabel()
        view.text = "Home"
        view.textColor = UIColor(hex: "#0A84FF")
        view.font = .systemFont(ofSize: 17, weight: .regular)
        return view
    }()
    
    private lazy var rightBarButton: UIButton = {
        let view = UIButton(type: .system)
        view.setImage(UIImage(systemName: "gear"), for: .normal)
        view.tintColor = .black
        view.addTarget(self, action: #selector(rightBarItemTapped), for: .touchUpInside)
        return view
    }()
    
    private lazy var searchTF: UITextField = {
        let view = UITextField()
        view.attributedPlaceholder = NSAttributedString(
            string: "Search",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        view.leftViewMode = .always
        view.rightViewMode = .always
        view.textColor = .black
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor(hex: "#EBEBF5")
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: view.frame.height))
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: view.frame.height))
        let leftButton = UIButton(type: .system)
        leftButton.frame = CGRect(x: 8, y: -11, width: 25, height: 22)
        leftButton.setImage(UIImage(named: "iconSearch"), for: .normal)
        leftButton.tintColor = UIColor(hex: "#626262")
        leftView.addSubview(leftButton)
        view.leftView = leftView
        view.rightView = rightView
        return view
    }()
    
    private lazy var notesLabel: UILabel = {
        let view = UILabel()
        view.text = "Notes"
        view.font = .systemFont(ofSize: 16, weight: .regular)
        view.textColor = UIColor(hex: "#262626")
        return view
    }()
    
    private lazy var notesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 165, height: 100)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.dataSource = self
        view.register(NotesCell.self, forCellWithReuseIdentifier: NotesCell.reuseId)
        return view
    }()
    
    private lazy var addNoteButton: UIButton = {
        let view = UIButton(type: .system)
        view.setImage(UIImage(named: "iconPlus"), for: .normal)
        view.backgroundColor = UIColor(hex: "#FF3D3D")
        view.layer.cornerRadius = 21
        view.tintColor = .white
        return view
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controller = HomeController(view: self)
        controller?.getNotes()
        setupUI()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        isColorWhite = UserDefaults.standard.bool(forKey: "colorTheme")
//        if isColorWhite == false {
//            view.backgroundColor = .white
//        }
//        else {
//            view.backgroundColor = UIColor(hex: "030303")
//        }
//    }
    
    private func setupUI() {
//        view.backgroundColor = .white
        view.backgroundColor = .systemBackground
        setupNavBar()
        setupSearchTF()
        setupNotesLabel()
        setupNotesCollectionView()
        setupAddNoteButton()
    }
    
    
    
    private func setupNavBar() {
        let leftBarItem = UIBarButtonItem(customView: leftBarLabel)
        let rightButton = UIBarButtonItem(customView: rightBarButton)
        self.navigationItem.leftBarButtonItem = leftBarItem
        navigationItem.rightBarButtonItem = rightButton
        navigationItem.title = "Home"
    }
    
    private func setupSearchTF() {
        view.addSubview(searchTF)

        searchTF.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(4)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(36)
        }
    }
    
    private func setupNotesLabel() {
        view.addSubview(notesLabel)
        
        notesLabel.snp.makeConstraints { make in
            make.top.equalTo(searchTF.snp.bottom).offset(22)
            make.horizontalEdges.equalToSuperview().inset(39)
            make.height.equalTo(42)
        }
    }
    
    private func setupNotesCollectionView() {
        view.addSubview(notesCollectionView)
        
        notesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(notesLabel.snp.bottom).offset(40)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(324)
        }
    }
    
    private func setupAddNoteButton() {
        view.addSubview(addNoteButton)
        
        addNoteButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-133)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(42)
        }
    }

    func succesNotes(notes: [String]) {
        self.notes = notes
        notesCollectionView.reloadData()
    }
    
    @objc func rightBarItemTapped(_ sender: UIButton) {
        let vc = SettingsVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension HomeViewVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        notes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NotesCell.reuseId, for: indexPath) as! NotesCell
        cell.setupCell(title: notes[indexPath.row])
        return cell
    }
    
}
