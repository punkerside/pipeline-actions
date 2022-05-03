#!/bin/bash

GITHUB_HEAD_REF=$1
GITHUB_BASE_REF=$2

if [ ${GITHUB_BASE_REF} = "develop" ]; then
  if [ ${GITHUB_HEAD_REF} != "feature" ] && [ ${GITHUB_HEAD_REF} != "master" ]; then
    echo "Error en la validacion de ramas: from=${GITHUB_HEAD_REF} to=${GITHUB_BASE_REF}"
    exit 1
  fi
  echo "validacion exitosa de ramas: from=${GITHUB_HEAD_REF} to=${GITHUB_BASE_REF}"
fi

if [ ${GITHUB_BASE_REF} = "release" ]; then
  if [ ${GITHUB_HEAD_REF} != "develop" ]; then
    echo "Error en la validacion de ramas: from=${GITHUB_HEAD_REF} to=${GITHUB_BASE_REF}"
    exit 1
  fi
  echo "validacion exitosa de ramas: from=${GITHUB_HEAD_REF} to=${GITHUB_BASE_REF}"
fi

if [ ${GITHUB_BASE_REF} = "master" ]; then
  if [ ${GITHUB_HEAD_REF} != "release" ] && [ ${GITHUB_HEAD_REF} != "hotfix" ]; then
    echo "Error en la validacion de ramas: from=${GITHUB_HEAD_REF} to=${GITHUB_BASE_REF}"
    exit 1
  fi
  echo "validacion exitosa de ramas: from=${GITHUB_HEAD_REF} to=${GITHUB_BASE_REF}"
fi