//
//  DashboardChart.swift
//  DPE Dashboard
//
//  Created by Muhammad Yusuf on 12/25/17.
//  Copyright © 2017 Department Power Plant & Energy. All rights reserved.
//

import UIKit
import Charts

@IBDesignable class DashboardChart: UIView {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    var valueLabel: UILabel? = nil
    var titleLabel: UILabel? = nil
    var detailsButton: UIButton? = nil
    var legend1Label: UILabel? = nil
    var legend1Circle: UIView? = nil
    var legend2Label: UILabel? = nil
    var legend2Circle: UIView? = nil
    var chart: LineChartView? = nil
    var chartData: LineChartData? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabels()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLabels()
    }
    
    @IBInspectable var valueLabelText: String = "0.00" {
        didSet {
            setupLabels()
        }
    }
    
    @IBInspectable var valueLabelColor: UIColor = UIColor.black {
        didSet {
            setupLabels()
        }
    }
    
    @IBInspectable var title: String = "Title" {
        didSet {
            setupLabels()
        }
    }
    
    @IBInspectable var titleColor: UIColor = UIColor.black {
        didSet {
            setupLabels()
        }
    }
    
    @IBInspectable var legend1: String = "Legend 1" {
        didSet {
            setupLabels()
        }
    }
    
    @IBInspectable var legend1Color: UIColor = UIColor.black {
        didSet {
            setupLabels()
        }
    }
    
    @IBInspectable var legend2: String = "Legend 2" {
        didSet {
            setupLabels()
        }
    }
    
    @IBInspectable var legend2Color: UIColor = UIColor.black {
        didSet {
            setupLabels()
        }
    }
    
    @IBInspectable var circle1Color: UIColor = UIColor.gray {
        didSet {
            setupLabels()
        }
    }
    
    @IBInspectable var circle2Color: UIColor = UIColor.gray {
        didSet {
            setupLabels()
        }
    }
    
    private func setupLabels() {
        setupValueLabel()
        setupTitleLabel()
        setupButton()
        setupLegend1Label()
        setupLegend1Circle()
        setupLegend2Label()
        setupLegend2Circle()
        setupChart()
    }
    
    private func setupValueLabel() {
        
        if self.valueLabel != nil {
            self.valueLabel?.removeFromSuperview()
        } else {
            self.valueLabel = UILabel()
        }
        
        let valueLabel = self.valueLabel!
        valueLabel.text = valueLabelText
        valueLabel.textColor = valueLabelColor
        valueLabel.font = UIFont.systemFont(ofSize: 36.0, weight: UIFont.Weight.ultraLight)
        valueLabel.adjustsFontSizeToFitWidth = true
        valueLabel.minimumScaleFactor = 0.5
        
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        valueLabel.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
        let margins = self.layoutMarginsGuide
        
        addSubview(valueLabel)
        
        valueLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 25).isActive = true
        valueLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: 1).isActive = true
    }
    
    private func setupTitleLabel() {
        
        if self.titleLabel != nil {
            self.titleLabel?.removeFromSuperview()
        } else {
            self.titleLabel = UILabel()
        }
        
        let titleLabel = self.titleLabel!
        titleLabel.text = title
        titleLabel.textColor = titleColor
        titleLabel.font = UIFont.systemFont(ofSize: 17.0, weight: UIFont.Weight.ultraLight)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let margins = self.layoutMarginsGuide
        
        addSubview(titleLabel)
        
        titleLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 25).isActive = true
        titleLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: 31).isActive = true
    }
    
    private func setupButton() {
        
        if self.detailsButton != nil {
            self.detailsButton?.removeFromSuperview()
        } else {
            self.detailsButton = UIButton(frame: CGRect(x: 0, y: 0, width: 75, height: 20))
        }
        
        let detailsButton = self.detailsButton!
        detailsButton.backgroundColor = .white
        detailsButton.layer.cornerRadius = 18
        detailsButton.layer.borderWidth = 1
        detailsButton.layer.borderColor = UIColor.white.cgColor
        detailsButton.setTitleColor(.black, for: .normal)
        detailsButton.setTitle("Details", for: .normal)
        detailsButton.addTarget(self, action: #selector(DashboardChart.detailsButtonTapped(button:)), for: .touchUpInside)
        
        detailsButton.translatesAutoresizingMaskIntoConstraints = false
        detailsButton.heightAnchor.constraint(equalToConstant: 37.0).isActive = true
        detailsButton.widthAnchor.constraint(equalToConstant: 85.0).isActive = true
        let margins = self.layoutMarginsGuide
        
        addSubview(detailsButton)
        
        detailsButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 160).isActive = true
        detailsButton.topAnchor.constraint(equalTo: margins.topAnchor, constant: 10).isActive = true
    }
    
    @objc func detailsButtonTapped(button: UIButton) {
        print("Button pressed")
    }
    
    private func setupLegend1Label() {
        if self.legend1Label != nil {
            self.legend1Label?.removeFromSuperview()
        } else {
            self.legend1Label = UILabel()
        }
        
        let legend1Label = self.legend1Label!
        legend1Label.text = legend1
        legend1Label.textColor = legend1Color
        legend1Label.font = UIFont.systemFont(ofSize: 15.0, weight: UIFont.Weight.ultraLight)
        
        legend1Label.translatesAutoresizingMaskIntoConstraints = false
        let margins = self.layoutMarginsGuide
        
        addSubview(legend1Label)
        
        legend1Label.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 42).isActive = true
        legend1Label.topAnchor.constraint(equalTo: margins.topAnchor, constant: 60).isActive = true
    }
    
    private func setupLegend1Circle() {
        if self.legend1Circle != nil {
            self.legend1Circle?.removeFromSuperview()
        } else {
            self.legend1Circle = UIView()
        }
        
        let legend1Circle = self.legend1Circle!
        legend1Circle.backgroundColor = UIColor.clear
        legend1Circle.translatesAutoresizingMaskIntoConstraints = false
        legend1Circle.heightAnchor.constraint(equalToConstant: 5.0).isActive = true
        legend1Circle.widthAnchor.constraint(equalToConstant: 5.0).isActive = true
        let margins = self.layoutMarginsGuide
        
        addSubview(legend1Circle)
        
        legend1Circle.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 30).isActive = true
        legend1Circle.topAnchor.constraint(equalTo: margins.topAnchor, constant: 69).isActive = true
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 0,y: 0), radius: CGFloat(5), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = circle1Color.cgColor
        legend1Circle.layer.addSublayer(shapeLayer)
    }
    
    private func setupLegend2Label() {
        if self.legend2Label != nil {
            self.legend2Label?.removeFromSuperview()
        } else {
            self.legend2Label = UILabel()
        }
        
        let legend2Label = self.legend2Label!
        legend2Label.text = legend2
        legend2Label.textColor = legend2Color
        legend2Label.font = UIFont.systemFont(ofSize: 15.0, weight: UIFont.Weight.ultraLight)
        
        legend2Label.translatesAutoresizingMaskIntoConstraints = false
        let margins = self.layoutMarginsGuide
        
        addSubview(legend2Label)
        
        legend2Label.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 130).isActive = true
        legend2Label.topAnchor.constraint(equalTo: margins.topAnchor, constant: 60).isActive = true
    }
    
    private func setupLegend2Circle() {
        if self.legend2Circle != nil {
            self.legend2Circle?.removeFromSuperview()
        } else {
            self.legend2Circle = UIView()
        }
        
        let legend2Circle = self.legend2Circle!
        legend2Circle.backgroundColor = UIColor.clear
        legend2Circle.translatesAutoresizingMaskIntoConstraints = false
        legend2Circle.heightAnchor.constraint(equalToConstant: 5.0).isActive = true
        legend2Circle.widthAnchor.constraint(equalToConstant: 5.0).isActive = true
        let margins = self.layoutMarginsGuide
        
        addSubview(legend2Circle)
        
        legend2Circle.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 118).isActive = true
        legend2Circle.topAnchor.constraint(equalTo: margins.topAnchor, constant: 69).isActive = true
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 0,y: 0), radius: CGFloat(5), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = circle2Color.cgColor
        legend2Circle.layer.addSublayer(shapeLayer)
    }
    
    private func setupChart() {
        
        if self.chart != nil {
            self.chart?.removeFromSuperview()
        } else {
            self.chart = LineChartView()
        }
        
        let chart = self.chart!
        
        chart.translatesAutoresizingMaskIntoConstraints = false
        let margins = self.layoutMarginsGuide
        
        addSubview(chart)
        chart.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        chart.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 0).isActive = true
        chart.topAnchor.constraint(equalTo: margins.topAnchor, constant: 90).isActive = true
        chart.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: 8).isActive = true
        
        chart.leftAxis.spaceBottom = 0
        
        chart.xAxis.labelPosition = .top
        chart.chartDescription?.text = ""
        chart.pinchZoomEnabled = true
        
        chart.drawBordersEnabled = false
        chart.rightAxis.enabled = false
        
        
        chart.xAxis.gridColor = UIColor.lightGray
        chart.legend.enabled = false
        
        chart.xAxis.labelTextColor = UIColor.white
        chart.xAxis.drawAxisLineEnabled = false
        
        chart.leftAxis.enabled = false
        
        let marker:BalloonMarker = BalloonMarker(color: UIColor.white, font: UIFont(name: "Helvetica", size: 12)!, textColor: UIColor.black, insets: UIEdgeInsets(top: 7.0, left: 7.0, bottom: 7.0, right: 7.0))
        marker.minimumSize = CGSize(width: 75.0, height: 35.0)
        chart.marker = marker
        
        chart.setViewPortOffsets(left: 0, top: 15, right: 0, bottom: 5)
    }
    
    func setChartData(chartData: LineChartData, xValues: [String]) {
        self.chartData = chartData
        chart?.xAxis.valueFormatter = IndexAxisValueFormatter(values: xValues)
        chart?.xAxis.granularity = 1.0
        chart?.data = self.chartData!
    }
    
    func clearChartData() {
        chart?.data = nil
        chart?.clear()
    }
    
    func zoom(xValue: Double, yValue: Double) -> Void {
        chart?.zoomAndCenterViewAnimated(scaleX: 2.0, scaleY: 3.0, xValue: xValue, yValue: yValue, axis: YAxis.AxisDependency.left, duration: TimeInterval(1))
    }
    
    func setValueCaption(caption: String) {
        valueLabel?.text = caption
    }
}
