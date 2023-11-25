# Global build args
ARG GIT_SHA=unspecified
ARG RACK_ENV=production

# Build image
FROM ruby:3.2.2-alpine as BUILD_IMAGE

# https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#using-pipes
SHELL ["/bin/ash", "-eo", "pipefail", "-c"]

# https://docs.docker.com/build/cache/#use-the-dedicated-run-cache
RUN --mount=type=cache,target=/var/cache/apk \
    apk add --no-cache build-base

ENV APP_HOME /app

RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY Gemfile* $APP_HOME/

# Run bundler in deployment mode
RUN bundle config set deployment 'true' && \
    bundle config set without 'development test' && \
    bundle config set path 'vendor/bundle'

# Install gems and remove unnecessary files
RUN MAKE="make --jobs $(($(nproc)+1))" bundle install --jobs "$(nproc)" --retry 3 \
    && rm -rf vendor/bundle/ruby/*/cache/*.gem \
    && find vendor/bundle/ruby/*/gems/ -type f -name "*.c" -delete \
    && find vendor/bundle/ruby/*/gems/ -type f -name "*.o" -delete \
    && find vendor/bundle/ruby/*/gems/ -type f -name "*.md" -delete \
    && find vendor/bundle/ruby/*/gems/ -name "test" -type d -exec rm -rf {} + \
    && find vendor/bundle/ruby/*/gems/ -name "spec" -type d -exec rm -rf {} +

COPY . $APP_HOME

# Final image
FROM ruby:3.2.2-alpine

ARG GIT_SHA
ARG RACK_ENV

LABEL git-sha=${GIT_SHA}

RUN adduser -D --uid 1001 ruby
USER 1001

ENV APP_HOME /home/ruby
WORKDIR $APP_HOME

# Copy the app from the BUILD_IMAGE
COPY --from=BUILD_IMAGE --chown=ruby /app $APP_HOME

# Copy the bundle configuration from the BUILD_IMAGE
COPY --from=BUILD_IMAGE --chown=ruby $BUNDLE_APP_CONFIG/config $BUNDLE_APP_CONFIG/config

ENV RACK_ENV=${RACK_ENV} \
    GIT_SHA=${GIT_SHA} \
    REQUIRE_DOTENV=false

EXPOSE 9292

CMD ["bundle", "exec", "puma", "-e", "production"]
