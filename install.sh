#!/bin/sh

PROJECT_DIRECTORY=..

TEMPLATE_DIRECTORY=`dirname $0`

cd ${TEMPLATE_DIRECTORY}

mkdir -p ${PROJECT_DIRECTORY}/inc
mkdir -p ${PROJECT_DIRECTORY}/obj
mkdir -p ${PROJECT_DIRECTORY}/src

cp -rb ./main.cpp ${PROJECT_DIRECTORY}/src/main.cpp

ln -s ${TEMPLATE_DIRECTORY}/Makefile ${PROJECT_DIRECTORY}/Makefile
ln -s ${TEMPLATE_DIRECTORY}/.gitignore ${PROJECT_DIRECTORY}/.gitignore

cd ${PROJECT_DIRECTORY}
ln -s ./src/main.cpp ./main.cpp

