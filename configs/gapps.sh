# script to sync OpenGapps
cd ../..
rm -rf vendor/opengapps/sources/arm64 vendor/opengapps/sources/arm #Since we need a clean pull everytime
git clone https://gitlab.opengapps.org/opengapps/arm64.git -b master --depth=1 vendor/opengapps/sources/arm64 
git clone https://gitlab.opengapps.org/opengapps/arm.git -b master --depth=1 vendor/opengapps/sources/arm 
cd vendor/opengapps/sources/arm 
git lfs pull 
cd .. && cd arm64
git lfs pull
