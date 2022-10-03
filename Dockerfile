FROM ruby:2.3-alpine AS base

RUN apk add --update sqlite sqlite-dev

FROM base as dependencies 

RUN apk add --update libxslt linux-headers build-base sqlite sqlite-dev

COPY Gemfile .

RUN bundle install

FROM base
COPY --from=dependencies /usr/local/bundle/ /usr/local/bundle/

COPY . /app

WORKDIR /app

CMD ["ruby", "puck.rb"]
