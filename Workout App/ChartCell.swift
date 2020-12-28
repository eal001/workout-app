//
//  ChartCell.swift
//  Workout App
//
//  Created by Elliot Lee on 12/27/20.
//

import UIKit
import Charts

class ChartCell: UITableViewCell, ChartViewDelegate {

    
    var data = [(Date, Exercise)]()
    
    @IBOutlet weak var exercise_name_label: UILabel!
    
    var progress_chart = LineChartView()
    
    override func awakeFromNib() {
        //print("did load cell")
        super.awakeFromNib()
        
        self.contentView.backgroundColor = Constants.CELL_0()
        exercise_name_label.textColor = Constants.TEXT()
        progress_chart.delegate = self
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        progress_chart.frame = CGRect(x: 0, y: 0 , width: self.contentView.frame.size.width , height: self.contentView.frame.size.height - 60)
        
        progress_chart.center = CGPoint(x: contentView.center.x, y: contentView.center.y + 20 )
        
        progress_chart.rightAxis.enabled = false
        progress_chart.rightAxis.xOffset = 15
        progress_chart.legend.enabled = false
        
        progress_chart.xAxis.valueFormatter = ChartDateFormatter()
        progress_chart.xAxis.granularity = 1
        progress_chart.xAxis.drawGridLinesEnabled = false
        progress_chart.xAxis.labelTextColor = Constants.TEXT()
        progress_chart.xAxis.axisLineColor = Constants.TEXT()
        progress_chart.xAxis.yOffset = 15
        
        progress_chart.leftAxis.labelTextColor = Constants.TEXT()
        progress_chart.leftAxis.axisLineColor = Constants.TEXT()
        progress_chart.leftAxis.drawGridLinesEnabled = false
        progress_chart.leftAxis.xOffset = 15
        
        progress_chart.pinchZoomEnabled = true
        progress_chart.doubleTapToZoomEnabled = false
        
        progress_chart.tintColor = Constants.BACKGROUND()
        
        contentView.addSubview(progress_chart)
        
        //set up data
        var coordinates = [ChartDataEntry]()
        //for i in 0..<10{
        //let i = 4
            //coordinates.append(ChartDataEntry(x: 1.0+Double(i),y: 1.0+Double(i) ))
        //}
        for coordinate in data{
            let time_interval = coordinate.0.timeIntervalSince1970
            let date_num = Double(time_interval)
            
            var volume = 0.0
            for set in coordinate.1.sets{
                if set.is_complete{
                    volume += set.weight * Double(set.reps)
                }
            }
            coordinates.insert(ChartDataEntry(x: date_num ,y: volume), at: 0)
        }
        
        let set = LineChartDataSet(entries: coordinates)
        //set.mode = .cubicBezier
        set.colors = [Constants.TEXT()]
        set.circleColors = [Constants.SECTION()]
        progress_chart.data = LineChartData(dataSet: set)
        progress_chart.data?.setDrawValues(false)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

class ChartDateFormatter : IAxisValueFormatter {
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        
        var index_1 = 0
        var index_2 = 0
        var index_3 = 0
        let current_index = axis?.entries.firstIndex(of: value) ?? 0
        let entry_count = (axis?.entries.count ?? 0) + 2
        if entry_count > 4 {
            if (entry_count) % 4 == 0 {
                index_1 = entry_count / 4 - 1
                index_2 = (entry_count / 4) * 2 - 1
                index_3 = (entry_count / 4) * 3 - 1
                
            } else {
                index_1 = (entry_count / 4)
                index_2 = (entry_count / 4) * 2
                index_3 = (entry_count / 4) * 3 - 1
            }
            
            if current_index == 0 || current_index == index_1 || current_index == index_2 || current_index == index_3
            {
                let time_interval = TimeInterval(value)
                let date = Date(timeIntervalSince1970: time_interval)
                let month = Calendar.current.component(.month, from: date)
                let day = Calendar.current.component(.day, from: date)
                let year = Calendar.current.component(.year, from: date)
                return "\(month)-\(day)-\(year)"
            } else {
                return ""
            }

        }
                
        let time_interval = TimeInterval(value)
        let date = Date(timeIntervalSince1970: time_interval)
        let month = Calendar.current.component(.month, from: date)
        let day = Calendar.current.component(.day, from: date)
        let year = Calendar.current.component(.year, from: date)
        return "\(month)-\(day)-\(year)"
    }
}
