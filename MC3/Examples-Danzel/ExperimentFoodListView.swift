//
//  FoodListView.swift
//  MC3
//
//  Created by mg0 on 14/08/24.
//
import UIKit
import CoreData

class ExampleFoodListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var foods: [Food] = []
    private let tableView = UITableView()
    private let viewContext: NSManagedObjectContext

    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        loadFoods()
        navigationItem.title = "Food List"
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "FoodCell")
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func loadFoods() {
        foods = JSONLoader.loadFoods()
        tableView.reloadData()
    }

    private func logFoodIntake(food: Food) {
        let newFoodIntake = FoodIntake(context: viewContext)
        newFoodIntake.intakeAt = Date()
        newFoodIntake.foodId = Int64(food.id)
        newFoodIntake.id = UUID()
        
        do {
            try viewContext.save()
            print("Food intake logged successfully")
        } catch {
            // Handle the error, e.g., show an alert
            print("Failed to save food intake: \(error.localizedDescription)")
        }
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCell", for: indexPath)
        let food = foods[indexPath.row]
        
        cell.textLabel?.text = food.title
        
        let logButton = UIButton(type: .system)
        logButton.setTitle("Log Intake", for: .normal)
        logButton.addAction(UIAction(handler: { [weak self] _ in
            self?.logFoodIntake(food: food)
        }), for: .touchUpInside)
        
        cell.accessoryView = logButton
        
        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

#if DEBUG
import SwiftUI

struct ExampleFoodListViewController_Previews: PreviewProvider {
    static var previews: some View {
        ExampleFoodListViewPreview()
            .edgesIgnoringSafeArea(.all)
    }
}

struct ExampleFoodListViewPreview: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ExampleFoodListViewController {
        let viewContext = PersistenceController.shared.container.viewContext
        return ExampleFoodListViewController(viewContext: viewContext)
    }

    func updateUIViewController(_ uiViewController: ExampleFoodListViewController, context: Context) {
        // No update needed for static preview
    }
}
#endif
