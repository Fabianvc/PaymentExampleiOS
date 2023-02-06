import Combine
import UIKit

/// This extension adds combine custom publisher
public extension UIControl {
    final class Subscription<SubscriberType: Subscriber, Control: UIControl>: Combine.Subscription where SubscriberType.Input == Control {
        private var subscriber: SubscriberType?
        private let input: Control

        public init(subscriber: SubscriberType, input: Control, event: UIControl.Event) {
            self.subscriber = subscriber
            self.input = input
            input.addTarget(self, action: #selector(eventHandler), for: event)
        }

        public func request(_: Subscribers.Demand) {}

        public func cancel() {
            subscriber = nil
        }

        @objc
        private func eventHandler() {
            _ = subscriber?.receive(input)
        }
    }

    struct Publisher<Output: UIControl>: Combine.Publisher {
        public typealias Output = Output
        public typealias Failure = Never

        let output: Output
        let event: UIControl.Event

        public init(output: Output, event: UIControl.Event) {
            self.output = output
            self.event = event
        }

        public func receive<S>(subscriber: S) where S: Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
            let subscription = Subscription(subscriber: subscriber, input: output, event: event)
            subscriber.receive(subscription: subscription)
        }
    }
}

/// Combine Comptable Protocol
public protocol CombineCompatible {}

extension UIControl: CombineCompatible {}

public extension CombineCompatible where Self: UIControl {
    /// Suscribe to UIControl publisher
    func publisher(for event: UIControl.Event) -> UIControl.Publisher<UIControl> {
        .init(output: self, event: event)
    }
}
