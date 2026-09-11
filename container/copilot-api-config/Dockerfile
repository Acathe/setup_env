FROM debian:13

RUN apt-get -qq update \
    && apt-get -qq install jq openssl \
    && rm -rf /var/lib/apt/lists/*

COPY api_key.sh /usr/local/bin/api_key.sh
COPY model_mapping.sh /usr/local/bin/model_mapping.sh
COPY small_model.sh /usr/local/bin/small_model.sh
COPY run.sh /usr/local/bin/run.sh

CMD ["bash", "/usr/local/bin/run.sh"]
