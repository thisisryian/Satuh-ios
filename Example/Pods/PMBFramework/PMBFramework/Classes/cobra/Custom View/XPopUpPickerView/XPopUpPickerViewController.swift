//
//  XPopUpPickerViewController.swift
//  SGByte-Property
//
//  Created by Mic Limz on 8/11/17.
//  Copyright © 2017 Pundi Mas Berjaya. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

public class XPopUpPickerViewController : BaseViewController {
    
    var root = XPopUpPickerView()
    public private(set) var dataSource: RxTableViewSectionedReloadDataSource<TableData>!
    public var data : [TableData] = []

    private var selectionType : Bool = false
    
    private var selection: [IndexPath] = []
    private var callback: (([IndexPath])->Void) = { _ in }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        view = root
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        root.XPopUpTable.delegate = self
        
        dataSource = RxTableViewSectionedReloadDataSource<TableData>(configureCell: { (ds, tv, index, item) in
            let cell = self.root.XPopUpTable.dequeueReusableCell(withIdentifier: "cell", for: index) as! XPopUpPickerTableCell
            cell.label.text = item.rowTitle
            cell.accessoryType = (self.selection.contains(index) ? .checkmark : .none)
            return cell
        })
        
        dataSource.titleForHeaderInSection = { ds, index in
            return ds.sectionModels[index].header
        }
        
        Observable.just(data)
            .bind(to: self.root.XPopUpTable.rx.items(dataSource: dataSource))
            .disposed(by: disposable)
        
        
        root.XPopUpTable.rx.itemSelected.subscribe(onNext: { index in
            guard let cell = self.root.XPopUpTable.cellForRow(at: index) else { return }
            
            if let search = self.selection.index(of: index) , search != -1 {
                if self.root.XPopUpTable.allowsMultipleSelection {
                    self.selection.remove(at: search)
                    cell.accessoryType = .none
                }
            } else {
                if self.root.XPopUpTable.allowsMultipleSelection {
                    self.selection.append(index)
                    cell.accessoryType = .checkmark
                } else {
                    if self.selection.count != 0 {
                        self.root.XPopUpTable.cellForRow(at: self.selection[0])?.accessoryType = .none
                    }
                    
                    self.selection = [index]
                    cell.accessoryType = .checkmark
                }
            }
            
            if !self.root.XPopUpTable.allowsMultipleSelection {
                self.callback(self.selection)
                self.dismiss(animated: true, completion: nil)
            }
        }).disposed(by: disposable)
        
        root.okButton.rx.tap.subscribe(onNext: { _ in
            self.callback(self.selection)
            self.dismiss(animated: true, completion: nil)
        }).disposed(by: disposable)
        
        if !selectionType {
            root.cancelButton.setTitle("Reset", for: .normal)
            root.cancelButton.rx.tap.subscribe(onNext : { _ in
                self.callback([])
                self.dismiss(animated: true, completion: nil)
            }).disposed(by: disposable)
        } else {
            root.cancelButton.rx.tap.subscribe(onNext : { _ in
                self.dismiss(animated: true, completion: nil)
            }).disposed(by: disposable)
        }
        
        
        root.dismissButton.rx.tap.subscribe(onNext : { _ in
            self.dismiss(animated: true, completion: nil)
        }).disposed(by: disposable)
    
        
    }
    
    public func initialize(data: [TableData], selectedIndexes : [IndexPath], isMultipleSelection selection: Bool = false, _ callback: @escaping (([IndexPath])->Void)) {
        self.data = data
        self.selection = selectedIndexes
        root.XPopUpTable.allowsMultipleSelection = selection
        selectionType = selection
        if selection {
            root.cancelButton.snp.makeConstraints({ (make) in
                make.height.equalTo(Margin.b30)
                make.width.equalTo(root.okButton)
            })
            root.okButton.snp.makeConstraints({ (make) in
                make.height.equalTo(Margin.b30)
                make.width.equalTo(root.cancelButton)
            })
        } else {
            root.cancelButton.snp.makeConstraints({ (make) in
                make.height.equalTo(Margin.b30)
                make.width.equalTo(root.XPopUpTable)
            })
        }
        self.callback = callback
    }
    
}
extension XPopUpPickerViewController : UITableViewDelegate{
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Margin.s32 * UI(1,1.5)
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let label = UILabel()
        view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(Margin.s4 * UI(1,2))
            make.leading.equalTo(view).offset(Margin.s8 * UI(1,2))
            make.trailing.equalTo(view).offset(-Margin.s8 * UI(1,2))
            make.bottom.equalTo(view).offset(-Margin.s4 * UI(1,2))
        }
        view.backgroundColor = UIColor.primary
        label.font = UIFont.semiBold(.h3)
        label.textColor = UIColor.white
//        label.text = "SECTION"
        label.text = dataSource.sectionModels[section].header
        return view
    }

}
