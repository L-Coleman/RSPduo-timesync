find_library(PIGPIO_LIBRARIES NAMES pigpio)
find_path(PIGPIO_INCLUDE_DIRS NAMES pigpio.h)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(pigpio DEFAULT_MSG PIGPIO_LIBRARIES PIGPIO_INCLUDE_DIRS)