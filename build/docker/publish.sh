#!/bin/bash

set -euo pipefail;

image_push_targets=($(./pleasew query alltargets --include docker-push //...))

for image_push_target in "${image_push_targets}"; do
    ./pleasew run "${image_push_target}"
    image_fqn_target=$(echo "${image_push_target}" | sed "s/_push$/_fqn/g")

    ./pleasew build "${image_fqn_target}"
    image_fqn=$(<$(./pleasew query output "${image_fqn_target}"))
    repository=$(echo "$image_fqn" | cut -f1 -d:)
    image_branch_fqn="${repository}:$(git rev-parse --abbrev-ref HEAD)"
    echo "${image_branch_fqn} = ${image_fqn}"
    docker tag "${image_fqn}" "${image_branch_fqn}"
    docker push "${image_branch_fqn}"
done
