# Base image
FROM node:18 AS base
WORKDIR /usr/src/app

COPY package.json ./
COPY prisma ./

COPY . .

RUN yarn install

RUN yarn global add prisma typescript@latest @nestjs/cli

RUN npx prisma migrate

RUN yarn build



FROM base AS dev
ENV NODE_ENV=development
CMD ["npm", "run", "dev"]

# Production image
FROM node:18-alpine AS prod
WORKDIR /app
COPY --from=base /usr/src/app/build ./build
COPY --from=base /usr/src/app/prisma ./prisma
COPY package.json ./
RUN yarn install --omit=dev
ENV NODE_ENV=production
CMD ["npm","run", "start:prod"]