#!/usr/bin/env bash


USERNAME="raychee"
BUILDS="python2 python2-teradata python3 python3-teradata jupyter-python-ultra-pack"
TAG="3.0.0"


function echo_line() {
    echo
    echo $@
    echo
}

function docker_build() {
    echo_line "Build image ${USERNAME}/$1."
    docker build -t ${USERNAME}/$1:$2 -f Dockerfile.$1 .
}

function docker_push() {
    echo_line "Push image ${USERNAME}/$1."
    docker push ${USERNAME}/$1:$2
}


LAST_EXIT=0

for IMAGE in ${BUILDS}; do
    if [ ${LAST_EXIT} -ne 0 ]; then
        break
    fi
    docker_build ${IMAGE} ${TAG} && docker_push ${IMAGE} ${TAG}
    docker_build ${IMAGE} latest && docker_push ${IMAGE} latest
    LAST_EXIT=$?
done

exit ${LAST_EXIT}
