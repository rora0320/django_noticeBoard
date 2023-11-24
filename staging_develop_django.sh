#!/bin/bash
set -ex
IMAGE="kinon-django-staging"
HOST="375442000859.dkr.ecr.ap-northeast-2.amazonaws.com"
REGION="ap-northeast-2"

# Timestamp 가져오기
CurrentDate=$(date +"%Y-%m-%d")
CurrentTime=$(date +"%H")
TIMESTAMP="$CurrentDate-$CurrentTime"

# AWS 계정명 가져오기 (만약 필요하다면 아래의 코드를 주석 해제하시길 바랍니다.)
# ACCOUNT_NAME=$(aws sts get-caller-identity --query Arn --output text | cut -d':' -f6)

ACCESS_KEY_LAST_4=$(aws configure list | grep 'access_key' | awk '{print $2}' | tail -c 5)

# ECR에 로그인
aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $HOST

DOCKER_IMAGE="$HOST/$IMAGE"
NAME_TIME_TAG="$ACCESS_KEY_LAST_4-$TIMESTAMP"

docker buildx build --platform linux/amd64 -t $DOCKER_IMAGE:latest .
# Local 이미지 push && delete
docker push $DOCKER_IMAGE:latest
docker tag $DOCKER_IMAGE:latest $DOCKER_IMAGE:$NAME_TIME_TAG
docker push $DOCKER_IMAGE:$NAME_TIME_TAG
docker rmi $DOCKER_IMAGE:$NAME_TIME_TAG

git tag $DOCKER_IMAGE--$NAME_TIME_TAG
