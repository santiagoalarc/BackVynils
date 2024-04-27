# Build stage
FROM node:12-alpine AS builder

WORKDIR /usr/src/app

COPY package*.json ./

#RUN npm install --quiet
RUN npm ci --quiet

COPY . .

#RUN npm run build

# Production stage
FROM node:12-alpine

WORKDIR /usr/src/app

COPY package*.json ./

#RUN npm ci --only=production
RUN npm ci --only=production --quiet

COPY --from=builder /usr/src/app/dist ./dist

CMD ["npm", "run", "start:prod"]
