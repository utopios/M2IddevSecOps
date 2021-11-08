FROM ubuntu as build
RUN apt-get update && apt-get install -y nodejs
WORKDIR /app
COPY . .
RUN useradd -r -u 1000 
USER ubuntu
#ENTRYPOINT [ "node", "index.js" ]

 CMD [ "node", "index.js" ]
# FROM build 
