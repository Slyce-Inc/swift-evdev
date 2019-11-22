import Clibevdev


public enum InputEvent {
  case KeyEvent(time: timeval, code: KeyCode, state: KeyState)
  case InputEvent(time: timeval, type: InputEventType, code: UInt16, value: Int32)
}

