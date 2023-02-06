import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    private lazy var viewGrant: UIView = setupView()
    private lazy var viewObtain: UIView = setupView()
    private lazy var viewPlaceHolderObtain: UIView = setupViewPlaceHolderObtain()

    lazy var avatarUrl: UIImageView = setupAvatarUrl()
    lazy var labelTitle: UILabel = setupLabelTitle()
    
    // MARK: - Setup
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
        self.setupConstraints()
    }
    
    private func configureUI() {
        contentView.clipsToBounds = true
        contentView.addSubview(viewGrant)
        contentView.addSubview(viewObtain)
        
        viewGrant.addSubview(avatarUrl)
        viewObtain.addSubview(viewPlaceHolderObtain)
        viewPlaceHolderObtain.addSubview(labelTitle)
        contentView.addBottomBorder(Colors.lightGray, height: 2)
    }
    
    private func setupConstraints() {
        viewGrant.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.width.equalTo(60)
            $0.left.equalToSuperview().offset(10)
            $0.top.equalToSuperview()
        }
        
        avatarUrl.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.width.equalTo(40)
            $0.center.equalToSuperview()
        }
        
        viewObtain.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.left.equalTo(viewGrant.snp.right)
            $0.right.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        viewPlaceHolderObtain.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        labelTitle.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Components

extension CardCollectionViewCell {
    func setupView() -> UIView {
        let viewGrant = UIView()
        viewGrant.translatesAutoresizingMaskIntoConstraints = false
        viewGrant.backgroundColor = Colors.black
        viewGrant.clipsToBounds = true

        return viewGrant
    }

    func setupAvatarUrl() -> UIImageView {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = Colors.white

        return image
    }

    func setupViewPlaceHolderObtain() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }

    func setupLabelTitle() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.white
        label.textAlignment = .left
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail

        return label
    }
}

