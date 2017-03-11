//
//  PageTitleView.swift
//  DYDemo
//
//  Created by 这个夏天有点冷 on 2017/3/8.
//  Copyright © 2017年 YLT. All rights reserved.
//

import UIKit

//  MARK:定义协议
protocol PageTitleViewDelegate : class {        //  后跟class，表示只能被类遵守
    func pageTitleView(titleView : PageTitleView, selectedIndex index : Int)
}

//  MARK:定义常亮
private let kScrollLineH : CGFloat = 2
private let kNomalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

//  MARK:定义类
class PageTitleView: UIView {

    // MARK:定义属性
    var currentIndex : Int = 0
    var titles : [String]
    
    //  定义代理
    weak var delegate : PageTitleViewDelegate?
    
    //  MARK: 懒加载属性
    lazy var titleLabels : [UILabel] = [UILabel]()
    
    lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView.init()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        
        return scrollView
    }()
    
    //  创建底部滑动线
    lazy var scrollLine : UIView = {
        let scrollLine  = UIView.init()
        scrollLine.backgroundColor = UIColor.init(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        
        return scrollLine
    }()
    
    // MARK: 自定义构造函数
    init(frame: CGRect, titles:[String]) {
        self.titles = titles
        
        super.init(frame: frame)
        
        //  设置界面
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//  MARK: 设置UI界面
extension PageTitleView {
    func setUI() {
        //  1.添加scrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        //  2.设置title对应的label
        setupTitleLabels()
        
        //  3.设置底线和滚动的滑块
        setupBottomMenuAndScrollLine()
    }
    
    //  设置label
    func setupTitleLabels() {
        
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelY : CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            //  创建label
            let label = UILabel.init()
            
            //  设置label的属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor.init(r: kNomalColor.0, g: kNomalColor.1, b: kNomalColor.2)
            label.textAlignment = .center
            
            //  设置frame
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect.init(x: labelX, y: labelY, width: labelW, height: labelH)
            
            //  将label添加到scrollView中
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            //  给label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(self.titleLabelClicked(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    
    func setupBottomMenuAndScrollLine() {
        //  创建底线
        let bottomLine = UIView.init()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect.init(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        //  添加scrollLine
        guard let firstLabel = titleLabels.first else {
            return
        }
        firstLabel.textColor = UIColor.init(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect.init(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.size.width, height: kScrollLineH)
    }
}

//  MARK: 监听label的点击
extension PageTitleView {
    //  如果是事件监听，需要用到@objc
    @objc func titleLabelClicked(tapGes : UITapGestureRecognizer) {
        //  1.获取当前label的下标值
        guard let currentLabel = tapGes.view as? UILabel else { return }
        
        //  2.获取之前的label
        let oldLabel = titleLabels[currentIndex]
        
        //  3.切换文字的颜色
        currentLabel.textColor = UIColor.init(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        oldLabel.textColor = UIColor.init(r: kNomalColor.0, g: kNomalColor.1, b: kNomalColor.2)
        
        //  4.保存最新label的下标志
        currentIndex = currentLabel.tag
        
        //  5.滚动条位置发生改变
        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        
        UIView.animate(withDuration: 0.15) { 
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        //  6.通知代理做事情
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
}

//  MARK:对外暴露方法
extension PageTitleView {
    func setTitleWithProgress(prog : CGFloat, sourceIndex : Int, targerIndex : Int) {
        //  1、取出sourceLabel/targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targerIndex]
        
        //  2.处理滑块逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * prog
        
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //  3.颜色渐变
        //  3.1 取出变化范围
        let colorDelta = (kSelectColor.0 - kNomalColor.0, kSelectColor.1 - kNomalColor.1, kSelectColor.2 - kNomalColor.2)
        
        //  3.2 变化sourceLabel
        sourceLabel.textColor = UIColor.init(r: kSelectColor.0 - colorDelta.0 * prog, g: kSelectColor.1 - colorDelta.1 * prog, b: kSelectColor.2 - colorDelta.2 * prog)
        
        //  3.3 变化targetLabel
        targetLabel.textColor = UIColor.init(r: kNomalColor.0 + colorDelta.0 * prog, g: kNomalColor.1 + colorDelta.1 * prog, b: kNomalColor.2 + colorDelta.2 * prog)
        
        //  4.记录最新的index
        currentIndex = targerIndex
        
    }
}
