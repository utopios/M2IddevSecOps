FROM ubuntu as build
RUN apt-get update && apt-get install -y nodejs
WORKDIR /app
COPY . .
USER ubuntu
ENTRYPOINT [ "node", "index.js" ]

# CMD [ "node", "index.js" ]
# FROM build 
