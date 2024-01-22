import UIKit
import SnapKit

enum SetTypes {
    case noParams
    case withSwitch
    case rightButton
}

struct SettingsItem {
    var image: String
    var title: String
    var type: SetTypes
}

protocol settingCellDelegate: AnyObject {
    func didSwitchchOn(isOn: Bool)
}


class SettingsVC: UIViewController {
    
    private var colorTheme: Bool = UserDefaults.standard.bool(forKey: "colorTheme") {
        didSet {
            updateTintColor()
        }
    }
    
    private let cellId = "setting_cell_id"
    private let language = "Русский"
    weak var delegate: settingCellDelegate?
    
    private let settingsItems: [SettingsItem] = [
        .init(image: "language_icon", title: "Язык", type: .rightButton),
        .init(image: "color_theme", title: "Темная тема", type: .withSwitch),
        .init(image: "trash", title: "Очистить данные", type: .noParams),
    ]
    
    private lazy var rightBarButton: UIButton = {
        let view = UIButton(type: .system)
        view.setImage(UIImage(systemName: "gear"), for: .normal)
        return view
    }()
    
    private lazy var settingsTableView: UITableView = {
        let view = UITableView()
        view.dataSource = self
        view.register(SettingsCell.self, forCellReuseIdentifier: cellId)
        return view
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    private func initUI() {
        view.backgroundColor = .systemBackground
        setupNavBar()
        setupSettingsTableView()
    }
    
    private func updateTintColor() {
        if colorTheme {
            rightBarButton.tintColor = .white
            navigationItem.rightBarButtonItem?.tintColor = .white
        }
        else {
            rightBarButton.tintColor = .black
            navigationItem.rightBarButtonItem?.tintColor = .black
        }
    }
    
    private func setupNavBar() {
        let rightButton = UIBarButtonItem(customView: rightBarButton)
        navigationItem.rightBarButtonItem = rightButton
        navigationItem.title = "Settings"
    }
    
    private func setupSettingsTableView() {
        view.addSubview(settingsTableView)
        
        settingsTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(4)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(151)
        }
    }
    
}



extension SettingsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settingsItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SettingsCell
        let item = settingsItems[indexPath.row]
        cell.setupCell(image: item.image, title: item.title, type: item.type)
        cell.delegate = self
        return cell
    }
    
}


extension SettingsVC: SettingCellDelegate {
    
    func didSwitchToggle(isOn: Bool) {
        if isOn {
            view.window?.overrideUserInterfaceStyle = .dark
        }
        else {
            view.window?.overrideUserInterfaceStyle = .light
        }
    }
    
}
