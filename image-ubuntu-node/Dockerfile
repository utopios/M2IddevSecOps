FROM ubuntu
RUN apt-get update && apt-get install -y nodejs
WORKDIR /app
COPY . .

# ENTRYPOINT [ "node", "index.js" ]

CMD [ "node", "index.js" ]