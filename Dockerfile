# Base image
FROM node:18 AS base
WORKDIR /usr/src/app

RUN npm install -g npm@latest
RUN npm install -g typescript@latest
COPY package.json ./
COPY prisma ./
RUN npm install
RUN npm install -g @nestjs/cli
COPY . .
RUN npx prisma generate
RUN npm run build

FROM base AS dev
ENV NODE_ENV=development
# ENTRYPOINT ["/bin/sh", "-c", "npm run start:dev"]
CMD ["npm", "run", "dev"]

# Production image
FROM node:18-alpine AS prod
WORKDIR /app
COPY --from=base /usr/src/app/build ./build
COPY --from=base /usr/src/app/prisma ./prisma
COPY package.json ./
RUN npm install -g npm@latest
# RUN npm install -g npm-check-updates
# RUN  ncu -u
RUN npm install --omit=dev
ENV NODE_ENV=production
CMD ["npm","run", "start:prod"]