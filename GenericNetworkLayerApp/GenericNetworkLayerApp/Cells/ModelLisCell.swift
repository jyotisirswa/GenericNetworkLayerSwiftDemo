//
//  ModelLisCell.swift
//  GenericNetworkLayerApp
//
//  Created by Jyoti - LetsWork on 1/13/24.
//

import UIKit

extension ModelLisCell : ViewModelInjectable {
    func configureWithViewModel(_ model: Model) {
        if model.name == "Alien Rick" {
            //UnComment this its for testing only
            titleLabel.text = "stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),contentView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 20),contentView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10)"
        } else {
            titleLabel.text = model.name
        }
        Task {
            do {
                try await profileImageView.loadImageUsingCacheWithURLStringTwo(model.image, placeHolder: nil)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}


class ModelLisCell: UITableViewCell {

    static let reuseID  = "ModelLisCell"
    private lazy var indicatorView: UIActivityIndicatorView! = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.style = .large
        indicator.startAnimating()
        return indicator
    }()
    private var valueObservation : NSKeyValueObservation!
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .title2 )
       // label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var titleLabelTwo: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .brown
        label.font = .preferredFont(forTextStyle: .title3)
        label.text = "djdksjdlskdjslkdjsd"
       // label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12.0
        imageView.clipsToBounds = true
        imageView.backgroundColor = .cyan
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCEll()
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCEll() {
        let marginGuide = contentView.layoutMarginsGuide
        let stackView = UIStackView(arrangedSubviews: [titleLabel, titleLabelTwo])
        stackView.spacing = 0
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.backgroundColor = .yellow
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubviews(profileImageView, stackView, indicatorView)
        stackView.accessibilityIdentifier = "characterImage"
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 10),
            profileImageView.heightAnchor.constraint(equalToConstant: 90),
            profileImageView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 90),
            profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: profileImageView.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor),
            stackView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 10),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: stackView.bottomAnchor, constant: 10),
            indicatorView.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor)
        ])
//        let constraint = titleLabelTwo.heightAnchor.constraint(equalTo: titleLabelTwo.heightAnchor)
//        constraint.priority = UILayoutPriority(1000)
//        constraint.isActive = true
//        titleLabelTwo.setContentHuggingPriority(UILayoutPriority(999) , for: .vertical)
        valueObservation = profileImageView.observe(\.image, options: [.new]) { [unowned self] observed, change in
          if change.newValue is UIImage {
            indicatorView.stopAnimating()
          }
        }
    }
    deinit {
        self.valueObservation.invalidate()
    }
}
extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
}
