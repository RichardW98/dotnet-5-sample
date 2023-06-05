#!/usr/bin/env bash
#   Copyright IBM Corporation 2020
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

# Invoke as ./pushimages.sh <registry_url> <registry_namespace> <container_runtime>
# Examples:
# 1) ./pushimages.sh
# 2) ./pushimages.sh quay.io your_quay_username
# 3) ./pushimages.sh index.docker.io your_registry_namespace podman

REGISTRY_URL=quay.com
REGISTRY_NAMESPACE=parodos
CONTAINER_RUNTIME=docker
if [ "$#" -gt 1 ]; then
  REGISTRY_URL=$1
  REGISTRY_NAMESPACE=$2
fi
if [ "$#" -eq 3 ]; then
    CONTAINER_RUNTIME=$3
fi
if [ "${CONTAINER_RUNTIME}" != "docker" ] && [ "${CONTAINER_RUNTIME}" != "podman" ]; then
   echo 'Unsupported container runtime passed as an argument for pushing the images: '"${CONTAINER_RUNTIME}"
   exit 1
fi
# Uncomment the below line if you want to enable login before pushing
# ${CONTAINER_RUNTIME} login ${REGISTRY_URL}

echo 'pushing image dotnet5webapp'
${CONTAINER_RUNTIME} tag dotnet5webapp ${REGISTRY_URL}/${REGISTRY_NAMESPACE}/dotnet5webapp
${CONTAINER_RUNTIME} push ${REGISTRY_URL}/${REGISTRY_NAMESPACE}/dotnet5webapp

echo 'pushing image dotnet5angular-dotnetcorebuildstage'
${CONTAINER_RUNTIME} tag dotnet5angular-dotnetcorebuildstage ${REGISTRY_URL}/${REGISTRY_NAMESPACE}/dotnet5angular-dotnetcorebuildstage
${CONTAINER_RUNTIME} push ${REGISTRY_URL}/${REGISTRY_NAMESPACE}/dotnet5angular-dotnetcorebuildstage

echo 'pushing image dotnet5webapp-dotnetcorebuildstage'
${CONTAINER_RUNTIME} tag dotnet5webapp-dotnetcorebuildstage ${REGISTRY_URL}/${REGISTRY_NAMESPACE}/dotnet5webapp-dotnetcorebuildstage
${CONTAINER_RUNTIME} push ${REGISTRY_URL}/${REGISTRY_NAMESPACE}/dotnet5webapp-dotnetcorebuildstage

echo 'pushing image dotnet5react-redux'
${CONTAINER_RUNTIME} tag dotnet5react-redux ${REGISTRY_URL}/${REGISTRY_NAMESPACE}/dotnet5react-redux
${CONTAINER_RUNTIME} push ${REGISTRY_URL}/${REGISTRY_NAMESPACE}/dotnet5react-redux

echo 'pushing image dotnet5react-redux-dotnetcorebuildstage'
${CONTAINER_RUNTIME} tag dotnet5react-redux-dotnetcorebuildstage ${REGISTRY_URL}/${REGISTRY_NAMESPACE}/dotnet5react-redux-dotnetcorebuildstage
${CONTAINER_RUNTIME} push ${REGISTRY_URL}/${REGISTRY_NAMESPACE}/dotnet5react-redux-dotnetcorebuildstage

echo 'pushing image dotnet5react'
${CONTAINER_RUNTIME} tag dotnet5react ${REGISTRY_URL}/${REGISTRY_NAMESPACE}/dotnet5react
${CONTAINER_RUNTIME} push ${REGISTRY_URL}/${REGISTRY_NAMESPACE}/dotnet5react

echo 'pushing image dotnet5react-dotnetcorebuildstage'
${CONTAINER_RUNTIME} tag dotnet5react-dotnetcorebuildstage ${REGISTRY_URL}/${REGISTRY_NAMESPACE}/dotnet5react-dotnetcorebuildstage
${CONTAINER_RUNTIME} push ${REGISTRY_URL}/${REGISTRY_NAMESPACE}/dotnet5react-dotnetcorebuildstage

echo 'pushing image dotnet5angular'
${CONTAINER_RUNTIME} tag dotnet5angular ${REGISTRY_URL}/${REGISTRY_NAMESPACE}/dotnet5angular
${CONTAINER_RUNTIME} push ${REGISTRY_URL}/${REGISTRY_NAMESPACE}/dotnet5angular

echo 'done'
