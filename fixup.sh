#!/bin/sh

set -x -e -o pipefail

for component in ansible-tower coreos4 idm insights ocp3 openshift-dedicated osp13 rhvh rhvm; do
                 pushd $component
                 [ -L component.yaml ] || ln -s $component.yaml component.yaml
                 popd
done
