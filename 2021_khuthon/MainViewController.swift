import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase
import Charts

class MainViewController: UIViewController {

    @IBOutlet weak var todayCountView: UIView!
    @IBOutlet weak var todayCountLabel: UILabel!
    @IBOutlet weak var graphCountView: UIView!
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var supplementaryLabel: UILabel!
    
    let ref = Database.database().reference()
    
    var counterDic: Dictionary<String, Int> = Dictionary<String, Int>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        chartInit()
        readDB()
    }
    private func updateUI(){
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.prefersLargeTitles = true
        todayCountView.layer.cornerRadius = 20
        graphCountView.layer.cornerRadius = 20
    }
    
    private func readDB(){
        todayCountLabel.text = "잠시 기다려주세요."
        supplementaryLabel.text = ""
        guard let UID = Auth.auth().currentUser?.uid else { return }
        print("UID : \(UID)")
        ref.child("count").child(UID).getData { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                self.todayCountLabel.text = "데이터를 찾을 수 없습니다."
                return;
            }

            guard let val = snapshot.value as? [String: [String: Any]] else {
                self.todayCountLabel.text = "데이터가 없습니다."
                self.lineChartView.noDataText = "데이터가 없습니다."
                return
            }
            for (date, counter) in val {
                let count = counter["count"] as! Int

                self.counterDic.updateValue(count, forKey: date)
            }
            let newdic = self.counterDic.sorted(by: <)
            self.dataProcess(counterDic: newdic)
        }
    }
    private func dataProcess(counterDic:[Dictionary<String, Int>.Element]){
        print(counterDic)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat="yyyy-MM-dd"
        let today = dateFormatter.string(from: Date())
        
        if let todayCnt = self.counterDic[today] {
            todayCountLabel.text = "\(todayCnt)회"
            if 1 <= todayCnt && todayCnt <= 2{
                supplementaryLabel.text = "조심하셔야겠어요!"
            }
            else if 3 <= todayCnt && todayCnt <= 6 {
                supplementaryLabel.text = "얼른 쉬세요!"
            }
            else {
                supplementaryLabel.text = "운전하지 마세요!"
            }
        }
        else {
            todayCountLabel.text = "오늘은 졸음운전한 기록이 없어요!"
            todayCountLabel.font = .systemFont(ofSize: 25, weight: .bold)
        }
        var dateArr:[String]=[]
        var countArr:[Int]=[]
        for (_date, _count) in counterDic {
            dateArr.append(_date)
            countArr.append(_count)
        }
        print(dateArr)
        print(countArr)
        
        var dataEntries:[ChartDataEntry] = []
        for i in 0..<dateArr.count {
            let dateEntry = ChartDataEntry(x: Double(i), y: Double(countArr[i]))
            dataEntries.append(dateEntry)
        }
        
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: "졸음운전 횟수")
        // 차트 모양 -
        chartDataSet.mode = .cubicBezier
        chartDataSet.drawCirclesEnabled = false
        chartDataSet.lineWidth = 2
        // 차트 컬러
        chartDataSet.colors = [.green]
        chartDataSet.fill = Fill(color: .green)
        chartDataSet.fillAlpha = 0.5
        chartDataSet.drawFilledEnabled = true
        // 선택, 줌 안되게
        chartDataSet.highlightEnabled = false
        lineChartView.doubleTapToZoomEnabled = false
        
        // ** 축
        // x축 레이블 위치, 포맷 조정
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dateArr)
        // x축 레이블 개수 최대, y축 오른쪽 숨기기
        lineChartView.xAxis.setLabelCount(4, force: false)
        lineChartView.rightAxis.enabled = false
        // 기타
        lineChartView.leftAxis.labelFont = .boldSystemFont(ofSize: 12)
        // bottom space to zero
        lineChartView.leftAxis.axisMinimum = 0
        lineChartView.xAxis.labelFont = .boldSystemFont(ofSize: 10)
        
        // 데이터 삽입
        let chartData = LineChartData(dataSet: chartDataSet)
        chartData.setDrawValues(false)
        lineChartView.data = chartData
        // animation
        lineChartView.animate(xAxisDuration: 4.0, yAxisDuration: 4.0)
    }
    private func chartInit(){
        lineChartView.noDataText = ""
        lineChartView.noDataFont = .systemFont(ofSize: 20)
        lineChartView.noDataTextColor = .lightGray
    }
    @IBAction func refreshButtonTapped(_ sender: Any) {
        self.readDB()
    }
    @IBAction func logoutButtonTapped(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("ERROR: signout \(signOutError.localizedDescription)")
        }
    }
}
