import UIKit
import SnapKit



class OnBoardCell: UICollectionViewCell {
    
    static let reuseId = "onBoardCell"
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(hex: "#282A32")
        view.font = .systemFont(ofSize: 22, weight: .bold)
        view.textAlignment = .center
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(hex: "#40424C")
        view.font = .systemFont(ofSize: 14, weight: .regular)
        view.textAlignment = .left
        view.numberOfLines = 0
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initUI() {
        setupImageView()
        setupTitleLabel()
        setupDescriptionLabel()
    }
    
    private func setupImageView() {
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(136)
            make.centerX.equalToSuperview()
            make.width.equalTo(212)
            make.height.equalTo(140)
        }
    }
    
    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(52)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupDescriptionLabel() {
        contentView.addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(310)
        }
    }
    
    func setupCell(image: String, title: String, description: String) {
        imageView.image = UIImage(named: image)
        titleLabel.text = title
        descriptionLabel.text = description
    }
    
}
