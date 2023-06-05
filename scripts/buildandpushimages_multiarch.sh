#!/usr/bin/env bash
#   Copyright IBM Corporation 2021
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

# Invoke as ./buildandpush_multiarchimages.sh <registry_url> <registry_namespace> <comma_separated_platforms>
# Examples:
# 1) ./buildandpush_multiarchimages.sh
# 2) ./buildandpush_multiarchimages.sh index.docker.io your_registry_namespace
# 3) ./buildandpush_multiarchimages.sh quay.io your_quay_username linux/amd64,linux/arm64,linux/s390x

if [[ "$(basename "$PWD")" != 'scripts' ]] ; then
  echo 'please run this script from the "scripts" directory'
  exit 1
fi

cd .. # go to the parent directory so that all the relative paths will be correct

REGISTRY_URL=quay.com
REGISTRY_NAMESPACE=parodos
PLATFORMS="linux/amd64,linux/arm64,linux/s390x,linux/ppc64le"
if [ "$#" -gt 1 ]; then
  REGISTRY_URL=$1
  REGISTRY_NAMESPACE=$2
fi
if [ "$#" -eq 3 ]; then
  PLATFORMS=$3
fi
# Uncomment the below line if you want to enable login before pushing
# docker login ${REGISTRY_URL}

echo 'building and pushing image dotnet5angular-dotnetcorebuildstage'
cd source/output/src/dotnet5angular
docker buildx build --platform ${PLATFORMS} -f Dockerfile.dotnetcorebuildstage  --push --tag ${REGISTRY_URL}/${REGISTRY_NAMESPACE}/dotnet5angular-dotnetcorebuildstage .
cd -

echo 'building and pushing image dotnet5angular'
cd source/output/src/dotnet5angular
docker buildx build --platform ${PLATFORMS} -f Dockerfile  --push --tag ${REGISTRY_URL}/${REGISTRY_NAMESPACE}/dotnet5angular .
cd -

echo 'building and pushing image dotnet5react-dotnetcorebuildstage'
cd source/output/src/dotnet5react
docker buildx build --platform ${PLATFORMS} -f Dockerfile.dotnetcorebuildstage  --push --tag ${REGISTRY_URL}/${REGISTRY_NAMESPACE}/dotnet5react-dotnetcorebuildstage .
cd -

echo 'building and pushing image dotnet5react'
cd source/output/src/dotnet5react
docker buildx build --platform ${PLATFORMS} -f Dockerfile  --push --tag ${REGISTRY_URL}/${REGISTRY_NAMESPACE}/dotnet5react .
cd -

echo 'building and pushing image dotnet5react-redux-dotnetcorebuildstage'
cd source/output/src/dotnet5react-redux
docker buildx build --platform ${PLATFORMS} -f Dockerfile.dotnetcorebuildstage  --push --tag ${REGISTRY_URL}/${REGISTRY_NAMESPACE}/dotnet5react-redux-dotnetcorebuildstage .
cd -

echo 'building and pushing image dotnet5react-redux'
cd source/output/src/dotnet5react-redux
docker buildx build --platform ${PLATFORMS} -f Dockerfile  --push --tag ${REGISTRY_URL}/${REGISTRY_NAMESPACE}/dotnet5react-redux .
cd -

echo 'building and pushing image dotnet5webapp-dotnetcorebuildstage'
cd source/output/src/dotnet5webapp
docker buildx build --platform ${PLATFORMS} -f Dockerfile.dotnetcorebuildstage  --push --tag ${REGISTRY_URL}/${REGISTRY_NAMESPACE}/dotnet5webapp-dotnetcorebuildstage .
cd -

echo 'building and pushing image dotnet5webapp'
cd source/output/src/dotnet5webapp
docker buildx build --platform ${PLATFORMS} -f Dockerfile  --push --tag ${REGISTRY_URL}/${REGISTRY_NAMESPACE}/dotnet5webapp .
cd -

echo 'done'
