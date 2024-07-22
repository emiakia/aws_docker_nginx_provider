#!/bin/bash

# Update the package list and install required packages
yum update -y
yum install -y docker

# Start and enable Docker service
systemctl start docker
systemctl enable docker

# Create a Dockerfile for Nginx
cat <<EOF > Dockerfile
FROM nginx:latest
COPY index.html /usr/share/nginx/html/index.html
EOF

# Create the index.html file
cat <<EOF > index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hello World</title>
</head>
<body>
    <h1>Hello World</h1>
	<br>
	<h1>Hello World from $(hostname -f)</h1>
</body>

</html>
EOF

# Build the Docker image
docker build -t nginx-hello-world .

# Run the Docker container
docker run -d -p 80:80 nginx-hello-world

# Clean up
rm Dockerfile index.html

echo "Nginx container is up and running. Access it at http://localhost"
