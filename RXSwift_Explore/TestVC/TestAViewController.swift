//
//  TestAViewController.swift
//  RXSwift_Explore
//
//  Created by zhang dekai on 2020/8/16.
//  Copyright © 2020 mr dk. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class TestAViewController: UIViewController {
    
    let bag = DisposeBag()

    private lazy var containerView: UIView = {
        let layerView = UIView()
        layerView.layer.masksToBounds = true
        layerView.layer.cornerRadius = 24
        layerView.backgroundColor = .white
        return layerView
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "vivi_privatecall_payleader_close"), for: .normal)
        return button
    }()
    
    private lazy var coinTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .black)
        label.textAlignment = .center
        label.text = "💰Insufficient Coins"
        return label
    }()
    
    private lazy var coinSubTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto Regular", size: 14)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "🍑Buy coins to answer this call. I'm waiting for you.🍌💦"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBackground()
        addSubviews()
        addActitons()
    }
    
    func addSubviews() {
        view.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(24)
            make.height.equalTo(435 + 24)
        }
        
        let topImage = UIImageView(image: UIImage(named: "vivi_privatecall_payleader"))
        containerView.addSubview(topImage)
        topImage.snp.makeConstraints { (make) in
            make.width.height.equalTo(80)
            make.top.equalTo(28)
            make.centerX.equalToSuperview()
        }
        
        containerView.addSubview(closeButton)
        closeButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(29)
            make.top.equalTo(20)
            make.right.equalTo(-20)
        }
        
        containerView.addSubview(coinTitle)
        coinTitle.snp.makeConstraints { (make) in
            make.top.equalTo(128)
            make.centerX.equalToSuperview()
        }
        
        containerView.addSubview(coinSubTitle)
        coinSubTitle.snp.makeConstraints { (make) in
            make.top.equalTo(coinTitle.snp.bottom).offset(8)
            make.left.equalTo(24)
            make.right.equalTo(-24)
        }
        
        let specialProduct = RecommendProductView()
        containerView.addSubview(specialProduct)
        specialProduct.snp.makeConstraints { (make) in
            make.top.equalTo(coinSubTitle.snp.bottom).offset(16)
            make.left.right.equalToSuperview()
            make.height.equalTo(88)
        }
        
        let popularProduct = RecommendProductView()
        containerView.addSubview(popularProduct)
        popularProduct.snp.makeConstraints { (make) in
            make.top.equalTo(specialProduct.snp.bottom).offset(12)
            make.left.right.equalToSuperview()
            make.height.equalTo(88)
        }
        popularProduct.setPopularUI()
    }
    
    func addActitons() {
        
        closeButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }).disposed(by: bag)
    }
    
    func addBackground() {
        let imageView = UIImageView(image: UIImage(named: "background"))
        view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    class RecommendProductView: UIView {
        
        var goToBuyHandle: (()-> Void)?
        
        let bag = DisposeBag()
        
        private lazy var container: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(red: 0.44, green: 0.06, blue: 1, alpha: 1)
            view.layer.masksToBounds = true
            view.layer.cornerRadius = 15
            view.layer.borderWidth = 0
            return view
        }()
        
        private lazy var discountLabel: UILabel = {
            let label = UILabel()
            label.textColor = .white
            label.textAlignment = .center
            label.backgroundColor = UIColor(red: 1, green: 0.2, blue: 0.33, alpha: 1)
            label.font = .systemFont(ofSize: 13, weight: .medium)
            label.text = "75% OFF"
            return label
        }()
        
        private lazy var coinImage: UIImageView = {
            let view = UIImageView(image: UIImage(named: "vivi_privatecall_paylead_coin1"))
            return view
        }()
        
        private lazy var productTitle: UILabel = {
            let label = UILabel()
            label.textColor = .white
            label.font = .systemFont(ofSize: 20, weight: .medium)
            label.text = "300"
            return label
        }()
        
        private lazy var productSubTitle: UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "Roboto Regular", size: 14)
            label.textColor = UIColor(red: 1, green: 0.81, blue: 0.03, alpha: 1)
            label.text = "Special offer"
            return label
        }()
        
        private lazy var priceTitle: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 16)
            label.textColor = .white
            label.text = " $3.99 "
            return label
        }()
        
        lazy var realPriceButton: UIButton = {
            let button = UIButton()
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = UIColor(red: 0.99, green: 0.38, blue: 0.65, alpha: 1)
            button.setTitle("$0.99", for: .normal)
            button.layer.masksToBounds = true
            button.layer.cornerRadius = 18
            return button
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            addSubview(container)
            container.snp.makeConstraints { (make) in
                make.top.equalTo(16)
                make.left.equalTo(16)
                make.right.equalTo(-16)
                make.height.equalTo(72)
            }
            addSubview(discountLabel)
            discountLabel.snp.makeConstraints { (make) in
                make.width.equalTo(67)
                make.height.equalTo(28)
                make.top.equalToSuperview()
                make.left.equalTo(16)
            }

            container.addSubview(coinImage)
            coinImage.snp.makeConstraints { (make) in
                make.width.height.equalTo(48)
                make.centerY.equalToSuperview()
                make.left.equalTo(24)
            }
            
            container.addSubview(productTitle)
            productTitle.snp.makeConstraints { (make) in
                make.left.equalTo(coinImage.snp.right).offset(16)
                make.top.equalTo(16)
            }
            
            container.addSubview(productSubTitle)
            productSubTitle.snp.makeConstraints { (make) in
                make.left.equalTo(coinImage.snp.right).offset(16)
                make.top.equalTo(productTitle.snp.bottom)
            }
                        
            container.addSubview(realPriceButton)
            realPriceButton.snp.makeConstraints { (make) in
                make.right.equalTo(-12)
                make.centerY.equalToSuperview()
                make.height.equalTo(36)
                make.width.equalTo(84)
            }
            
            realPriceButton.rx.tap
                .subscribe(onNext: { [weak self](tap) in
                    if let block = self?.goToBuyHandle {
                        block()
                    }
            }).disposed(by: bag)
            
            container.addSubview(priceTitle)
            priceTitle.snp.makeConstraints { (make) in
                make.right.equalTo(realPriceButton.snp.left).offset(-8)
                make.centerY.equalToSuperview()
            }

            //MARK: - 绘制从左下到右上的斜线
            // 线的路径
            let linePath = UIBezierPath.init()
            //MARK: 动画
            
            // 起点
            linePath.move(to: CGPoint.init(x: 0, y: 22))
            // 其他点
            linePath.addLine(to: CGPoint.init(x: 50, y: 0))
            //可以添加n多个点 可为折线，直线等
            // linePath.addLine(to: CGPoint.init(x: 90, y: 70))
            
            let lineLayer = CAShapeLayer()
            
            lineLayer.lineWidth = 2
            lineLayer.strokeColor = UIColor.red.cgColor
            lineLayer.path = linePath.cgPath
            lineLayer.fillColor = UIColor.clear.cgColor
            //动画1
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.toValue = 1
            animation.duration = 1
            lineLayer.add(animation, forKey: "")
            priceTitle.layer.addSublayer(lineLayer)
        }
        
        func setPopularUI() {
            container.backgroundColor = .white
            container.layer.borderWidth = 0.5
            container.layer.borderColor = UIColor.lightGray.cgColor
            
            coinImage.image = UIImage(named: "vivi_privatecall_paylead_coin2")
            productTitle.textColor = .black
            productSubTitle.text = "Popular"
            productSubTitle.textColor = UIColor(red: 0.99, green: 0.38, blue: 0.65, alpha: 1)
            priceTitle.isHidden = true
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
