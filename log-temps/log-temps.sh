#!/bin/bash
logger $(vcgencmd measure_temp)
logger $(vcgencmd measure_clock arm)
logger $(vcgencmd measure_volts core)
