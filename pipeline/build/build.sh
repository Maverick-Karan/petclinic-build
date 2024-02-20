echo "*********************************"
echo "***** Building Docker Image *****"
echo "*********************************"

cd pipeline/build/ && docker-compose -f docker-compose-build.yml build --no-cache