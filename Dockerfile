# Base image
FROM node:16-alpine AS base
WORKDIR /app

# Dependencies
FROM base AS dependencies
COPY package.json package-lock.json ./
RUN npm ci --only=production

# Builder
FROM dependencies AS builder
COPY . .
COPY .env.prod .env.production
RUN npm run build

FROM node:16-alpine AS runner
WORKDIR /app

COPY --from=dependencies /app/node_modules ./node_modules
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/package.json ./package.json

ENV NODE_ENV production
EXPOSE 3000

CMD ["npm", "start"]

# Nginx
# FROM nginx:alpine AS nginx
# COPY --from=builder /app/public /usr/share/nginx/html
# COPY nginx.conf /etc/nginx/conf.d/default.conf

