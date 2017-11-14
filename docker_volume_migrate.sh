#!/usr/bin/env bash


BASE_NAME=$(basename $0)

ALL_ACTIONS="backup restore"


function change_delimiter() {
    echo $1 | sed "s/$2/$3/g"
}

function exit_with_usage() {
    echo "./${BASE_NAME} <$(change_delimiter "${ALL_ACTIONS}" " " "|")> <docker volume name> [volume data archive (.tar.gz) name]"
    exit $1
}

function contains() {
    [[ $2 =~ (^| )$1($| ) ]]
}


ACTION=$1; shift;

if ! contains "${ACTION}" "${ALL_ACTIONS}"; then
    echo "\"${ACTION}\" is not a valid action. Available are: ${ALL_ACTIONS}."
    exit_with_usage 1
fi


DOCKER_VOLUME=$1; shift;

#MATCHED_DOCKER_VOLUMES=$(docker volume ls --filter name=${DOCKER_VOLUME} --format "{{.Name}}" | wc -l)
if [[ -z ${DOCKER_VOLUME} ]]; then
    echo "Please provide a docker volume."
    exit_with_usage 1
fi


TAR_PATH=$1; shift;

if [[ -z ${TAR_PATH} ]]; then
    TAR_PATH="${DOCKER_VOLUME}.tar.gz"
fi


if [[ ${ACTION} = "backup" ]]; then
    docker run --rm -v ${DOCKER_VOLUME}:/__docker_vol__ -v $(pwd):/__host_dir__ busybox tar zcf /__host_dir__/${TAR_PATH} /__docker_vol__
fi

if [[ ${ACTION} = "restore" ]]; then
    docker run --rm -v ${DOCKER_VOLUME}:/__docker_vol__ -v $(pwd):/__host_dir__ busybox tar zxf /__host_dir__/${TAR_PATH} -C /
fi

