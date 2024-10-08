#Chuẩn bị môi trường: Nodejs version 12-alpine
FROM node:16-alpine
RUN apk add --no-cache python3 g++ make
#Tạo thư mục /app
WORKDIR /app
COPY . .
RUN yarn install --production
#Hướng dẫn docker chạy file index.js
CMD ["node", "src/index.js"]