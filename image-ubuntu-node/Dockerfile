FROM ubuntu as build
RUN apt-get update && apt-get install -y nodejs
WORKDIR /app
COPY . .
RUN useradd -r -u 1000 dockeruser
USER dockeruser
#ENTRYPOINT [ "node", "index.js" ]

 CMD [ "node", "index.js" ]
# FROM build 
