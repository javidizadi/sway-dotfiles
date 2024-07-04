#!/bin/bash

backlight_device_path="/sys/class/backlight/intel_backlight"
backlight_device_brightness_path="$backlight_device_path"/brightness
MAX_BRIGHTNESS=$(cat "$backlight_device_path"/max_brightness)

change_brightness() {

	local value current_brightness

	current_brightness=$(get_current_brightness)
	value=$(($1 + current_brightness))

	if [[ $value -gt 100 ]]; then
		value=100
	elif [[ $value -lt 0 ]]; then
		value=0
	fi

	write_brightness $((value * MAX_BRIGHTNESS / 100))
}

get_current_brightness() {
	local current_brightness
	current_brightness=$(cat "$backlight_device_brightness_path")

	echo $((current_brightness * 100 / MAX_BRIGHTNESS))
}

write_brightness() {
	local value
	value=$1

	echo "$value" >"$backlight_device_brightness_path"
}

change_brightness "$1"
