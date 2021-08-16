FROM fluent/fluentd:v1.13-1
LABEL maintainer "Vivek Lanjekar <vivek.lanjekar@gmail.com>"
# Use root account to use apk
USER root

# below RUN includes plugin as examples elasticsearch is not required
# you may customize including plugins as you wish
RUN apk add --no-cache --update --virtual .build-deps \
        sudo build-base ruby-dev \
 && sudo gem install \
        fluent-plugin-elasticsearch \
        fluent-plugin-scalyr \
        fluent-plugin-s3 \
        fluent-plugin-kafka \
        fluent-plugin-grok-parser \
        fluent-plugin-rewrite-tag-filter \
        fluent-plugin-record-reformer \
        fluent-plugin-throttle \
        fluent-plugin-detect-exceptions \
        fluent-plugin-multi-format-parser \
 && sudo gem sources --clear-all \
 && apk del .build-deps \
 && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

COPY entrypoint.sh /bin/

USER fluent
