#!/bin/bash

if [ -z "${OWM_API_KEY+x}" ]; then
    echo "OWM_API_KEY must be set. Aborting."
    exit 1
fi

echo "Building the backend..."

pushd ../backend
docker build -t wapp-backend --build-arg APPID=${OWM_API_KEY} .
popd

echo "Done. Building the frontend..."

pushd ../frontend
docker build -t wapp-frontend .
popd

echo "Done."

echo "The backend can be launched by running:"
echo "'docker run --rm -i -p 9000:9000 --name wapp-backend -t wapp-backend'"
echo
echo "The frontend can be launched by running:"
echo "'docker run --rm -i -p 8000:8000 --name wapp-frontend -t wapp-frontend'"
