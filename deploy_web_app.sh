#!/bin/bash
mkdir deployment
mkdir deployment/templates
mkdir deployment/static
cp web_app.py deployment/.
cp -r templates/* deployment/templates/.
cp -r static/* deployment/static/.
echo "FROM python" > deployment/Dockerfile
echo "RUN pip install flask" >> deployment/Dockerfile
echo "COPY ./static /home/webapp/static/" >> deployment/Dockerfile
echo "COPY ./templates /home/webapp/templates/" >> deployment/Dockerfile
echo "COPY web_app.py /home/webapp/" >> deployment/Dockerfile
echo "EXPOSE 8899" >> deployment/Dockerfile
echo "CMD python3 /home/webapp/deploy_web_app.py" >> deployment/Dockerfile
cd deployment
docker build -t web_app_image .
docker run -t -d -p 8899:8899 --name web_app_container web_app_image
docker container ls | grep 8899