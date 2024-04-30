//
//  ViewController.swift
//  TestOBRIO
//
//  Created by admin on 30.04.2024.
//

import UIKit

class TransactionVC: UIViewController {
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "BlueGradient")
        return imageView
    }()
    
    private let amountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Amount"
        textField.font = UIFont(name: "Avenir-Book", size: 16)
        textField.backgroundColor = .clear
        textField.textAlignment = .center
        textField.textColor = .white
        textField.keyboardType = .decimalPad
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let addButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("Make Transaction", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Book", size: 25)
        button.startColor = UIColor(cgColor: CGColor(red: 7/255, green: 35/255, blue: 115/255, alpha: 1))
        button.endColor = UIColor(cgColor: CGColor(red: 22/255, green: 91/255, blue: 171/255, alpha: 1))
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let backButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("Back", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Book", size: 18)
        button.startColor = UIColor(cgColor: CGColor(red: 7/255, green: 35/255, blue: 115/255, alpha: 1))
        button.endColor = UIColor(cgColor: CGColor(red: 22/255, green: 91/255, blue: 171/255, alpha: 1))
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let valueSegmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["+","-"])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentControl
    }()
    
    let categoriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.pageIndicatorTintColor = UIColor(white: 1, alpha: 0.5)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    let categories = ["Groceries", "Taxi", "Electronics", "Restaurant", "Other"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backgroundImageView)
        backgroundImageView.frame = view.frame
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        view.addSubview(amountTextField)
        view.addSubview(valueSegmentControl)
        view.addSubview(addButton)
        view.addSubview(backButton)
        view.addSubview(categoriesCollectionView)
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        
        amountTextField.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(pageControl)
        
        pageControl.numberOfPages = categories.count
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            backButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 8),
            backButton.widthAnchor.constraint(equalToConstant: 100),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            
            amountTextField.topAnchor.constraint(equalTo:backButton.bottomAnchor, constant: 30),
            amountTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            amountTextField.widthAnchor.constraint(equalToConstant: 300),
            
            valueSegmentControl.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 8),
            valueSegmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            valueSegmentControl.widthAnchor.constraint(equalToConstant: 300),
            valueSegmentControl.heightAnchor.constraint(equalToConstant: 50),
   
            categoriesCollectionView.topAnchor.constraint(equalTo: valueSegmentControl.bottomAnchor, constant: 8),
            categoriesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoriesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoriesCollectionView.heightAnchor.constraint(equalToConstant: 50),

            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.topAnchor.constraint(equalTo: categoriesCollectionView.bottomAnchor, constant: 8),
            
            addButton.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 8),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.widthAnchor.constraint(equalToConstant: 300),
            addButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func addButtonTapped() {
        guard let amountString = amountTextField.text, var amount = Double(String(amountString.map {
            $0 == "," ? "." : $0
        })) else {
            let alert = UIAlertController(title: "Careful!", message: "Invalid amount", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        if valueSegmentControl.selectedSegmentIndex == 1 {
            amount *= -1
        }
        
        
        CoreDataManager.shared.createTransaction(amount: amount, date: Calendar.current.date(byAdding: .day, value: -1, to: Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: Date())!)!, category: categories[pageControl.currentPage])
        self.dismiss(animated: true)
    }
    
}

extension TransactionVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        cell.categoryLabel.text = categories[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
}

extension TransactionVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / categoriesCollectionView.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}

