function __print_cygnus_functions_help() {
cat <<EOF
Additional functions:
- mka:             Builds using SCHED_BATCH on all processors.
- merge:           Merge caf tags. Syntax- merge <caf-tag>
EOF
}

# Make using all available CPUs
function mka() {
    if [ -f $ANDROID_BUILD_TOP/$QTI_BUILDTOOLS_DIR/build/update-vendor-hal-makefiles.sh ]; then
        vendor_hal_script=$ANDROID_BUILD_TOP/$QTI_BUILDTOOLS_DIR/build/update-vendor-hal-makefiles.sh
        source $vendor_hal_script --check
        regen_needed=$?
    else
        vendor_hal_script=$ANDROID_BUILD_TOP/vendor/cygnus/vendor_hal_makefile_generator.sh
        regen_needed=1
    fi

    if [ $regen_needed -eq 1 ]; then
        _wrap_build $(get_make_command hidl-gen) hidl-gen ALLOW_MISSING_DEPENDENCIES=true
        RET=$?
        if [ $RET -ne 0 ]; then
            echo -n "${color_failed}#### hidl-gen compilation failed, check above errors"
            echo " ####${color_reset}"
            return $RET
        fi
        source $vendor_hal_script
        RET=$?
        if [ $RET -ne 0 ]; then
            echo -n "${color_failed}#### HAL file .bp generation failed dure to incpomaptible HAL files , please check above error log"
            echo " ####${color_reset}"
            return $RET
        fi
    fi

    schedtool -B -n 1 -e ionice -n 1 make -j `cat /proc/cpuinfo | grep "^processor" | wc -l` "$@"
}

function merge-caf() {
    # Variables
    root=$(gettop)
    branch="caf-ten"
    caf="https://source.codeaurora.org/quic/la"
    read -p "Enter CAF tag: " tag

    # Repos
    repo="$(grep 'remote="cygnus"' $root/.repo/manifests/cygnus.xml  | awk '{print $2}' | awk -F '"' '{print $2}')"

    # Repos that need to be excluded
    blacklist="device/qcom/common \
        manifest \
        vendor/cygnus \
        vendor/cygnus-overlays \
        vendor/prebuilts"

    # Create log files
    rm $root/merge_log.txt
    touch $root/merge_log.txt

    # Reset and checkout to  remote's branch
    reset() {
        git reset --hard
        git checkout $branch &> /dev/null
    }

    for repo in $repo; do
        if [[ $blacklist =~ $repo ]]; then echo -e "Skipping $repo"
        else
        case $repo in
            device/qcom/sepolicy)
                repo_url="$caf/$repo" ;;
            build/make)
                repo_url="$caf/platform/build" ;;
            vendor/codeaurora/commonsys/telephony)
                repo_url="$caf/platform/vendor/codeaurora/telephony" ;;
            vendor/qcom/opensource/commonsys/bluetooth)
                repo_url="$caf/platform/vendor/qcom-opensource/bluetooth" ;;
            vendor/qcom/opensource/commonsys/bluetooth_ext)
                repo_url="$caf/platform/vendor/qcom-opensource/bluetooth_ext" ;;
            vendor/qcom/opensource/commonsys/fm)
                repo_url="$caf/platform/vendor/qcom-opensource/fm-commonsys" ;;
            vendor/qcom/opensource/commonsys/system/bt)
                repo_url="$caf/platform/vendor/qcom-opensource/system/bt" ;;
            vendor/qcom/opensource/commonsys-intf/display)
                repo_url="$caf/platform/vendor/qcom-opensource/display-commonsys-intf" ;;
            vendor/qcom*) repo_url="$caf/platform/$(echo $repo | sed -e 's|qcom/opensource|qcom-opensource|')" ;;
            *) repo_url="$caf/platform/$repo" ;; esac
        fi

        if wget -q --spider $repo_url; then
            echo -e "Merging $repo"
            cd $root/$repo
            reset
            git pull $repo_url $tag
        fi
        done
    echo "Done"
}
