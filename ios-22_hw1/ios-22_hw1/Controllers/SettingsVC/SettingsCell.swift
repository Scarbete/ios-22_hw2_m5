import UIKit
import SnapKit


protocol SettingCellDelegate: AnyObject {
    func didSwitchToggle(isOn: Bool)
}


class SettingsCell: UITableViewCell {
    
    weak var delegate: SettingCellDelegate?
    
    private lazy var leftImage: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    private lazy var rightButton: UIButton = {
        let view = UIButton()
        view.isHidden = true
        view.setTitle("Русский", for: .normal)
        view.setTitleColor(UIColor(hex: "#0E0E0E"), for: .normal)
//        view.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        return view
    }()
    
    private lazy var switchButton: UISwitch = {
        let view = UISwitch()
        view.isHidden = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initCellUI() {
        setupLeftImage()
        setupTitleLabel()
        setupRightButton()
        setupSwitchButton()
    }
    
    private func setupLeftImage() {
        contentView.addSubview(leftImage)
        
        leftImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(22)
        }
    }
    
    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)

        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(leftImage.snp.trailing).offset(15)
        }
    }

    private func setupRightButton() {
        contentView.addSubview(rightButton)

        rightButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-24)
        }
    }

    private func setupSwitchButton() {
        contentView.addSubview(switchButton)
        
        let colorTheme = UserDefaults.standard.bool(forKey: "colorTheme")
        
        if colorTheme == true {
            switchButton.isOn = true
        }
        else {
            switchButton.isOn = false
        }

        switchButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-24)
        }
        
        switchButton.addTarget(self, action: #selector(switchButtonToggle), for: .valueChanged)
    }
    
    func setupCell(image: String, title: String, type: SetTypes) {
        leftImage.image = UIImage(named: image)
        titleLabel.text = title
        switch type {
            case .rightButton:
                rightButton.isHidden = false
            case .withSwitch:
                switchButton.isHidden = false
            default: ()
        }
    }
    
    @objc func switchButtonToggle(_ sender: UISwitch) {
        if switchButton.isOn == true {
            delegate?.didSwitchToggle(isOn: true)
            UserDefaults.standard.set(true, forKey: "colorTheme")
        }
        else {
            delegate?.didSwitchToggle(isOn: false)
            UserDefaults.standard.set(false, forKey: "colorTheme")
        }
    }
    
}
