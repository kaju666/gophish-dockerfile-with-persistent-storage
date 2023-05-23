FROM golang:latest

WORKDIR $GOPATH
RUN go install github.com/gophish/gophish@v0.12.1
RUN mkdir /app && cp -R $GOPATH/bin/* /app/ && cp -R $GOPATH/pkg/mod/github.com/gophish/gophish@v0.12.1/* /app/ && rm -rf $GOPATH
WORKDIR /app
RUN sed -i "s|127.0.0.1|0.0.0.0|g" config.json
RUN sed -i "s|gophish.db|persistent/gophish.db|g" config.json
RUN sed -i 's|example|persistent/gophish|g' config.json
RUN sed -i 's|gophish_admin|persistent/gophish_admin|g' config.json
RUN touch config.json.tmp
RUN mkdir -p persistent && touch persistent/gophish.db

EXPOSE 3333 8080 8443 80
ENTRYPOINT ["./gophish"]
