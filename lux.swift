import Foundation

let usage: String = "\n  lux(1)\n" +
"  Set brightness of all connected Apple displays on macOS\n\n" +
"  Usage:\n" +
"    lux <level>   Brightness level from 0 to 10\n\n" +
"  Examples:\n" +
"    lux 0         Minimum brightness\n" +
"    lux 5         50% brightness\n" +
"    lux 10        Maximum brightness\n"

private extension String {
  var isNaN: Bool { return Int(self) == nil || Double(self) == nil }
}

private func setBrightness(level: Float) {
  var iterator: io_iterator_t = 0
  if IOServiceGetMatchingServices(kIOMasterPortDefault,
                                  IOServiceMatching("IODisplayConnect"),
                                  &iterator) == kIOReturnSuccess {
    var service: io_object_t = 1
    while service != 0 {
        service = IOIteratorNext(iterator)
        IODisplaySetFloatParameter(service, 0, kIODisplayBrightnessKey as CFString!, level)
        IOObjectRelease(service)
    }
  }
}

if (CommandLine.arguments.count < 2 || CommandLine.arguments[1].isNaN) {
  print(usage)
  exit(EXIT_FAILURE)
}

let level: Float! = (Float(CommandLine.arguments[1])! / 10)
setBrightness(level: level)
