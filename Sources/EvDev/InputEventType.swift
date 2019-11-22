import Clibevdev


public enum InputEventType : UInt16 {
  case EV_SYN			  = 0x00
  case EV_KEY		    = 0x01
  case EV_REL			  = 0x02
  case EV_ABS			  = 0x03
  case EV_MSC			  = 0x04
  case EV_SW			  = 0x05
  case EV_LED			  = 0x11
  case EV_SND			  = 0x12
  case EV_REP			  = 0x14
  case EV_FF			  = 0x15
  case EV_PWR			  = 0x16
  case EV_FF_STATUS = 0x17
}

extension InputEventType : CustomStringConvertible {
  public var description: String {
    return String(cString: libevdev_event_type_get_name(UInt32(self.rawValue))!)
  }
}