FROM node:16-alpine AS builder
WORKDIR /app
COPY . .
RUN npm install --save --legacy-peer-deps
RUN npm run build
FROM public.ecr.aws/c3r7q5u5/vb:nginx
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=builder /app/build .
ENTRYPOINT ["nginx", "-g", "daemon off;"]