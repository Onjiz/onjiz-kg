FROM node:lts-alpine


RUN mkdir /var/www && chown node:node /var/www
# Create app directory
WORKDIR /var/www


RUN  apk add --update python make g++\
    && rm -rf /var/cache/apk/*

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
# COPY webroot/package*.json ./

USER node
COPY --chown=node:node webroot/package.json webroot/package-lock.json* ./

RUN npm install --no-optional && npm cache clean --force

ENV PATH /var/www/node_modules/.bin:$PATH
# If you are building your code for production
# RUN npm ci --only=production

# Bundle app source
COPY --chown=node:node webroot .

CMD [ "sails", "lift" ]

