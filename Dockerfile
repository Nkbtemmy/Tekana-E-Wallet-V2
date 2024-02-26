# Base image
FROM node:18-alpine AS base
WORKDIR /usr/src/app
COPY package.json ./
COPY prisma ./prisma
RUN yarn global add prisma typescript@latest @nestjs/cli
RUN yarn install
RUN yarn prisma generate
RUN npx prisma migrate
COPY . .
RUN yarn build

# Development phase
FROM base AS dev
ENV NODE_ENV=development
CMD ["yarn", "dev"]

# Production phase
FROM node:alpine AS prod
WORKDIR /app
COPY --from=base /usr/src/app/build ./build
COPY package.json ./
RUN yarn install --omit=dev
ENV NODE_ENV=production
CMD ["yarn", "start"]
