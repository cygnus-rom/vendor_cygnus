for device in $(cat $(gettop)/vendor/rockstar/rockstar.devices | sed -e 's/#.*$//' | awk '{printf "rockstar_%s-userdebug\n", $1}'); do
    add_lunch_combo $device;
done;
