FROM mhart/alpine-node:6.3
MAINTAINER Earvin Kayonga <e.kayonga@bevolta.com>

ENV EMBER_CLI_VERSION 2.4.1
ENV BOWER_VERSION 1.7.1
ENV PHANTOMJS_VERSION 1.9.19
ENV WATCHMAN_VERSION 3.5.0


ENV LANG en_US.utf8

# Install ruby & ruby-dev
RUN apk add  --update bash ruby ruby-dev git python

# Install sass and compass gems
# install compass --no-ri --no-rdoc --pre sass-css-importer
RUN \
apk add --update \
    ruby \
    libffi-dev \
    build-base
RUN gem sources --add https://rubygems.org/
RUN gem update --no-rdoc --no-ri
RUN gem install \
		compass --no-ri --no-rdoc \
    listen \
		ffi \
		--pre sass-css-importer \
    compass &&\

rm -rf /var/cache/apk/*

RUN \
apk --update add git build-base &&\
git clone https://github.com/sass/sassc &&\
cd sassc &&\
git clone https://github.com/sass/libsass &&\
SASS_LIBSASS_PATH=/sassc/libsass make &&\

# install
mv bin/sassc /usr/bin/sass &&\

# cleanup
cd / &&\
rm -rf /sassc &&\
apk add libstdc++


# ember-cli, bower and phantomjs
RUN npm install -g ember-cli@$EMBER_CLI_VERSION
RUN npm install -g bower@$BOWER_VERSION
RUN npm install -g node-sass
#RUN npm install -g phantomjs@$PHANTOMJS_VERSION

# run ember server on container start
EXPOSE 4200 49152
ENTRYPOINT ["/usr/bin/ember"]
CMD ["serve","--live-reload=false"]
