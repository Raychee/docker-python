#!/usr/bin/env bash


ALL_ACTIONS="backup restore"


ACTION=$1; shift;

if [[ ${ACTION} =~ (^|[[:space:]])${ALL_ACTIONS}($|[[:space:]]) ]]; then
    echo "\"${ACTION}\" is not a valid action. Available are: ${ALL_ACTIONS}."
    exit 1
fi


DOCKER_VOLUME=$1; shift;

#MATCHED_DOCKER_VOLUMES=$(docker volume ls --filter name=${DOCKER_VOLUME} --format "{{.Name}}" | wc -l)
if [[ -z ${DOCKER_VOLUME} ]]; then
    echo "Please provide a docker volume."
    exit 1
fi


TAR_PATH=$1; shift;

if [[ -z ${TAR_PATH} ]]; then
    TAR_PATH="${DOCKER_VOLUME}.tar"
fi


if [[ ${ACTION} = "backup" ]]; then
    docker run --rm -v ${DOCKER_VOLUME}:/__docker_vol__ -v $(pwd):/__host_dir__ busybox tar cvf /__host_dir__/${TAR_PATH} /__docker_vol__
fi

if [[ ${ACTION} = "restore" ]]; then
    docker run --rm -v ${DOCKER_VOLUME}:/__docker_vol__ -v $(pwd):/__host_dir__ busybox tar xvf /__host_dir__/${TAR_PATH} -C /
fi

