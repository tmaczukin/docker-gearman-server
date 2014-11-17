tstamp = $(shell date +"%Y%m%d%H%M%S")
tag = 0.1
name = gearman-server
vendor = tmaczukin
imageName = $(vendor)/$(name)

build:
	docker build --rm -t $(imageName):$(tag) .
	docker tag $(imageName):$(tag) $(imageName):latest

vupdate:
	sed -i "s/# update_[0-9]*/# update_$(tstamp)/" Dockerfile

ubuild: vupdate build

