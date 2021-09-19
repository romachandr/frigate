default_target: amd64_all

version:
	echo "VERSION='0.8.4-$(COMMIT_HASH)'" > frigate/version.py

web:
	docker build --tag frigate-web --file docker/Dockerfile.web web/

amd64_wheels:
	docker build --tag blakeblackshear/frigate-wheels:1.0.3-amd64 --file docker/Dockerfile.wheels .

amd64_ffmpeg:
	docker build --tag blakeblackshear/frigate-ffmpeg:1.1.0-amd64 --file docker/Dockerfile.ffmpeg.amd64 .

amd64_frigate: version web
	docker build --tag frigate-base --build-arg ARCH=amd64 --build-arg FFMPEG_VERSION=1.1.0 --build-arg WHEELS_VERSION=1.0.3 --file docker/Dockerfile.base .
	docker build --tag frigate --file docker/Dockerfile.amd64 .

amd64_all: amd64_wheels amd64_ffmpeg amd64_frigate

.PHONY: web