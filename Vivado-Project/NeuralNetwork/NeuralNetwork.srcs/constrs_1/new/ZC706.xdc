

set_property PACKAGE_PIN H9 [get_ports CLOCK_N]

set_property IOSTANDARD LVDS [get_ports -regexp {CLOCK_N}]

create_clock -period 5.000 -name PIN_SystemClock_200MHz [get_ports CLOCK_N]