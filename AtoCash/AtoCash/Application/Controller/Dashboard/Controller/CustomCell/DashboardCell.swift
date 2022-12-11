//
//  DashboardCell.swift
//  AtoCash
//
//  Created by user on 05/05/21.
//

import UIKit

class DashboardCell: UICollectionViewCell {
    @IBOutlet weak var baseView: CSCustomViewCell!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblCOunt: UILabel!
    
    @IBOutlet weak var chartBtn: UIButton!
    @IBOutlet weak var pieChartView: PieChartView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setup(pieChartView: self.pieChartView)
        pieChartView.delegate = self
        
    }
    func setup(pieChartView chartView: PieChartView) {
        chartView.usePercentValuesEnabled = true
        chartView.drawSlicesUnderHoleEnabled = false
        chartView.holeRadiusPercent = 0.58
        chartView.transparentCircleRadiusPercent = 0.68
        chartView.chartDescription.enabled = false
        chartView.setExtraOffsets(left: 5, top: 10, right: 5, bottom: 5)
        
        chartView.drawCenterTextEnabled = false
        
        let paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.alignment = .center
        
//        let centerText = NSMutableAttributedString(string: "Charts\nby Daniel Cohen Gindi")
//        centerText.setAttributes([.font : UIFont(name: "HelveticaNeue-Light", size: 13)!,
//                                  .paragraphStyle : paragraphStyle], range: NSRange(location: 0, length: centerText.length))
//        centerText.addAttributes([.font : UIFont(name: "HelveticaNeue-Light", size: 11)!,
//                                  .foregroundColor : UIColor.gray], range: NSRange(location: 10, length: centerText.length - 10))
//        centerText.addAttributes([.font : UIFont(name: "HelveticaNeue-Light", size: 11)!,
//                                  .foregroundColor : UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)], range: NSRange(location: centerText.length - 19, length: 19))
//        chartView.centerAttributedText = centerText;
        chartView.centerText = ""
        
        chartView.drawHoleEnabled = true
        chartView.rotationAngle = 0
        chartView.rotationEnabled = true
        chartView.highlightPerTapEnabled = true
        
        let l = chartView.legend
        l.horizontalAlignment = .right
        l.verticalAlignment = .top
        l.orientation = .vertical
        l.drawInside = false
        l.xEntrySpace = 7
        l.yEntrySpace = 0
        l.yOffset = 0
        drawpieChartData()
    }
    
    func drawpieChartData(){
        pieChartView.delegate = self
        
        let l = pieChartView.legend
        l.verticalAlignment = .center
        l.verticalAlignment = .bottom
        l.orientation = .horizontal
        l.xEntrySpace = 7
        l.yEntrySpace = 0
        l.yOffset = 0
        // entry label styling
        pieChartView.entryLabelColor = .clear
        pieChartView.entryLabelFont = .systemFont(ofSize: 12, weight: .light)
        pieChartView.animate(xAxisDuration: 1.4, easingOption: .easeOutBack)
    }
    func setDataCount(_ count: RequestCountModel) {
        let entries = [PieChartDataEntry(value: Double(count.approvedCount!),
                                         label: NSLocalizedString("approve", comment: "")),PieChartDataEntry(value: Double(count.pendingCount!),
                                                                              label: NSLocalizedString("pending", comment: "pending")),PieChartDataEntry(value: Double(count.rejectedCount!),
                                                                                                                   label: NSLocalizedString("reject", comment: ""))]
        let set = PieChartDataSet(entries: entries, label: "")
        set.drawIconsEnabled = false
        set.sliceSpace = 2
        
        
        set.colors = [UIColor(red: 42/255, green: 217/255, blue: 138/255, alpha: 1),UIColor(red: 242/255, green: 183/255, blue: 48/255, alpha: 1), UIColor(red: 230/255, green: 44/255, blue: 33/255, alpha: 1)]
        
        let data = PieChartData(dataSet: set)
        
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = " %"
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        
        data.setValueFont(.systemFont(ofSize: 11, weight: .light))
        data.setValueTextColor(.clear)
        
        pieChartView.setExtraOffsets(left: -10, top: -10, right: -10, bottom: -10)
        pieChartView.data = data
        pieChartView.highlightValues(nil)
        pieChartView.animate(xAxisDuration: 1.4, yAxisDuration: 1.4)
    }
    func setDataInboxCount(_ countValue: [[String : Int]]) {
        var entries = [PieChartDataEntry]()
        for i in 0..<countValue.count{
            let inbox = countValue[i]
            let count = inbox[inbox.keys.first!]
            entries.append(PieChartDataEntry(value: Double(count ?? 0),
                                             label: inbox.keys.first!))
        }
        let set = PieChartDataSet(entries: entries, label: "")
        set.drawIconsEnabled = false
        set.sliceSpace = 2
        
        
        set.colors = [UIColor(red: 42/255, green: 217/255, blue: 138/255, alpha: 1),UIColor(red: 242/255, green: 183/255, blue: 48/255, alpha: 1), UIColor(red: 230/255, green: 44/255, blue: 33/255, alpha: 1)]
        
        let data = PieChartData(dataSet: set)
        
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = " %"
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        
        data.setValueFont(.systemFont(ofSize: 11, weight: .light))
        data.setValueTextColor(.clear)
        
        pieChartView.setExtraOffsets(left: -10, top: -10, right: -10, bottom: -10)
        pieChartView.data = data
        pieChartView.highlightValues(nil)
        pieChartView.animate(xAxisDuration: 1.4, yAxisDuration: 1.4)
    }
}
extension DashboardCell: ChartViewDelegate{
    
}
