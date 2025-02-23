docker build --no-cache -t planckomat .
docker run --rm -v "./dist:/dist" planckomat
docker rmi planckomat