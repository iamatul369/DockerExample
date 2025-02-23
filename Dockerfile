
# Fetching the latest node image on alpine linux
FROM node:alpine AS development

# Declaring env
ENV NODE_ENV development

# Setting up the work directory
WORKDIR /my-app

# Installing dependencies
COPY ./package*.json /my-app

RUN yarn install

# Copying all the files in our project
COPY . .

# Starting our application
CMD ["yarn","start"]


FROM development AS test
RUN yarn test

# Production stage
FROM node:alpine AS prod
ENV NODE_ENV production
WORKDIR /my-app
COPY ./package*.json /my-app
RUN yarn install --production
COPY . .
CMD ["yarn", "start"]