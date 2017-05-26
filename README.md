# RHEL 7 dockerfile for MongoDB

Pull Dockerfile then build:

docker build -t mongodb-dev /path/to/Dockerfile

Create Container from Docker image:

docker run -d -p 27017:27017 --name mongodb-container mongodb-dev:latest
