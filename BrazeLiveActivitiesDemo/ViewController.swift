import UIKit
import BrazeKit

#if canImport(ActivityKit)
import ActivityKit
#endif

class ViewController: UIViewController {

    private var textField: UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        setupButton()
        setupTapGestureRecognizer()
    }

    func setupTextField() {
        textField = UITextField()
        textField?.placeholder = "Push Token Tag"
        textField?.borderStyle = .roundedRect
        textField?.autocapitalizationType = .none
        textField?.autocorrectionType = .no
        view.addSubview(textField!)

        textField?.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField!.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField!.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            textField!.widthAnchor.constraint(equalToConstant: 200),
            textField!.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    func setupButton() {
        let button = UIButton(type: .system)
        button.setTitle("Start Live Activity", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.tintColor = .white
        button.backgroundColor = UIColor(red: 38/255, green: 140/255, blue: 173/255, alpha: 1.0)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(startLiveActivity), for: .touchUpInside)

        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: textField!.bottomAnchor, constant: 20),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc func startLiveActivity() {

        if let pushTokenTag = textField?.text {
            createLiveActivity(with: pushTokenTag)
        }
    }
    
    @available(iOS 16.2, *)
    func createLiveActivity(with pushTokenTag: String) {
        print(pushTokenTag)
      let activityAttributes = LiveActivitesExampleAttributes(gameName: "NBA Finals", gameNumber: "Game 1")
      let contentState = LiveActivitesExampleAttributes.ContentState(teamOneScore: 0, teamTwoScore: 0, quarter: "Q1", eventDescription: "🏀 Game on! Tip-off has commenced. Tune in now to catch the excitement!")
      let activityContent = ActivityContent(state: contentState, staleDate: nil)
      if let activity = try? Activity.request(attributes: activityAttributes,
                                              content: activityContent,
        // Setting your pushType as .token allows the Activity to generate push tokens for the server to watch.
                                              pushType: .token) {
        // Register your Live Activity with Braze using the pushTokenTag
          AppDelegate.braze?.liveActivities.launchActivity(pushTokenTag: pushTokenTag, activity: activity)
      }
    }
    
    func setupTapGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        textField?.resignFirstResponder()
    }
}
