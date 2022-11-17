import SwiftUI

struct DatePickerTextField: UIViewRepresentable {

    @ObservedObject var orderViewModel = OrderViewModel()

    private let textField = UITextField()
    private let datePicker = UIDatePicker()
    private let helper = Helper()
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter
    }()

    public var placeholder: String
    @Binding public var date: Date?

    func makeUIView(context: Context) -> UITextField {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.minimumDate = .now
        datePicker.addTarget(
            helper,
            action: #selector(helper.dateValueChanged),
            for: .valueChanged
        )
        textField.text = dateFormatter.string(from: Date.now)
        textField.placeholder = placeholder
        textField.inputView = datePicker

        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        let doneButton = UIBarButtonItem(
            title: "Выбрать",
            style: .plain,
            target: helper,
            action: #selector(helper.doneButtonAction)
        )

        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        textField.inputAccessoryView = toolbar

        helper.dateChanged = {
            self.date = self.datePicker.date
        }

        helper.doneButtonTapped = {
            if self.date == nil {
                self.date = self.datePicker.date
            }
            self.textField.resignFirstResponder()
        }

        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        if let selectedDate = date {
            uiView.text = dateFormatter.string(from: selectedDate)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Helper {
        public var dateChanged: (() -> Void)?
        public var doneButtonTapped: (() -> Void)?

        @objc func dateValueChanged() {
            dateChanged?()
        }

        @objc func doneButtonAction() {
            doneButtonTapped?()
        }
    }

    class Coordinator {}
}
