# Copyright 2023 VMware. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

CARVEL_BINARIES := ytt kbld

all: build-and-push-image

check-carvel:
	$(foreach exec,$(CARVEL_BINARIES),\
		$(if $(shell which $(exec)),,$(error "'$(exec)' not found. Carvel toolset is required. See instructions at https://carvel.dev/#install")))

build-and-push-image: check-carvel
	mkdir -p out/tanzu-cluster-essentials-bootstrap && \
	kbld -f bootstrap/build.yaml > _bootstrap.yaml && \
	ytt -f config -f _bootstrap.yaml > out/tanzu-cluster-essentials-bootstrap/bootstrap-app.yaml && \
	rm -f _bootstrap.yaml && \
	cp config/bootstrap-secrets.yaml.template out/tanzu-cluster-essentials-bootstrap

clean:
	rm -rf out
