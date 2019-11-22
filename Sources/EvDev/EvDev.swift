import Clibevdev
import Glibc


public class EvDev {
  let fileDescriptor: Int32?
  let handle: OpaquePointer

  init?(fileDescriptor: Int32, closeOnDeinit: Bool) {
    var possiblyNilHandle: OpaquePointer?
    let result = libevdev_new_from_fd(fileDescriptor, &possiblyNilHandle)
    if result < 0 {
      if closeOnDeinit { close(fileDescriptor) }
      return nil
    }
    guard let handle = possiblyNilHandle else {
      if closeOnDeinit { close(fileDescriptor) }
      return nil
    }
    self.fileDescriptor = closeOnDeinit ? fileDescriptor : nil
    self.handle = handle
  }

  public convenience init?(fileDescriptor: Int32) {
    self.init(fileDescriptor: fileDescriptor, closeOnDeinit: false)
  }

  public convenience init?(pathToFile: String) {
    let fileDescriptor = open(pathToFile, O_RDONLY)
    if fileDescriptor <= 0 {
      return nil
    }
    self.init(fileDescriptor: fileDescriptor, closeOnDeinit: true)
  }

  deinit {
    libevdev_free(self.handle)
    if let fileDescriptor = self.fileDescriptor {
      close(fileDescriptor)
    }
  }

  public var name: String {
    get {
      return String(cString: libevdev_get_name(self.handle)!)
    }
  }

  public var busType: Int32 {
    get {
      return libevdev_get_id_bustype(self.handle)
    }
  }

  public var vendorId: Int32 {
    get {
      return libevdev_get_id_vendor(self.handle)
    }
  }

  public var productId: Int32 {
    get {
      return libevdev_get_id_product(self.handle)
    }
  }

  public struct EventGenerator: Sequence, IteratorProtocol {   
    let evdev: EvDev

    public mutating func next() -> InputEvent? {
      var ev = input_event()
      let result = libevdev_next_event(self.evdev.handle, _LIBEVDEV_READ_FLAG_BLOCKING, &ev)
      if result != _LIBEVDEV_READ_STATUS_SUCCESS {
        return nil
      }
      let type = InputEventType(rawValue: ev.type)! /* TODO */
      switch type {
        case .EV_KEY: 
          let code = KeyCode(rawValue: ev.code)! /* TODO */
          let state = KeyState(rawValue: ev.value)!/* TODO */
          return .KeyEvent(time: ev.time, code: code, state: state)
        default: 
          return .InputEvent(time: ev.time, type: type, code: ev.code, value: ev.value)
      }
    }
  }

  public var events: EventGenerator {
    return EventGenerator(evdev: self)
  }
}
