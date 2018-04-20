for device in $(cat $(gettop)/vendor/rockstar/rockstar.devices | sed -e 's/#.*$//' | awk '{printf "rockstar_%s-userdebug\n", $1}'); do
    add_lunch_combo $device;
done;

# SDClang Environment Variables
export SDCLANG_AE_CONFIG=vendor/rockstar/sdclang/sdclangAE.json
export SDCLANG_CONFIG=vendor/rockstar/sdclang/sdclang.json
export SDCLANG_SA_ENABLED=false
