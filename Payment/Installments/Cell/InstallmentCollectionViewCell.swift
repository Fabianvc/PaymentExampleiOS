import UIKit

class InstallmentCollectionViewCell: UICollectionViewCell {
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

    func configureUI() {
        contentView.clipsToBounds = true
        contentView.addSubview(viewObtain)
        
        viewObtain.addSubview(viewPlaceHolderObtain)
        viewPlaceHolderObtain.addSubview(labelTitle)
        contentView.addBottomBorder(Colors.lightGray, height: 1)
    }

    func setupConstraints() {
        viewObtain.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.left.equalToSuperview().offset(30)
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

extension InstallmentCollectionViewCell {
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
