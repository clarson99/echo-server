FROM ruby:2.3.5-alpine3.4

ENV ECHO_SERVER_PORT=8000

WORKDIR /usr/src/app

COPY ./echo.rb echo.rb

ENTRYPOINT ruby ./echo.rb

EXPOSE ${ECHO_SERVER_PORT}
