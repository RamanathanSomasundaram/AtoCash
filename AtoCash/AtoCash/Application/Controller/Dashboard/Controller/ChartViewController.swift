//
//  ChartViewController.swift
//  AtoCash
//
//  Created by user on 13/05/21.
//

import UIKit

class ChartViewController: UIViewController {

    @IBOutlet weak var pieChartView: PieChartView!
    var pieChartData : RequestCountModel?
    var inboxCount : [[String: Int]]?
    var chartName : String!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup(pieChartView: self.pieChartView)
        
    }
    func setup(pieChartView chartView: PieChartView) {
        chartView.usePercentValuesEnabled = true
        chartView.drawSlicesUnderHoleEnabled = false
        chartView.holeRadiusPercent = 0.58
        chartView.transparentCircleRadiusPercent = 0.65
        chartView.chartDescription.enabled = false
        chartView.setExtraOffsets(left: 5, top: 10, right: 5, bottom: 5)
        
        chartView.drawCenterTextEnabled = true
        if chartName != ""{
        let paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.alignment = .center
        
        let centerText = NSMutableAttributedString(string: chartName)
        centerText.setAttributes([.font : UIFont(name: "HelveticaNeue-Bold", size: 15)!,.foregroundColor : UIColor.black,
                                  .paragraphStyle : paragraphStyle], range: NSRange(location: 0, length: centerText.length))
        chartView.centerAttributedText = centerText;
        }
        else{
            chartView.centerText = NSLocalizedString("no_chart", comment: "")
        }
        
        
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
        
        let l = pieChartView.legend
        l.verticalAlignment = .center
        l.orientation = .vertical
        l.xEntrySpace = 7
        l.yEntrySpace = 0
        l.yOffset = 0
        // entry label styling
        pieChartView.entryLabelColor = .clear
        pieChartView.entryLabelFont = .systemFont(ofSize: 12, weight: .light)
        //pieChartView.animate(xAxisDuration: 1.4, easingOption: .easeOutBack)
        //Setup chart data
        if let data = self.pieChartData{
            self.setDataCount(data)
        }
        else if let inbox = self.inboxCount{
            self.setDataInboxCount(inbox)
        }
    }
    func setDataCount(_ count: RequestCountModel) {
        let entries = [PieChartDataEntry(value: Double(count.approvedCount!),
                                         label: NSLocalizedString("approve", comment: "")),PieChartDataEntry(value: Double(count.pendingCount!),
                                                                              label: NSLocalizedString("pending", comment: "")),PieChartDataEntry(value: Double(count.rejectedCount!),
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
        
        data.setValueFont(.systemFont(ofSize: 15, weight: .bold))
        data.setValueTextColor(.white)
        
        pieChartView.setExtraOffsets(left: 0, top: 0, right: 0, bottom: 0)
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
        
        data.setValueFont(.systemFont(ofSize: 15, weight: .bold))
        data.setValueTextColor(.white)
        
        pieChartView.setExtraOffsets(left: -5, top: -5, right: -5, bottom: -5)
        pieChartView.data = data
        pieChartView.highlightValues(nil)
        pieChartView.animate(xAxisDuration: 1.4, yAxisDuration: 1.4)
    }
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
